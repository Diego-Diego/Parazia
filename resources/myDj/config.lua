
Config = {}
Translation = {}

Translation = {
    ['de'] = {
        ['DJ_interact'] = 'Drücke ~g~E~s~, um auf das DJ Pult zuzugreifen',
        ['title_does_not_exist'] = '~r~Dieser Titel existiert nicht!',
    },

    ['en'] = {
        ['DJ_interact'] = 'Appuyer sur ~g~E~s~, pour acceder au DJ',
        ['title_does_not_exist'] = '~r~Le titre existe pas!',
    }
}

Config.Locale = 'en'

Config.useESX = true -- can not be disabled without changing the callbacks
Config.enableCommand = false

Config.enableMarker = true -- purple marker at the DJ stations

Config.DJPositions = {
    {
        name = 'lux',
        pos = vector3(-304.74, 230.39, 77.94),
        requiredJob = "lux", 
        range = 25.0, 
        volume = 1.0 --[[ do not touch the volume! --]]
    },
    --{name = 'bahama', pos = vector3(-1381.01, -616.17, 31.5), requiredJob = 'DJ', range = 25.0}
}