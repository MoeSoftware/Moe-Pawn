Config = Config or {}


Config.Products = {
    ["pawnshop"] = {
        [1] = {
            name = 'metaltrash',
            pricemin = 25,
            pricemax = 75,
        },
        [2] = {
            name = 'irontrash',
            pricemin = 50,
            pricemax = 100,
        },
        [3] = {
            name = 'bulletcasings',
            pricemin = 75,
            pricemax = 100,
        },
        [4] = {
            name = 'aluminumcan',
            pricemin = 50,
            pricemax = 100,
        },
        [5] = {
            name = 'brokenknife',
            pricemin = 50,
            pricemax = 100,
        },
        [6] = {
            name = 'brokendetector',
            pricemin = 50,
            pricemax = 100,
        },
        [7] = {
            name = 'brokenphone',
            pricemin = 50,
            pricemax = 100,
        },
        [8] = {
            name = 'housekeys',
            pricemin = 70,
            pricemax = 120,
        },
        [9] = {
            name = 'brokengameboy',
            pricemin = 1000,
            pricemax = 1500,
        },
        [10] = {
            name = 'burriedtreasure',
            pricemin = 2000,
            pricemax = 2500,
        },
        [11] = {
            name = 'treasurekey',
            pricemin = 1000,
            pricemax = 1500,
        },
        [12] = {
            name = 'antiquecoin',
            pricemin = 1000,
            pricemax = 1500,
        },
        [13] = {
            name = 'goldennugget',
            pricemin = 1000,
            pricemax = 1500,
        },
        [14] = {
            name = 'goldcoin',
            pricemin = 1000,
            pricemax = 1500,
        },
        [15] = {
            name = 'ancientcoin',
            pricemin = 1000,
            pricemax = 1500,
        },
        [16] = {
            name = 'ww2relic',
            pricemin = 1000,
            pricemax = 1500,
        },
        [17] = {
            name = 'steeltrash',
            pricemin = 1000,
            pricemax = 1500,
        },
        [18] = {
            name = 'pocketwatch',
            pricemin = 1000,
            pricemax = 1500,
        },
        [19] = {
            name = 'gameboy',
            pricemin = 22500,
            pricemax = 25000,
        },
        [20] = {
            name = 'laptop',
            pricemin = 1500,
            pricemax = 2500,
        },
        [21] = {
            name = 'thermite',
            pricemin = 7500,
            pricemax = 9000,
        },
        [22] = {
            name = 'lockpick',
            pricemin = 2000,
            pricemax = 3000,
        },
        [23] = {
            name = 'joint',
            pricemin = 5000,
            pricemax = 7000,
        },
    },
}

Config.SellShops = {
    ["pawnshop"] = {
        ["label"] = "Pawnshop",
        ["coords"] = vector4(413.05, 313.46, 103.02, 206.9),
        ["ped"] = 'mp_m_shopkeep_01',
        ["scenario"] = "WORLD_HUMAN_STAND_MOBILE",
        ["radius"] = 1.5,
        ["targetIcon"] = "fas fa-shopping-basket",
        ["targetLabel"] = "Sell Items",
        ["description"] = "Items to sell",
        ["products"] = Config.Products["pawnshop"],
        ["showblip"] = true,
        ["blipsprite"] = 277,
        ["blipcolor"] = 0
    },
}