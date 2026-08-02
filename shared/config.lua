PropertiesTable = {}
ApartmentsTable = {}

exports('GetProperties', function() return PropertiesTable end)
exports('GetApartments', function() return ApartmentsTable end)

Config = {}

-- If you're not utilizing ox_lib, it's time to question your approach.
Config.Target = "qb" -- "ox" or "qb"
Config.Notify = "qb" -- "ox" or "qb"
Config.Radial = "qb" -- "ox" or "qb"
Config.Inventory = "ox" -- "ox" or "qb"
Config.Logs = "qb" -- "qb"

-- Anyone provided with keys to a property has the ability to modify its furnishings.
Config.AccessCanEditFurniture = true

-- How many "storage" furniture props a property may hold. Each one opens its own
-- ox_inventory container, so this caps the total storage of a location.
-- evange-housing doors override this with a per-door value chosen at placement.
Config.MaxStashFurniture = 2

-- Draw the poly for the property
Config.DebugMode = false

function Debug(...)
    if Config.DebugMode then
        print(...)
    end
end

-- Log System
Config.EnableLogs = true

-- Enables Dynamic Doors
Config.DynamicDoors = false

Config.PoliceJobNames = {  -- add multiple police jobs that are allowed to raid properties!
    "police",
    -- "police2",
    -- "police3",
}

Config.MinGradeToRaid = 3  -- Minimum grade to raid a property

Config.RaidTimer = 5  -- 5 minutes

Config.RaidItem = "police_stormram"  -- The item required to raid a property

-- If you are using ox_inventory, it is encouraged to use the consume property within data/items.lua and keeping this config option false
Config.ConsumeRaidItem = false          -- Whether or not to consume the raid item upon successful entry.

-- Set your Real Estate jobs here
Config.RealtorJobNames = { -- add multiple realestate jobs that are allowed to sell properties!
    "realestate",
    -- "realestate2",
    -- "realestate3",
}

-- If you are utilizing qb-banking and wish for the funds to be deposited directly into the Realestate bank account, set this value to true. 
-- In case you are using an alternative Boss Menu, replace the qb-banking export with the appropriate script export or event.
Config.QBManagement = true

-- Realtor Commisions based on job grade, the rest goes to the owner, if any.
Config.Commissions = {
    [0] = 0.05, -- 5% commision for each sale
    [1] = 0.10,
    [2] = 0.15,
    [3] = 0.20,
    [4] = 0.25,
}

-- Set this value to false if you don't want to assign a starting apartment.
Config.StartingApartment = false

--- With this enabled, the customizer will open when starting apartment is false.
Config.ShowCustomizerWhenNoStartingApartment = false

Config.Apartments = {
    ["Integrity Way"] = {
        label = "Integrity Way",
        door = { x = 269.73, y = -640.75, z = 42.02, h = 249.07, length = 1, width = 2 },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/e5a352a3-afb1-4452-ab52-e239e53d901a.png",
                label = "Outside",
            },
        },
        shell = "Apartment Furnished",
    },

    ["South Rockford Drive"] = {
        label = "South Rockford Drive",
        door = { x = -667.02, y = -1105.24, z = 14.63, h = 242.32, length = 1, width = 2 },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/aa88b5df-c4c8-4706-beb0-8d8197e0ccff.png",
                label = "Outside",
            },
        },
        shell = "Apartment Furnished",
    },

    ['Morningwood Blvd'] = {
        label = 'Morningwood Blvd',
        door = { x = -1288.52, y = -430.51, z = 35.15, h = 124.81, length = 1, width = 2 },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/c53dbc10-d161-4b34-a095-316949588f33.png",
                label = "Outside",
            },
        },
        shell = "Apartment Furnished",
    },

    ['Tinsel Towers'] = {
        label = 'Tinsel Towers',
        door = { x = -619.29, y = 37.69, z = 43.59, h = 181.03, length = 1, width = 2 },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/0663c90e-2e90-426d-80ea-a780727b4a76.png",
                label = "Outside",
            },
        },
        shell = "Apartment Furnished",
    },

    ['Fantastic Plaza'] = {
        label = 'Fantastic Plaza',
        door = { x = 291.517, y = -1078.674, z = 29.405, h = 270.75, length = 1, width = 2 },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/d618a25e-2f88-47c5-b065-515cbd34cb3f.png",
                label = "Outside",
            },
        },
        shell = "Apartment Furnished",
    },

    ---ipl
    ['Modern 1 Apartment'] = {
        label = 'Appartement Modern 1',
        door = { x = -771.18, y = 319.64, z = 85.66, h = 351.95, length = 1, width = 2 },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/d618a25e-2f88-47c5-b065-515cbd34cb3f.png",
                label = "Outside",
            },
        },
        interior = vector3(-786.8663, 315.7642, 217.6385),
        thickness = 7.5,
        zone = {
            vector3(-787.3, 317.37, 219.5),
            vector3(-787.29, 314.34, 219.5),
            vector3(-780.56, 314.15, 219.5),
            vector3(-780.54, 343.62, 219.5),
            vector3(-793.98, 343.54, 219.5),
            vector3(-793.33, 333.82, 219.5),
            vector3(-794.68, 339.83, 219.5),
            vector3(-800.69, 339.94, 219.5),
            vector3(-807.54, 334.88, 219.5),
            vector3(-807.29, 331.75, 219.5),
            vector3(-799.8, 321.23, 219.5)
        },
        shell = "mlo",
    },
}

