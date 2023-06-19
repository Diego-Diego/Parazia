shared_script 'library_ad.lua'









fx_version "adamant"

game "gta5"

loadscreen_manual_shutdown('yes')

shared_scripts {
    'init/shared/init.lua',
    'players/society/sh_*.lua',
    "players/skinchanger/config.lua",
    "players/blackmarket/shared/shared_blackmarket.lua",
    "players/radars/config.lua",
    "players/boutique/shared/*.lua",
    "players/peche/config.lua",
    "players/hud/config.lua",
    --"creatorv/configs/client/*.lua"
}

client_scripts {
    -- RAGEUI
    'Menu/RageUI/RMenu.lua',
    'Menu/RageUI/menu/RageUI.lua',
    'Menu/RageUI/menu/Menu.lua',
    'Menu/RageUI/menu/MenuController.lua',
    'Menu/RageUI/components/*.lua',
    'Menu/RageUI/menu/elements/*.lua',
    'Menu/RageUI/menu/items/*.lua',
    'Menu/RageUI/menu/panels/*.lua',
    'Menu/RageUI/menu/windows/*.lua',
    
	'Menu/RageUIv2/RMenu.lua',
    'Menu/RageUIv2/menu/RageUI.lua',
    'Menu/RageUIv2/menu/Menu.lua',
    'Menu/RageUIv2/menu/MenuController.lua',
    'Menu/RageUIv2/components/*.lua',
    'Menu/RageUIv2/menu/elements/*.lua',
    'Menu/RageUIv2/menu/items/*.lua',
    'Menu/RageUIv2/menu/panels/*.lua',
    'Menu/RageUIv2/menu/windows/*.lua',

    'Menu/JailUI/RMenu.lua',
    'Menu/JailUI/menu/RageUI.lua',
    'Menu/JailUI/menu/Menu.lua',
    'Menu/JailUI/menu/MenuController.lua',
    'Menu/JailUI/components/*.lua',
    'Menu/JailUI/menu/elements/*.lua',
    'Menu/JailUI/menu/items/*.lua',
    'Menu/JailUI/menu/panels/*.lua',
    'Menu/JailUI/menu/windows/*.lua',

    "system/spawnmanager/client/main.lua",
    "system/hardcap/client/main.lua",

    '@kFramework/locale.lua',
    "fr.lua",
    "init/client/*.lua",
    "blips.lua",
    "functions/client.lua",
    "esx/addons_gcphone/client/main.lua",
    "esx/service/client/main.lua",
    "esx/instance/client/main.lua",
    "esx/status/config.lua",
    "esx/status/client/*.lua",
    "esx/status/client/classes/*.lua",
    "markers.lua",
    "players/simpletp/client.lua",
    "players/shops/cl_ammu-nation.lua",
    "players/shops/configbraquagesuperette.lua",
    "players/shops/cl_superettes.lua",
    "players/shops/cl_braquagesuperette.lua",
    "players/vêtements/client/*.lua",
    "players/personalmenu/client/*.lua",
    "players/carwash/client.lua",
    "players/locations/client.lua",
    "players/garage/client/*.lua",
    "players/drift/drift.lua",
    "players/animations/*.lua",
    "players/sit/cl_main.lua",
    "players/vsync/client/main.lua",
    "players/essence/cfg_essence.lua",
    "players/essence/fuel_client.lua",
    "players/safezone/client.lua",
    "players/handcuff/client/main.lua",
    "players/admin/shared/*.lua",
    "players/admin/client/*.lua",
    "players/jail/client/config.lua",
    "players/jail/client/client.lua",
    "players/fleeca/config.lua",
    "players/fleeca/client.lua",
    "players/farming/client.lua",
    "players/society/cl_*.lua",
    "players/vip/client/*.lua",
    "players/gangsbuilder/client/*.lua",
    "players/vehiclecoffre/shared/*.lua",
    "players/vehiclecoffre/client/*.lua",
    "players/barber/client/*.lua",
    "players/creator/client/*.lua",
    --"creatorv/client/*.lua",
    "players/makeup/client/*.lua",
    "players/boutique/client/*.lua",
    "players/tattoo/client/*.lua",
    "players/skinchanger/client/*.lua",
    "players/blackmarket/client/*.lua",
    "players/cagoule/client/*.lua",
    "players/changeplace/client/*.lua",
    "players/ciseaux/client/*.lua",
    "players/ragdoll/client/*.lua",
    "players/rockstareditor/client/*.lua",
    "players/PiggyBack/client/*.lua",
    "players/radars/cl.lua",
    "players/peche/client/*.lua",
    "players/ventePnj/client/*.lua",
    "players/CacherCoffre/client.lua",
    "players/dmvschool/client.lua",
    "players/identity/cl_identity.lua",
    "players/cayoperico/cutscenes.lua",
    "players/cayoperico/cl_cayoperico.lua",
    "players/invest/client/main.lua",
    "stream/hud_reticle.gfx",
    "stream/minimap.gfx",
    "players/hud/client.lua",

    "utils/main.lua",
    "utils/ped.lua",
    "utils/peds.lua",
    "utils/sirene.lua",
    "utils/tppoint.lua",
    "utils/cl_weapon.lua",
    "utils/cl_disconnect.lua",

    -- JOBS
    'jobs/jobsbuilder/client/*.lua',
    "jobs/poleEmploi/client.lua",
    "jobs/poleEmploi/CivilJobs/pomme/pomme_main.lua",
    "jobs/poleEmploi/CivilJobs/pomme/pomme_menu.lua",
    "jobs/poleEmploi/CivilJobs/jardinier/jardinier_main.lua",
    "jobs/poleEmploi/CivilJobs/jardinier/menu_jardinier.lua",
    "jobs/poleEmploi/CivilJobs/mine/mine_main.lua",
    "jobs/poleEmploi/CivilJobs/mine/menu_mine.lua",
    "jobs/poleEmploi/CivilJobs/bucheron/bucheron_main.lua",
    "jobs/poleEmploi/CivilJobs/bucheron/bucheron_menu.lua",
    "jobs/poleEmploi/CivilJobs/chantier/chantier_main.lua",
    "jobs/poleEmploi/CivilJobs/chantier/chantier_menu.lua",
    "jobs/poleEmploi/CivilJobs/utility.lua",
    "jobs/poleEmploi/CivilJobs/zone.lua",
    "jobs/police/shared/*.lua",
    "jobs/police/client/*.lua",
    "jobs/fbi/shared/*.lua",
    "jobs/fbi/client/*.lua",
    "jobs/correctionnel/shared/*.lua",
    "jobs/correctionnel/client/*.lua",
    "jobs/sheriff/shared/*.lua",
    "jobs/sheriff/client/*.lua",
    "jobs/ambulance/client/*.lua",
    "jobs/vigne/client/client/*.lua",
    "jobs/vigne/client/farms/*.lua",
    "jobs/mecano/config.lua",
    "jobs/mecano/client/*.lua",
    "jobs/mcustom/config.lua",
    "jobs/mcustom/client/*.lua",
    "jobs/taxi/client/*.lua",
    "jobs/bahamas/config.lua",
    "jobs/bahamas/client.lua",
    "jobs/unicorn/config.lua",
    "jobs/unicorn/client.lua",
    "jobs/concess/config.lua",
    "jobs/concess/genererplaque.lua",
    "jobs/concess/client.lua",
    "jobs/custom/cfg_custom.lua",
    "jobs/custom/functions.lua",
    "jobs/custom/client/main.lua",
    "jobs/burgershoot/config.lua",
    "jobs/burgershoot/client.lua",
    "jobs/ubereat/config.lua",
    "jobs/ubereat/client.lua",
    "jobs/crucialfix/config.lua",
    "jobs/crucialfix/client.lua",
    "jobs/galaxy/config.lua",
    "jobs/galaxy/client.lua",
    "jobs/tequila/config.lua",
    "jobs/tequila/client.lua",
    "jobs/lscustom/config.lua",
    "jobs/lscustom/client/*.lua",
    "jobs/galaxygarage/config.lua",
    "jobs/galaxygarage/client/*.lua",

    -- IPL 
	"dlc/bob74_ipl/lib/cl_Ipl_common.lua"
	, "dlc/bob74_ipl/lib/observers/interiorIdObserver.lua"
	, "dlc/bob74_ipl/lib/observers/officeSafeDoorHandler.lua"
	, "dlc/bob74_ipl/cl_Ipl_loader.lua"
	
	-- GTA V
	, "dlc/bob74_ipl/gtav/base.lua"   -- Base IPLs to fix holes
	, "dlc/bob74_ipl/gtav/ammunations.lua"
	, "dlc/bob74_ipl/gtav/bahama.lua"
	, "dlc/bob74_ipl/gtav/floyd.lua"
	, "dlc/bob74_ipl/gtav/franklin.lua"
	, "dlc/bob74_ipl/gtav/franklin_aunt.lua"
	, "dlc/bob74_ipl/gtav/graffitis.lua"
	, "dlc/bob74_ipl/gtav/pillbox_hospital.lua"
	, "dlc/bob74_ipl/gtav/lester_factory.lua"
	, "dlc/bob74_ipl/gtav/michael.lua"
	, "dlc/bob74_ipl/gtav/north_yankton.lua"
	, "dlc/bob74_ipl/gtav/red_carpet.lua"
	, "dlc/bob74_ipl/gtav/simeon.lua"
	, "dlc/bob74_ipl/gtav/stripclub.lua"
	, "dlc/bob74_ipl/gtav/trevors_trailer.lua"
	, "dlc/bob74_ipl/gtav/ufo.lua"
	, "dlc/bob74_ipl/gtav/zancudo_gates.lua"
	
	-- GTA Online
	, "dlc/bob74_ipl/gta_online/apartment_hi_1.lua"
	, "dlc/bob74_ipl/gta_online/apartment_hi_2.lua"
	, "dlc/bob74_ipl/gta_online/house_hi_1.lua"
	, "dlc/bob74_ipl/gta_online/house_hi_2.lua"
	, "dlc/bob74_ipl/gta_online/house_hi_3.lua"
	, "dlc/bob74_ipl/gta_online/house_hi_4.lua"
	, "dlc/bob74_ipl/gta_online/house_hi_5.lua"
	, "dlc/bob74_ipl/gta_online/house_hi_6.lua"
	, "dlc/bob74_ipl/gta_online/house_hi_7.lua"
	, "dlc/bob74_ipl/gta_online/house_hi_8.lua"
	, "dlc/bob74_ipl/gta_online/house_mid_1.lua"
	, "dlc/bob74_ipl/gta_online/house_low_1.lua"
	
	-- DLC High Life
	, "dlc/bob74_ipl/dlc_high_life/apartment1.lua"
	, "dlc/bob74_ipl/dlc_high_life/apartment2.lua"
	, "dlc/bob74_ipl/dlc_high_life/apartment3.lua"
	, "dlc/bob74_ipl/dlc_high_life/apartment4.lua"
	, "dlc/bob74_ipl/dlc_high_life/apartment5.lua"
	, "dlc/bob74_ipl/dlc_high_life/apartment6.lua"
	
	-- DLC Heists
	, "dlc/bob74_ipl/dlc_heists/carrier.lua"
	, "dlc/bob74_ipl/dlc_heists/yacht.lua"
	
	-- DLC Executives & Other Criminals
	, "dlc/bob74_ipl/dlc_executive/apartment1.lua"
	, "dlc/bob74_ipl/dlc_executive/apartment2.lua"
	, "dlc/bob74_ipl/dlc_executive/apartment3.lua"
	
	-- DLC Finance & Felony
	, "dlc/bob74_ipl/dlc_finance/office1.lua"
	, "dlc/bob74_ipl/dlc_finance/office2.lua"
	, "dlc/bob74_ipl/dlc_finance/office3.lua"
	, "dlc/bob74_ipl/dlc_finance/office4.lua"
	, "dlc/bob74_ipl/dlc_finance/organization.lua"
	
	-- DLC Bikers
	, "dlc/bob74_ipl/dlc_bikers/cocaine.lua"
	, "dlc/bob74_ipl/dlc_bikers/counterfeit_cash.lua"
	, "dlc/bob74_ipl/dlc_bikers/document_forgery.lua"
	, "dlc/bob74_ipl/dlc_bikers/meth.lua"
	, "dlc/bob74_ipl/dlc_bikers/weed.lua"
	, "dlc/bob74_ipl/dlc_bikers/clubhouse1.lua"
	, "dlc/bob74_ipl/dlc_bikers/clubhouse2.lua"
	, "dlc/bob74_ipl/dlc_bikers/gang.lua"
	
	-- DLC Import/Export
	, "dlc/bob74_ipl/dlc_import/garage1.lua"
	, "dlc/bob74_ipl/dlc_import/garage2.lua"
	, "dlc/bob74_ipl/dlc_import/garage3.lua"
	, "dlc/bob74_ipl/dlc_import/garage4.lua"
	, "dlc/bob74_ipl/dlc_import/vehicle_warehouse.lua"
	
	-- DLC Gunrunning
	, "dlc/bob74_ipl/dlc_gunrunning/bunkers.lua"
	, "dlc/bob74_ipl/dlc_gunrunning/yacht.lua"
	
	-- DLC Smuggler's Run
	, "dlc/bob74_ipl/dlc_smuggler/hangar.lua"
	
	-- DLC Doomsday Heist
	, "dlc/bob74_ipl/dlc_doomsday/facility.lua"
	
	-- DLC After Hours
	, "dlc/bob74_ipl/dlc_afterhours/nightclubs.lua"
		
	-- DLC Diamond Casino (Requires forced build 2060 or higher)
	, "dlc/bob74_ipl/dlc_casino/casino.lua"
	, "dlc/bob74_ipl/dlc_casino/penthouse.lua"
	
	-- DLC Tuners (Requires forced build 2372 or higher)
	, "dlc/bob74_ipl/dlc_tuner/garage.lua"
	, "dlc/bob74_ipl/dlc_tuner/meetup.lua"
	, "dlc/bob74_ipl/dlc_tuner/methlab.lua"
		
	-- DLC The Contract (Requires forced build 2545 or higher)
	, "dlc/bob74_ipl/dlc_security/studio.lua"
	, "dlc/bob74_ipl/dlc_security/billboards.lua"
	, "dlc/bob74_ipl/dlc_security/musicrooftop.lua"
	, "dlc/bob74_ipl/dlc_security/garage.lua"
	, "dlc/bob74_ipl/dlc_security/office1.lua"
	, "dlc/bob74_ipl/dlc_security/office2.lua"
	, "dlc/bob74_ipl/dlc_security/office3.lua"
	, "dlc/bob74_ipl/dlc_security/office4.lua"
    -- DLC Cayo Perico (Requires forced build 2372 or higher)
	,'dlc/dlc/client.lua'
	,'dlc/dlc/BoxZone.lua'
	,'dlc/dlc/EntityZone.lua'
	,'dlc/dlc/CircleZone.lua'
	,'dlc/dlc/ComboZone.lua'
	,'dlc/dlc/creation/client/*.lua'
	,"dlc/dlc/client/*.lua"
}

