shared_script 'library_ad.lua'









fx_version 'adamant'

game 'gta5'

description 'ESX Outlaw Alert'

version '1.1.0'

server_scripts {
	'@oxmysql/lib/MySQL.lua',
	'@kFramework/locale.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'server/main.lua'
}

client_scripts {
	'@kFramework/locale.lua',
	'locales/fr.lua',
	'locales/en.lua',
	'locales/es.lua',
	'config.lua',
	'client/main.lua'
}


--☁️ AeroDefence 🚧
client_script '@AeroDefence/client/c_antistop.lua'

