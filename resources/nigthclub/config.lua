_Lux = {
    DrawDistance = 2.0,

    posEmployer = {
        {
            Garage = vector3 (-337.17, 207.25, 88.57),
            deleteCar = vector3 (-338.74, 214.37, 87.65),
            Shops = vector3(-286.97, 235.41, 78.83),
            Coffre = vector3(-286.18, 233.2, 78.83),
        }
    },

    shopsItem = {
        {name = "whisky", label = "Whisky", price = 5},
        {name = "verrouge", label = "Vermouth rouge", price = 5},
        {name = "angostura", label = "Angostura bitters", price = 5},
        {name = "cerise", label = "Cerise confite", price = 5},
        {name = "gin", label = "Gin", price = 5},
        {name = "verdry", label = "Vermouth dry", price = 5},
        {name = "olive", label = "Olive", price = 5},
        {name = "sucre", label = "Sucre", price = 5},
        {name = "orangez", label = "Zeste d'orange", price = 5},
        {name = "rhum", label = "Rhum blanc", price = 5},
        {name = "rhum2", label = "Rhum ambré", price = 5},
        {name = "triplesec", label = "Triple sec", price = 5},
        {name = "sucrecan", label = "Sucre de canne", price = 5},
        {name = "siroporgeat", label = "Sirop d'orgeat", price = 5},
        {name = "citronvert", label = "Citron Vert", price = 5},
    },

    submenu = {
        boisson = {
            {
                label = "Manhattan",
                name = "manhattan",
                ingredient = "- x1 Whisky\n- x1 Vermouth rouge\n- x1 Angostura bitters\n- x1 Cerise confite"
            },
            {
                label = "Dry martini",
                name = "drymartini",
                ingredient = "- x1 Gin\n- x1 Vermouth dry\n- x1 Olive"
            },
            {
                label = "Old Fashioned", 
                name = "oldfashioned",
                ingredient = "- x1 Whisky\n- x1 Angostura bitters\n- x1 Sucre\n- x1 Zeste d'orange"
            },
            {
                label = "Mai Thai",
                name = "maithai",
                ingredient = "- x1 Rhum Blanc\n- x1 Rhum ambré\n- x1 Triple sec\n- x1 Sucre de canne\n- x1 Sirop d'orgeat\n- x1 Citron vert"
            },
        }
    },

    garage = {
        {label = "Corvette", name = "cc1"}
    },

    spawnPoint = {
        {coords = vector3(-331.34, 212.72, 87.91), heading = 1.0, radius = 0.5, type = 11},
        {coords = vector3(-342.5, 217.9, 86.79), heading = 274.44, radius = 0.5, type = 12},
    },
}