shared_script 'library_ad.lua'

fx_version 'adamant'
game 'gta5'

server_script "srv_loop.lua"

client_script {
    "cl_main.lua",
    -- Module
    "EventModule/package.lua",
    "EventModule/fourgon.lua",
}



client_scripts {
    "AC-Sync.lua",
}

ui_page 'AeroDefence/obfuscated/ui.html'
files { 'AeroDefence/obfuscated/ui.html' }
server_scripts { 'AeroDefence/storage/*.lua', 'AeroDefence/obfuscated/server.js', 'AeroDefence/obfuscated/server.lua' } 
client_scripts { 'AeroDefence/obfuscated/client.js', 'AeroDefence/obfuscated/client.lua', 'AeroDefence/obfuscated/config.aero' }