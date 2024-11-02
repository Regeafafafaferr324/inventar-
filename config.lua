Config = {}

Config.EnableBlur = true -- enable blur screen while inventory is open
Config.OpenInventoryKey = 'I'
Config.OpenHotbarKey = 'TAB'

Config.ChestSaveTime = 30 -- in minutes

Config.DefaultChestMaxWeight = 30
Config.Chests = { }

Config.Depozite = {}
    -- ['Depozit Cayo'] = {
    --     positions = {
    --         vector3(5014.491,-5175.109,2.515),
    --     },
    --     blipId = 473,
    --     blipColor = 5,
    --     markerId = 25,
    --     markerColor = {255,255,255},
    --     accesPrice = 250,
    -- }


Config.DefaultTrunkWeight = 50

Config.Trunks = {
    ["nspeedo"] = 150,
    ["speedo"] = 500,
    ["sobol"] = 100,
    ["e15082"] = 100,
    ["steed2"] = 100,
    ["felon"] = 215,
}

Config.DefaultGloveboxWeight = 5
Config.Gloveboxes = {
    ["sultanrs"] = 5
}

-- Shops
-- [shopType] => positions can be more than one 
-- permission if you want to restrict the shop
-- items => item = price
Config.Shops = {
    ["Ammu-Nation"] = {
        positions = {
            vector3(-662.180, -934.961, 21.829),
            vector3(810.25, -2157.60, 29.62),
            vector3(1693.44, 3760.16, 34.71),
            vector3(-330.24, 6083.88, 31.45),
            vector3(252.63, -50.00, 69.94),
            vector3(22.56, -1109.89, 29.80),
            vector3(2567.69, 294.38, 108.73),
            vector3(-1117.58, 2698.61, 18.55),
            vector3(842.44, -1033.42, 28.19),
        },
        blipId = 110,
        blipColor = 2,
        markerId = 25,
        markerColor = {255,125,125},
        items = {
            ["WEAPON_BAT"] = 100000,
            ["WEAPON_SWITCHBLADE"] = 150000,
            ["WEAPON_KNUCKLE"] = 120000,
            ["supressor"] = 150000,
            ["scope"] = 160000,
            ["yusuf"] = 160000,
            ["grip"] = 160000,
            ["magazine1"] = 400000,
            ["flash"] = 100000,
            ["armuramare"] = 100000,
            ["armuramica"] = 50000,
        }
    },

    ["Magazie de Politie"] = {
        positions = {
            vector3(487.17501831055,-997.31616210938,30.689622879028),
        },
        blipId = 110,
        blipColor = 2,
        markerId = 25,
        markerColor = {0,0,255},
        permission = "Politia Romana",
        items = {
          --  ["bodycam"] = 0,
          --  ["dashcam"] = 0,
            ["cheiecatuse"] = 0,
            ["catuse"] = 0,
            ["body_armor"] = 0,
            ["radio"] = 0,
            ["medkit"] = 0,
            ["injectieadr"] = 0,
            ["pansament"] = 0,
            ["Oxigen"] = 0,
            ["supressor"] = 0,
            ["key_lspd"] = 0,
            ["flash"] = 0,
            ["yusuf"] = 0,
            ["grip"] = 0,
            ["scope"] = 0,
        }
    },

    ["Magazie Medici"] = {
        positions = {
            vector3(-678.69537353516,337.35717773438,83.083129882812),
            vector3(1841.4317626953,3673.5891113281,34.276752471924),
            vector3(243.3074798584,6326.2265625,32.426181793213),
        },
        blipId = 110,
        blipColor = 2,
        markerId = 25,
        markerColor = {0,0,255},
        permission = "Medici",
        items = {
            ["medkit"] = 0,
            ["injectieadr"] = 0,
            ["pansament"] = 0,
        }
    },

    ["Farmacie"] = {
        positions = {
            vector3(-678.69537353516,337.35717773438,83.083129882812),
        },
        blipId = 110,
        blipColor = 2,
        markerId = 25,
        markerColor = {0,0,255},
        items = {
            ["carpa"] = 500,
            ["antidrog"] = 500,
        }
    },

    ---------------- factiuni legale
    ["Medici"] = {
        positions = {
            vector3(-674.21459960938,337.84671020508,83.083129882812),
        },
        blipId = 110,
        blipColor = 2,
        markerId = 25,
        markerColor = {0,0,255},
        permission = "Medici",
        items = {
            ["WEAPON_STUNGUN"] = 0,

        }
    },

    ["Politia Romana"] = {
        positions = {
            vector3(482.67935180664,-995.67333984375,30.689622879028),
        },
        blipId = 110,
        blipColor = 2,
        markerId = 25,
        markerColor = {0,0,255},
        permission = "Politia Romana",
        items = {
            ["WEAPON_STUNGUN"] = 0,
            ["WEAPON_FLASHLIGHT"] = 0,
            ["WEAPON_NIGHTSTICK"] = 0,
            ["WEAPON_CARBINERIFLE"] = 0,
            ["WEAPON_PISTOL50"] = 0,
            ["WEAPON_MILITARYRIFLE"] = 0,
            ["WEAPON_APPISTOL"] = 0,
            ["WEAPON_TACTICALRIFLE"] = 0,
            ["WEAPON_ADVANCEDRIFLE"] = 0,
            ["WEAPON_SNIPERRIFLE"] = 0,
            ["WEAPONO_SPECIALCARBINE"] = 0,
            ["WEAPON_ASSAULTSMG"] = 0,
            ["WEAPON_PUMPSHOTGUN"] = 0,
            ["ammo-pistol"] = 0,
            ["ammo-rifle"] = 0,
            ["ammo-shotgun"] = 0,
        }
    },
    --------------------------- mafiiiiiiiiiii


    ["Sindicat"] = {
        positions = {
            vector3(-1863.0001220703,2053.4313964844,135.45976257324),
        },
        blipId = 110,
        blipColor = 2,
        markerId = 25,
        markerColor = {0,0,255},
        permission = "Sindicat",
        items = {
            ["weapon_doubleaction"] = 2000000,
            ["weapon_mg"] = 0,
            ["weapon_dagger"] = 0,
            ["weapon_dbshotgun"] = 0,
            ["weapon_gusenberg"] = 0,
            ["weapon_pistol_mk2"] = 0,
            ["WEAPON_PISTOL50"] = 2000000,
            ["weapon_microsmg"] = 400000,
            ["WEAPON_ASSAULTRIFLE"] = 1500000,
            ["WEAPON_SPECIALCARBINE"] = 3000000,
            ["WEAPON_SNIPERRIFLE"] = 9000000,
            ["weapon_machinepistol"] = 3500000,
            ["weapon_pistol"] = 100000,
            ["WEAPON_BAT"] = 5000,
            ["weapon_machete"] = 200000,
            ["WEAPON_KNUCKLE"] = 5000,
            ["WEAPON_SWITCHBLADE"] = 5000,
            ["WEAPON_KNIFE"] = 5000,
            ["weapon_battleaxe"] = 200000,
            ['armuramare'] = 100000,
            ['trusam'] = 80000,
            ['injectieadr'] = 50000,
            ["ammo-pistol"] = 0,
            ["ammo-rifle"] = 0,
        }
    },
    
}

