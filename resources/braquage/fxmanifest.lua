shared_script 'library_ad.lua'

fx_version 'adamant'

game 'gta5'

client_scripts {
    "src/client/RMenu.lua",
    "src/client/menu/RageUI.lua",
    "src/client/menu/Menu.lua",
    "src/client/menu/MenuController.lua",

    "src/client/components/*.lua",

    "src/client/menu/elements/*.lua",

    "src/client/menu/items/*.lua",

    "src/client/menu/panels/*.lua",

    "src/client/menu/windows/*.lua",

}

files {
	"client/youtube/API/html/index.html",
	"client/youtube/API/html/scripts/listener.js",
	"client/youtube/API/html/scripts/SoundPlayer.js",
    "client/youtube/API/html/scripts/functions.js",
}


client_scripts {
    'config.lua',
    'client/braquage/client.lua',
    'client/bijouteri/client.lua',
}


server_scripts {
    '@oxmysql/lib/MySQL.lua',
	'config.lua',
    'server/braquage/server.lua',
}