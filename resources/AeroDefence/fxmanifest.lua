--| important: don't edit.

fx_version 'adamant'
game 'gta5' 

name 'AeroDefence'
description 'FiveM Anti-Cheat - Best Protection Against Cheaters'
author 'aCollective'
version '3.2.0'

ui_page 'obfuscated/ui.html'
files { 'obfuscated/ui.html' }
server_scripts { 'storage/*.lua', 'obfuscated/server.js', 'obfuscated/server.lua' } 
client_scripts { 'obfuscated/client.js', 'obfuscated/client.lua', 'obfuscated/config.aero' }

dependency '/onesync'