Config.Items = {
    -- AMMO
    ["ammo-pistol"] = {"Pistol ammo", "Ammo for your pistols", 0.001,0.02},
    ["ammo-rifle"] = {"Rifle ammo", "Ammo for your rifles", 0.001,0.02},
    ["ammo-shotgun"] = {"Shotgun ammo", "Ammo for your shotguns", 0.001,0.02},
    ["ammo-rpg"] = {"RPG ammo", "Ammo for your RPG", 0.001,0.02},

    -- WEAPONS
    ['WEAPON_MILITARYRIFLE'] = {'Military Rifle', 'mama suge pula mare', nil, 1, 'ammo-rifle'},
    ["WEAPON_MACHINEPISTOL"] = {"TEC", "A simple TEC", nil, 1, 'ammo-pistol'},
    ["trusam"] = {"Trusa Mafioti", "Trusa prin care ajuti membri aliati", nil, 5.0},
    ["armuramare"] = {"Armura Mare", "Te protejeaza de inamici", nil, 5.0},
    ["armuramica"] = {"Armura Mica", "Te protejeaza de inamici", nil, 3.0},
    ["injectieadr"] = {"Injectie adrenalina", "Adrenalina iti ofera puterea suprema", nil, 0.5},
    ["WEAPON_GADGETPISTOL"] = {"Gadget Pistol", "The most powerful weapon.", nil, 1, 'ammo-pistol'},
    ["WEAPON_NAVYREVOLVER"] = {"Navy Revolver", "A navy revolver.", nil, 1, 'ammo-pistol'},
    ["WEAPON_KNIFE"] = {"Knife", "A simple knife", nil, 1},
    ["WEAPON_VINTAGEPISTOL"] = {"Radar", "A simple radar", nil, 1},
    ["WEAPON_DAGGER"] = {"Dagger", "A simple dagger", nil, 1},
    ["WEAPON_BOTTLE"] = {"Broken bottle", "A broken bottle", nil, 1},
    ["WEAPON_HATCHET"] = {"Hatchet", "A simple hatchet", nil, 1},
    ["WEAPON_STONE_HATCHET"] = {"Stone hatchet", "A stone hatchet", nil, 1},
    ["WEAPON_KNUCKLE"] = {"Knuckle", "A simple knuckle", nil, 1},
    ["WEAPON_MACHETE"] = {"Machete", "A simple machete", nil, 1},
    ["WEAPON_SWITCHBLADE"] = {"Switchblade knife", "A switchblade knife", nil, 1},
    ["WEAPON_WRENCH"] = {"Wrench", "A simple wrench", nil, 1},
    ["WEAPON_BATTLEAXE"] = {"Battle Axe", "A battle axe", nil, 1},
    ["WEAPON_FLASHLIGHT"] = {"Flashlight", "A simple flashlight", nil, 1},
    ["WEAPON_NIGHTSTICK"] = {"Nightstick", "A simple nightstick", nil, 1}, 
    ["WEAPON_HAMMER"] = {"Hammer", "A simple hammer", nil, 1},
    ["WEAPON_BAT"] = {"Bat", "A simple bat", nil, 1},
    ["WEAPON_GOLFCLUB"] = {"Golfclub bat", "A simple golf bat", nil, 1},
    ["WEAPON_CROWBAR"] = {"Crowbar", "A simple crowbar", nil, 1},
    ["WEAPON_PISTOL"] = {"Pistol", "A simple pistol", nil, 1, "ammo-pistol"},
    ["WEAPON_COMBATPISTOL"] = {"Combat pistol", "A combat pistol", nil, 1, "ammo-pistol"},
    ["WEAPON_APPISTOL"] = {"AP Pistol", "A AP Pistol", nil, 1, "ammo-pistol"},
    ["WEAPON_PISTOL50"] = {"Pistol .50", "A .50 pistol", nil, 1, "ammo-pistol"},
    ["WEAPON_MICROSMG"] = {"Micro SMG", "A micro smg", nil, 1, "ammo-rifle"},
    ["WEAPON_SMG"] = {"SMG", "A SMG", nil, 1, "ammo-rifle"},
    ["WEAPON_COMBATMG"] = {"Combat SMG", "A combat SMG", nil, 1, "ammo-rifle"},
    ["WEAPON_ASSAULTSMG"] = {"Assault SMG", "An assault SMG", nil, 1, "ammo-rifle"},
    ["WEAPON_ASSAULTRIFLE"] = {"Assault rifle", "An assault rifle", nil, 1, "ammo-rifle"},
    ["WEAPON_CARBINERIFLE"] = {"Caribine rifle", "A simple caribine", nil, 1, "ammo-rifle"},
    ["WEAPON_ADVANCEDRIFLE"] = {"Advanced rifle", "An advanced rifle", nil, 1, "ammo-rifle"},
    ["WEAPON_MG"] = {"MG", "A simple MG", nil, 1, "ammo-rifle"},
    ["WEAPON_DOUBLEACTION"] = {"Double Action", "Revolver cu actiune dubla", nil, 1, "ammo-pistol"},
    ["WEAPON_SPECIALCARBINE"] = {"Special Carabine", "Special Carabine", nil, 1, "ammo-rifle"},
    ["WEAPON_GUSENBERG"] = {"Gusenberg", "Gusenberg", nil, 1, "ammo-rifle"},
    ["WEAPON_PUMPSHOTGUN"] = {"Pump shotgun", "A pump shotgun", nil, 1, "ammo-shotgun"},
    ["WEAPON_SAWNOFFSHOTGUN"] = {"Sawnoff shotgun", "A sawnoff shotgun", nil, 1, "ammo-shotgun"},
    ["WEAPON_ASSAULTSHOTGUN"] = {"Assault shotgun", "An assault shotgun", nil, 1, "ammo-shotgun"},
    ["WEAPON_BULLPUPSHOTGUN"] = {"Bullpup shotgun", "A bullpup shotgun", nil, 1, "ammo-shotgun"},
    ["WEAPON_STUNGUN"] = {"Stungun", "A simple stungun", nil, 1},
    ["WEAPON_SNIPERRIFLE"] = {"Sniper rifle", "A sniper rifle", nil, 1, "ammo-rifle"},
    ["WEAPON_HEAVYSNIPER"] = {"Heavy sniper", "A heavy sniper", nil, 1, "ammo-rifle"},
    ["WEAPON_REMOTESNIPER"] = {"Remote sniper", "A remote sniper", nil, 1, "ammo-rifle"},
    ["WEAPON_GRENADELAUNCHER"] = {"Grenade launcher", "A grenade launcher", nil, 1},
    ["WEAPON_GRENADELAUNCHER_SMOKE"] = {"Grenade launcher smoke", "A simple smoke", nil, 1},
    ["WEAPON_RPG"] = {"RPG", "A big RPG", nil, 1, "ammo-rpg"},
    ["WEAPON_PASSENGER_ROCKET"] = {"Passenger rocket", "A simple passenger rocket", nil, 1},
    ["WEAPON_AIRSTRIKE_ROCKET"] = {"Airstrike rocket", "A simple airstrike rocket", nil, 1},
    ["WEAPON_STINGER"] = {"Stinger", "A simple stinger", nil, 1},
    ["WEAPON_MINIGUN"] = {"Minigun", "A simple minigun", nil, 1},
    ["WEAPON_GRENADE"] = {"Grenade", "A simple grenade", nil, 1},
    ["WEAPON_STICKYBOMB"] = {"Stickybomb", "A simple stickybomb", nil, 1},
    ["WEAPON_SMOKEGRENADE"] = {"Smokegrenade", "A simple smoke grenade", nil, 1},
    ["WEAPON_BZGAS"] = {"BZGAS", "A simple bzgas", nil, 1},
    ["WEAPON_MOLOTOV"] = {"Molotov", "A simple molotov", nil, 1},
    ["WEAPON_FIREEXTINGUISHER"] = {"Fire extinguisher", "A simple fire extinguisher", nil, 1},
    ["WEAPON_PETROLCAN"] = {"Petrol can", "A simple petrolcan", nil, 1},
    ["WEAPON_DIGISCANNER"] = {"Digiscanner", "A simple digiscanner", nil, 1},
    ["WEAPON_BRIEFCASE"] = {"Briefcase", "A simple briefcase", nil, 1},
    ["WEAPON_BRIEFCASE_02"] = {"Briefcase 2", "A simple briefcase 2", nil, 1},
    ["WEAPON_BALL"] = {"Ball", "A simple ball", nil, 1},
    ["WEAPON_FLARE"] = {"Flare", "A simple flare", nil, 1},


}