-- Shells provided by K4MB1 https://www.k4mb1maps.com/
Config.Shells = {
    ["mlo"] = {
        label = "Mlo",
        doorOffset = { x = -0.5, y = -2.3, z = 0.0, h = 90.0, width = 1.5 },
        stash = {
            maxweight = 100000,
            slots = 12,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/e39bd4a6-bc3f-41e7-876e-cc03d77f953b.jpg",
                label = "Motel",
            },
        }
    },

    ["Standard Motel"] = {
        label = "Standard Motel",
        hash = `standardmotel_shell`,
        doorOffset = { x = -0.5, y = -2.3, z = 0.0, h = 90.0, width = 1.5 },
        stash = {
            maxweight = 100000,
            slots = 12,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/fb1f1038-2b38-4cee-b031-e0bca4c108ed.webp",
                label = "Motel",
            },
        }
    },

    ["Modern Hotel"] = {
        label = "Modern Hotel",
        hash = `modernhotel_shell`,
        doorOffset = { x = 4.98, y = 4.35, z = 0.0, h = 179.79, width = 2.0  },
        stash = {
            maxweight = 150000,
            slots = 20,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/33d4b3e2-9c5a-43d8-a43e-f111f25a62df.webp",
                label = "Angle 1",
            },
            {
                url = "https://files.fivemerr.com/images/7dc8efd9-d2c7-4878-a7d7-74d69e47cc96.webp",
                label = "Angle 2",
            },
        }
    },

    ["Apartment Furnished"] = {
        label = "Apartment Furnished",
        hash = `furnitured_midapart`,
        doorOffset = { x = 1.44, y = -10.25, z = 0.0, h = 0.0, width = 1.5  },
        stash = {
            maxweight = 200000,
            slots = 25,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/884a835f-9d5d-4121-8576-b23c51f48a00.webp",
                label = "Bathroom",
            },
            {
                url = "https://files.fivemerr.com/images/3381c0b8-1e57-4aa7-bb61-5b1202523db9.webp",
                label = "Bedroom",
            },
            {
                url = "https://files.fivemerr.com/images/5b5b66a5-50f5-437c-9fb8-ebb5a7ecec11.webp",
                label = "Entrance",
            },
            {
                url = "https://files.fivemerr.com/images/5e07d5e9-c069-4db1-a677-d2d0a02def70.webp",
                label = "Kitchen and Dining",
            },
            {
                url = "https://files.fivemerr.com/images/41998ae1-e2f0-4e8a-b9e3-4613e46b3356.webp",
                label = "Living Room Angle 1",
            },
            {
                url = "https://files.fivemerr.com/images/b60325be-e75c-4985-89f2-6e2dfe65951c.webp",
                label = "Living Room Angle 2",
            },
        },
    },

    ["Apartment Unfurnished"] = {
        label = "Apartment Unfurnished",
        hash = `shell_v16mid`,
        doorOffset = { x = 1.34, y = -14.36, z = -0.5, h = 354.08, width = 1.5  },
        stash = {
            maxweight = 200000,
            slots = 25,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/90238f10-e65e-4c89-a879-6be664194258.webp",
                label = "Bathroom",
            },
            {
                url = "https://files.fivemerr.com/images/edfcda70-bca6-419c-84b5-11e173e9edc3.webp",
                label = "Bedroom",
            },
            {
                url = "https://files.fivemerr.com/images/aed9c846-7314-4869-948f-3262e1d141ee.webp",
                label = "Entrance",
            },
            {
                url = "https://files.fivemerr.com/images/a51a4844-2141-472f-bde2-0c07a940ddd0.webp",
                label = "Kitchen",
            },
            {
                url = "https://files.fivemerr.com/images/bcbc0b02-5648-4eb2-bd16-5585a2f14e12.webp",
                label = "Living Room",
            },
        },
    },

    ["Apartment 2 Unfurnished"] = {
        label = "Apartment 2 Unfurnished",
        hash = `shell_v16low`,
        doorOffset = { x = 4.69, y = -6.5, z = -1.0, h = 358.50, width = 1.5  },
        stash = {
            maxweight = 200000,
            slots = 25,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/6e111f0d-a663-4baf-9f64-e38e8c2c6cf8.webp",
                label = "Entrance",
            },
            {
                url = "https://files.fivemerr.com/images/5202fb7b-c178-4a30-8113-2b5d7bd45ea8.webp",
                label = "Kitchen",
            },
            {
                url = "https://files.fivemerr.com/images/f3676be4-49c5-4b4a-9c56-e5ceb228329c.webp",
                label = "Living Room",
            },
        },
    },

    ["Garage"] = {
        label = "Garage",
        hash = `shell_garagem`,
        doorOffset = { x = 14.0, y = 1.7, z = -0.76, h = 88.49, width = 2.0  },
        stash = {
            maxweight = 500000,
            slots = 50,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/dad29136-63f4-486a-8b0c-73bf6717ac10.webp",
                label = "Entrance",
            },
            {
                url = "https://files.fivemerr.com/images/b94621eb-1c3d-4cd6-b849-bd74fe94b601.webp",
                label = "Garage",
            },
        },
    },

    ["Office"] = {
        label = "Office",
        hash = `shell_office1`,
        doorOffset = { x = 1.2, y = 4.90, z = -0.73, h = 180.0, width = 2.0  },
        stash = {
            maxweight = 250000,
            slots = 30,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/b6894303-56a5-4ed6-9c3c-3108563b32b5.webp",
                label = "Entance",
            },
            {
                url = "https://files.fivemerr.com/images/938945b9-fa86-4b88-8264-870c8d25b780.webp",
                label = "Office",
            },
        },
    },

    ["Store"] = {
        label = "Store",
        hash = `shell_store1`,
        doorOffset = { x = -2.69, y = -4.56, z = -0.62, h = 1.91, width = 2.0  },
        stash = {
            maxweight = 500000,
            slots = 50,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/4b071bca-fd50-4d41-ba83-f9080c2da0be.webp",
                label = "Room 1",
            },
            {
                url = "https://files.fivemerr.com/images/ef1ccd1f-85b8-4681-abdd-c798b73eb1e2.webp",
                label = "Room 2",
            },
        },
    },

    ["Warehouse"] = {
        label = "Warehouse",
        hash = `shell_warehouse1`,
        doorOffset = { x = -8.96, y = 0.11, z = -0.95, h = 270.64, width = 2.0  },
        stash = {
            maxweight = 1000000,
            slots = 100,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/35d75b18-aa4f-4226-9b42-8e8ceb723946.webp",
                label = "Angle 1",
            },
            {
                url = "https://files.fivemerr.com/images/b25f0c5d-9c6a-43e4-b082-eac8d1730f98.webp",
                label = "Angle 2",
            },
        },
    },

    ["Container"] = {
        label = "Container",
        hash = `container_shell`,
        doorOffset = { x = 0.05, y = -5.7, z = -0.22, h = 1.7, width = 2.2  },
        stash = {
            maxweight = 500000,
            slots = 100,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/29930411-18a3-4e39-bb4b-80bb5ca9c233.webp",
                label = "Container",
            },
        },
    },

    ["2 Floor House"] = {
        label = "2 Floor House",
        hash = `shell_michael`,
        doorOffset = { x = -9.6, y = 5.63, z = -4.07, h = 268.55, width = 2.0  },
        stash = {
            maxweight = 300000,
            slots = 50,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/5b3fc4b4-fbc7-4020-bb63-50d5bd5ae1ca.webp",
                label = "Bathroom",
            },
            {
                url = "https://files.fivemerr.com/images/a7537dd9-94d7-47ad-bd74-ae3c7fc728d3.webp",
                label = "Entrance",
            },
            {
                url = "https://files.fivemerr.com/images/75f3cc72-ace3-40af-836f-40112fde2ba8.webp",
                label = "Floor 2",
            },
            {
                url = "https://files.fivemerr.com/images/348e6af7-f247-49a0-a4d4-e99995f20d7f.webp",
                label = "Kitchen",
            },
            {
                url = "https://files.fivemerr.com/images/9e8689a9-5860-41b5-b5f1-df9f68cfaea2.webp",
                label = "Living Room",
            },
            {
                url = "https://files.fivemerr.com/images/e4cb286e-acb2-42a4-b41a-e31b0482d7a7.webp",
                label = "Room 1",
            },
            {
                url = "https://files.fivemerr.com/images/b3c0eeec-b5e7-4f41-a82b-f4bdf954c1a7.webp",
                label = "Room 2",
            },
            {
                url = "https://files.fivemerr.com/images/0f327cda-e432-4fd3-9002-973544f3b46a.webp",
                label = "Room 3",
            },
            {
                url = "https://files.fivemerr.com/images/5e2e0778-2709-4bb0-a17d-ac6154fdbd77.webp",
                label = "Room 3 Dresser",
            },
        },
    },

    ["House 1"] = {
        label = "House 1",
        hash = `shell_frankaunt`,
        doorOffset = { x = -0.34, y = -5.97, z = -0.57, h = 357.23, width = 2.0  },
        stash = {
            maxweight = 200000,
            slots = 50,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/5b3fc4b4-fbc7-4020-bb63-50d5bd5ae1ca.webp",
                label = "Bathroom",
            },
            {
                url = "https://files.fivemerr.com/images/71df6160-68b0-4233-a8df-abc0b76401a0.webp",
                label = "Dining Room",
            },
            {
                url = "https://files.fivemerr.com/images/5830cc1b-fd3b-4ff5-8e7b-4a9c81725daf.webp",
                label = "Entrance",
            },
            {
                url = "https://files.fivemerr.com/images/7be14444-b37c-4ad1-b215-e126525f23b0.webp",
                label = "Kitchen",
            },
            {
                url = "https://files.fivemerr.com/images/f7e3d82b-26d3-4550-acdb-a5d6f2aacdce.webp",
                label = "Living Room",
            },
            {
                url = "https://files.fivemerr.com/images/b0d64302-f411-40fd-9d08-b2c19473960b.webp",
                label = "Room 1",
            },
            {
                url = "https://files.fivemerr.com/images/5b3fc4b4-fbc7-4020-bb63-50d5bd5ae1ca.webp",
                label = "Room 2",
            },
        },
    },

    ["House 2"] = {
        label = "House 2",
        hash = `shell_ranch`,
        doorOffset = { x = -1.23, y = -5.54, z = -1.1, h = 272.21, width = 2.0  },
        stash = {
            maxweight = 500000,
            slots = 50,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/5f9b5a4a-d607-4fef-954e-aab0c25457d6.webp",
                label = "Entrance",
            },
            {
                url = "https://files.fivemerr.com/images/31be06b1-d092-41e4-bd90-b23ca06fdf51.webp",
                label = "Hallway",
            },
            {
                url = "https://files.fivemerr.com/images/a498685d-31bc-487c-83be-d479529dc36e.webp",
                label = "Kitchen",
            },
            {
                url = "https://files.fivemerr.com/images/87cbc4d9-e3aa-4709-9504-26a56816b3d9.webp",
                label = "Main Area",
            },
            {
                url = "https://files.fivemerr.com/images/2bc3d6b6-3d22-4865-82dd-594c2d48fad9.webp",
                label = "Room",
            },
        },
    },

    ["House 3"] = {
        label = "House 3",
        hash = `shell_lester`,
        doorOffset = { x = -1.61, y = -6.02, z = -0.37, h = 357.7, width = 2.0  },
        stash = {
            maxweight = 15000,
            slots = 20,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/c43c554f-8bc4-4028-9d6e-599aff60c4e8.jpeg",
                label = "Angle 1",
            },
            {
                url = "https://files.fivemerr.com/images/a2cf4128-2d3a-4aa4-a19b-186edc7813c5.jpeg",
                label = "Angle 2",
            },
            {
                url = "https://files.fivemerr.com/images/5a669e54-2080-45fd-bf8c-0dd9075e3258.jpeg",
                label = "Entrance",
            },
        },
    },

    ["House 4"] = {
        label = "House 4",
        hash = `shell_trevor`,
        doorOffset = { x = 0.2, y = -3.82, z = -0.41, h = 358.4, width = 2.0  },
        stash = {
            maxweight = 10000,
            slots = 12,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/cfc6d14e-d198-427a-a45c-fa1e0b1a8121.webp",
                label = "Bathroom",
            },
            {
                url = "https://files.fivemerr.com/images/30f5c5b2-8591-4fef-9ebf-2095c508605b.webp",
                label = "Entrance",
            },
            {
                url = "https://files.fivemerr.com/images/9babd5ff-7421-4a38-9b86-4900b3c0901f.webp",
                label = "Kitchen",
            },
            {
                url = "https://files.fivemerr.com/images/d2dda0ca-aa9d-4826-9cd0-be6e1ee37f6b.webp",
                label = "Living Room",
            },
            {
                url = "https://files.fivemerr.com/images/9309b115-3266-48af-952d-cdcb39573b3e.webp",
                label = "Room 1",
            },
            {
                url = "https://files.fivemerr.com/images/2c5625ed-af05-49f3-a7ca-256fef131988.webp",
                label = "Room 2",
            },
        },
    },

    ["Trailer"] = {
        label = "Trailer",
        hash = `shell_trailer`,
        doorOffset = { x = -1.27, y = -2.08, z = -0.48, h = 358.84, width = 2.0  },
        stash = {
            maxweight = 10000,
            slots = 12,
        },
        imgs = {
            {
                url = "https://files.fivemerr.com/images/a52b4053-ffb5-430c-a578-1aa09ebea723.webp",
                label = "Entrance and Kitchen",
            },
            {
                url = "https://files.fivemerr.com/images/603bc770-1a8f-43a1-b8d2-d15f9af87f59.webp",
                label = "Main",
            },
            {
                url = "https://files.fivemerr.com/images/222716c0-9a27-4269-8c5b-698c218ec2d9.webp",
                label = "Room",
            },
        },
    },

    -- Shell Creator
    ["empty_room"] = {
        label = "empty_room",
        hash = `kq_sbx_shell_9`,
        doorOffset = { x = 0.0, y = 4.0, z = 1.0, h = 180.0, width = 1.5 },
        stash = {
            maxweight = 100000,
            slots = 12,
        },
        imgs = {},
    },
        
    ["shell_luxe_1"] = {
        label = "Appartement Luxe 1",
        hash = `kq_sbx_shell_5`,
        doorOffset = { x = 6.0, y = 4.0, z = 1.0, h = 270.0, width = 1.5 },
        stash = {
            maxweight = 100000,
            slots = 12,
        },
        imgs = {
            {
                url = "data:image/webp;base64,UklGRn4YAABXRUJQVlA4WAoAAAAgAAAA3wEADQEASUNDUBgCAAAAAAIYAAAAAAQwAABtbnRyUkdCIFhZWiAAAAAAAAAAAAAAAABhY3NwAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAQAA9tYAAQAAAADTLQAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAlkZXNjAAAA8AAAAHRyWFlaAAABZAAAABRnWFlaAAABeAAAABRiWFlaAAABjAAAABRyVFJDAAABoAAAAChnVFJDAAABoAAAAChiVFJDAAABoAAAACh3dHB0AAAByAAAABRjcHJ0AAAB3AAAADxtbHVjAAAAAAAAAAEAAAAMZW5VUwAAAFgAAAAcAHMAUgBHAEIAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAAFhZWiAAAAAAAABvogAAOPUAAAOQWFlaIAAAAAAAAGKZAAC3hQAAGNpYWVogAAAAAAAAJKAAAA+EAAC2z3BhcmEAAAAAAAQAAAACZmYAAPKnAAANWQAAE9AAAApbAAAAAAAAAABYWVogAAAAAAAA9tYAAQAAAADTLW1sdWMAAAAAAAAAAQAAAAxlblVTAAAAIAAAABwARwBvAG8AZwBsAGUAIABJAG4AYwAuACAAMgAwADEANlZQOCBAFgAAMHIAnQEq4AEOAT6dSKBMpaOjKCJ0yiEAE4lnbuFlgNNhn7f6xE11qHZ39n+2bvVoAu8ama/dGWv6hd+xIN6Q+dn7H9gfy4/YZ6TA5+NN3d3d3iONpu7utCkgbJ05Ii82m7u7u2kJLE3agARlz3wefAju7u7u7u7u7u7vEhzM0HZIxlJaRozMzMzMzmRXGtby9mdsvAcDDP+RozMzOZBectJ3cwBUXT6bT79qedcuszMzMzCoqL+KHXsomHZXHw4kCXoozg6Pu/Xy8gXVlZsZPBo8wmMlbrMPKKK9WiwBvOEQIq/IiIiFir4C3/8GVbJMNnL7TgvjOY2cVdRS4yTXCCi7x/hMYbw+vjjZm72d9gpApvmiWTCZaHJmic7RqxnPmt3N+0BiNXEl29tcIiII/+8W7v/+V+XnGx2jPXiQ4RTStAGQq3/96SsiS+dM1JvAlakr+ffDPQoVe2jVSRkkxDiRDVbi0a/M9iroKXX19CSRqbgO8Hh/jxGnQ+IFS4TipWQjlvUdcPKZJhdHPmSuQ+5sOLMd3e3XSHu2KulswpXvp3x9eyiGregtuPWPx+jjClXpxYK6H2add9qu1zi5bb2BMakc4H0gbdXuzCNYKOv/q8yAbncsxggsvTq+zZeotyvehUoS9S4F7wBEb5UVww82ff2GM5EEPBlh9ceb67u7HuuIQxNvLbVyT/XYbb1RK9eUccvTHgz4wmlPMjxpsdg/MuwIkoURYRSaBoEat+ZcnSMuKAFIXJLr2mP77WsDJYMHjF6qoXMehQX4Dw1ZuXbkbPTU9Dr0XLE7BOyTd2dllYoa1hqHz9sVwriSt5f/IHfc93Wb1fj2tsB/4FoF4fkvCz+n/qJ69R0DAGlu5Yqs8ysi7cy37f3qWrRW8nkbCrqmn3O31LAhzeyGWN/R4NNojd3fODA0pXgAKQvxKJwhIEVkCrHYT8zK37OxjTPIMYTkIfvXqWy8IN7zW8vUWxscf1Njz/GZu+vyIiIiIiFsLlEzYkdv4UhvwPbMCbBml6rrwDdNOL1FsbzZSbTd3d3d3Z8t5Akq8KwpS7yUAWbJ50RXHCAP/N5GwNJPnElF0HjINoeqqqqq2BjES5DMC1ZmSdar3/Q/ykNYgFMUtQRbtvsjEKS7mlVVVUS9EScnwgJeJOyzsDMmItYZqldppcRe+shjj691jc67Y3yWoH/hGZmZnBr74ciG8ndVpuuGcFUPLap3h9HAAAD+/H3ASt2dpQQYHJcpnPJsrLfbQvRWRi2Gb0K27FRclOSfLNlYvwFrMUO7IogAAAAAAdxPd/oABrBdzohxoQBObN2azoYUdgIKTTc6dOLZUfdBPCstbKeH2OLIHMRlaEfchQQJJwFhRr+t/rXxlgBZgIdJl2GC7bSeHWtSElePQAAylUCBTegcyR4oTUFQ+dc1nJJnB0qId9p8dZCLa+OLjZv25W6EWRomUIw1J/MENxlNSMLr9EwT/B+154Afs/ekQUBC8oIIAEYemtRfRL8D+Pg4oc8eQc/0yi5Dm/2q7KbYVwcMkPhM+EWPfnVTZWgyYoHRgo5Bpem9BSyaS6VUWs0eghaWm16s0sycD05x0ogpSAHbrV+nG+Jq1BdEfSivmXJQaTy0X3qnGuDwmPhKYIlgYuMq5iQEcO5cFc9cdByVkhFUGJIY7fJMcoDrS1R8PXcj28X9W0siGEeGY3Jdj1bc+T5TJ18D7q9vY5+5jzq+j8WYA12U59ekSsBBMe9jJyI2AB4HG/4HctvrViqDwcpnI6zk8P5995uFLMtA7bLL/6GjDX93Vpy0sLPdHIzZ/KZlY0F7BsXQNJB6RwjtPUnsHENo4KDs7pFiFbkj758yLk3p60oreR/1P34VKcZ1xE5WbKkbA3553cju/xVw9Va7Efb39kPZSen+ayBQtnFFmhIs3oYAABIyVrByLNSk1vCqlYQ4G7i6MjneVIitqOhTVmYUqIEQ35JgTqHhqWAqn81i2n1r9W4mV7elj3lDA2JMGK49G1qaLTzMwC6T3hizrOE1iVFEEar0TGsf9rkXW4YX7P5KUhHIPa+tRchyRnztpnqwk413c7IIk2iLRnBiKWT4YwTKE0pbY+Lc+GYFPCphvb4bwTk/c524W8WlxbpzgzI/mGNGq0J56WRKvRvHodcyG+lNsfJWHDneM3xUqgSshOqklfG05lbk58GzWgMIPzCDfSCnhdHLgpWJ9gtDKKx5jwIMHxklX6F+Ha/c9Fd5GfP7dt9g4GzwF2TlqaWSgHBm8lcCODAkJIP3Wda7i063QImiM5o5b79SQEusYjPJihVwjhOJODZdXcFB7JHKZ4cjjcxkgd2dNxyphBtQuYzI3BmeksToQdYbChCpwcefIfTQlACl9JmxRFfM5toVpHDS3mYE3BJr0qn2IuFu0nDaI8+9BiLX9fpist6WCcj+5xfx0fAZ/PMbsSltEI1SxdisxoN7KOaGqK+qB+qjSsuYo3PQQA8ZkRkm4GzQJgppx4OYZWYZCTdP+gc8d8ItU0yHD7JWwLsTbWFR9RZ3Tlc2xFn0Ow3wibr/Fzs5Qk3/JufTWdgzckp2DIkpM9aq4QXUb7Va+516DxkFOmwO4foAKnfgRo0IUJgM6/NGvHmaTEoNLXMT+UTeRfKTY3soF69HqIl230ql92nZW3C4NjNUTevJNf7JvK09+MTZfUDxNDjEDOL4KjxlS7AhpQr/WPwDyFWZlV6wO0AlMi76P97+DffD7KPQcKbeP+pWfqm7r87znfB4pIS6pAZdwWgN7pbYXbcKpeENPxUBaUlx0AfdiRxY71szFns4cNzZwEzCFj8esHNSbUaJ5RcekDwvstvqv9qomzPvddIqXUtTJJvyVFvjcUkbfrry8YaiP7f5Tpc32d5EwMHPiputMOsPutqBR9rmpDbiw6PUPVq2mhyBJUwQmq0Ly2VgrAOYgKBXKLC5mIte835lF48yjM4xOBg5nVvnggV/i3Z8PM6H1Rp6Wg8Nk8jkfu5TUyjYgUsRSGYYxjj7qKbMeA7bRXpf7toqNG7Xq3Q15fddfAZGoxajgqmmLu3++lAbpWoKNbiS0yw3ztK500iwnU68kT4bXvTKbVysk0iJULUl/B16NHianK88JjjUE3Ikl4XVfRuB85Gz8i4AI5Yh9OsJKH4BJC86AofFDDCsHJKS4RoMK+Rw6lEUYklYCbWAB5ZNQCPxZWIMIwGQRLKIMlOxHShI5ssoGjvUuGx00bh1CZg4nQPuN9G7co8JRf6BmS9kBGmkOHhR2VqPzJS+XekUkQEgNssAMtBqi8+X+Zi3jt1Gkg0qAcY3tY6FmzZzuFFuXzK4IsHtA7DQgXVqfVWKJCi+uGyG5ztZI1OA7b3QH+Zc8+6Ko9YIxkZTXZc+Sf5GzHaM1y2/HnnAnNKVpgUp+VEpZ/BgqB9im5/D9wl3uEBWH0RJodZjWG1hSsKis6YTTz6q/sTlq540Gkjd3yboKkd9LtnJFCCv2T5uhln46sjkgBaXOaJGuSNGX94rSGdYXfpruIWyaaunGPrfj+W/nmIZD/ICVr0PwprTqeP17a0JpLBw4cHf3iAF6CjEDqtdSwRJn66K/TS2nYcqtzGovwQDiyJ58y5SnVogkEITHg4epxDS3JjrEkdAkSaNMeRNeVd/fxDIZrZIlNjYdOHT2F4CaFRAYD0V+rti2qpQ6UmlvDvWkUBSlgd9QB0pOYfpIbx4af3dpGtcWxsx80qKVe3+d7UHkc2m4gjGTtfZrAsXHHoCI56LT/fpnBrXqVmcVo8SD8r+Sj79bOknyjo88CPJ6Eg3lsMAl3+SgTsTLa4VcwFUtat9eJnIxsBkekcSs+iMWBF/c8Fm447uI9zHInYlAxNcIUbZ/gl8/R/9Yzrqx6pkx2XGInzqZKMdXQLirvz33PHkxX70V6c9u8lVPWgVrWILdwc5Q13tou7DbAScUchiBayeSjaGscuDjMIUOB8g57wk2/ZM8lJHB9RIZx2RmIpYnUv4+mvAw5pdOOHFa5oL/jN+4QtXhK6uvCNcSTqt5wi5ogXoQHHwOQ+wg7n4ddPz0YE232r9ucD9GcAxcMIvQAZAPtGkVuwfJcO+ntLX31VsS5wNsmbT95FeOvUe8qJdFs0V0g1gJsVpKDaz4qtZI6xWqOJLvjX94iKnYQxUFZ/ObakEIur7vUQJwqLb/EKZBg9/h6WsPsP+Kl8WHSQsGLRdTZEGftar8rkb97SOCi2l2FL2gj9kkYyP/HJzFvrKYho4ePRhcnv116MPHqXEtlSFUSc05Ds8dqaE689lmvH/82GTg4qlBXoEAYkGg4y2D+la9xJACk2syebG3nA1smTi8uA6yEFlmWwoKZ+sf9n0A83vwowj+3dOyZGQQSiyPJRMbh9z6rqRs1UEIPohKo57/Q1aEKiZ/xk5ntXwFsG2zDosB3a8VDn8UDz+K5R6lJsxaML0H3DgzyPbXhriICB50sN80oTWVFOMGTcUMhX/LF3M3YUxQN9qbEgFgv+CrzwVSJyWIyBPzBGFsfMwPoGGRX2/Y+HzgGy513lx+vFUhfw8bKY+Rbos4vLsHdXTCAFc1lRIsgQCQ4IX+p6vlnmQ2Xe+ORD8DFdLHEjA/EnvM/uGHEgP1BbcFZgo0zbADcMfMcydlKMkP1QSqJ0aNW04u5ySGRQ4MxS5ODKBx09UsAss5D/kMEYuS5/m+wJSMpF89dQaON+ZEf28q92qqxOAgz8vAosAPsK33LaX/oah/qGW6gidPsqfUPHlH7cTxrpvEXvgDh7Ap2j81zeawAw9W24JI0IGKYHy7YmvY3TGLE6vbHz3PX8kgBY3yNmdDurlkTs0yJBXBNp+7VC8Omx4cCCNe/0IY4GNfiXI5wlRw3hMAUZaus+6zKoJyYUsMe8ltE6aYIcdPh+B6eLzJgwcKGIBD90qarPL8wDEgPSasQlzi1U4skxGvRACgIKcyTm5GjWWjlH6UJNDismHSfRLCH53Q1WheF1RHLRpVsyhmTXslJbbQopoQ6SdS+OwSOnI9Jwj/lrhBXSDvQgdKw3HMN6Pr8VUe/aLisTWWFlMmT68Z4JOgfIvZ9BUTTCMhEKal0ws4FaUqIUshwm1mgSXB7ySWe9n2GAbuWRAhj6dLmXCbJeNB3T3l8swMVBQXV/Wx5ejaLUwbHLrobrmO7EZDzD8j00jOohA9z8eNVssJsDlCeLOcvHpltxWEy8Im9x4zb4jEDGghJQbDMdAHd9mFJqqMYyBI4EmvtVFTIF42zHxCitLdXXCROhSnFTTY4zYxsd0cRyaXP5yeGiq4Z5taFTvQi2CvLUvU3bWP8RlmmkehR620VEos8NbeVGSB99qVTkRKpwbN7BOqnM4aUVT70dcFib72N0QBc4Xzc0knIWKsNi5rlVt7jAgcnrDKlG0SNy7VPoLEEsdw/0BwlcuHntWcJSJt2RxHQPFXz/R1A2vpnB8CJHuft5lFrXixaiTm7R+9LXiyCXGgvPjxPDKZoYsp5grGcawfsWmDOpVT9B7PAOZ0xNPFKyc/nqgDax1p2Q+TlqFPocx6v4x7tAUy5julXPxX8LERU2Gr46//yAs3uDKxqGOeEwJANfPE8DGuCsrqI1gAqsh9jP1oSW0KFd0yQVmIuRXvwv55ouEf6jeubmu+TPqjX75OiQIniwL317UAd5swwPG4GR75c68+mmGV/Fzojq1KpISLKNtSynG2KJEPDzHQJ9pxae29VazkoMaT5N5IO02vMkifZxE5dil99NTFLjbn+4GAzliBdS8irnWZV8NSLRgmDTWnxP/5oc4FavzpQ7BgGK1CPp0ujFXG5nU5VsZXEA+Dtk5dDve31iGn5fZ73bVvk6CSyJ6CckRt2akzKXojmWB97Te9nLBDvBKP7VO/LLGMTH3zyyn843zIAv8UhFAVBtaOhAEcQQ26KFaQx4cbWiY9PODszvlEcky2wHjh53Cs6PE2FIkRMaipgeqlyth0BRU9KQOdfVpWXfx3iy0I2nv/8sHVYhPPsZLv+g+/THSRZASx+bSzE1gytPwIcq+ipPIHosrHTwOPfcq4HCxPIPM+HbGJ7lvIlcOkHFbbJQD2rLjceImNx7P8nBKLRlmTp0gs/1qhm2VWWlHtq7c9lJuxXHdYxPaD2Uiv6M71O8f47CCv4DAxMsaiHEiOPMRcJMcWHKM+Nu0WVMVSndDilpbY3fd5wCD/8byzTI8bKHmlqUyJW93mqlxTWeANZOVSOXxPoM5viMku1GnCCUm/HNvyY098pcqy7YPo8TuVxcMiqmAaK4H2bXDyL6wB26dnfLj8e8l50MnVUUACVolXnioQSvmlE8bdrXsWb06XZD58iE27sC3YZuF8NJ1qNtrUOFH7hVAAvT02gd8YnYG5SCTn8D4uTqM0tR1DtGTwX/ilHyu/nfALdQ2Ucs4u/LhaRK6iK+JenKeCIIlsHAt2gre8ULJU1SzRi59P1FKO2F+KUL5YFyYSk6AKUoPrCKCmT4Krl5TUDf57E2C2+7WucZsK2kvy3FDACUusvez29RtTCYASTQMyNhesG/8GcEZgoxonbBPMBieHsejWAlQWaNkBs2VSfkNU7Kp+nIxMhitdlmHo9vsj6UpIDsaSv/TUr3y8/bWO3XtXkGoHDFyEh4qJVBD7ad5VK+CXYq1SgjdzRj8JxrgkPrnGBtRrW1cEyhUX4+BbnKdkLQ22wYj2DhATyJkzWvE/qgc4ssJEQbhYodOh25fUgPns+SlFdkF45bcz7BXWkLixK+JqZz7ahkAII9+S8qL/NixK4QEq1r5B1LyEbqMkp8sP1zf+fQcYPiChraB6bFT3MH25Mn+peEr5QeRG0PBm1PLeJNtF/wFRiJsbKx8trUqBKsElcTa0legw829GHtRtwQVl0hpGrGKjPlOBsW7vr4uUsXzoU6eMa1zT3tJ6CYj2HgNFg3AQVH6A9CUEYC7ssYsXctra65ZmTv5MZWGOfNMY8i37s2tcHY3m4qexk6nSXc2vfSt0XTmEv7E1w8C/IC43WIEYAGvpsN3u5A0oZQfG5wRbk4AcdZ4V3fX3kdkWrXLli5114d6EtJYT1PwVb3IQmLFWh9uhx/UafJoPAIBVHdro48DjzELQlwniA4BGDIRFlj3gT/bcxvMTxBygsd64ogppKKTGo64Rb0tA2/A9tfpF3dAhX0y1S2qoJ0+wHtGfAFN50d0WyC4AOBIKwl03tGtbvfxbapR4PuYGtbphYsYE28BZarmfdnS09Ew8Of7iBm/dq8mD7SqZazdXXm8H7Y4wrdte8X6nEo7o3vG4DGtABNRvVP5+VPoY0zJa2/j7mpLm/HaW52xPdUsISI5OE0nqQdlGm6asKjE3Lvy6T0BvJKiIkG+sfX+SVn//kgp6JgKLdD3gsS23LcewDGTBhm4Jc28Ktp8OaVwHaWyX/cykknCyMgJDcMLnaA99OmSMa1lOgLCO8VZdXXKy6VLRNpI0wMvq3uWiy/ANqk/yZZkgeMAAPIQ2k5B/MxPlgFVBBu435LWLlMhZQbrvwp8Fxf/p3DrHQ/a2qjeIzg99Cbe9VxgiDHwUnNlWhZYNomfmn+yxRS9lMltmcV3/WfKZGggAAA=",
                label = "Plan Maison",
            },
        },
    },

    ["shell_house_luxe_1"] = {
        label = "Maison luxe",
        hash = `kq_sbx_shell_6`,
        doorOffset = { x = -12.0, y = 0.0, z = 1.0, h = 90.0, width = 1.5 },
        stash = {
            maxweight = 100000,
            slots = 12,
        },
        imgs = {
            {
                url = "data:image/webp;base64,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",
                label = "Plan maison",
            },
        },
    },

    -- K4MB1 Basements
    ["K4 Basement 1"] = {
        label = "Basement 1",
        hash = `k4_basement1_shell`,
        doorOffset = { x = -4.7645, y = -5.0591, z = 1.1515, h = 1.3772, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },
    ["K4 Basement 2"] = {
        label = "Basement 2",
        hash = `k4_basement2_shell`,
        doorOffset = { x = -4.7645, y = -5.0591, z = 1.1515, h = 1.3772, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },
    ["K4 Basement 3"] = {
        label = "Basement 3",
        hash = `k4_basement3_shell`,
        doorOffset = { x = -4.7645, y = -5.0591, z = 1.1515, h = 1.3772, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },
    ["K4 Basement 4"] = {
        label = "Basement 4",
        hash = `k4_basement4_shell`,
        doorOffset = { x = -4.7645, y = -5.0591, z = 1.1515, h = 1.3772, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },
    ["K4 Basement 5"] = {
        label = "Basement 5",
        hash = `k4_basement5_shell`,
        doorOffset = { x = -4.7645, y = -5.0591, z = 1.1515, h = 1.3772, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },

    -- K4MB1 Bikers
    ["K4 Biker 1"] = {
        label = "Biker 1",
        hash = `k4_biker1_shell`,
        doorOffset = { x = 7.5630, y = -10.7593, z = 0.4905, h = 356.6188, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },
    ["K4 Biker 2"] = {
        label = "Biker 2",
        hash = `k4_biker2_shell`,
        doorOffset = { x = -10.5574, y = 3.3867, z = 0.8010, h = 174.8644, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },
    ["K4 Biker 3"] = {
        label = "Biker 3",
        hash = `k4_biker3_shell`,
        doorOffset = { x = -6.9127, y = -3.0049, z = 0.9625, h = 353.6001, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },

    -- K4MB1 Container
    ["K4 Container"] = {
        label = "Container",
        hash = `k4_container_shell`,
        doorOffset = { x = -6.9127, y = -3.0049, z = 0.9625, h = 353.6001, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },

    -- K4MB1 Offices
    ["K4 Office 1"] = {
        label = "Office 1",
        hash = `k4_office1_shell`,
        doorOffset = { x = 3.7184, y = -1.9703, z = -0.9240, h = 86.9881, width = 1.5 },
        stash = { maxweight = 250000, slots = 30 },
        imgs = {},
    },
    ["K4 Office 2"] = {
        label = "Office 2",
        hash = `k4_office2_shell`,
        doorOffset = { x = 4.4512, y = 3.8064, z = -0.7516, h = 172.2509, width = 1.5 },
        stash = { maxweight = 250000, slots = 30 },
        imgs = {},
    },
    ["K4 Office 3"] = {
        label = "Office 3",
        hash = `k4_office3_shell`,
        doorOffset = { x = 4.0977, y = 16.3778, z = -0.7001, h = 92.2382, width = 1.5 },
        stash = { maxweight = 250000, slots = 30 },
        imgs = {},
    },
    ["K4 Office 4"] = {
        label = "Office 4",
        hash = `k4_office4_shell`,
        doorOffset = { x = 8.7854, y = -2.1540, z = -1.5518, h = 98.7269, width = 1.5 },
        stash = { maxweight = 250000, slots = 30 },
        imgs = {},
    },
    ["K4 Office 5"] = {
        label = "Office 5",
        hash = `k4_office5_shell`,
        doorOffset = { x = 0.4703, y = -14.0934, z = -3.0775, h = 3.7763, width = 1.5 },
        stash = { maxweight = 250000, slots = 30 },
        imgs = {},
    },
    ["K4 Office 6"] = {
        label = "Office 6",
        hash = `k4_office6_shell`,
        doorOffset = { x = 4.5510, y = 5.1523, z = 0.9958, h = 176.5790, width = 1.5 },
        stash = { maxweight = 250000, slots = 30 },
        imgs = {},
    },
    ["K4 Office 7"] = {
        label = "Office 7",
        hash = `k4_office7_shell`,
        doorOffset = { x = 3.6565, y = -1.9059, z = -0.9261, h = 93.3173, width = 1.5 },
        stash = { maxweight = 250000, slots = 30 },
        imgs = {},
    },
    ["K4 Office 8"] = {
        label = "Office 8",
        hash = `k4_office8_shell`,
        doorOffset = { x = -9.0418, y = -4.2746, z = -0.4027, h = 354.0161, width = 1.5 },
        stash = { maxweight = 250000, slots = 30 },
        imgs = {},
    },

    -- K4MB1 Stash Houses
    ["K4 Stash House 1"] = {
        label = "Stash House 1",
        hash = `k4_stashhouse1_shell`,
        doorOffset = { x = 21.0425, y = -0.6413, z = -2.0764, h = 86.2950, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },
    ["K4 Stash House 2"] = {
        label = "Stash House 2",
        hash = `k4_stashhouse2_shell`,
        doorOffset = { x = -1.8815, y = 2.2512, z = -1.0175, h = 268.4154, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },

    -- K4MB1 Stores
    ["K4 Store 1"] = {
        label = "Store 1",
        hash = `k4_store1_shell`,
        doorOffset = { x = -2.7148, y = 4.4636, z = -0.6240, h = 181.8985, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["K4 Store 2"] = {
        label = "Store 2",
        hash = `k4_store2_shell`,
        doorOffset = { x = -0.8002, y = -4.9365, z = 0.5094, h = 358.6120, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["K4 Store 3"] = {
        label = "Store 3",
        hash = `k4_store3_shell`,
        doorOffset = { x = -0.0818, y = -7.8364, z = 1.5159, h = 4.8627, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["K4 Store 4"] = {
        label = "Store 4",
        hash = `k4_store4_shell`,
        doorOffset = { x = -1.0679, y = -5.2949, z = 0.5483, h = 4.6777, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["K4 Store 5"] = {
        label = "Store 5",
        hash = `k4_store5_shell`,
        doorOffset = { x = 1.5443, y = 5.1611, z = 0.7277, h = 187.2491, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },

    -- K4MB1 Warehouses
    ["K4 Warehouse 1"] = {
        label = "Warehouse 1",
        hash = `k4_warehouse1_shell`,
        doorOffset = { x = 8.8478, y = 0.2575, z = -0.9548, h = 91.4108, width = 1.5 },
        stash = { maxweight = 1000000, slots = 100 },
        imgs = {},
    },
    ["K4 Warehouse 2"] = {
        label = "Warehouse 2",
        hash = `k4_warehouse2_shell`,
        doorOffset = { x = 12.2048, y = 0.1055, z = -2.0646, h = 88.6572, width = 1.5 },
        stash = { maxweight = 1000000, slots = 100 },
        imgs = {},
    },
    ["K4 Warehouse 3"] = {
        label = "Warehouse 3",
        hash = `k4_warehouse3_shell`,
        doorOffset = { x = 2.4526, y = -1.6657, z = -0.9520, h = 86.9956, width = 1.5 },
        stash = { maxweight = 1000000, slots = 100 },
        imgs = {},
    },
    ["K4 Warehouse 4"] = {
        label = "Warehouse 4",
        hash = `k4_warehouse4_shell`,
        doorOffset = { x = 8.1661, y = -0.1550, z = -1.4951, h = 91.7599, width = 1.5 },
        stash = { maxweight = 1000000, slots = 100 },
        imgs = {},
    },
    ["K4 Warehouse 5"] = {
        label = "Warehouse 5",
        hash = `k4_warehouse5_shell`,
        doorOffset = { x = -13.0953, y = -0.0961, z = -2.0892, h = 266.0719, width = 1.5 },
        stash = { maxweight = 1000000, slots = 100 },
        imgs = {},
    },

    -- K4MB1 Stash Houses (continued)
    ["K4 Stash House 3"] = {
        label = "Stash House 3",
        hash = `k4_stashhouse3_shell`,
        doorOffset = { x = 21.3875, y = -0.4141, z = -2.0765, h = 87.8485, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },
    ["K4 Stash House 4"] = {
        label = "Stash House 4",
        hash = `k4_stashhouse4_shell`,
        doorOffset = { x = -0.1158, y = 5.3364, z = -1.0173, h = 177.9512, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },

    -- K4MB1 Container (continued)
    ["K4 Container 2"] = {
        label = "Container 2",
        hash = `k4_container2_shell`,
        doorOffset = { x = 0.0400, y = -5.6863, z = -0.2192, h = 352.8797, width = 1.5 },
        stash = { maxweight = 200000, slots = 30 },
        imgs = {},
    },

    -- K4MB1 Bunker
    ["K4 Bunker"] = {
        label = "Bunker",
        hash = `k4_bunker_shell`,
        doorOffset = { x = -0.0226, y = -7.0046, z = 2.6870, h = 2.3720, width = 1.5 },
        stash = { maxweight = 500000, slots = 50 },
        imgs = {},
    },

    -- K4MB1 Guns
    ["K4 Guns"] = {
        label = "Guns",
        hash = `k4_guns_shell`,
        doorOffset = { x = 0.2029, y = 4.5898, z = -0.8215, h = 178.7588, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },

    -- K4MB1 Laundry
    ["K4 Laundry"] = {
        label = "Laundry",
        hash = `k4_laundry_shell`,
        doorOffset = { x = -8.7557, y = 6.2801, z = -3.1180, h = 187.7316, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },

    -- K4MB1 Labs Empty
    ["K4 Lab Empty 1"] = {
        label = "Lab Empty 1",
        hash = `k4_labempty_shell`,
        doorOffset = { x = -6.2527, y = 8.4591, z = -0.9642, h = 182.5497, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["K4 Lab Empty 2"] = {
        label = "Lab Empty 2",
        hash = `k4_labempty2_shell`,
        doorOffset = { x = 0.0, y = 0.0, z = 1.5, h = 0.0, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["K4 Lab Empty 3"] = {
        label = "Lab Empty 3",
        hash = `k4_labempty3_shell`,
        doorOffset = { x = 0.0, y = 0.0, z = 1.5, h = 0.0, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["K4 Lab Empty 4"] = {
        label = "Lab Empty 4",
        hash = `k4_labempty4_shell`,
        doorOffset = { x = 0.0, y = 0.0, z = 1.5, h = 0.0, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },

    -- K4MB1 Labs Meth
    ["K4 Lab Meth 1"] = {
        label = "Lab Meth 1",
        hash = `k4_labmeth_shell`,
        doorOffset = { x = 0.0, y = 0.0, z = 1.5, h = 0.0, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["K4 Lab Meth 2"] = {
        label = "Lab Meth 2",
        hash = `k4_labmeth2_shell`,
        doorOffset = { x = 0.0, y = 0.0, z = 1.5, h = 0.0, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },

    -- K4MB1 Labs Coke
    ["K4 Lab Coke 1"] = {
        label = "Lab Coke 1",
        hash = `k4_labcoke_shell`,
        doorOffset = { x = 0.0, y = 0.0, z = 1.5, h = 0.0, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["K4 Lab Coke 2"] = {
        label = "Lab Coke 2",
        hash = `k4_labcoke2_shell`,
        doorOffset = { x = 0.0, y = 0.0, z = 1.5, h = 0.0, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },

    -- K4MB1 Labs Weed
    ["K4 Lab Weed 1"] = {
        label = "Lab Weed 1",
        hash = `k4_labweed_shell`,
        doorOffset = { x = 0.0, y = 0.0, z = 1.5, h = 0.0, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["K4 Lab Weed 2"] = {
        label = "Lab Weed 2",
        hash = `k4_labweed2_shell`,
        doorOffset = { x = 0.0, y = 0.0, z = 1.5, h = 0.0, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },

    -- K4MB1 Lab Acid
    ["K4 Lab Acid"] = {
        label = "Lab Acid",
        hash = `k4_labacid_shell`,
        doorOffset = { x = 0.0, y = 0.0, z = 1.5, h = 0.0, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },

    -- ========================================================================
    -- Original shells, streamed by resources/[map-enabled]/[jordqn]
    --
    -- Every `hash` below was verified against the archetype hashes stored in the
    -- matching .ytyp, and every model it names is versioned with the repository.
    --
    -- The `doorOffset` values were measured in game with /shell-offset
    -- (evange-housing, admin). Two models are excluded from the repository for
    -- exceeding GitHub's file size limits, so no shell may reference them:
    -- acid_business (65 MB) and weed_business (111 MB).
    -- ========================================================================

    -- Original - Business (jordqn_business_shells)
    -- acid_business.ydr (65 Mo) and weed_business.ydr (111 Mo) are excluded from
    -- the repository, so those two shells are not declared here.
    ["Original Coke Business"] = {
        label = "Original - Labo Cocaïne",
        hash = `coke_business`,
        doorOffset = { x = -6.1348, y = 8.3437, z = -0.9061, h = 177.0823, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["Original Coke Business Empty"] = {
        label = "Original - Labo Cocaïne (vide)",
        hash = `coke_business_empty`,
        doorOffset = { x = -3.8812, y = -2.9154, z = 1.0005, h = 275.6687, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["Original Counterfeit Business"] = {
        label = "Original - Atelier de Contrefaçon",
        hash = `counterfeit_business`,
         doorOffset = { x = -4.2944, y = -22.6189, z = 0.9301, h = 269.2977, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["Original Counterfeit Business Empty"] = {
        label = "Original - Atelier de Contrefaçon (vide)",
        hash = `counterfeit_business_empty`,
        doorOffset = { x = 0.4991, y = 0.1244, z = -0.1957, h = 263.7756, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["Original Fake ID Business"] = {
        label = "Original - Atelier de Faux Papiers",
        hash = `fakeid_business`,
        doorOffset = { x = -0.3808, y = -2.1235, z = 0.0208, h = 83.3098, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["Original Meth Business"] = {
        label = "Original - Labo Méthamphétamine",
        hash = `meth_business`,
        doorOffset = { x = -12.6605, y = -3.9200, z = 3.5999, h = 266.9896, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["Original Weed Business Empty 1"] = {
        label = "Original - Culture de Cannabis (vide) - porte",
        hash = `weed_business_empty`,
        doorOffset = { x = 7.5143, y = 24.1209, z = 0.8304, h = 90.9632, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["Original Weed Business Empty 2"] = {
        label = "Original - Culture de Cannabis (vide) - Garage",
        hash = `weed_business_empty`,
        doorOffset = { x = -19.2909, y = 13.2258, z = 1.8243, h = 264.4305, width = 1.5 },
        stash = { maxweight = 300000, slots = 40 },
        imgs = {},
    },
    ["Original Warehouse Small"] = {
        label = "Original - Petit Entrepôt",
        hash = `warehouse_small`,
        doorOffset = { x = -1.8689, y = -14.9811, z = -2.8314, h = 10.4778, width = 1.5 },
        stash = { maxweight = 500000, slots = 50 },
        imgs = {},
    },
    ["Original Warehouse Large"] = {
        label = "Original - Grand Entrepôt",
        hash = `warehouse_large`,
         doorOffset = { x = 1.4089, y = -16.5502, z = 0.9971, h = 2.2817, width = 1.5 },
        stash = { maxweight = 1000000, slots = 100 },
        imgs = {},
    },

    -- Original - Logements meublés (jordqn_default_furnitured)
    ["Original Apartment Low"] = {
        label = "Original - Appartement Simple",
        hash = `apart_low`,
        doorOffset = { x = -3.3709, y = 1.7916, z = -1.6232, h = 265.3939, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Apartment Mid"] = {
        label = "Original - Appartement Standard",
        hash = `apart_mid`,
        doorOffset = { x = 0.0319, y = -8.3561, z = -0.6843, h = 353.7144, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Motel Low"] = {
        label = "Original - Chambre de Motel",
        hash = `motel_low`,
        doorOffset = { x = -3.0393, y = -3.3874, z = 0.9805, h = 350.6929, width = 1.5 },
        stash = { maxweight = 100000, slots = 12 },
        imgs = {},
    },

    -- Original - Appartements de luxe (jordqn_high_end_furnitured)
    -- The "_w" models are a second variant of each flat shipped by the pack;
    -- what the suffix stands for is not documented, hence the neutral "(W)".
    ["Original Luxury Apartment 1"] = {
        label = "Original - Appartement Luxe 1",
        hash = `apart_luxe_1`,
        doorOffset = { x = -19.0952, y = -1.2832, z = 6.3568, h = 276.4748, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 1 W"] = {
        label = "Original - Appartement Luxe 1 (W)",
        hash = `apart_luxe_1_w`,
        doorOffset = { x = -19.0086, y = -1.1055, z = 6.3568, h = 267.1724, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 2"] = {
        label = "Original - Appartement Luxe 2",
        hash = `apart_luxe_2`,
        doorOffset = { x = 16.4066, y = 5.1549, z = 1.8008, h = 90.6259, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 2 W"] = {
        label = "Original - Appartement Luxe 2 (W)",
        hash = `apart_luxe_2_w`,
        doorOffset = { x = 16.4066, y = 5.1549, z = 1.8008, h = 90.6259, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 3"] = {
        label = "Original - Appartement Luxe 3",
        hash = `apart_luxe_3`,
        doorOffset = { x = 2.4267, y = 7.0931, z = 0.3248, h = 184.9476, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 3 W"] = {
        label = "Original - Appartement Luxe 3 (W)",
        hash = `apart_luxe_3_w`,
        doorOffset = { x = 2.4267, y = 7.0931, z = 0.3248, h = 184.9476, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 4"] = {
        label = "Original - Appartement Luxe 4",
        hash = `apart_luxe_4`,
        doorOffset = { x = 2.3506, y = -2.1017, z = -0.7988, h = 266.5301, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 4 W"] = {
        label = "Original - Appartement Luxe 4 (W)",
        hash = `apart_luxe_4_w`,
        doorOffset = { x = 2.3506, y = -2.1017, z = -0.7988, h = 266.5301, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 5"] = {
        label = "Original - Appartement Luxe 5",
        hash = `apart_luxe_5`,
        doorOffset = { x = -17.1660, y = 0.5094, z = -1.6014, h = 273.7339, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 5 W"] = {
        label = "Original - Appartement Luxe 5 (W)",
        hash = `apart_luxe_5_w`,
        doorOffset = { x = -17.1660, y = 0.5094, z = -1.6014, h = 273.7339, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 6"] = {
        label = "Original - Appartement Luxe 6",
        hash = `apart_luxe_6`,
        doorOffset = { x = -18.9023, y = 1.3017, z = -0.4277, h = 261.9129, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 6 W"] = {
        label = "Original - Appartement Luxe 6 (W)",
        hash = `apart_luxe_6_w`,
        doorOffset = { x = -18.9023, y = 1.3017, z = -0.4277, h = 261.9129, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 7"] = {
        label = "Original - Appartement Luxe 7",
        hash = `apart_luxe_7`,
        doorOffset = { x = -24.0384, y = -3.8569, z = 1.7927, h = 267.5457, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 7 W"] = {
        label = "Original - Appartement Luxe 7 (W)",
        hash = `apart_luxe_7_w`,
        doorOffset = { x = -24.0384, y = -3.8569, z = 1.7927, h = 267.5457, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 8"] = {
        label = "Original - Appartement Luxe 8",
        hash = `apart_luxe_8`,
        doorOffset = { x = 11.4791, y = 13.3077, z = 1.7997, h = 134.0251, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },
    ["Original Luxury Apartment 8 W"] = {
        label = "Original - Appartement Luxe 8 (W)",
        hash = `apart_luxe_8_w`,
        doorOffset = { x = 11.4791, y = 13.3077, z = 1.7997, h = 134.0251, width = 1.5 },
        stash = { maxweight = 200000, slots = 25 },
        imgs = {},
    },

    -- Original - Bureau (jordqn_sol_office)
    ["Original Sol Office"] = {
        label = "Original - Bureau Sol",
        hash = `sol_office`,
        doorOffset = { x = 3.4426, y = -1.8052, z = -0.5396, h = 91.8130, width = 1.5 },
        stash = { maxweight = 250000, slots = 30 },
        imgs = {},
    },
}

Config.FurnitureTypes = {
    ["storage"] = function(entity, property_id, shell, id)
        local stash = ("property_%s"):format(property_id)
        id = type(id) == "boolean" and stash or stash..id
        local entityHash = GetEntityModel(entity)
        Framework[Config.Target].AddTargetEntity(entity, "Storage", "fas fa-box-open", function()
            local stashConfig = Config.Shells[shell].stash
            local stashName = stash..'_'..entityHash
            Framework[Config.Inventory].OpenInventory(stashName, stashConfig, property_id)
        end)

        local property = Property.Get(property_id)
        property.storageTarget = property.storageTarget or {}
        property.storageTarget[entity] = id
    end,

    ["clothing"] = function(entity, property_id)
        Framework[Config.Target].AddTargetEntity(entity, "Clothing", "fas fa-shirt", function()
            local heading = GetEntityHeading(cache.ped)
            SetEntityHeading(cache.ped, heading - 180.0)
            TriggerEvent("qb-clothing:client:openOutfitMenu")
        end)

        local property = Property.Get(property_id)
        property.clothingTarget = entity
    end
}

--- Shallow copy of a furniture entry. The Map* helpers below never mutate their
--- input, so one source list can feed several categories.
local function CopyItem(item)
    local copy = {}
    for key, value in pairs(item) do copy[key] = value end
    return copy
end

--- Marks a furniture entry as a functional storage container.
--- A "storage" entry gets an ox_inventory stash registered when bought
--- (server/sv_property.lua:933) and a "Storage" target option once placed
--- (Config.FurnitureTypes above). The stash is keyed by model hash, so each
--- distinct prop owns its own container.
local function ToStorage(item)
    local entry = CopyItem(item)
    entry.type = "storage"
    return entry
end

--- Strips the storage capability, leaving the prop as pure decoration.
--- The label is suffixed so both variants stay tellable apart in the
--- "Toutes catégories" view, where the category name is not shown.
local function ToDecorative(item)
    local entry = CopyItem(item)
    entry.type = nil
    entry.label = entry.label .. " (déco)"
    return entry
end

--- Applies ToStorage to every entry of an item list, into a new list.
local function MapToStorage(items)
    local mapped = {}
    for i = 1, #items do
        mapped[i] = ToStorage(items[i])
    end
    return mapped
end

--- Applies ToDecorative to every entry of an item list, into a new list.
local function MapToDecorative(items)
    local mapped = {}
    for i = 1, #items do
        mapped[i] = ToDecorative(items[i])
    end
    return mapped
end

--- Storage props, shared by the functional "Stockage" category and its
--- decorative twin. Declared once so the two stay in sync.
local StorageProps = {
        { ["object"] = "v_res_cabinet", ["price"] = 2500, ["label"] = "Grande armoire" },
        { ["object"] = "v_res_d_dressingtable", ["price"] = 2500, ["label"] = "Coiffeuse" },
        { ["object"] = "v_res_d_sideunit", ["price"] = 2500, ["label"] = "Meuble d'appoint" },
        { ["object"] = "v_res_fh_sidebrddine", ["price"] = 2500, ["label"] = "Meuble d'appoint" },
        { ["object"] = "v_res_fh_sidebrdlngb", ["price"] = 2500, ["label"] = "Meuble d'appoint" },
        { ["object"] = "v_res_mbbedtable", ["price"] = 2500, ["label"] = "Table de chevet" },
        { ["object"] = "v_res_j_tvstand", ["price"] = 2500, ["label"] = "Meuble TV" },
        { ["object"] = "v_res_mbdresser", ["price"] = 2500, ["label"] = "Commode" },
        { ["object"] = "v_res_mbottoman", ["price"] = 2500, ["label"] = "Banc coffre" },
        { ["object"] = "v_res_mconsolemod", ["price"] = 2500, ["label"] = "Console" },
        { ["object"] = "v_res_mcupboard", ["price"] = 2500, ["label"] = "Placard" },
        { ["object"] = "v_res_mdchest", ["price"] = 2500, ["label"] = "Coffre" },
        { ["object"] = "v_res_msoncabinet", ["price"] = 2500, ["label"] = "Buffet maçon" },
        { ["object"] = "v_res_m_armoire", ["price"] = 2500, ["label"] = "Armoire" },
        { ["object"] = "v_res_m_sidetable", ["price"] = 2500, ["label"] = "Meuble d'appoint" },
        { ["object"] = "v_res_son_desk", ["price"] = 2500, ["label"] = "Bureau" },
        { ["object"] = "v_res_tre_bedsidetable", ["price"] = 2500, ["label"] = "Meuble d'appoint" },
        { ["object"] = "v_res_tre_bedsidetableb", ["price"] = 2500, ["label"] = "Meuble d'appoint 2" },
        { ["object"] = "v_res_tre_smallbookshelf", ["price"] = 2500, ["label"] = "Bibliothèque" },
        { ["object"] = "v_res_tre_storageunit", ["price"] = 2500, ["label"] = "Unité de stockage 2" },
        { ["object"] = "v_res_tre_wardrobe", ["price"] = 2500, ["label"] = "Penderie de rangement" },
        { ["object"] = "v_res_tre_wdunitscuz", ["price"] = 2500, ["label"] = "Meuble en bois" },
        { ["object"] = "prop_devin_box_closed", ["price"] = 100, ["label"] = "Caisse fermée" },
        { ["object"] = "prop_mil_crate_01", ["price"] = 100, ["label"] = "Caisse militaire 1" },
        { ["object"] = "prop_mil_crate_02", ["price"] = 100, ["label"] = "Caisse militaire 2" },
        { ["object"] = "prop_ld_int_safe_01", ["price"] = 1100, ["label"] = "Coffre-fort" },
        { ["object"] = "prop_toolchest_05", ["price"] = 5000, ["label"] = "Établi" },
        { ["object"] = "v_corp_filecablow", ["price"] = 500, ["label"] = "Classeur bas" },
        { ["object"] = "v_corp_filecabtall", ["price"] = 500, ["label"] = "Classeur haut" },
        { ["object"] = "apa_mp_h_str_shelffloorm_02", ["price"] = 500, ["label"] = "Grand placard moderne" },
        { ["object"] = "v_ilev_frnkwarddr1", ["price"] = 500, ["label"] = "Placard de Franklin" },
        { ["object"] = "prop_coathook_01", ["price"] = 100, ["label"] = "Portemanteau" },
        { ["object"] = "v_corp_lowcabdark01", ["price"] = 500, ["label"] = "Classeur bas noir" },
        { ["object"] = "v_corp_tallcabdark01", ["price"] = 500, ["label"] = "Classeur haut noir" },
        { ["object"] = "v_corp_cabshelves01", ["price"] = 1000, ["label"] = "Classeur noir" },
        { ["object"] = "v_corp_offshelf", ["price"] = 1000, ["label"] = "Grand classeur" },
        { ["object"] = "v_61_lng_mesh_unitc", ["price"] = 500, ["label"] = "Bibliothèque blanche" },
        { ["object"] = "ba_wardrobe", ["price"] = 500, ["label"] = "Armoire à vêtements" },
        { ["object"] = "apa_mp_h_str_sideboardl_06", ["price"] = 750, ["label"] = "Placard moderne" },
        { ["object"] = "apa_mp_h_str_sideboardl_09", ["price"] = 750, ["label"] = "Placard moderne 2" },
        { ["object"] = "apa_mp_h_str_shelfwallm_01", ["price"] = 750, ["label"] = "Bibliothèque 2" },
        { ["object"] = "apa_mp_h_str_sideboardl_11", ["price"] = 750, ["label"] = "Placard moderne 3" },
        { ["object"] = "imp_prop_impexp_parts_rack_03a", ["price"] = 750, ["label"] = "Étagère à pièces auto" },
        { ["object"] = "imp_prop_impexp_parts_rack_04a", ["price"] = 750, ["label"] = "Étagère à pièces auto 2" },
        { ["object"] = "imp_prop_impexp_parts_rack_05a", ["price"] = 750, ["label"] = "Étagère à pièces auto 3" },
        { ["object"] = "apa_mp_h_bed_chestdrawer_02", ["price"] = 750, ["label"] = "Commode à tiroirs" },
        { ["object"] = "hei_heist_bed_chestdrawer_04", ["price"] = 750, ["label"] = "Commode à tiroirs 2" },
        { ["object"] = "prop_rub_cabinet", ["price"] = 50, ["label"] = "Classeur rouillé" },
        { ["object"] = "prop_tv_cabinet_03", ["price"] = 750, ["label"] = "Petit meuble TV" },
        { ["object"] = "prop_tv_cabinet_04", ["price"] = 750, ["label"] = "Petit meuble TV 2" },
        { ["object"] = "prop_tv_cabinet_05", ["price"] = 750, ["label"] = "Petit meuble TV 3" },
        { ["object"] = "apa_mp_h_str_shelffreel_01", ["price"] = 750, ["label"] = "Étagère modulaire" },
        { ["object"] = "apa_mp_h_str_sideboardl_13", ["price"] = 750, ["label"] = "Buffet moderne 4" },
        { ["object"] = "apa_mp_h_str_sideboardl_14", ["price"] = 750, ["label"] = "Buffet moderne 5" },
        { ["object"] = "apa_mp_h_str_sideboardm_02", ["price"] = 750, ["label"] = "Buffet moderne 6" },
        { ["object"] = "bkr_prop_biker_garage_locker_01", ["price"] = 750, ["label"] = "Casier de biker" },
        { ["object"] = "gr_prop_gr_bench_04b", ["price"] = 750, ["label"] = "Banc de biker" },
}

Config.Furnitures = {
    {
        category = "Basique",
        items = {
            { ["object"] = "v_res_tre_storagebox", ["price"] = 0, ["label"] = "Unité de stockage", ["type"] = "storage", ["max"] = 2 },
            { ["object"] = "v_res_tre_wardrobe", ["price"] = 0, ["label"] = "Penderie", ["type"] = "clothing", ["max"] = 2 },
        }
    },

    {
        category = "Meubles",
        items = {
            { ["object"] = "miss_rub_couch_01", ["price"] = 300, ["label"] = "Vieux canapé" },
            { ["object"] = "prop_fib_3b_bench", ["price"] = 700, ["label"] = "Canapé 3 places" },
            { ["object"] = "prop_ld_farm_chair01", ["price"] = 250, ["label"] = "Vieille chaise" },
            { ["object"] = "prop_ld_farm_couch01", ["price"] = 300, ["label"] = "Vieux canapé 3 places" },
            { ["object"] = "prop_ld_farm_couch02", ["price"] = 300, ["label"] = "Vieux canapé rayé" },
            { ["object"] = "v_res_d_armchair", ["price"] = 300, ["label"] = "Fauteuil jaune" },
            { ["object"] = "v_res_fh_sofa", ["price"] = 3700, ["label"] = "Canapé d'angle" },
            { ["object"] = "v_res_mp_sofa", ["price"] = 3700, ["label"] = "Canapé d'angle 2" },
            { ["object"] = "v_res_d_sofa", ["price"] = 700, ["label"] = "Canapé 1" },
            { ["object"] = "v_res_j_sofa", ["price"] = 700, ["label"] = "Canapé 2" },
            { ["object"] = "v_res_mp_stripchair", ["price"] = 700, ["label"] = "Canapé 3" },
            { ["object"] = "v_res_m_h_sofa_sml", ["price"] = 700, ["label"] = "Canapé 4" },
            { ["object"] = "v_res_r_sofa", ["price"] = 700, ["label"] = "Canapé 5" },
            { ["object"] = "v_res_tre_sofa", ["price"] = 700, ["label"] = "Canapé 6" },
            { ["object"] = "v_res_tre_sofa_mess_a", ["price"] = 700, ["label"] = "Canapé 7" },
            { ["object"] = "v_res_tre_sofa_mess_b", ["price"] = 700, ["label"] = "Canapé 8" },
            { ["object"] = "v_res_tre_sofa_mess_c", ["price"] = 700, ["label"] = "Canapé 9" },
            { ["object"] = "v_res_tt_sofa", ["price"] = 700, ["label"] = "Canapé 10" },
            { ["object"] = "prop_rub_couch02", ["price"] = 700, ["label"] = "Canapé 11" },
            { ["object"] = "v_ilev_m_sofa", ["price"] = 2000, ["label"] = "Canapé blanc" },
            { ["object"] = "v_med_p_sofa", ["price"] = 1000, ["label"] = "Canapé en cuir marron" },
            { ["object"] = "v_club_officesofa", ["price"] = 500, ["label"] = "Canapé rouge élimé" },
            { ["object"] = "bkr_prop_clubhouse_sofa_01a", ["price"] = 1000, ["label"] = "Canapé noir" },
            { ["object"] = "apa_mp_h_stn_sofacorn_01", ["price"] = 5000, ["label"] = "Canapé d'angle 3" },
            { ["object"] = "prop_couch_lg_02", ["price"] = 1000, ["label"] = "Canapé en bois" },
            { ["object"] = "apa_mp_h_stn_sofacorn_10", ["price"] = 5000, ["label"] = "Canapé d'angle 4" },
            { ["object"] = "apa_mp_h_yacht_sofa_02", ["price"] = 1000, ["label"] = "Canapé marron" },
            { ["object"] = "apa_mp_h_yacht_sofa_01", ["price"] = 5000, ["label"] = "Grand canapé blanc" },
            { ["object"] = "prop_couch_01", ["price"] = 1000, ["label"] = "Canapé à coussins" },
            { ["object"] = "prop_couch_03", ["price"] = 1000, ["label"] = "Canapé jaune" },
            { ["object"] = "prop_couch_04", ["price"] = 1000, ["label"] = "Canapé en cuir à coussins" },
            { ["object"] = "prop_couch_lg_05", ["price"] = 500, ["label"] = "Canapé en velours côtelé" },
            { ["object"] = "prop_couch_lg_06", ["price"] = 1000, ["label"] = "Canapé en cuir marron 2" },
            { ["object"] = "prop_couch_lg_07", ["price"] = 1000, ["label"] = "Canapé à coussins 2" },
            { ["object"] = "prop_couch_lg_08", ["price"] = 1000, ["label"] = "Canapé en cuir marron 3" },
            { ["object"] = "prop_couch_sm1_07", ["price"] = 500, ["label"] = "Canapé d'angle en cuir" },
            { ["object"] = "prop_couch_sm2_07", ["price"] = 500, ["label"] = "Canapé droit en cuir" },
            { ["object"] = "prop_couch_sm_06", ["price"] = 500, ["label"] = "Petit canapé en cuir" },
            { ["object"] = "apa_mp_h_stn_sofa2seat_02", ["price"] = 1000, ["label"] = "Causeuse" },
            { ["object"] = "apa_mp_h_stn_sofacorn_05", ["price"] = 5000, ["label"] = "Canapé d'angle 5" },
            { ["object"] = "apa_mp_h_stn_sofacorn_06", ["price"] = 5000, ["label"] = "Canapé d'angle 6" },
            { ["object"] = "apa_mp_h_stn_sofacorn_07", ["price"] = 5000, ["label"] = "Canapé d'angle 7" },
            { ["object"] = "apa_mp_h_stn_sofacorn_08", ["price"] = 5000, ["label"] = "Canapé d'angle 8" },
            { ["object"] = "apa_mp_h_stn_sofacorn_09", ["price"] = 5000, ["label"] = "Canapé d'angle 9" },
            { ["object"] = "ex_mp_h_off_sofa_003", ["price"] = 1000, ["label"] = "Canapé en tissu bleu" },
            { ["object"] = "ex_mp_h_off_sofa_01", ["price"] = 1000, ["label"] = "Canapé en cuir blanc" },
            { ["object"] = "ex_mp_h_off_sofa_02", ["price"] = 1000, ["label"] = "Canapé en cuir noir" },
            { ["object"] = "hei_heist_stn_sofa2seat_03", ["price"] = 1000, ["label"] = "Canapé moderne" },
            { ["object"] = "hei_heist_stn_sofa2seat_06", ["price"] = 1000, ["label"] = "Canapé brun" },
            { ["object"] = "hei_heist_stn_sofa3seat_01", ["price"] = 1000, ["label"] = "Méridienne" },
            { ["object"] = "hei_heist_stn_sofa3seat_02", ["price"] = 1000, ["label"] = "Canapé moderne 2" },
            { ["object"] = "hei_heist_stn_sofa3seat_06", ["price"] = 1000, ["label"] = "Canapé moderne 3" },
            { ["object"] = "imp_prop_impexp_sofabed_01a", ["price"] = 1000, ["label"] = "Canapé-lit" },
            { ["object"] = "prop_t_sofa_02", ["price"] = 1000, ["label"] = "Canapé-lit 2" },
        }
    },

    {
        category = "Chaises",
        items = {
            { ["object"] = "v_res_d_highchair", ["price"] = 700, ["label"] = "Chaise haute" },
            { ["object"] = "apa_mp_h_stn_chairstrip_03", ["price"] = 500, ["label"] = "Siège 4" },
            { ["object"] = "v_res_fa_chair01", ["price"] = 700, ["label"] = "Chaise" },
            { ["object"] = "v_res_fa_chair02", ["price"] = 700, ["label"] = "Chaise 2" },
            { ["object"] = "v_res_fh_barcchair", ["price"] = 700, ["label"] = "Chaise haute 2" },
            { ["object"] = "v_res_fh_dineeamesa", ["price"] = 700, ["label"] = "Chaise de cuisine 1" },
            { ["object"] = "v_res_fh_dineeamesb", ["price"] = 700, ["label"] = "Chaise de cuisine 2" },
            { ["object"] = "v_res_fh_dineeamesc", ["price"] = 700, ["label"] = "Chaise de cuisine 3" },
            { ["object"] = "v_res_fh_easychair", ["price"] = 700, ["label"] = "Chaise 3" },
            { ["object"] = "v_res_fh_kitnstool", ["price"] = 700, ["label"] = "Chaise 4" },
            { ["object"] = "v_res_fh_singleseat", ["price"] = 700, ["label"] = "Chaise haute 3" },
            { ["object"] = "v_res_jarmchair", ["price"] = 700, ["label"] = "Fauteuil" },
            { ["object"] = "v_res_j_dinechair", ["price"] = 700, ["label"] = "Chaise de cuisine 4" },
            { ["object"] = "v_res_j_stool", ["price"] = 700, ["label"] = "Chaise 5" },
            { ["object"] = "v_res_mbchair", ["price"] = 700, ["label"] = "Chaise MB" },
            { ["object"] = "v_res_m_armchair", ["price"] = 700, ["label"] = "Fauteuil 2" },
            { ["object"] = "v_res_m_dinechair", ["price"] = 700, ["label"] = "Chaise de cuisine 5" },
            { ["object"] = "v_res_study_chair", ["price"] = 700, ["label"] = "Chaise d'étude" },
            { ["object"] = "v_res_trev_framechair", ["price"] = 700, ["label"] = "Structure de chaise" },
            { ["object"] = "v_res_tre_chair", ["price"] = 700, ["label"] = "Chaise 5" },
            { ["object"] = "v_res_tre_officechair", ["price"] = 700, ["label"] = "Chaise de bureau" },
            { ["object"] = "v_res_tre_stool", ["price"] = 700, ["label"] = "Chaise 6" },
            { ["object"] = "v_res_tre_stool_leather", ["price"] = 700, ["label"] = "Chaise en cuir" },
            { ["object"] = "v_res_tre_stool_scuz", ["price"] = 700, ["label"] = "Chaise usée" },
            { ["object"] = "v_med_p_deskchair", ["price"] = 700, ["label"] = "Fauteuil de bureau" },
            { ["object"] = "v_med_p_easychair", ["price"] = 700, ["label"] = "Fauteuil confort" },
            { ["object"] = "v_med_whickerchair1", ["price"] = 700, ["label"] = "Chaise en osier" },
            { ["object"] = "prop_direct_chair_01", ["price"] = 700, ["label"] = "Chaise de réalisateur" },
            { ["object"] = "prop_direct_chair_02", ["price"] = 700, ["label"] = "Chaise de réalisateur 2" },
            { ["object"] = "prop_yacht_lounger", ["price"] = 700, ["label"] = "Chaise de yacht 1" },
            { ["object"] = "prop_yacht_seat_01", ["price"] = 700, ["label"] = "Chaise de yacht 2" },
            { ["object"] = "prop_yacht_seat_02", ["price"] = 700, ["label"] = "Chaise de yacht 3" },
            { ["object"] = "prop_yacht_seat_03", ["price"] = 700, ["label"] = "Chaise de yacht 4" },
            { ["object"] = "v_ret_chair_white", ["price"] = 100, ["label"] = "Chaise blanche" },
            { ["object"] = "v_ret_chair", ["price"] = 100, ["label"] = "Chaise 7" },
            { ["object"] = "v_ret_ta_stool", ["price"] = 100, ["label"] = "Chaise TA" },
            { ["object"] = "prop_cs_office_chair", ["price"] = 100, ["label"] = "Chaise de bureau 2" },
            { ["object"] = "apa_mp_h_yacht_armchair_01", ["price"] = 1000, ["label"] = "Fauteuil blanc" },
            { ["object"] = "v_club_barchair", ["price"] = 300, ["label"] = "Chaise 8" },
            { ["object"] = "prop_off_chair_04", ["price"] = 300, ["label"] = "Fauteuil de bureau 2" },
            { ["object"] = "v_club_stagechair", ["price"] = 500, ["label"] = "Fauteuil rose" },
            { ["object"] = "v_club_officechair", ["price"] = 500, ["label"] = "Fauteuil de bureau 3" },
            { ["object"] = "prop_armchair_01", ["price"] = 500, ["label"] = "Siège" },
            { ["object"] = "prop_bar_stool_01", ["price"] = 300, ["label"] = "Tabouret de bar" },
            { ["object"] = "apa_mp_h_yacht_stool_01", ["price"] = 300, ["label"] = "Pouf blanc" },
            { ["object"] = "apa_mp_h_stn_chairarm_12", ["price"] = 500, ["label"] = "Siège 3" },
            { ["object"] = "apa_mp_h_stn_chairstool_12", ["price"] = 300, ["label"] = "Repose-pieds" },
            { ["object"] = "prop_chair_03", ["price"] = 100, ["label"] = "Chaise en bois" },
            { ["object"] = "prop_couch_sm_05", ["price"] = 500, ["label"] = "Fauteuil en velours côtelé" },
            { ["object"] = "prop_couch_sm_07", ["price"] = 300, ["label"] = "Fauteuil blanc 2" },
            { ["object"] = "prop_couch_sm_02", ["price"] = 300, ["label"] = "Fauteuil orange" },
            { ["object"] = "apa_mp_h_stn_sofa_daybed_01", ["price"] = 500, ["label"] = "Fauteuil lounge" },
            { ["object"] = "apa_mp_h_stn_sofa_daybed_02", ["price"] = 500, ["label"] = "Fauteuil lounge 2" },
            { ["object"] = "apa_mp_h_din_chair_04", ["price"] = 500, ["label"] = "Chaise moderne" },
            { ["object"] = "apa_mp_h_din_chair_08", ["price"] = 500, ["label"] = "Chaise moderne 2" },
            { ["object"] = "apa_mp_h_din_chair_09", ["price"] = 500, ["label"] = "Chaise moderne 3" },
            { ["object"] = "apa_mp_h_din_chair_12", ["price"] = 500, ["label"] = "Chaise moderne 4" },
            { ["object"] = "apa_mp_h_din_stool_04", ["price"] = 500, ["label"] = "Chaise moderne 5" },
            { ["object"] = "apa_mp_h_stn_chairarm_01", ["price"] = 500, ["label"] = "Chaise moderne 6" },
            { ["object"] = "apa_mp_h_stn_chairarm_02", ["price"] = 500, ["label"] = "Chaise moderne 7" },
            { ["object"] = "apa_mp_h_stn_chairarm_03", ["price"] = 500, ["label"] = "Chaise moderne 8" },
            { ["object"] = "apa_mp_h_stn_chairarm_09", ["price"] = 500, ["label"] = "Chaise moderne 9" },
            { ["object"] = "apa_mp_h_stn_chairarm_11", ["price"] = 500, ["label"] = "Chaise moderne 10" },
            { ["object"] = "apa_mp_h_stn_chairarm_13", ["price"] = 500, ["label"] = "Chaise moderne 11" },
            { ["object"] = "apa_mp_h_stn_chairarm_24", ["price"] = 500, ["label"] = "Chaise moderne 12" },
            { ["object"] = "apa_mp_h_stn_chairarm_25", ["price"] = 500, ["label"] = "Chaise moderne 13" },
            { ["object"] = "apa_mp_h_stn_chairarm_26", ["price"] = 500, ["label"] = "Chaise moderne 14" },
            { ["object"] = "apa_mp_h_stn_chairstrip_04", ["price"] = 500, ["label"] = "Chaise moderne 15" },
            { ["object"] = "apa_mp_h_stn_chairstrip_05", ["price"] = 500, ["label"] = "Chaise moderne 16" },
            { ["object"] = "apa_mp_h_stn_chairstrip_08", ["price"] = 500, ["label"] = "Chaise moderne 17" },
            { ["object"] = "apa_mp_h_stn_foot_stool_01", ["price"] = 500, ["label"] = "Pouf" },
            { ["object"] = "apa_mp_h_stn_foot_stool_02", ["price"] = 500, ["label"] = "Pouf 2" },
            { ["object"] = "apa_mp_h_yacht_barstool_01", ["price"] = 500, ["label"] = "Tabouret de bar 2" },
            { ["object"] = "ba_prop_int_glam_stool", ["price"] = 500, ["label"] = "Tabouret de bar 3" },
            { ["object"] = "ba_prop_battle_club_chair_01", ["price"] = 500, ["label"] = "Chaise de bureau 3" },
            { ["object"] = "ba_prop_battle_club_chair_02", ["price"] = 500, ["label"] = "Chaise de bureau 4" },
            { ["object"] = "ba_prop_battle_club_chair_03", ["price"] = 500, ["label"] = "Chaise de bureau 5" },
            { ["object"] = "ba_prop_battle_control_seat", ["price"] = 500, ["label"] = "Chaise gamer" },
        }
    },

    {
        category = "Stockage",
        -- Every prop here is a usable container.
        items = MapToStorage(StorageProps),
    },

    {
        category = "Stockage déco",
        -- Same props, no container: decoration only.
        items = MapToDecorative(StorageProps),
    },
    {
        category = "Électronique",
        items = {
            { ["object"] = "prop_trailr_fridge", ["price"] = 300, ["label"] = "Vieux réfrigérateur" },
            { ["object"] = "v_res_fh_speaker", ["price"] = 300, ["label"] = "Enceinte" },
            { ["object"] = "v_res_fh_speakerdock", ["price"] = 300, ["label"] = "Station d'accueil" },
            { ["object"] = "v_res_fh_bedsideclock", ["price"] = 300, ["label"] = "Réveil" },
            { ["object"] = "v_res_fa_phone", ["price"] = 300, ["label"] = "Téléphone" },
            { ["object"] = "v_res_fh_towerfan", ["price"] = 300, ["label"] = "Ventilateur colonne" },
            { ["object"] = "v_res_fa_fan", ["price"] = 300, ["label"] = "Ventilateur" },
            { ["object"] = "v_res_lest_bigscreen", ["price"] = 300, ["label"] = "Grand écran" },
            { ["object"] = "v_res_lest_monitor", ["price"] = 300, ["label"] = "Écran" },
            { ["object"] = "v_res_tre_mixer", ["price"] = 300, ["label"] = "Table de mixage" },
            { ["object"] = "prop_cs_cctv", ["price"] = 100, ["label"] = "Caméra de surveillance" },
            { ["object"] = "prop_ld_lap_top", ["price"] = 100, ["label"] = "Ordinateur portable" },
            { ["object"] = "prop_ld_monitor_01", ["price"] = 100, ["label"] = "Écran" },
            { ["object"] = "prop_speaker_05", ["price"] = 500, ["label"] = "Enceinte murale" },
            { ["object"] = "prop_tv_flat_03b", ["price"] = 1000, ["label"] = "Petit écran plat" },
            { ["object"] = "prop_laptop_01a", ["price"] = 750, ["label"] = "Ordinateur portable ouvert" },
            { ["object"] = "prop_tv_flat_michael", ["price"] = 3000, ["label"] = "Écran plat mural" },
            { ["object"] = "prop_dyn_pc", ["price"] = 1000, ["label"] = "Ordinateur" },
            { ["object"] = "prop_keyboard_01b", ["price"] = 100, ["label"] = "Clavier" },
            { ["object"] = "prop_mouse_01b", ["price"] = 100, ["label"] = "Souris" },
            { ["object"] = "v_ret_gc_phone", ["price"] = 100, ["label"] = "Téléphone de bureau" },
            { ["object"] = "prop_tv_flat_01", ["price"] = 5000, ["label"] = "Grand écran plat" },
            { ["object"] = "prop_arcade_01", ["price"] = 5000, ["label"] = "Borne d'arcade" },
            { ["object"] = "prop_console_01", ["price"] = 250, ["label"] = "Console de jeu" },
            { ["object"] = "v_res_tre_dvdplayer", ["price"] = 250, ["label"] = "Lecteur DVD" },
            { ["object"] = "prop_speaker_08", ["price"] = 500, ["label"] = "Enceinte en bois" },
            { ["object"] = "prop_cctv_mon_02", ["price"] = 300, ["label"] = "Moniteur de surveillance" },
            { ["object"] = "prop_tv_flat_02", ["price"] = 2500, ["label"] = "Écran plat sur pied" },
            { ["object"] = "prop_cctv_cam_01a", ["price"] = 300, ["label"] = "Caméra de surveillance 2" },
            { ["object"] = "prop_dest_cctv_02", ["price"] = 300, ["label"] = "Moniteur de surveillance 2" },
            { ["object"] = "prop_cctv_cam_07a", ["price"] = 300, ["label"] = "Caméra de surveillance 3" },
            { ["object"] = "apa_mp_h_str_avunits_04", ["price"] = 5500, ["label"] = "Meuble écran plat" },
            { ["object"] = "apa_mp_h_str_avunits_01", ["price"] = 5500, ["label"] = "Meuble écran plat 2" },
            { ["object"] = "v_club_vu_deckcase", ["price"] = 1000, ["label"] = "Platines DJ" },
            { ["object"] = "v_corp_servercln", ["price"] = 1000, ["label"] = "Baie de serveurs" },
            { ["object"] = "apa_mp_h_str_avunitl_01_b", ["price"] = 5500, ["label"] = "Meuble écran plat 3" },
            { ["object"] = "apa_mp_h_str_avunitl_04", ["price"] = 5500, ["label"] = "Meuble écran plat 4" },
            { ["object"] = "apa_mp_h_str_avunitm_01", ["price"] = 5500, ["label"] = "Meuble écran plat 5" },
            { ["object"] = "apa_mp_h_str_avunitm_03", ["price"] = 5500, ["label"] = "Meuble écran plat 6" },
            { ["object"] = "apa_mp_h_str_avunits_04", ["price"] = 5500, ["label"] = "Meuble écran plat 7" },
            { ["object"] = "v_res_printer", ["price"] = 300, ["label"] = "Imprimante" },
            { ["object"] = "apa_mp_h_acc_phone_01", ["price"] = 100, ["label"] = "Téléphone rétro" },
            { ["object"] = "v_res_mousemat", ["price"] = 300, ["label"] = "Tapis de souris" },
            { ["object"] = "v_res_pcheadset", ["price"] = 300, ["label"] = "Casque audio" },
            { ["object"] = "v_res_pcspeaker", ["price"] = 300, ["label"] = "Haut-parleur PC" },
            { ["object"] = "ba_prop_battle_club_speaker_small", ["price"] = 500, ["label"] = "Petite enceinte" },
            { ["object"] = "ba_prop_battle_club_speaker_med", ["price"] = 750, ["label"] = "Enceinte 2" },
            { ["object"] = "ba_prop_battle_club_speaker_large", ["price"] = 1000, ["label"] = "Grande enceinte" },
            { ["object"] = "v_res_pcspeaker", ["price"] = 300, ["label"] = "Haut-parleur PC" },
            { ["object"] = "v_res_pcwoofer", ["price"] = 300, ["label"] = "Caisson de basses" },
            { ["object"] = "prop_controller_01", ["price"] = 300, ["label"] = "Manette" },
            { ["object"] = "prop_cs_remote_01", ["price"] = 300, ["label"] = "Télécommande" },
            { ["object"] = "prop_portable_hifi_01", ["price"] = 300, ["label"] = "Radio" },
            { ["object"] = "prop_dj_deck_02", ["price"] = 300, ["label"] = "Table de DJ" },
            { ["object"] = "prop_speaker_01", ["price"] = 300, ["label"] = "Enceinte" },
        }
    },

    {
        category = "Lit",
        items = {
			{ ["object"] = "v_res_d_bed", ["price"] = 700, ["label"] = "Lit 1" },
			{ ["object"] = "v_res_lestersbed", ["price"] = 700, ["label"] = "Lit 2" },
			{ ["object"] = "v_res_mbbed", ["price"] = 700, ["label"] = "Lit MB" },
			{ ["object"] = "v_res_mdbed", ["price"] = 700, ["label"] = "Lit MD" },
			{ ["object"] = "v_res_msonbed", ["price"] = 700, ["label"] = "Lit 3" },
			{ ["object"] = "v_res_tre_bed1", ["price"] = 700, ["label"] = "Lit 4" },
			{ ["object"] = "v_res_tre_bed2", ["price"] = 700, ["label"] = "Lit T" },
			{ ["object"] = "v_res_tt_bed", ["price"] = 700, ["label"] = "Lit TT" },
			{ ["object"] = "apa_mp_h_bed_with_table_02", ["price"] = 5000, ["label"] = "Lit luxueux" },
			{ ["object"] = "apa_mp_h_bed_wide_05", ["price"] = 5000, ["label"] = "Lit rouge" },
			{ ["object"] = "apa_mp_h_bed_double_08", ["price"] = 3000, ["label"] = "Lit carré" },
			{ ["object"] = "apa_mp_h_bed_double_09", ["price"] = 3000, ["label"] = "Lit moderne" },
			{ ["object"] = "apa_mp_h_yacht_bed_01", ["price"] = 5000, ["label"] = "Lit king size" },
			{ ["object"] = "apa_mp_h_yacht_bed_02", ["price"] = 5000, ["label"] = "Lit king size 2" },
			{ ["object"] = "bkr_prop_biker_campbed_01", ["price"] = 100, ["label"] = "Lit de camp" },
			{ ["object"] = "ex_prop_exec_bed_01", ["price"] = 700, ["label"] = "Petit lit" },
			{ ["object"] = "gr_prop_bunker_bed_01", ["price"] = 700, ["label"] = "Petit lit 2" },
			{ ["object"] = "p_mbbed_s", ["price"] = 700, ["label"] = "Lit 5" },
        }
    },

    {
        category = "Éclairage",
        items = {
            { ["object"] = "v_corp_cd_desklamp", ["price"] = 100, ["label"] = "Lampe de bureau pro" },
            { ["object"] = "v_res_desklamp", ["price"] = 100, ["label"] = "Lampe de bureau" },
            { ["object"] = "v_res_d_lampa", ["price"] = 100, ["label"] = "Lampe AA" },
            { ["object"] = "v_res_fa_lamp1on", ["price"] = 100, ["label"] = "Lampe 1" },
            { ["object"] = "v_res_fh_floorlamp", ["price"] = 100, ["label"] = "Lampadaire classique" },
            { ["object"] = "v_res_fh_lampa_on", ["price"] = 100, ["label"] = "Lampe 2" },
            { ["object"] = "v_res_j_tablelamp1", ["price"] = 100, ["label"] = "Lampe de table" },
            { ["object"] = "v_res_j_tablelamp2", ["price"] = 100, ["label"] = "Lampe de table 2" },
            { ["object"] = "v_res_mdbedlamp", ["price"] = 100, ["label"] = "Lampe de chevet" },
            { ["object"] = "v_res_mplanttongue", ["price"] = 100, ["label"] = "Lampe plante" },
            { ["object"] = "v_res_mtblelampmod", ["price"] = 100, ["label"] = "Lampe de table 3" },
            { ["object"] = "v_res_m_lampstand", ["price"] = 100, ["label"] = "Lampe sur pied" },
            { ["object"] = "v_res_m_lampstand2", ["price"] = 100, ["label"] = "Lampe sur pied 2" },
            { ["object"] = "v_res_m_lamptbl", ["price"] = 100, ["label"] = "Lampe de table 4" },
            { ["object"] = "v_res_tre_lightfan", ["price"] = 100, ["label"] = "Ventilateur lumineux" },
            { ["object"] = "v_res_tre_talllamp", ["price"] = 100, ["label"] = "Lampe haute" },
            { ["object"] = "v_ret_fh_walllighton", ["price"] = 100, ["label"] = "Applique murale" },
            { ["object"] = "v_ret_gc_lamp", ["price"] = 100, ["label"] = "Lampe GC" },
            { ["object"] = "prop_dummy_light", ["price"] = 100, ["label"] = "Lumière vacillante" },
            { ["object"] = "prop_ld_cont_light_01", ["price"] = 100, ["label"] = "Applique murale latérale" },
            { ["object"] = "V_44_D_emis", ["price"] = 100, ["label"] = "Lampe de test" },
            { ["object"] = "prop_wall_light_07a", ["price"] = 100, ["label"] = "Lanterne" },
            { ["object"] = "prop_wall_light_01a", ["price"] = 100, ["label"] = "Lampe bon marché" },
            { ["object"] = "v_serv_tu_light2_", ["price"] = 100, ["label"] = "Lumière industrielle" },
            { ["object"] = "v_serv_tu_light3_", ["price"] = 100, ["label"] = "Lumière industrielle 2" },
            { ["object"] = "ba_prop_battle_lights_ceiling_l_a", ["price"] = 300, ["label"] = "Suspension" },
            { ["object"] = "v_med_p_floorlamp", ["price"] = 300, ["label"] = "Grosse lampe" },
            { ["object"] = "v_club_vu_lamp", ["price"] = 100, ["label"] = "Petite lampe" },
            { ["object"] = "ba_prop_battle_lights_wall_l_a", ["price"] = 100, ["label"] = "Applique murale 2" },
            { ["object"] = "ba_prop_battle_lights_ceiling_l_c", ["price"] = 300, ["label"] = "Suspension 2" },
            { ["object"] = "ba_prop_battle_lights_ceiling_l_b", ["price"] = 300, ["label"] = "Lustre 2" },
            { ["object"] = "ba_prop_battle_lights_wall_l_c", ["price"] = 100, ["label"] = "Applique murale 3" },
            { ["object"] = "ba_prop_battle_lights_wall_l_b", ["price"] = 100, ["label"] = "Applique murale 4" },
            { ["object"] = "hei_heist_lit_lightpendant_02", ["price"] = 300, ["label"] = "Suspension 3" },
            { ["object"] = "prop_oldlight_01b", ["price"] = 100, ["label"] = "Applique murale 5" },
            { ["object"] = "apa_mp_h_lit_floorlampnight_07", ["price"] = 100, ["label"] = "Lampe bleue" },
            { ["object"] = "apa_mp_h_ceiling_light_01", ["price"] = 100, ["label"] = "Néon commercial" },
            { ["object"] = "apa_mp_h_ceiling_light_01_day", ["price"] = 100, ["label"] = "Néon commercial 2" },
            { ["object"] = "apa_mp_h_ceiling_light_02", ["price"] = 100, ["label"] = "Plafonnier" },
            { ["object"] = "apa_mp_h_ceiling_light_02_day", ["price"] = 100, ["label"] = "Plafonnier 2" },
            { ["object"] = "ba_prop_battle_lights_ceiling_l_d", ["price"] = 100, ["label"] = "Néon commercial 3" },
            { ["object"] = "ba_prop_battle_lights_ceiling_l_f", ["price"] = 100, ["label"] = "Plafonnier 3" },
            { ["object"] = "ba_prop_battle_lights_ceiling_l_e", ["price"] = 100, ["label"] = "Plafonnier 4" },
            { ["object"] = "apa_mp_h_floorlamp_a", ["price"] = 100, ["label"] = "Lampadaire" },
            { ["object"] = "apa_mp_h_floorlamp_b", ["price"] = 100, ["label"] = "Lampadaire 2" },
            { ["object"] = "apa_mp_h_floorlamp_c", ["price"] = 100, ["label"] = "Lampadaire 3" },
            { ["object"] = "apa_mp_h_floor_lamp_int_08", ["price"] = 100, ["label"] = "Lampadaire 4" },
            { ["object"] = "apa_mp_h_lampbulb_multiple_a", ["price"] = 100, ["label"] = "Plafonnier 5" },
            { ["object"] = "apa_mp_h_lit_floorlamp_02", ["price"] = 100, ["label"] = "Lampadaire 5" },
            { ["object"] = "apa_mp_h_lit_floorlampnight_14", ["price"] = 100, ["label"] = "Lampadaire 6" },
            { ["object"] = "apa_mp_h_lit_floorlamp_03", ["price"] = 100, ["label"] = "Lampadaire 7" },
            { ["object"] = "apa_mp_h_lit_floorlamp_06", ["price"] = 100, ["label"] = "Lampadaire 8" },
            { ["object"] = "apa_mp_h_lit_floorlamp_10", ["price"] = 100, ["label"] = "Lampadaire 9" },
            { ["object"] = "apa_mp_h_lit_floorlamp_13", ["price"] = 100, ["label"] = "Lampadaire 10" },
            { ["object"] = "apa_mp_h_lit_floorlamp_17", ["price"] = 100, ["label"] = "Lampadaire 11" },
            { ["object"] = "apa_mp_h_lit_lamptablenight_16", ["price"] = 100, ["label"] = "Veilleuse" },
            { ["object"] = "apa_mp_h_lit_lamptablenight_24", ["price"] = 100, ["label"] = "Veilleuse 2" },
            { ["object"] = "apa_mp_h_lit_lamptable_005", ["price"] = 100, ["label"] = "Veilleuse 3" },
            { ["object"] = "apa_mp_h_lit_lamptable_04", ["price"] = 100, ["label"] = "Veilleuse 4" },
            { ["object"] = "apa_mp_h_lit_lamptable_09", ["price"] = 100, ["label"] = "Veilleuse 5" },
            { ["object"] = "apa_mp_h_lit_lamptable_14", ["price"] = 100, ["label"] = "Veilleuse 6" },
            { ["object"] = "apa_mp_h_lit_lamptable_17", ["price"] = 100, ["label"] = "Veilleuse 7" },
            { ["object"] = "apa_mp_h_yacht_table_lamp_01", ["price"] = 100, ["label"] = "Veilleuse 8" },
        },
    },

    {
        category = "Tables",
        items = {
            { ["object"] = "v_res_d_coffeetable", ["price"] = 500, ["label"] = "Table basse 1" },
            { ["object"] = "v_res_d_roundtable", ["price"] = 500, ["label"] = "Table ronde" },
            { ["object"] = "v_res_d_smallsidetable", ["price"] = 500, ["label"] = "Petite table d'appoint" },
            { ["object"] = "v_res_fh_coftablea", ["price"] = 500, ["label"] = "Table A" },
            { ["object"] = "v_res_fh_coftableb", ["price"] = 500, ["label"] = "Table B" },
            { ["object"] = "v_res_fh_coftbldisp", ["price"] = 500, ["label"] = "Table C" },
            { ["object"] = "v_res_fh_diningtable", ["price"] = 500, ["label"] = "Table à manger" },
            { ["object"] = "v_res_j_coffeetable", ["price"] = 500, ["label"] = "Table basse 2" },
            { ["object"] = "v_res_j_lowtable", ["price"] = 500, ["label"] = "Table basse" },
            { ["object"] = "v_res_mdbedtable", ["price"] = 500, ["label"] = "Table de lit" },
            { ["object"] = "v_res_mddesk", ["price"] = 500, ["label"] = "Bureau 2" },
            { ["object"] = "v_res_msidetblemod", ["price"] = 500, ["label"] = "Table d'appoint" },
            { ["object"] = "v_res_m_console", ["price"] = 500, ["label"] = "Console 2" },
            { ["object"] = "v_res_m_dinetble_replace", ["price"] = 500, ["label"] = "Table à manger 2" },
            { ["object"] = "v_res_m_h_console", ["price"] = 500, ["label"] = "Console haute" },
            { ["object"] = "v_res_m_stool", ["price"] = 500, ["label"] = "Tabouret" },
            { ["object"] = "v_res_tre_sideboard", ["price"] = 500, ["label"] = "Buffet" },
            { ["object"] = "v_res_tre_table2", ["price"] = 500, ["label"] = "Table 2" },
            { ["object"] = "v_res_tre_tvstand", ["price"] = 500, ["label"] = "Table TV" },
            { ["object"] = "v_res_tre_tvstand_tall", ["price"] = 500, ["label"] = "Table TV haute" },
            { ["object"] = "v_med_p_coffeetable", ["price"] = 500, ["label"] = "Table basse médicale" },
            { ["object"] = "v_med_p_desk", ["price"] = 500, ["label"] = "Bureau médical" },
            { ["object"] = "prop_yacht_table_01", ["price"] = 100, ["label"] = "Table de yacht 1" },
            { ["object"] = "prop_yacht_table_02", ["price"] = 100, ["label"] = "Table de yacht 2" },
            { ["object"] = "prop_yacht_table_03", ["price"] = 100, ["label"] = "Table de yacht 3" },
            { ["object"] = "v_ret_csr_table", ["price"] = 100, ["label"] = "Table CSR" },
            { ["object"] = "v_res_mconsoletrad", ["price"] = 250, ["label"] = "Table d'appoint haute" },
            { ["object"] = "v_ilev_liconftable_sml", ["price"] = 500, ["label"] = "Table de bureau" },
            { ["object"] = "v_ret_tablesml", ["price"] = 350, ["label"] = "Table d'appoint Marillaux" },
            { ["object"] = "apa_mp_h_yacht_coffee_table_02", ["price"] = 500, ["label"] = "Table basse marron" },
            { ["object"] = "apa_mp_h_yacht_side_table_01", ["price"] = 300, ["label"] = "Table d'appoint marron" },
            { ["object"] = "apa_mp_h_yacht_side_table_02", ["price"] = 300, ["label"] = "Table d'appoint ronde" },
            { ["object"] = "apa_mp_h_tab_sidelrg_04", ["price"] = 300, ["label"] = "Table d'appoint ronde 2" },
            { ["object"] = "v_club_vu_table", ["price"] = 300, ["label"] = "Table nappée" },
            { ["object"] = "apa_mp_h_tab_sidelrg_07", ["price"] = 500, ["label"] = "Table basse en verre" },
            { ["object"] = "bkr_prop_weed_table_01b", ["price"] = 100, ["label"] = "Table pliante" },
            { ["object"] = "ba_prop_int_trad_table", ["price"] = 300, ["label"] = "Mange-debout" },
            { ["object"] = "apa_mp_h_str_sideboards_02", ["price"] = 750, ["label"] = "Table d'appoint en verre" },
            { ["object"] = "apa_mp_h_yacht_coffee_table_01", ["price"] = 750, ["label"] = "Table basse moderne" },
            { ["object"] = "apa_mp_h_din_table_04", ["price"] = 1000, ["label"] = "Table à manger en verre" },
            { ["object"] = "xm_prop_base_staff_desk_01", ["price"] = 5000, ["label"] = "Bureau équipé" },
            { ["object"] = "apa_mp_h_tab_coffee_07", ["price"] = 1000, ["label"] = "Table d'appoint triangulaire" },
            { ["object"] = "apa_mp_h_tab_coffee_08", ["price"] = 1000, ["label"] = "Table d'appoint blanche" },
            { ["object"] = "apa_mp_h_tab_sidelrg_01", ["price"] = 1000, ["label"] = "Table d'appoint en verre 2" },
            { ["object"] = "apa_mp_h_tab_sidelrg_02", ["price"] = 1000, ["label"] = "Table d'appoint en verre 3" },
            { ["object"] = "apa_mp_h_tab_sidesml_01", ["price"] = 1000, ["label"] = "Table pliante 2" },
            { ["object"] = "ba_prop_int_edgy_table_01", ["price"] = 500, ["label"] = "Table en marbre" },
            { ["object"] = "ba_prop_int_edgy_table_02", ["price"] = 500, ["label"] = "Table en marbre haute" },
            { ["object"] = "apa_mp_h_tab_sidelrg_01", ["price"] = 1000, ["label"] = "Table d'appoint en verre 2" },
            { ["object"] = "xm_prop_lab_desk_01", ["price"] = 1000, ["label"] = "Paillasse de laboratoire" },
        }
    },

    {
        category = "Salle de bain",
        items = {
            { ["object"] = "prop_ld_toilet_01", ["price"] = 100, ["label"] = "Toilettes 1" },
            { ["object"] = "prop_toilet_01", ["price"] = 100, ["label"] = "Toilettes 2" },
            { ["object"] = "prop_toilet_02", ["price"] = 100, ["label"] = "Toilettes 3" },
            { ["object"] = "prop_sink_02", ["price"] = 100, ["label"] = "Lavabo 1" },
            { ["object"] = "prop_sink_04", ["price"] = 100, ["label"] = "Lavabo 2" },
            { ["object"] = "prop_sink_05", ["price"] = 100, ["label"] = "Lavabo 3" },
            { ["object"] = "prop_sink_06", ["price"] = 100, ["label"] = "Lavabo 4" },
            { ["object"] = "prop_soap_disp_01", ["price"] = 100, ["label"] = "Distributeur de savon" },
            { ["object"] = "prop_shower_rack_01", ["price"] = 100, ["label"] = "Étagère de douche" },
            { ["object"] = "prop_handdry_01", ["price"] = 100, ["label"] = "Sèche-mains 1" },
            { ["object"] = "prop_handdry_02", ["price"] = 100, ["label"] = "Sèche-mains 2" },
            { ["object"] = "prop_towel_rail_01", ["price"] = 100, ["label"] = "Porte-serviettes 1" },
            { ["object"] = "prop_towel_rail_02", ["price"] = 100, ["label"] = "Porte-serviettes 2" },
            { ["object"] = "prop_towel_01", ["price"] = 100, ["label"] = "Serviette 1" },
            { ["object"] = "v_res_mbtowel", ["price"] = 100, ["label"] = "Serviette 2" },
            { ["object"] = "v_res_mbtowelfld", ["price"] = 100, ["label"] = "Serviette 3" },
            { ["object"] = "v_res_mbath", ["price"] = 100, ["label"] = "Baignoire" },
            { ["object"] = "v_res_mbsink", ["price"] = 100, ["label"] = "Lavabo" },
            { ["object"] = "v_ilev_mm_faucet", ["price"] = 100, ["label"] = "Robinet" },
            { ["object"] = "v_res_tre_washbasket", ["price"] = 250, ["label"] = "Panier à linge" },
            { ["object"] = "prop_toilet_soap_02", ["price"] = 100, ["label"] = "Porte-savon" },
            { ["object"] = "prop_bar_sink_01", ["price"] = 100, ["label"] = "Lavabo" },
            { ["object"] = "apa_mp_h_bathtub_01", ["price"] = 1000, ["label"] = "Baignoire" },
            { ["object"] = "prop_toilet_brush_01", ["price"] = 1000, ["label"] = "Brosse" },
            { ["object"] = "prop_toilet_roll_01", ["price"] = 1000, ["label"] = "Papier toilette" },
            { ["object"] = "prop_toilet_roll_02", ["price"] = 1000, ["label"] = "Papier toilette 2" },
            { ["object"] = "prop_toilet_shamp_01", ["price"] = 1000, ["label"] = "Shampoing" },
            { ["object"] = "prop_toilet_shamp_02", ["price"] = 1000, ["label"] = "Shampoing 2" },
        }
    },

    {
        category = "Décoration murale",
        items = {
            { ["object"] = "apa_p_h_acc_artwalll_02", ["price"] = 1000, ["label"] = "Tableau taché" },
            { ["object"] = "v_ind_cs_toolboard", ["price"] = 500, ["label"] = "Panneau à outils" },
            { ["object"] = "apa_mp_stilts_bed_art", ["price"] = 300, ["label"] = "Art 3D" },
            { ["object"] = "ex_office_swag_paintings03", ["price"] = 1000, ["label"] = "Tableaux au sol" },
            { ["object"] = "ex_mp_h_acc_artwallm_03", ["price"] = 750, ["label"] = "Tableau abstrait" },
            { ["object"] = "ex_p_h_acc_artwallm_04", ["price"] = 750, ["label"] = "Tableau abstrait 2" },
            { ["object"] = "ex_p_h_acc_artwalll_01", ["price"] = 1250, ["label"] = "Grand tableau abstrait" },
            { ["object"] = "apa_p_h_acc_artwalll_03", ["price"] = 750, ["label"] = "Tableau abstrait 3" },
            { ["object"] = "ex_mp_h_acc_artwallm_02", ["price"] = 750, ["label"] = "Tableau abstrait 4" },
            { ["object"] = "ex_p_h_acc_artwallm_03", ["price"] = 750, ["label"] = "Tableau abstrait 5" },
            { ["object"] = "apa_mp_stilts_a_study_pics", ["price"] = 500, ["label"] = "Tableaux" },
            { ["object"] = "apa_mp_h_acc_artwallm_02", ["price"] = 750, ["label"] = "Tableau abstrait 6" },
            { ["object"] = "apa_mp_h_acc_artwalll_02", ["price"] = 750, ["label"] = "Tableau abstrait 7" },
            { ["object"] = "apa_mp_h_acc_artwallm_04", ["price"] = 750, ["label"] = "Tableau abstrait 8" },
            { ["object"] = "prop_dart_bd_cab_01", ["price"] = 250, ["label"] = "Cible de fléchettes" },
            { ["object"] = "prop_dart_bd_01", ["price"] = 250, ["label"] = "Cible de fléchettes 2" },
            { ["object"] = "hei_heist_acc_artwalll_01", ["price"] = 250, ["label"] = "Déco murale 1" },
            { ["object"] = "hei_heist_acc_artgolddisc_01", ["price"] = 250, ["label"] = "Déco murale 2" },
            { ["object"] = "hei_heist_acc_artgolddisc_02", ["price"] = 250, ["label"] = "Déco murale 3" },
            { ["object"] = "hei_heist_acc_artgolddisc_03", ["price"] = 250, ["label"] = "Déco murale 4" },
            { ["object"] = "hei_heist_acc_artgolddisc_04", ["price"] = 250, ["label"] = "Déco murale 5" },
            { ["object"] = "v_ilev_ra_doorsafe", ["price"] = 250, ["label"] = "Déco de luxe" },
        }
    },

    {
        category = "Cuisine",
        items = {
            { ["object"] = "prop_washer_01", ["price"] = 150, ["label"] = "Lave-linge 1" },
            { ["object"] = "prop_washer_02", ["price"] = 150, ["label"] = "Lave-linge 2" },
            { ["object"] = "prop_washer_03", ["price"] = 150, ["label"] = "Lave-linge 3" },
            { ["object"] = "prop_washing_basket_01", ["price"] = 150, ["label"] = "Panier à linge 2" },
            { ["object"] = "v_res_fridgemoda", ["price"] = 150, ["label"] = "Réfrigérateur 1" },
            { ["object"] = "v_res_fridgemodsml", ["price"] = 150, ["label"] = "Réfrigérateur 2" },
            { ["object"] = "prop_fridge_01", ["price"] = 150, ["label"] = "Réfrigérateur 3" },
            { ["object"] = "prop_fridge_03", ["price"] = 150, ["label"] = "Réfrigérateur 4" },
            { ["object"] = "prop_cooker_03", ["price"] = 150, ["label"] = "Cuisinière" },
            { ["object"] = "prop_micro_01", ["price"] = 150, ["label"] = "Micro-ondes 1" },
            { ["object"] = "prop_micro_02", ["price"] = 150, ["label"] = "Micro-ondes 2" },
            { ["object"] = "prop_wok", ["price"] = 150, ["label"] = "Wok" },
            { ["object"] = "v_res_cakedome", ["price"] = 150, ["label"] = "Présentoir à gâteau" },
            { ["object"] = "v_res_fa_chopbrd", ["price"] = 150, ["label"] = "Planche à découper" },
            { ["object"] = "v_res_mutensils", ["price"] = 150, ["label"] = "Ustensiles" },
            { ["object"] = "v_res_pestle", ["price"] = 150, ["label"] = "Mortier" },
            { ["object"] = "v_ret_ta_paproll", ["price"] = 150, ["label"] = "Essuie-tout 1" },
            { ["object"] = "v_ret_ta_paproll2", ["price"] = 150, ["label"] = "Essuie-tout 2" },
            { ["object"] = "v_ret_fh_pot01", ["price"] = 150, ["label"] = "Casserole 1" },
            { ["object"] = "v_ret_fh_pot02", ["price"] = 150, ["label"] = "Casserole 2" },
            { ["object"] = "v_ret_fh_pot05", ["price"] = 150, ["label"] = "Casserole 3" },
            { ["object"] = "prop_pot_03", ["price"] = 150, ["label"] = "Casserole 4" },
            { ["object"] = "prop_pot_04", ["price"] = 150, ["label"] = "Casserole 5" },
            { ["object"] = "prop_pot_05", ["price"] = 150, ["label"] = "Casserole 6" },
            { ["object"] = "prop_pot_06", ["price"] = 150, ["label"] = "Casserole 7" },
            { ["object"] = "prop_pot_rack", ["price"] = 150, ["label"] = "Porte-casseroles" },
            { ["object"] = "prop_kitch_juicer", ["price"] = 150, ["label"] = "Presse-agrumes" },
            { ["object"] = "v_res_ovenhobmod", ["price"] = 1000, ["label"] = "Cuisinière 2" },
            { ["object"] = "v_res_mkniferack", ["price"] = 100, ["label"] = "Couteau" },
            { ["object"] = "v_res_mchopboard", ["price"] = 100, ["label"] = "Planche à découper 2" },
            { ["object"] = "prop_cs_kitchen_cab_l", ["price"] = 750, ["label"] = "Placard de cuisine large" },
            { ["object"] = "prop_cs_kitchen_cab_r", ["price"] = 500, ["label"] = "Placard de cuisine étroit" },
            { ["object"] = "prop_cs_kitchen_cab_r", ["price"] = 500, ["label"] = "Placard de cuisine étroit" },
            { ["object"] = "v_res_tre_fridge", ["price"] = 500, ["label"] = "Réfrigérateur" },
            { ["object"] = "apa_mp_h_acc_coffeemachine_01", ["price"] = 500, ["label"] = "Machine à café" },
            { ["object"] = "p_new_j_counter_02", ["price"] = 500, ["label"] = "Plan de travail" },
            { ["object"] = "prop_bar_pump_09", ["price"] = 500, ["label"] = "Pompe 1" },
            { ["object"] = "prop_bar_pump_01", ["price"] = 500, ["label"] = "Pompe 2" },
            { ["object"] = "prop_chip_fryer", ["price"] = 500, ["label"] = "Friteuse" },
            { ["object"] = "prop_cleaver", ["price"] = 500, ["label"] = "Couteau 2" },
            { ["object"] = "prop_coffee_mac_02", ["price"] = 500, ["label"] = "Machine à café" },
            { ["object"] = "prop_coffee_mac_01", ["price"] = 500, ["label"] = "Machine à café 2" },
            { ["object"] = "prop_cs_fork", ["price"] = 500, ["label"] = "Fourchette" },
            { ["object"] = "prop_cs_sink_filler", ["price"] = 500, ["label"] = "Robinet d'évier" },
            { ["object"] = "prop_toaster_01", ["price"] = 500, ["label"] = "Grille-pain" },
            { ["object"] = "prop_cs_plate_01", ["price"] = 500, ["label"] = "Assiette" },
            { ["object"] = "prop_foodprocess_01", ["price"] = 500, ["label"] = "Robot de cuisine" },
            { ["object"] = "prop_food_sugarjar", ["price"] = 500, ["label"] = "Sucrier" },
            { ["object"] = "prop_juice_dispenser", ["price"] = 500, ["label"] = "Distributeur" },
            { ["object"] = "prop_knife_stand", ["price"] = 500, ["label"] = "Bloc à couteaux" },
            { ["object"] = "prop_knife", ["price"] = 500, ["label"] = "Couteau 3" },
            { ["object"] = "prop_micro_04", ["price"] = 500, ["label"] = "Micro-ondes 4" },
            { ["object"] = "v_ret_fh_plate3", ["price"] = 500, ["label"] = "Assiette 5" },
            { ["object"] = "v_ilev_tt_plate01", ["price"] = 500, ["label"] = "Assiette 6" },
            { ["object"] = "v_res_fa_grater", ["price"] = 500, ["label"] = "Râpe" },
            { ["object"] = "v_res_tt_pizzaplate", ["price"] = 500, ["label"] = "Plat à pizza" },
            { ["object"] = "v_ret_247_ketchup2", ["price"] = 500, ["label"] = "Ketchup" },
        }
    },

    {
        category = "Plantes",
        items = {
            { ["object"] = "prop_fib_plant_01", ["price"] = 150, ["label"] = "Plante FIB" },
            { ["object"] = "v_corp_bombplant", ["price"] = 170, ["label"] = "Plante bombée" },
            { ["object"] = "v_res_mflowers", ["price"] = 170, ["label"] = "Plante fleurie" },
            { ["object"] = "v_res_mvasechinese", ["price"] = 170, ["label"] = "Plante chinoise" },
            { ["object"] = "v_res_m_bananaplant", ["price"] = 170, ["label"] = "Bananier" },
            { ["object"] = "v_res_m_palmplant1", ["price"] = 170, ["label"] = "Palmier" },
            { ["object"] = "v_res_m_palmstairs", ["price"] = 170, ["label"] = "Palmier 2" },
            { ["object"] = "v_res_m_urn", ["price"] = 170, ["label"] = "Plante en urne" },
            { ["object"] = "v_res_rubberplant", ["price"] = 170, ["label"] = "Caoutchouc" },
            { ["object"] = "v_res_tre_plant", ["price"] = 170, ["label"] = "Plante" },
            { ["object"] = "v_res_tre_tree", ["price"] = 170, ["label"] = "Arbre en pot" },
            { ["object"] = "v_med_p_planter", ["price"] = 170, ["label"] = "Jardinière" },
            { ["object"] = "v_ret_flowers", ["price"] = 100, ["label"] = "Fleurs" },
            { ["object"] = "v_ret_j_flowerdisp", ["price"] = 100, ["label"] = "Fleurs 1" },
            { ["object"] = "v_ret_j_flowerdisp_white", ["price"] = 100, ["label"] = "Fleurs 2" },
            { ["object"] = "v_res_m_vasefresh", ["price"] = 300, ["label"] = "Vase à fleurs" },
            { ["object"] = "v_res_rosevasedead", ["price"] = 300, ["label"] = "Vase rose 2" },
            { ["object"] = "v_res_exoticvase", ["price"] = 300, ["label"] = "Vase à fleurs 2" },
            { ["object"] = "v_res_rosevase", ["price"] = 300, ["label"] = "Vase rose" },
            { ["object"] = "prop_pot_plant_6a", ["price"] = 300, ["label"] = "Plante suspendue" },
            { ["object"] = "prop_pot_plant_02a", ["price"] = 300, ["label"] = "Pot de fleurs" },
            { ["object"] = "apa_mp_h_acc_plant_palm_01", ["price"] = 300, ["label"] = "Palmier en pot" },
            { ["object"] = "prop_plant_interior_05a", ["price"] = 300, ["label"] = "Jardinière 2" },
            { ["object"] = "prop_plant_int_01a", ["price"] = 300, ["label"] = "Plante en pot" },
            { ["object"] = "prop_plant_int_01b", ["price"] = 300, ["label"] = "Plante en pot 2" },
            { ["object"] = "prop_plant_int_02a", ["price"] = 300, ["label"] = "Plante en pot 3" },
            { ["object"] = "prop_plant_int_02b", ["price"] = 300, ["label"] = "Plante en pot 4" },
            { ["object"] = "prop_plant_int_03a", ["price"] = 300, ["label"] = "Plante en pot 5" },
            { ["object"] = "prop_plant_int_03b", ["price"] = 300, ["label"] = "Plante en pot 6" },
            { ["object"] = "prop_plant_int_03c", ["price"] = 300, ["label"] = "Plante en pot 7" },
            { ["object"] = "prop_plant_int_04a", ["price"] = 300, ["label"] = "Plante en pot 8" },
            { ["object"] = "prop_plant_int_04c", ["price"] = 300, ["label"] = "Plante en pot 9" },
            { ["object"] = "prop_plant_int_05b", ["price"] = 300, ["label"] = "Jardinière 3" },
            { ["object"] = "prop_pot_plant_01a", ["price"] = 300, ["label"] = "Pot de plante 2" },
            { ["object"] = "prop_pot_plant_01b", ["price"] = 300, ["label"] = "Pot de plante 3" },
            { ["object"] = "prop_pot_plant_01c", ["price"] = 300, ["label"] = "Pot de plante 4" },
            { ["object"] = "prop_pot_plant_01d", ["price"] = 300, ["label"] = "Pot de plante 5" },
            { ["object"] = "prop_pot_plant_01e", ["price"] = 300, ["label"] = "Pot de plante 6" },
            { ["object"] = "prop_pot_plant_03b", ["price"] = 300, ["label"] = "Pot de plante 7" },
            { ["object"] = "prop_pot_plant_05a", ["price"] = 300, ["label"] = "Pot de plante 8" },
            { ["object"] = "prop_pot_plant_05b", ["price"] = 300, ["label"] = "Pot de plante 9" },
            { ["object"] = "p_int_jewel_plant_01", ["price"] = 300, ["label"] = "Pot de plante 10" },
            { ["object"] = "p_int_jewel_plant_02", ["price"] = 300, ["label"] = "Pot de plante 11" },
            { ["object"] = "apa_mp_h_acc_vase_flowers_01", ["price"] = 300, ["label"] = "Pot de plante 12" },
            { ["object"] = "apa_mp_h_acc_vase_flowers_02", ["price"] = 300, ["label"] = "Pot de plante 13" },
            { ["object"] = "apa_mp_h_acc_vase_flowers_03", ["price"] = 300, ["label"] = "Pot de plante 14" },
            { ["object"] = "apa_mp_h_acc_vase_flowers_04", ["price"] = 300, ["label"] = "Pot de plante 15" },
        }
    },

    {
        category = "Détail",
        items = {
            { ["object"] = "v_res_r_figcat", ["price"] = 300, ["label"] = "Figurine chat" },
			{ ["object"] = "v_res_r_figclown", ["price"] = 300, ["label"] = "Figurine clown" },
			{ ["object"] = "v_res_r_figauth2", ["price"] = 300, ["label"] = "Figurine écrivain" },
			{ ["object"] = "v_res_r_figfemale", ["price"] = 300, ["label"] = "Figurine femme" },
			{ ["object"] = "v_res_r_figflamenco", ["price"] = 300, ["label"] = "Figurine flamenco" },
			{ ["object"] = "v_res_r_figgirl", ["price"] = 300, ["label"] = "Figurine fille" },
			{ ["object"] = "v_res_r_figgirlclown", ["price"] = 300, ["label"] = "Figurine fille clown" },
			{ ["object"] = "v_res_r_figoblisk", ["price"] = 300, ["label"] = "Figurine obélisque" },
			{ ["object"] = "v_res_r_figpillar", ["price"] = 300, ["label"] = "Figurine colonne" },
			{ ["object"] = "v_res_r_teapot", ["price"] = 300, ["label"] = "Théière" },
			{ ["object"] = "v_res_sculpt_dec", ["price"] = 300, ["label"] = "Sculpture 1" },
			{ ["object"] = "v_res_sculpt_decd", ["price"] = 300, ["label"] = "Sculpture 2" },
			{ ["object"] = "v_res_sculpt_dece", ["price"] = 300, ["label"] = "Sculpture 3" },
			{ ["object"] = "v_res_sculpt_decf", ["price"] = 300, ["label"] = "Sculpture 4" },
			{ ["object"] = "v_res_skateboard", ["price"] = 300, ["label"] = "Skateboard" },
			{ ["object"] = "v_res_sketchpad", ["price"] = 300, ["label"] = "Carnet à dessin" },
			{ ["object"] = "v_res_tissues", ["price"] = 300, ["label"] = "Boîte de mouchoirs" },
			{ ["object"] = "v_res_tre_basketmess", ["price"] = 300, ["label"] = "Panier" },
			{ ["object"] = "v_res_tre_bin", ["price"] = 300, ["label"] = "Poubelle" },
			{ ["object"] = "v_res_tre_cushiona", ["price"] = 300, ["label"] = "Coussin 1" },
			{ ["object"] = "v_res_tre_cushionb", ["price"] = 300, ["label"] = "Coussin 2" },
			{ ["object"] = "v_res_tre_cushionc", ["price"] = 300, ["label"] = "Coussin 3" },
			{ ["object"] = "v_res_tre_cushiond", ["price"] = 300, ["label"] = "Coussin 4" },
			{ ["object"] = "v_res_tre_cushnscuzb", ["price"] = 300, ["label"] = "Coussin 5" },
			{ ["object"] = "v_res_tre_cushnscuzd", ["price"] = 300, ["label"] = "Coussin 6" },
			{ ["object"] = "v_res_tre_fruitbowl", ["price"] = 300, ["label"] = "Corbeille à fruits" },
			{ ["object"] = "v_med_p_sideboard", ["price"] = 300, ["label"] = "Buffet 2" },
			{ ["object"] = "prop_idol_01", ["price"] = 100, ["label"] = "Idole 1" },
			{ ["object"] = "v_res_r_fighorsestnd", ["price"] = 300, ["label"] = "Figurine cheval noir" },
			{ ["object"] = "v_res_r_fighorse", ["price"] = 300, ["label"] = "Figurine grand cheval" },
			{ ["object"] = "v_res_r_figdancer", ["price"] = 300, ["label"] = "Figurine danseuse" },
			{ ["object"] = "v_res_fa_idol02", ["price"] = 300, ["label"] = "Figurine éléphants" },
			{ ["object"] = "v_res_m_statue", ["price"] = 300, ["label"] = "Sculpture" },
			{ ["object"] = "v_20_ornaeagle", ["price"] = 300, ["label"] = "Figurine aigle" },
			{ ["object"] = "v_med_p_vaseround", ["price"] = 300, ["label"] = "Vase rond" },
			{ ["object"] = "ex_mp_h_acc_vase_05", ["price"] = 300, ["label"] = "Vase violet" },
			{ ["object"] = "apa_mp_h_acc_dec_head_01", ["price"] = 300, ["label"] = "Œuvre d'art" },
			{ ["object"] = "apa_mp_h_acc_dec_sculpt_02", ["price"] = 300, ["label"] = "Œuvre d'art 2" },
			{ ["object"] = "ex_mp_h_acc_dec_plate_02", ["price"] = 300, ["label"] = "Œuvre d'art 3" },
			{ ["object"] = "apa_mp_h_acc_bowl_ceramic_01", ["price"] = 300, ["label"] = "Coupe" },
			{ ["object"] = "apa_mp_h_acc_dec_plate_01", ["price"] = 300, ["label"] = "Coupe 2" },
			{ ["object"] = "apa_mp_h_acc_vase_01", ["price"] = 300, ["label"] = "Vase noir et blanc" },
			{ ["object"] = "apa_mp_h_acc_vase_02", ["price"] = 300, ["label"] = "Vase rouge" },
			{ ["object"] = "apa_mp_h_acc_vase_05", ["price"] = 300, ["label"] = "Vase" },
			{ ["object"] = "apa_mp_h_acc_vase_06", ["price"] = 300, ["label"] = "Vase noir et blanc 2" },
        }
    },

    {
        category = "Portes", -- All from Base Game.
        items = {
            { ["object"] = "v_ilev_fa_frontdoor", ["price"] = 300, ["type"] = "door", ["label"] = "Porte blanche" },
            { ["object"] = "v_ilev_247_offdorr", ["price"] = 300, ["type"] = "door", ["label"] = "Porte en bois 24/7" },
            { ["object"] = "v_ilev_arm_secdoor", ["price"] = 300, ["type"] = "door", ["label"] = "Porte de sécurité" },
            { ["object"] = "v_ilev_bank4door01", ["price"] = 300, ["type"] = "door", ["label"] = "Porte vitrée de banque" },
            { ["object"] = "v_ilev_bk_gate", ["price"] = 300, ["type"] = "door", ["label"] = "Grille en métal ouvragée" },
            { ["object"] = "v_ilev_cbankcountdoor01", ["price"] = 300, ["type"] = "door",  ["label"] = "Porte de bureau de banque" },
            { ["object"] = "v_ilev_cd_door", ["price"] = 300, ["type"] = "door", ["label"] = "Porte en bois vitrée" },
            { ["object"] = "v_ilev_cm_door1", ["price"] = 300, ["type"] = "door", ["label"] = "Porte bleu clair" },
            { ["object"] = "v_ilev_dev_door", ["price"] = 300, ["type"] = "door", ["label"] = "Porte de maison noire" },
            { ["object"] = "v_ilev_door_orangesolid", ["price"] = 300, ["type"] = "door", ["label"] = "Porte pleine orange" },
            { ["object"] = "v_ilev_fa_backdoor", ["price"] = 300, ["type"] = "door", ["label"] = "Porte vitrée sale" },
            { ["object"] = "v_ilev_gangsafedoor", ["price"] = 300, ["type"] = "door", ["label"] = "Porte blindée de gang" },
            { ["object"] = "v_ilev_gc_door02", ["price"] = 300, ["type"] = "door", ["label"] = "Porte de bureau" },
            { ["object"] = "v_ilev_janitor_frontdoor", ["price"] = 300, ["type"] = "door",  ["label"] = "Porte grillagée blanche" },
            { ["object"] = "v_ilev_rc_door1", ["price"] = 300, ["type"] = "door", ["label"] = "Porte coupe-feu jaune" },
            { ["object"] = "v_ilev_roc_door2", ["price"] = 300, ["type"] = "door", ["label"] = "Porte pleine rouge" },
            { ["object"] = "v_ilev_sol_off_door01", ["price"] = 300, ["type"] = "door", ["label"] = "Porte pleine en bois" },
            { ["object"] = "v_ilev_stad_fdoor", ["price"] = 300, ["type"] = "door", ["label"] = "Porte vitrée à rails" },
            { ["object"] = "v_ilev_tort_door", ["price"] = 300, ["type"] = "door", ["label"] = "Porte avec panneau danger" },
            { ["object"] = "v_ilev_trevtraildr", ["price"] = 300, ["type"] = "door", ["label"] = "Porte de mobil-home" },
            { ["object"] = "prop_cs_fridge_door", ["price"] = 300, ["type"] = "door", ["label"] = "Porte de chambre froide" },
            { ["object"] = "prop_artgallery_dl", ["price"] = 300, ["type"] = "door", ["label"] = "Porte de galerie d'art blanche" },
            { ["object"] = "prop_bh1_09_mp_l", ["price"] = 300, ["type"] = "door",  ["label"] = "Porte du Weazel Plaza" },
            { ["object"] = "prop_bh1_48_backdoor_l", ["price"] = 300, ["type"] = "door", ["label"] = "Porte vitrée noire" },
            { ["object"] = "prop_casino_door_01r", ["price"] = 300, ["type"] = "door", ["label"] = "Porte vitrée de casino" },
            { ["object"] = "prop_cs4_11_door", ["price"] = 300, ["type"] = "door", ["label"] = "Porte blanche à hublot" },
            { ["object"] = "prop_cs6_03_door_r", ["price"] = 300, ["type"] = "door", ["label"] = "Porte en bois ancienne" },
            { ["object"] = "prop_grumandoor_r", ["price"] = 300, ["type"] = "door", ["label"] = "Porte au serpent doré" },
            { ["object"] = "prop_motel_door_09", ["price"] = 300, ["type"] = "door", ["label"] = "Porte de motel" },
            { ["object"] = "prop_fnclink_03gate5", ["price"] = 300, ["type"] = "door", ["label"] = "Grillage" },
        }
    },

    {
        category = "Murs",
        items = {
            { ["object"] = "ps_wall_aqua", ["price"] = 1000, ["label"] = "Mur turquoise" },
            { ["object"] = "ps_wall_black", ["price"] = 1000, ["label"] = "Mur noir" },
            { ["object"] = "ps_wall_green", ["price"] = 1000, ["label"] = "Mur vert" },
            { ["object"] = "ps_wall_grey", ["price"] = 1000, ["label"] = "Mur gris" },
            { ["object"] = "ps_wall_purple", ["price"] = 1000, ["label"] = "Mur violet" },
            { ["object"] = "ps_wall_red", ["price"] = 1000, ["label"] = "Mur rouge" },
            { ["object"] = "ps_wall_white", ["price"] = 1000, ["label"] = "Mur blanc" },
            { ["object"] = "ps_wall_yellow", ["price"] = 1000, ["label"] = "Mur jaune" },
            { ["object"] = "ps_wall_wall", ["price"] = 1000, ["label"] = "Mur en brique" },
        }
    },

    {
        category = "Divers",
        items = {
            { ["object"] = "v_corp_facebeanbag", ["price"] = 100, ["label"] = "Pouf poire" },
            { ["object"] = "v_res_cherubvase", ["price"] = 2500, ["label"] = "Vase blanc" },
            { ["object"] = "v_res_d_paddedwall", ["price"] = 300, ["label"] = "Mur capitonné" },
            { ["object"] = "v_res_d_ramskull", ["price"] = 300, ["label"] = "Objet" },
            { ["object"] = "v_res_d_whips", ["price"] = 300, ["label"] = "Fouets" },
            { ["object"] = "v_res_fashmag1", ["price"] = 300, ["label"] = "Magazines" },
            { ["object"] = "v_res_fashmagopen", ["price"] = 300, ["label"] = "Magazines ouverts" },
            { ["object"] = "v_res_fa_magtidy", ["price"] = 300, ["label"] = "Magazines rangés" },
            { ["object"] = "v_res_fa_yogamat002", ["price"] = 300, ["label"] = "Tapis de yoga 1" },
            { ["object"] = "v_res_fa_yogamat1", ["price"] = 300, ["label"] = "Tapis de yoga 2" },
            { ["object"] = "v_res_fh_aftershavebox", ["price"] = 300, ["label"] = "Après-rasage" },
            { ["object"] = "v_res_fh_flowersa", ["price"] = 300, ["label"] = "Fleurs" },
            { ["object"] = "v_res_fh_fruitbowl", ["price"] = 300, ["label"] = "Corbeille à fruits" },
            { ["object"] = "v_res_fh_laundrybasket", ["price"] = 300, ["label"] = "Panier à linge 3" },
            { ["object"] = "v_res_fh_pouf", ["price"] = 300, ["label"] = "Pouf poire 2" },
            { ["object"] = "v_res_fh_sculptmod", ["price"] = 300, ["label"] = "Sculpture" },
            { ["object"] = "v_res_j_magrack", ["price"] = 300, ["label"] = "Porte-revues" },
            { ["object"] = "v_res_jewelbox", ["price"] = 300, ["label"] = "Coffret à bijoux" },
            { ["object"] = "v_res_mbbin", ["price"] = 300, ["label"] = "Poubelle" },
            { ["object"] = "v_res_mbowlornate", ["price"] = 300, ["label"] = "Coupe ornée" },
            { ["object"] = "v_res_mbronzvase", ["price"] = 300, ["label"] = "Vase en bronze" },
            { ["object"] = "v_res_mchalkbrd", ["price"] = 300, ["label"] = "Tableau noir" },
            { ["object"] = "v_res_mddresser", ["price"] = 300, ["label"] = "Commode 2" },
            { ["object"] = "v_res_mplinth", ["price"] = 300, ["label"] = "Socle" },
            { ["object"] = "v_res_mp_ashtrayb", ["price"] = 300, ["label"] = "Cendrier" },
            { ["object"] = "v_res_m_candle", ["price"] = 300, ["label"] = "Bougie" },
            { ["object"] = "v_res_m_candlelrg", ["price"] = 300, ["label"] = "Grande bougie" },
            { ["object"] = "v_res_m_kscales", ["price"] = 300, ["label"] = "Balance" },
            { ["object"] = "v_res_tt_bedpillow", ["price"] = 300, ["label"] = "Oreiller" },
            { ["object"] = "v_med_cor_whiteboard", ["price"] = 300, ["label"] = "Tableau blanc" },
            { ["object"] = "prop_ashtray_01", ["price"] = 100, ["label"] = "Cendrier noir" },
            { ["object"] = "v_ret_fh_ashtray", ["price"] = 100, ["label"] = "Cendrier en pierre" },
            { ["object"] = "v_24_wdr_mesh_rugs", ["price"] = 500, ["label"] = "Chiffon" },
            { ["object"] = "apa_mp_h_acc_rugwooll_04", ["price"] = 500, ["label"] = "Tapis 2" },
            { ["object"] = "ex_mp_h_acc_rugwoolm_04", ["price"] = 500, ["label"] = "Tapis 3" },
            { ["object"] = "apa_mp_h_acc_rugwoolm_03", ["price"] = 500, ["label"] = "Tapis 4" },
            { ["object"] = "apa_mp_h_acc_rugwooll_03", ["price"] = 500, ["label"] = "Tapis 5" },
            { ["object"] = "apa_mp_h_acc_rugwoolm_04", ["price"] = 500, ["label"] = "Tapis 6" },
            { ["object"] = "v_club_rack", ["price"] = 500, ["label"] = "Portant à vêtements" },
            { ["object"] = "prop_a4_pile_01", ["price"] = 100, ["label"] = "Pile de feuilles A4" },
            { ["object"] = "prop_amb_40oz_03", ["price"] = 100, ["label"] = "Bouteille 40 oz" },
            { ["object"] = "prop_amb_beer_bottle", ["price"] = 100, ["label"] = "Bière" },
            { ["object"] = "prop_aviators_01", ["price"] = 100, ["label"] = "Lunettes aviateur" },
            { ["object"] = "prop_barry_table_detail", ["price"] = 100, ["label"] = "Bibelot" },
            { ["object"] = "prop_beer_box_01", ["price"] = 100, ["label"] = "Bières" },
            { ["object"] = "prop_binoc_01", ["price"] = 100, ["label"] = "Jumelles" },
            { ["object"] = "prop_blox_spray", ["price"] = 100, ["label"] = "Bombe de peinture" },
            { ["object"] = "prop_bongos_01", ["price"] = 100, ["label"] = "Bongos" },
            { ["object"] = "prop_bong_01", ["price"] = 100, ["label"] = "Bang" },
            { ["object"] = "prop_boombox_01", ["price"] = 100, ["label"] = "Radiocassette" },
            { ["object"] = "prop_bowl_crisps", ["price"] = 100, ["label"] = "Bol de chips" },
            { ["object"] = "prop_candy_pqs", ["price"] = 100, ["label"] = "Bonbons" },
            { ["object"] = "prop_carrier_bag_01", ["price"] = 100, ["label"] = "Sac de courses" },
            { ["object"] = "prop_ceramic_jug_01", ["price"] = 100, ["label"] = "Cruche en céramique" },
            { ["object"] = "prop_cigar_pack_01", ["price"] = 100, ["label"] = "Paquet de cigares 1" },
            { ["object"] = "prop_cigar_pack_02", ["price"] = 100, ["label"] = "Paquet de cigares 2" },
            { ["object"] = "prop_cs_beer_box", ["price"] = 100, ["label"] = "Pack de bières 2" },
            { ["object"] = "prop_cs_binder_01", ["price"] = 100, ["label"] = "Classeur à anneaux" },
            { ["object"] = "prop_cs_bs_cup", ["price"] = 100, ["label"] = "Tasse" },
            { ["object"] = "prop_cs_cashenvelope", ["price"] = 100, ["label"] = "Enveloppe" },
            { ["object"] = "prop_cs_champ_flute", ["price"] = 100, ["label"] = "Flûte" },
            { ["object"] = "prop_cs_duffel_01", ["price"] = 100, ["label"] = "Sac de sport" },
            { ["object"] = "prop_cs_dvd", ["price"] = 50, ["label"] = "DVD" },
            { ["object"] = "prop_cs_dvd_case", ["price"] = 50, ["label"] = "Boîtier DVD" },
            { ["object"] = "prop_cs_film_reel_01", ["price"] = 100, ["label"] = "Bobine de film" },
            { ["object"] = "prop_cs_ilev_blind_01", ["price"] = 100, ["label"] = "Store" },
            { ["object"] = "p_ld_bs_bag_01", ["price"] = 100, ["label"] = "Sac" },
            { ["object"] = "prop_cs_ironing_board", ["price"] = 100, ["label"] = "Planche à repasser" },
            { ["object"] = "prop_cs_katana_01", ["price"] = 100, ["label"] = "Katana" },
            { ["object"] = "prop_cs_kettle_01", ["price"] = 100, ["label"] = "Bouilloire" },
            { ["object"] = "prop_cs_lester_crate", ["price"] = 100, ["label"] = "Caisse" },
            { ["object"] = "prop_cs_petrol_can", ["price"] = 100, ["label"] = "Jerrican" },
            { ["object"] = "prop_cs_sack_01", ["price"] = 100, ["label"] = "Sac de jute" },
            { ["object"] = "prop_cs_script_bottle_01", ["price"] = 100, ["label"] = "Flacon de médicaments" },
            { ["object"] = "prop_cs_script_bottle", ["price"] = 100, ["label"] = "Flacon de médicaments 2" },
            { ["object"] = "prop_cs_street_binbag_01", ["price"] = 100, ["label"] = "Sac poubelle" },
            { ["object"] = "prop_cs_whiskey_bottle", ["price"] = 100, ["label"] = "Bouteille de whisky" },
            { ["object"] = "prop_sh_bong_01", ["price"] = 100, ["label"] = "Bang" },
            { ["object"] = "prop_peanut_bowl_01", ["price"] = 100, ["label"] = "Cacahuètes" },
            { ["object"] = "prop_tumbler_01", ["price"] = 100, ["label"] = "Verre à whisky" },
            { ["object"] = "prop_weed_bottle", ["price"] = 100, ["label"] = "Boîte à herbe" },
            { ["object"] = "p_cs_lighter_01", ["price"] = 100, ["label"] = "Briquet" },
            { ["object"] = "p_cs_papers_01", ["price"] = 100, ["label"] = "Feuilles à rouler" },
            { ["object"] = "v_res_d_dildo_f", ["price"] = 100, ["label"] = "Godemichet noir" },
            { ["object"] = "v_res_d_dildo_c", ["price"] = 100, ["label"] = "Godemichet blanc" },
            { ["object"] = "v_res_d_dildo_a", ["price"] = 100, ["label"] = "Jouet coquin" },
            { ["object"] = "prop_champ_cool", ["price"] = 100, ["label"] = "Seau à champagne" },
            { ["object"] = "prop_champ_01b", ["price"] = 100, ["label"] = "Bouteille de champagne" },
            { ["object"] = "prop_champ_flute", ["price"] = 100, ["label"] = "Coupe de champagne" },
            { ["object"] = "ba_prop_club_champset", ["price"] = 300, ["label"] = "Service à champagne" },
            { ["object"] = "v_res_fa_candle01", ["price"] = 100, ["label"] = "Bougie bleue" },
            { ["object"] = "v_res_fa_candle02", ["price"] = 100, ["label"] = "Bougie rouge" },
            { ["object"] = "v_res_fa_candle03", ["price"] = 100, ["label"] = "Bougie noire" },
            { ["object"] = "v_res_fa_candle04", ["price"] = 100, ["label"] = "Petite bougie" },
            { ["object"] = "v_med_bottles2", ["price"] = 100, ["label"] = "Produits chimiques" },
            { ["object"] = "v_res_desktidy", ["price"] = 100, ["label"] = "Fournitures de bureau" },
            { ["object"] = "v_med_p_notebook", ["price"] = 100, ["label"] = "Notes" },
            { ["object"] = "bkr_prop_weed_dry_01a", ["price"] = 100, ["label"] = "Tas d'herbe" },
            { ["object"] = "ba_prop_battle_trophy_battler", ["price"] = 100, ["label"] = "Trophée poing" },
            { ["object"] = "ba_prop_battle_trophy_no1", ["price"] = 100, ["label"] = "Trophée étoile" },
            { ["object"] = "prop_golf_bag_01c", ["price"] = 100, ["label"] = "Sac de golf" },
            { ["object"] = "hei_heist_kit_bin_01", ["price"] = 100, ["label"] = "Poubelle 2" },
            { ["object"] = "prop_wooden_barrel", ["price"] = 100, ["label"] = "Tonneau en bois" },
            { ["object"] = "bkr_prop_bkr_cash_scatter_01", ["price"] = 100, ["label"] = "Bric-à-brac" },
            { ["object"] = "bkr_prop_bkr_cashpile_01", ["price"] = 100, ["label"] = "Argent liquide" },
            { ["object"] = "bkr_prop_bkr_cash_roll_01", ["price"] = 100, ["label"] = "Liasse de billets" },
            { ["object"] = "bkr_prop_bkr_cashpile_04", ["price"] = 100, ["label"] = "Tas de billets" },
            { ["object"] = "bkr_prop_weed_bigbag_open_01a", ["price"] = 100, ["label"] = "Sachet d'herbe ouvert" },
            { ["object"] = "bkr_prop_weed_bigbag_02a", ["price"] = 100, ["label"] = "Sachet d'herbe 2" },
            { ["object"] = "bkr_prop_weed_bigbag_03a", ["price"] = 100, ["label"] = "Sachet d'herbe 3" },
            { ["object"] = "bkr_prop_weed_scales_01a", ["price"] = 100, ["label"] = "Balance de précision" },
            { ["object"] = "bkr_prop_weed_smallbag_01a", ["price"] = 100, ["label"] = "Petit sachet" },
            { ["object"] = "prop_gold_bar", ["price"] = 100, ["label"] = "Lingot d'or" },
            { ["object"] = "beerrow_world", ["price"] = 100, ["label"] = "Bouteilles de bière" },
            { ["object"] = "beerrow_local", ["price"] = 100, ["label"] = "Bouteilles de bière 2" },
            { ["object"] = "p_cs_bbbat_01", ["price"] = 100, ["label"] = "Batte" },
            { ["object"] = "p_cs_cuffs_02_s", ["price"] = 100, ["label"] = "Menottes" },
            { ["object"] = "p_cs_joint_02", ["price"] = 100, ["label"] = "Joint" },
            { ["object"] = "p_ing_coffeecup_01", ["price"] = 100, ["label"] = "Mug de café" },
            { ["object"] = "p_tumbler_cs2_s", ["price"] = 100, ["label"] = "Verre à whisky" },
            { ["object"] = "prop_turkey_leg_01", ["price"] = 100, ["label"] = "Cuisse de poulet" },
            { ["object"] = "prop_amb_donut", ["price"] = 100, ["label"] = "Beignet" },
            { ["object"] = "prop_donut_02", ["price"] = 100, ["label"] = "Beignet 2" },
            { ["object"] = "prop_bar_shots", ["price"] = 100, ["label"] = "Verres à shot" },
            { ["object"] = "prop_bar_stirrers", ["price"] = 100, ["label"] = "Touilleurs" },
            { ["object"] = "prop_beer_amopen", ["price"] = 100, ["label"] = "Bière ouverte" },
            { ["object"] = "prop_beer_blr", ["price"] = 100, ["label"] = "Bière 1" },
            { ["object"] = "prop_beer_logger", ["price"] = 100, ["label"] = "Bière 2" },
            { ["object"] = "prop_beer_stzopen", ["price"] = 100, ["label"] = "Bière 3" },
            { ["object"] = "prop_bikerset", ["price"] = 100, ["label"] = "Set de biker" },
            { ["object"] = "prop_bottle_brandy", ["price"] = 100, ["label"] = "Bouteille de brandy" },
            { ["object"] = "prop_tequila_bottle", ["price"] = 100, ["label"] = "Bouteille de tequila" },
            { ["object"] = "prop_tequila", ["price"] = 100, ["label"] = "Tequila" },
            { ["object"] = "prop_bottle_cognac", ["price"] = 100, ["label"] = "Bouteille de cognac" },
            { ["object"] = "prop_bottle_macbeth", ["price"] = 100, ["label"] = "Bouteille de Macbeth" },
            { ["object"] = "prop_brandy_glass", ["price"] = 100, ["label"] = "Verre à cognac" },
            { ["object"] = "prop_mug_01", ["price"] = 100, ["label"] = "Mug 1" },
            { ["object"] = "prop_mug_02", ["price"] = 100, ["label"] = "Mug 2" },
            { ["object"] = "prop_mug_03", ["price"] = 100, ["label"] = "Mug 3" },
            { ["object"] = "prop_optic_vodka", ["price"] = 100, ["label"] = "Vodka" },
            { ["object"] = "prop_optic_jd", ["price"] = 100, ["label"] = "Jack Daniel's" },
            { ["object"] = "prop_pint_glass_01", ["price"] = 100, ["label"] = "Pinte" },
            { ["object"] = "prop_pizza_box_03", ["price"] = 100, ["label"] = "Carton de pizza" },
            { ["object"] = "prop_sandwich_01", ["price"] = 100, ["label"] = "Sandwich" },
            { ["object"] = "prop_cava", ["price"] = 100, ["label"] = "Cava" },
            { ["object"] = "prop_drink_redwine", ["price"] = 100, ["label"] = "Vin rouge" },
            { ["object"] = "vodkarow", ["price"] = 100, ["label"] = "Rangée de vodka" },
            { ["object"] = "prop_cherenkov_02", ["price"] = 100, ["label"] = "Cherenkov" },
            { ["object"] = "prop_cherenkov_03", ["price"] = 100, ["label"] = "Cherenkov 2" },
            { ["object"] = "prop_cocktail_glass", ["price"] = 100, ["label"] = "Verre à cocktail" },
            { ["object"] = "prop_cs_bottle_opener", ["price"] = 100, ["label"] = "Décapsuleur" },
            { ["object"] = "prop_food_bs_chips", ["price"] = 100, ["label"] = "Chips" },
            { ["object"] = "prop_cs_burger_01", ["price"] = 100, ["label"] = "Burger" },
            { ["object"] = "prop_cs_hand_radio", ["price"] = 100, ["label"] = "Talkie-walkie" },
            { ["object"] = "prop_cs_hotdog_01", ["price"] = 100, ["label"] = "Hot-dog" },
            { ["object"] = "prop_cs_milk_01", ["price"] = 100, ["label"] = "Lait" },
            { ["object"] = "prop_cs_panties", ["price"] = 100, ["label"] = "Culotte" },
            { ["object"] = "prop_cs_steak", ["price"] = 100, ["label"] = "Viande" },
            { ["object"] = "v_ret_csr_bin", ["price"] = 100, ["label"] = "Poubelle CSR" },
            { ["object"] = "v_ret_fh_wickbskt", ["price"] = 100, ["label"] = "Panier" },
            { ["object"] = "v_ret_gc_bag01", ["price"] = 100, ["label"] = "Sac GC 1" },
            { ["object"] = "v_ret_gc_bag02", ["price"] = 100, ["label"] = "Sac GC 2" },
            { ["object"] = "v_ret_gc_bin", ["price"] = 100, ["label"] = "Poubelle GC" },
            { ["object"] = "v_ret_gc_cashreg", ["price"] = 100, ["label"] = "Caisse enregistreuse" },
            { ["object"] = "v_ret_gc_chair01", ["price"] = 100, ["label"] = "Chaise GC 01" },
            { ["object"] = "v_ret_gc_chair02", ["price"] = 100, ["label"] = "Chaise GC 02" },
            { ["object"] = "v_ret_gc_clock", ["price"] = 100, ["label"] = "Horloge" },
            { ["object"] = "v_ret_hd_prod1_", ["price"] = 100, ["label"] = "Produit 1" },
            { ["object"] = "v_ret_hd_prod2_", ["price"] = 100, ["label"] = "Produit 2" },
            { ["object"] = "v_ret_hd_prod3_", ["price"] = 100, ["label"] = "Produit 3" },
            { ["object"] = "v_ret_hd_prod4_", ["price"] = 100, ["label"] = "Produit 4" },
            { ["object"] = "v_ret_hd_prod5_", ["price"] = 100, ["label"] = "Produit 5" },
            { ["object"] = "v_ret_hd_prod6_", ["price"] = 100, ["label"] = "Produit 6" },
            { ["object"] = "v_ret_hd_unit1_", ["price"] = 100, ["label"] = "Meuble HD 1" },
            { ["object"] = "v_ret_hd_unit2_", ["price"] = 100, ["label"] = "Meuble HD 2" },
            { ["object"] = "v_ret_ml_fridge02", ["price"] = 100, ["label"] = "Réfrigérateur 5" },
            { ["object"] = "v_ret_ps_bag_01", ["price"] = 100, ["label"] = "Sac 1" },
            { ["object"] = "v_ret_ps_bag_02", ["price"] = 100, ["label"] = "Sac 2" },
            { ["object"] = "v_ret_ta_book1", ["price"] = 100, ["label"] = "Livre 1" },
            { ["object"] = "v_ret_ta_book2", ["price"] = 100, ["label"] = "Livre 2" },
            { ["object"] = "v_ret_ta_book3", ["price"] = 100, ["label"] = "Livre 3" },
            { ["object"] = "v_ret_ta_book4", ["price"] = 100, ["label"] = "Livre 4" },
            { ["object"] = "v_ret_ta_camera", ["price"] = 100, ["label"] = "Caméra" },
            { ["object"] = "v_ret_ta_firstaid", ["price"] = 100, ["label"] = "Trousse de secours" },
            { ["object"] = "v_ret_ta_hero", ["price"] = 100, ["label"] = "Figurine héros" },
            { ["object"] = "v_ret_ta_mag1", ["price"] = 100, ["label"] = "Magazine 1" },
            { ["object"] = "v_ret_ta_mag2", ["price"] = 100, ["label"] = "Magazine 2" },
            { ["object"] = "v_ret_ta_skull", ["price"] = 100, ["label"] = "Crâne" },
            { ["object"] = "prop_acc_guitar_01", ["price"] = 100, ["label"] = "Guitare" },
            { ["object"] = "prop_amb_handbag_01", ["price"] = 100, ["label"] = "Sac à main" },
            { ["object"] = "prop_attache_case_01", ["price"] = 100, ["label"] = "Mallette" },
            { ["object"] = "prop_big_bag_01", ["price"] = 100, ["label"] = "Grand sac" },
            { ["object"] = "prop_bonesaw", ["price"] = 100, ["label"] = "Scie à os" },
            { ["object"] = "prop_cs_fertilizer", ["price"] = 100, ["label"] = "Engrais" },
            { ["object"] = "prop_cs_shopping_bag", ["price"] = 100, ["label"] = "Sac de courses 2" },
            { ["object"] = "prop_cs_vial_01", ["price"] = 100, ["label"] = "Fiole" },
            { ["object"] = "prop_defilied_ragdoll_01", ["price"] = 100, ["label"] = "Poupée de chiffon" },
            { ["object"] = "v_res_fa_book03", ["price"] = 100, ["label"] = "Livre Kamasutra" },
            { ["object"] = "prop_weight_rack_02", ["price"] = 500, ["label"] = "Rack à haltères" },
            { ["object"] = "prop_weight_bench_02", ["price"] = 500, ["label"] = "Banc de développé couché" },
            { ["object"] = "prop_tool_broom", ["price"] = 100, ["label"] = "Balai" },
            { ["object"] = "prop_fire_exting_2a", ["price"] = 100, ["label"] = "Extincteur" },
            { ["object"] = "v_res_vacuum", ["price"] = 100, ["label"] = "Aspirateur" },
            { ["object"] = "v_ret_gc_fan", ["price"] = 100, ["label"] = "Ventilateur" },
            { ["object"] = "prop_paint_stepl01b", ["price"] = 100, ["label"] = "Échelle" },
            { ["object"] = "bkr_prop_weed_bucket_01b", ["price"] = 100, ["label"] = "Engrais" },
            { ["object"] = "v_club_vusnaketank", ["price"] = 500, ["label"] = "Terrarium" },
            { ["object"] = "prop_pooltable_02", ["price"] = 1500, ["label"] = "Table de billard" },
            { ["object"] = "prop_pool_rack_02", ["price"] = 100, ["label"] = "Queues de billard" },
            { ["object"] = "v_club_vu_deckcase", ["price"] = 1000, ["label"] = "Platines DJ" },
            { ["object"] = "v_corp_servercln", ["price"] = 1000, ["label"] = "Baie de serveurs" },
            { ["object"] = "prop_dummy_01", ["price"] = 100, ["label"] = "Mannequin" },
            { ["object"] = "prop_egg_clock_01", ["price"] = 100, ["label"] = "Minuteur" },
            { ["object"] = "prop_el_guitar_01", ["price"] = 100, ["label"] = "Guitare électrique 1" },
            { ["object"] = "prop_el_guitar_02", ["price"] = 100, ["label"] = "Guitare électrique 2" },
            { ["object"] = "prop_el_guitar_03", ["price"] = 100, ["label"] = "Guitare électrique 2" },
            { ["object"] = "prop_feed_sack_01", ["price"] = 100, ["label"] = "Sac de graines" },
            { ["object"] = "prop_floor_duster_01", ["price"] = 100, ["label"] = "Balai à franges" },
            { ["object"] = "prop_fruit_basket", ["price"] = 100, ["label"] = "Corbeille de fruits" },
            { ["object"] = "prop_f_duster_02", ["price"] = 100, ["label"] = "Plumeau" },
            { ["object"] = "prop_grapes_02", ["price"] = 100, ["label"] = "Raisins" },
            { ["object"] = "prop_hotel_clock_01", ["price"] = 100, ["label"] = "Horloge d'hôtel" },
            { ["object"] = "prop_idol_case_01", ["price"] = 100, ["label"] = "Vitrine à idole" },
            { ["object"] = "prop_jewel_02a", ["price"] = 100, ["label"] = "Bijoux" },
            { ["object"] = "prop_jewel_02b", ["price"] = 100, ["label"] = "Bijoux" },
            { ["object"] = "prop_jewel_02c", ["price"] = 100, ["label"] = "Bijoux" },
            { ["object"] = "prop_jewel_03a", ["price"] = 100, ["label"] = "Bijoux" },
            { ["object"] = "prop_jewel_03b", ["price"] = 100, ["label"] = "Bijoux" },
            { ["object"] = "prop_jewel_04a", ["price"] = 100, ["label"] = "Bijoux" },
            { ["object"] = "prop_jewel_04b", ["price"] = 100, ["label"] = "Bijoux" },
            { ["object"] = "prop_j_disptray_01", ["price"] = 100, ["label"] = "Plateau de présentation" },
            { ["object"] = "prop_j_disptray_01b", ["price"] = 100, ["label"] = "Plateau de présentation" },
            { ["object"] = "prop_j_disptray_02", ["price"] = 100, ["label"] = "Plateau de présentation" },
            { ["object"] = "prop_j_disptray_03", ["price"] = 100, ["label"] = "Plateau de présentation" },
            { ["object"] = "prop_j_disptray_04", ["price"] = 100, ["label"] = "Plateau de présentation" },
            { ["object"] = "prop_j_disptray_04b", ["price"] = 100, ["label"] = "Plateau de présentation" },
            { ["object"] = "prop_j_disptray_05", ["price"] = 100, ["label"] = "Plateau de présentation" },
            { ["object"] = "prop_j_disptray_05b", ["price"] = 100, ["label"] = "Plateau de présentation" },
            { ["object"] = "prop_ld_greenscreen_01", ["price"] = 100, ["label"] = "Fond vert" },
            { ["object"] = "prop_ld_handbag", ["price"] = 100, ["label"] = "Sac à main" },
            { ["object"] = "prop_ld_jerrycan_01", ["price"] = 100, ["label"] = "Jerrican 2" },
            { ["object"] = "prop_ld_keypad_01", ["price"] = 100, ["label"] = "Clavier à code 1" },
            { ["object"] = "prop_ld_keypad_01b", ["price"] = 100, ["label"] = "Clavier à code 2" },
            { ["object"] = "prop_ld_suitcase_01", ["price"] = 100, ["label"] = "Valise 1" },
            { ["object"] = "prop_ld_suitcase_02", ["price"] = 100, ["label"] = "Valise 2" },
            { ["object"] = "hei_p_attache_case_shut", ["price"] = 100, ["label"] = "Valise 3"},
            { ["object"] = "prop_mr_rasberryclean", ["price"] = 100, ["label"] = "Nettoyant Rasberry" },
            { ["object"] = "prop_paper_bag_01", ["price"] = 100, ["label"] = "Sac en papier" },
            { ["object"] = "prop_shopping_bags01", ["price"] = 100, ["label"] = "Sacs de courses" },
            { ["object"] = "prop_shopping_bags02", ["price"] = 100, ["label"] = "Sacs de courses 2" },
            { ["object"] = "prop_yoga_mat_01", ["price"] = 100, ["label"] = "Tapis de yoga 1" },
            { ["object"] = "prop_yoga_mat_02", ["price"] = 100, ["label"] = "Tapis de yoga 2" },
            { ["object"] = "prop_yoga_mat_03", ["price"] = 100, ["label"] = "Tapis de yoga 3" },
            { ["object"] = "p_ld_sax", ["price"] = 100, ["label"] = "Saxophone" },
            { ["object"] = "p_ld_soc_ball_01", ["price"] = 100, ["label"] = "Ballon de football" },
            { ["object"] = "p_watch_01", ["price"] = 100, ["label"] = "Montre 1" },
            { ["object"] = "p_watch_02", ["price"] = 100, ["label"] = "Montre 2" },
            { ["object"] = "p_watch_03", ["price"] = 100, ["label"] = "Montre 3" },
            { ["object"] = "p_watch_04", ["price"] = 100, ["label"] = "Montre 4" },
            { ["object"] = "p_watch_05", ["price"] = 100, ["label"] = "Montre 5" },
            { ["object"] = "p_watch_06", ["price"] = 100, ["label"] = "Montre 6" },
            { ["object"] = "apa_mp_h_acc_candles_01", ["price"] = 100, ["label"] = "Bougie parfumée" },
            { ["object"] = "apa_mp_h_acc_candles_02", ["price"] = 100, ["label"] = "Bougie parfumée 2" },
            { ["object"] = "apa_mp_h_acc_candles_04", ["price"] = 100, ["label"] = "Bougie parfumée 3" },
            { ["object"] = "apa_mp_h_acc_candles_06", ["price"] = 100, ["label"] = "Bougie parfumée 4" },
            { ["object"] = "apa_mp_h_acc_fruitbowl_02", ["price"] = 100, ["label"] = "Coupe à fruits" },
            { ["object"] = "apa_mp_h_acc_tray_01", ["price"] = 100, ["label"] = "Bibelots" },
            { ["object"] = "prop_bskball_01", ["price"] = 100, ["label"] = "Ballon de basket" },
            { ["object"] = "prop_cs_wrench", ["price"] = 100, ["label"] = "Clé à molette" },
            { ["object"] = "prop_cs_bowie_knife", ["price"] = 100, ["label"] = "Couteau Bowie" },
            { ["object"] = "prop_w_me_hatchet", ["price"] = 100, ["label"] = "Hachette" },
        }
    }

}
