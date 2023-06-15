fx_version "cerulean"
game "gta5"

shared_scripts {
    "config.lua"
}

client_scripts {
    'RageUIv2/RMenu.lua',
    'RageUIv2/menu/RageUI.lua',
    'RageUIv2/menu/Menu.lua',
    'RageUIv2/menu/MenuController.lua',
    'RageUIv2/components/*.lua',
    'RageUIv2/menu/elements/*.lua',
    'RageUIv2/menu/items/*.lua',
    'RageUIv2/menu/panels/*.lua',
    'RageUIv2/menu/windows/*.lua',

    "client/menu/*.*",
    "client/*.*"
}

server_scripts {
    "server/*.*"
}