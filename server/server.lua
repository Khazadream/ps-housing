DoorResource = GetResourceState('ox_doorlock') == 'started' and 'ox' or GetResourceState('qb-doorlock') == 'started' and 'qb'
if not DoorResource then 
    return error('ox_doorlock/qb-doorlock must be started before ps-housing.') 
end

QBCore = exports['qb-core']:GetCoreObject()
-- PSCore = exports['ps-core']:GetCoreObject()

local dbloaded = false
MySQL.ready(function()
    MySQL.query('SELECT * FROM properties', {}, function(result)
        if not result then
            print("Error: No result returned from properties query.")
            return
        end
        if result.id then -- If only one result
            result = {result}
        end
        for _, v in pairs(result) do
            local id = tostring(v.property_id)
            local has_access = json.decode(v.has_access)
            local owner = v.owner_citizenid
            local propertyData = {
                property_id = tostring(id),
                owner = owner,
                street = v.street,
                region = v.region,
                description = v.description,
                has_access = has_access,
                extra_imgs = json.decode(v.extra_imgs),
                furnitures = json.decode(v.furnitures),
                for_sale = v.for_sale,
                price = v.price,
                shell = v.shell,
                apartment = v.apartment,
                door_data = json.decode(v.door_data),
                garage_data = json.decode(v.garage_data),
                zone_data = v.zone_data,
                isGM = v.isGM,
            }
            PropertiesTable[id] = Property:new(propertyData)

            if v.shell == 'mlo' and DoorResource == 'qb' and owner then
                local property = PropertiesTable[id]
                -- we add door access for qb doorlock
                property:addMloDoorsAccess(owner)
                if has_access and #has_access > 0 then
                    for _, citizenId in ipairs(has_access) do
                        property:addMloDoorsAccess(citizenId)
                    end
                end
            end
        end

        dbloaded = true
    end, function(err)
        print("Error querying properties: " .. err)
    end)
end)

lib.callback.register("ps-housing:server:requestProperties", function()
    while not dbloaded do
        Wait(100)
    end

    return PropertiesTable
end)

