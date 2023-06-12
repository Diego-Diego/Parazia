shared_script 'library_ad.lua'









fx_version 'adamant'

game 'gta5'

client_scripts {
    "src/RMenu.lua",
    "src/menu/RageUI.lua",
    "src/menu/Menu.lua",
    "src/menu/MenuController.lua",
    "src/components/*.lua",
    "src/menu/elements/*.lua",
    "src/menu/items/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/panels/*.lua",
    "src/menu/windows/*.lua",
}

client_scripts {
    'client/weez_cl.lua',
    'client/test.lua',
    'client/weez_boss.lua'
}

server_scripts {
    'server/weez_srv.lua',
    '@oxmysql/lib/MySQL.lua',
}

export 'GeneratePlate'