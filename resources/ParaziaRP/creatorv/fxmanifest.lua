fx_version ('cerulean')
game ('gta5')

shared_scripts {
    'configs/client/*.lua',
}

client_scripts {
    'libs/RageUI//RMenu.lua',
    'libs/RageUI//menu/RageUI.lua',
    'libs/RageUI//menu/Menu.lua',
    'libs/RageUI//menu/MenuController.lua',
    'libs/RageUI//components/*.lua',
    'libs/RageUI//menu/elements/*.lua',
    'libs/RageUI//menu/items/*.lua',
    'libs/RageUI//menu/panels/*.lua',
    'libs/RageUI/menu/windows/*.lua',
    
    'client/*.lua',
}

server_scripts {
    '@oxmysql/lib/MySQL.lua',
    '@kFramework/locale.lua',

    'configs/server/*.lua',
    'server/*.lua',
}