function RegisterProperty(propertyData, preventEnter, source)
    propertyData.owner = propertyData.owner or nil
    propertyData.has_access = propertyData.has_access or {}
    propertyData.extra_imgs = propertyData.extra_imgs or {}
    propertyData.furnitures = propertyData.furnitures or {}
    propertyData.door_data = propertyData.door_data or {}
    propertyData.garage_data = propertyData.garage_data or {}
    propertyData.zone_data = propertyData.zone_data or {}
    
    local cols = "(owner_citizenid, street, region, description, has_access, extra_imgs, furnitures, for_sale, price, shell, apartment, door_data, garage_data, zone_data, isGM)"
    local vals = "(@owner_citizenid, @street, @region, @description, @has_access, @extra_imgs, @furnitures, @for_sale, @price, @shell, @apartment, @door_data, @garage_data, @zone_data, @isGM)"

    local id = MySQL.insert.await("INSERT INTO properties " .. cols .. " VALUES " .. vals , {
        ["@owner_citizenid"] = propertyData.owner or nil,
        ["@street"] = propertyData.street,
        ["@region"] = propertyData.region,
        ["@description"] = propertyData.description,
        ["@has_access"] = json.encode(propertyData.has_access),
        ["@extra_imgs"] = json.encode(propertyData.extra_imgs),
        ["@furnitures"] = json.encode(propertyData.furnitures),
        ["@for_sale"] = propertyData.for_sale ~= nil and propertyData.for_sale or 1,
        ["@price"] = propertyData.price or 0,
        ["@shell"] = propertyData.shell or '',
        ["@apartment"] = propertyData.apartment,
        ["@door_data"] = json.encode(propertyData.shell == 'mlo' and {count = #propertyData.door_data} or propertyData.door_data),
        ["@garage_data"] = json.encode(propertyData.garage_data),
        ["@zone_data"] = json.encode(propertyData.zone_data),
        ["@isGM"] = propertyData.isGM,
    })

    if source and propertyData.shell == 'mlo' then
        if DoorResource == 'ox' then
            TriggerClientEvent("ps-housing:client:createOxDoors", source, {
                id = id,
                doors = propertyData.door_data
            })
        else
            local qb_doorlock = exports['qb-doorlock']
            for _, v in ipairs(propertyData.door_data) do
                local isArray = v[1] and true
                local success, err = pcall(function()
                    qb_doorlock:saveNewDoor(source, {
                        locked = true,
                        model = isArray and {v[1].model, v[2].model} or v.model,
                        heading = isArray and {v[1].heading, v[2].heading} or v.heading,
                        coords = isArray and {v[1].coords, v[2].coords} or v.coords,
                        distance = 2.5,
                        doortype = 'door',
                        id = ('ps_mloproperty%s_%s'):format(id, _)
                    }, isArray)
                end)
                if not success then
                    print("Error saving new door: " .. err)
                end
            end
        end
        propertyData.door_data = {count = #propertyData.door_data}
        Wait(1000)
    end

    id = tostring(id)
    propertyData.property_id = id
    PropertiesTable[id] = Property:new(propertyData)

    TriggerClientEvent("ps-housing:client:addProperty", -1, propertyData)

    if propertyData.apartment and not preventEnter then
        local player = QBCore.Functions.GetPlayerByCitizenId(propertyData.owner)
        if not player then
            print("Error: Player not found for citizen ID " .. propertyData.owner)
            return
        end

        local src = player.PlayerData.source
        local property = Property.Get(id)
        if not property then
            print("Error: Property not found for ID " .. id)
            return
        end

        property:PlayerEnter(src)

        Wait(1000)

        local query = "SELECT skin FROM playerskins WHERE citizenid = ?"
        local result = MySQL.Sync.fetchAll(query, {propertyData.owner})

        if result and result[1] then
            Debug("Player: " .. propertyData.owner .. " skin already exists!")
        else
            TriggerClientEvent("qb-clothes:client:CreateFirstCharacter", src)
            Debug("Player: " .. propertyData.owner .. " is creating a new character!")
        end

        Framework[Config.Notify].Notify(src, "Open radial menu for furniture menu and place down your stash and clothing locker.", "info")

        -- This will create the stash for the apartment and migrate the items from the old apartment stash if applicable
        if GetResourceState('qb-inventory') == 'started' then
            TriggerEvent("ps-housing:server:createApartmentStash", propertyData.owner, id)
        else
            print("Error: qb-inventory is not started")
        end
    end

    return id
end

local function getMainDoor(propertyId, doorIndex, isShell)
    -- ps_mloproperty is prefix, self.property_id is property unique id, 1 is main door index, cause mlo can have multiple doors

    if isShell then
        local property = Property.Get(propertyId)
        if not property then return end
        return {
            coords = property.propertyData.door_data
        }
    end
    
    local id = ('ps_mloproperty%s_%s'):format(propertyId, doorIndex)
    return DoorResource == 'ox' and exports.ox_doorlock:getDoorFromName(id) or DoorResource == 'qb' and exports['qb-doorlock']:getDoor(id)
end
exports('getMainDoor', getMainDoor)
lib.callback.register("ps-housing:cb:getMainMloDoor", function(_, propertyId, doorIndex)
    return getMainDoor(propertyId, doorIndex)
end)

exports('registerProperty', RegisterProperty) -- triggered by realtor job
AddEventHandler("ps-housing:server:registerProperty", RegisterProperty)

lib.callback.register("ps-housing:cb:GetOwnedApartment", function(source, cid)
    Debug("ps-housing:cb:GetOwnedApartment", source, cid)
    local result
    if cid ~= nil then
        local success, err = pcall(function()
            result = MySQL.query.await('SELECT * FROM properties WHERE owner_citizenid = ? AND apartment IS NOT NULL AND apartment <> ""', { cid })
        end)
        if not success then
            print("Error querying database for owned apartment with cid: " .. cid .. " - " .. err)
            return nil
        end
    else
        local src = source
        local Player = QBCore.Functions.GetPlayer(src)
        if not Player then
            print("Error: Player not found for source: " .. src)
            return nil
        end
        local success, err = pcall(function()
            result = MySQL.query.await('SELECT * FROM properties WHERE owner_citizenid = ? AND apartment IS NOT NULL AND apartment <> ""', { Player.PlayerData.citizenid })
        end)
        if not success then
            print("Error querying database for owned apartment with citizenid: " .. Player.PlayerData.citizenid .. " - " .. err)
            return nil
        end
    end

    if result and result[1] then
        return result[1]
    else
        print("No owned apartment found for the given criteria.")
        return nil
    end
end)

lib.callback.register("ps-housing:cb:inventoryHasItems", function(source, name, isOx)
    local success, result
    if isOx then
        local items = #exports.ox_inventory:GetInventoryItems(name)
        return items and items > 0
    end

    local query = lib.checkDependency('qb-inventory', '2.0.0') and 'SELECT items FROM inventories WHERE identifier = ?' or 'SELECT items FROM stashitems WHERE stash = ?'
    
    success, result = pcall(function()
        return MySQL.query.await(query, { name })
    end)

    if not success then
        print("Error querying database for inventory items: " .. result)
        return false
    end

    if not result or not result[1] then
        print("No items found for inventory: " .. name)
        return false
    end

    return result[1].items ~= '[]'
end)

AddEventHandler("ps-housing:server:updateProperty", function(type, property_id, data)
    local property = Property.Get(property_id)
    if not property then return end

    property[type](property, data)
end)

AddEventHandler("onResourceStart", function(resourceName) -- Used for when the resource is restarted while in game
	if (GetCurrentResourceName() == resourceName) then
        while not dbloaded do
            Wait(100)
        end
        TriggerClientEvent('ps-housing:client:initialiseProperties', -1, PropertiesTable)
	end 
end)

RegisterNetEvent("ps-housing:server:createNewApartment", function(aptLabel)
    local src = source
    local citizenid = GetCitizenid(src)
    if not Config.StartingApartment then return end
    local PlayerData = GetPlayerData(src)

    local apartment = Config.Apartments[aptLabel]
    if not apartment then return end

    local propertyData = {
        owner = citizenid,
        description = string.format("This is %s's apartment in %s", PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname, apartment.label),
        for_sale = 0,
        shell = apartment.shell,
        apartment = apartment.label,
    }

    Debug("Creating new apartment for " .. GetPlayerName(src) .. " in " .. apartment.label)

    Framework[Config.Logs].SendLog("Creating new apartment for " .. GetPlayerName(src) .. " in " .. apartment.label)

    RegisterProperty(propertyData)
end)

-- we show the character creator if they spawn without starting appartment and doesn't have skin set
RegisterNetEvent("QBCore:Server:OnPlayerLoaded", function()
    if Config.StartingApartment then return end

    local src = source
    local citizenid = GetCitizenid(src)
    local query = "SELECT skin FROM playerskins WHERE citizenid = ?"
    
    local success, result = pcall(function()
        return MySQL.Sync.fetchAll(query, {citizenid})
    end)

    if not success then
        print("Error querying database for player skin: " .. result)
        return
    end

    if result and result[1] then
        Debug("Player: " .. citizenid .. " skin already exists!")
    else
        TriggerClientEvent("qb-clothes:client:CreateFirstCharacter", src)
        Debug("Player: " .. citizenid .. " is creating a new character!")
    end
end)

-- Creates apartment stash
-- If player has an existing apartment from qb-apartments, it will transfer the items over to the new apartment stash
RegisterNetEvent("ps-housing:server:createApartmentStash", function(citizenId, propertyId)
    local stashId = string.format("property_%s", propertyId)

    -- Check for existing apartment and corresponding stash
    local query = lib.checkDependency('qb-inventory', '2.0.0') and 'SELECT items, identifier FROM inventories WHERE identifier' or 'SELECT items, stash FROM stashitems WHERE stash'
    local success, result = pcall(function()
        return MySQL.query.await(('%s IN (SELECT name FROM apartments WHERE citizenid = ?)'):format(query), { citizenId })
    end)

    if not success then
        print("Error querying database for existing apartment stash: " .. result)
        return
    end

    local items = {}
    if result[1] ~= nil then
        items = json.decode(result[1].items)

        -- Delete the old apartment stash as it is no longer needed
        local deleteSuccess, deleteResult = pcall(function()
            MySQL.Async.execute('DELETE FROM stashitems WHERE stash = ?', { result[1].identifier or result[1].stash })
        end)

        if not deleteSuccess then
            print("Error deleting old apartment stash: " .. deleteResult)
            return
        end
    end

    -- This will create the stash for the apartment (without requiring player to have first opened and placed item in it)
    local saveSuccess, saveResult = pcall(function()
        TriggerEvent('qb-inventory:server:SaveStashItems', stashId, items)
    end)

    if not saveSuccess then
        print("Error saving new apartment stash: " .. saveResult)
    end
end)

RegisterNetEvent('qb-apartments:returnBucket', function()
    local src = source
    QBCore.Functions.SetPlayerBucket(src, 0)
end)

AddEventHandler("ps-housing:server:addTenantToApartment", function (data)
    local apartment = data.apartment
    local targetSrc = tonumber(data.targetSrc)
    local realtorSrc = data.realtorSrc
    local targetCitizenid = GetCitizenid(targetSrc, realtorSrc)

    -- id of current apartment so we can change it
    local property_id = nil

    for _, v in pairs(PropertiesTable) do
        local propertyData = v.propertyData
        if propertyData.owner == targetCitizenid then
            if propertyData.apartment == apartment then
                Framework[Config.Notify].Notify(targetSrc, "You are already in this apartment", "error")
                Framework[Config.Notify].Notify(targetSrc, "This person is already in this apartment", "error")

                return
            elseif propertyData.apartment and #propertyData.apartment > 1 then
                property_id = propertyData.property_id
                break
            end
        end
    end

    if property_id == nil then
        local newApartment = Config.Apartments[apartment]
        if not newApartment then return end

        local citizenid = GetCitizenid(targetSrc, realtorSrc)
        local targetToAdd = QBCore.Functions.GetPlayerByCitizenId(citizenid).PlayerData
        local propertyData = {
            owner = targetCitizenid,
            description = string.format("This is %s's apartment in %s", targetToAdd.charinfo.firstname .. " " .. targetToAdd.charinfo.lastname, newApartment.label),
            for_sale = 0,
            shell = newApartment.shell,
            apartment = newApartment.label,
        }

        Debug("Creating new apartment for " .. GetPlayerName(targetSrc) .. " in " .. newApartment.label)

        Framework[Config.Logs].SendLog("Creating new apartment for " .. GetPlayerName(targetSrc) .. " in " .. newApartment.label)

        Framework[Config.Notify].Notify(targetSrc, "Your apartment is now at "..apartment, "success")
        Framework[Config.Notify].Notify(realtorSrc, "You have added ".. targetToAdd.charinfo.firstname .. " " .. targetToAdd.charinfo.lastname .. " to apartment "..apartment, "success")

        RegisterProperty(propertyData, true)

        return
    end

    local property = Property.Get(property_id)
    if not property then return end

    property:UpdateApartment(data)

    local citizenid = GetCitizenid(targetSrc, realtorSrc)
    local targetToAdd = QBCore.Functions.GetPlayerByCitizenId(citizenid)
    local targetPlayer = targetToAdd.PlayerData

    Framework[Config.Notify].Notify(targetSrc, "Your apartment is now at "..apartment, "success")
    Framework[Config.Notify].Notify(realtorSrc, "You have added ".. targetPlayer.charinfo.firstname .. " " .. targetPlayer.charinfo.lastname .. " to apartment "..apartment, "success")
end)

exports('IsOwner', function(src, property_id)
    local property = Property.Get(property_id)
    if not property then return false end

    local citizenid = GetCitizenid(src, src)
    return property:CheckForAccess(citizenid)
end)

function GetCitizenid(targetSrc, callerSrc)
    local Player = QBCore.Functions.GetPlayer(tonumber(targetSrc))
    if not Player then
        Framework[Config.Notify].Notify(callerSrc, "Player not found.", "error")
        return
    end
    local PlayerData = Player.PlayerData
    local citizenid = PlayerData.citizenid
    return citizenid
end

function GetCharName(src)
    local Player = QBCore.Functions.GetPlayer(tonumber(src))
    if not Player then return end
    local PlayerData = Player.PlayerData
    return PlayerData.charinfo.firstname .. " " .. PlayerData.charinfo.lastname
end

function GetPlayerData(src)
    local Player = QBCore.Functions.GetPlayer(tonumber(src))
    if not Player then return end
    local PlayerData = Player.PlayerData
    return PlayerData
end

function GetPlayer(src)
    local Player = QBCore.Functions.GetPlayer(tonumber(src))
    if not Player then return end
    return Player
end