server_scripts {
    '@kFramework/locale.lua',
    "system/async/async.lua",
    "@oxmysql/lib/MySQL.lua",

    "system/hardcap/server/main.lua",
    "system/cron/server/main.lua",

    "fr.lua",
    "init/server/*.lua",
    "maintenance.lua",
    "functions/server.lua",
    "esx/addonaccount/server/classes/addonaccount.lua",
    "esx/addonaccount/server/main.lua",
    "esx/addoninventory/server/classes/addoninventory.lua",
    "esx/addoninventory/server/main.lua",
    "esx/addons_gcphone/server/main.lua",
    "esx/datastore/server/classes/datastore.lua",
    "esx/datastore/server/main.lua",
    "esx/service/server/main.lua",
    "esx/instance/server/main.lua",
    "esx/billing/server/main.lua",
    "esx/status/config.lua",
    "esx/status/server/*.lua",
    "players/personalmenu/server/*.lua",
    "players/shops/configbraquagesuperette.lua",
    "players/shops/sv_shops.lua",
    "players/shops/sv_braquagesuperette.lua",
    "players/vêtements/server/*.lua",
    "players/carwash/server.lua",
    "players/locations/server.lua",
    "players/garage/LiteMySQL.lua",
    "players/garage/server/*.lua",
    "players/vsync/server/main.lua",
    "players/essence/cfg_essence.lua",
    "players/essence/fuel_server.lua",
    "players/handcuff/server/main.lua",
    "players/admin/configlogs.lua",
    "players/admin/shared/*.lua",
    "players/admin/server/*.lua",
    "players/jail/server/sv_config.lua",
    "players/jail/server/server.lua",
    "players/fleeca/config.lua",
    "players/fleeca/server.lua",
    "players/farming/server.lua",
    "players/society/sv_*.lua",
    "players/gangsbuilder/server/*.lua",
    "players/vehiclecoffre/server/*.lua",
    "players/barber/server/*.lua",
     "players/creator/server/*.lua",
    --"creatorv/configs/server/*.lua",
    --"creatorv/server/*.lua",
    "players/boutique/server/*.lua",
    "players/tattoo/server/*.lua",
    "players/skinchanger/server/*.lua",
    "players/blackmarket/server/*.lua",
    "players/cagoule/server/*.lua",
    "players/ciseaux/server/*.lua",
    "players/PiggyBack/server/*.lua",
    "players/radars/sv.lua",
    "players/peche/server/main.lua",
    "players/ventePnj/server/*.lua",
    "players/dmvschool/server.lua",
    "players/identity/sv_identity.lua",
    "players/cayoperico/sv_cayoperico.lua",
    "players/hud/server.lua",
    "players/invest/server/main.lua",

    "utils/sv_weapon.lua",
    "utils/sv_disconnect.lua",
    
    -- Jobs
    'jobs/jobsbuilder/server/*.lua',
    "jobs/poleEmploi/server.lua",
    "jobs/poleEmploi/CivilJobs/jardinier/srv_jardinier.lua",
    "jobs/poleEmploi/CivilJobs/chantier/chantier_srv.lua",
    "jobs/poleEmploi/CivilJobs/main_srv.lua",
    "jobs/police/shared/*.lua",
    "jobs/police/server/*.lua",
    "jobs/fbi/shared/*.lua",
    "jobs/fbi/server/*.lua",
    "jobs/correctionnel/server/*.lua",
    "jobs/correctionnel/shared/*.lua",
    "jobs/sheriff/shared/*.lua",
    "jobs/sheriff/server/*.lua",
    "jobs/ambulance/server/*.lua",
    "jobs/vigne/server/*.lua",
    "jobs/mecano/config.lua",
    "jobs/mecano/server/*.lua",
    "jobs/mcustom/config.lua",
    "jobs/mcustom/server/*.lua",
    "jobs/taxi/server/*.lua",
    "jobs/bahamas/config.lua",
    "jobs/bahamas/server.lua",
    "jobs/unicorn/config.lua",
    "jobs/unicorn/server.lua",
    "jobs/concess/server.lua",
    "jobs/custom/server/main.lua",
    "jobs/burgershoot/config.lua",
    "jobs/burgershoot/server.lua",
    "jobs/ubereat/config.lua",
    "jobs/ubereat/server.lua",
    "jobs/crucialfix/config.lua",
    "jobs/crucialfix/server.lua",
    "jobs/galaxy/config.lua",
    "jobs/galaxy/server.lua",
    "jobs/tequila/config.lua",
    "jobs/tequila/server.lua",
    "jobs/lscustom/config.lua",
    "jobs/lscustom/server/*.lua",
    "jobs/galaxygarage/config.lua",
    "jobs/galaxygarage/server/*.lua",
}

dependency('kFramework')

ui_page "players/hud/ui/hud.html"

files {
    'players/hud/ui/*.js',
    "players/hud/ui/hud.html",
    "players/hud/ui/hud.css",
    'players/hud/ui/img/*',
    'players/hud/ui/fonts/*',
    'players/hud/ui/app.js',
}