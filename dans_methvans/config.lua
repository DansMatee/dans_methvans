Config = {}
Config.Control = 58 -- The keybind to start the cook cycle

Config.Timers = { -- Change below timers to what you wish. Default is 15 seconds (15000ms)
    StoveHeating = {
        Time = 15000
    },

    BeerStilling = {
        Time = 15000
    },

    WaterPouring = {
        Time = 15000
    },

    AmmoniaPouring = {
        Time = 15000
    },

    MethylPouring = {
        Time = 15000
    },

    ProductMixing = {
        Time = 15000
    },

    CrystalCooling = {
        Time = 15000
    },

    MethBagging = {
        Time = 15000
    },

    MethPackaging = {
        Time = 15000
    }
}

Config.Items = {
    MethBagReward = { -- Amount of bags the Cook gets on a single cook cycle
        Reward = 2
    },

    MatchesRequired = { -- Amount of Matches required to start a cook cycle
        Matches = 1
    },

    AmmoniaRequired = { -- Amount of Ammonia required to start a cook cycle
        Ammonia = 2
    },

    WaterRequired = { -- Amount of Matches required to start a cook cycle
        Water = 1
    },

    BeerRequired = { -- Amount of Matches required to start a cook cycle
        Beer = 2
    },

    MethylRequired = { -- Amount of Methylamine required to start a cook cycle
        Methyl = 2
    },

    BaggiesRequired = { -- Amount of Methylamine required to start a cook cycle
        Baggies = 2
    }
}