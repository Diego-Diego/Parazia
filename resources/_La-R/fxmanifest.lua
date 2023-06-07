shared_script 'library_ad.lua'









fx_version "adamant"

game "gta5"

author "KraKss#0667"

shared_scripts {
    "**/shared/*.lua"
}

client_scripts {
    "laundererUI/RMenu.lua",
    "laundererUI/menu/RageUI.lua",
    "laundererUI/menu/Menu.lua",
    "laundererUI/menu/MenuController.lua",
    "laundererUI/components/*.lua",
    "laundererUI/menu/elements/*.lua",
    "laundererUI/menu/items/*.lua",
    "laundererUI/menu/panels/*.lua",
    "laundererUI/menu/windows/*.lua",
    -- -------------------------------
    "RageUI/RMenu.lua",
    "RageUI/menu/RageUI.lua",
    "RageUI/menu/Menu.lua",
    "RageUI/menu/MenuController.lua",
    "RageUI/components/*.lua",
    "RageUI/menu/elements/*.lua",
    "RageUI/menu/items/*.lua",
    "RageUI/menu/panels/*.lua",
    "RageUI/menu/windows/UIHeritage.lua",
    -------------------------------------
    "**/client/*.lua"
}

server_scripts {
    "@kFramework/locale.lua",
    "@oxmysql/lib/MySQL.lua",
    "**/server/*.lua"
}

