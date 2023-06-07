fx_version 'cerulean'
game "gta5"
lua54 'yes'

shared_script 'library_ad.lua'

shared_scripts {
    "shared/*.lua"
}

client_scripts {
    '@ox_lib/init.lua',

    "client/mhacking.lua",
    "client/sequentialhack.lua",
    "client/main.lua",
}

server_scripts {
    "server/*.lua"
}

ui_page 'html/hack.html'
files {
    'html/phone.png',
    'html/snd/beep.ogg',
    'html/snd/correct.ogg',
    'html/snd/fail.ogg', 
    'html/snd/start.ogg',
    'html/snd/finish.ogg',
    'html/snd/wrong.ogg',
    'html/hack.html'
}

dependencies {
	'ox_target',
	'ox_lib'
}