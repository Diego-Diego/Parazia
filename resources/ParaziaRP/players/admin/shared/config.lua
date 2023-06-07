Admin_cfg = {
    --[[
        -1  ->  Tous les groupes (sauf user)
    --]]
    authorizations = {
        ["vehicles"] = {"_dev", "superadmin", "admin", "responsable", "helper", "modo", "gamemaster"},
        ["vehicles2"] = {"_dev", "superadmin", "admin", "responsable", "helper", "modo", "gamemaster"},
        ["ped"] = {"_dev", "responsable"},
        ["kick"] = -1,
        ["mess"] = -1,
        ["jail"] = -1,
        ["unjail"] = -1,
        ["teleport"] = -1,
        ["revive"] = -1,
        ["heal"] = -1,
        ["tppc"] = -1,
        ["warn"] = -1,
        ["permInventaire"] = {"_dev", "superadmin", "admin", "responsable", "gamemaster", "modo", "helper"},
        ["clearInventory"] = {"_dev", "superadmin", "responsable", "gamemaster", "admin"},
        ["clearLoadout"] = {"_dev", "superadmin", "responsable", "gamemaster", "admin"},
        ["setGroup"] = {"_dev", "responsable"},
        ["setJob"] = {"_dev", "superadmin", "responsable", "gamemaster", "admin", "modo"},
        ["give"] = {"_dev", "superadmin", "responsable", "gamemaster"},
        ["giveMoney"] = {"_dev", "superadmin", "responsable", "gamemaster"},
        ["wipe"] = {"_dev", "superadmin", "responsable", "gamemaster"},
        ["clearvéhicules"] = {"_dev", "gamemaster", "responsable", "superadmin"},
    }
}