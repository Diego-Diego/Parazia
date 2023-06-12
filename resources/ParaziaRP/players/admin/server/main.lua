ESX, players, items = nil, {}, {}
inService = {}

warnedPlayers = {}
blacklistedLicenses = {}

MySQL.ready(function()
    MySQL.Async.fetchAll("SELECT * FROM items", {}, function(result)
        for k, v in pairs(result) do
            items[k] = { label = v.label, name = v.name }
        end
    end)
end)

local function getLicense(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for _, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers
        end
        return identifiers
    end
end

local function isStaff(source)
    return players[source].rank ~= "user"
end

local function isWebhookSet(val)
    return val ~= nil and val ~= ""
end

TriggerEvent('sova:KraKss0TEX0', function(obj)
    ESX = obj
end)

RegisterServerEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(source, xPlayer)
    local source = source
    if players[source] then
        return
    end
    TriggerClientEvent("adminmenu:cbPermLevel", source, xPlayer.getGroup())
    print(("^1[Admin Menu] ^7Player ^3%s ^7loaded with group ^1%s^7 ! ^7"):format(GetPlayerName(source),xPlayer.getGroup()))
    players[source] = {
        timePlayed = { 0, 0 },
        rank = xPlayer.getGroup(),
        name = GetPlayerName(source),
        license = getLicense(source)["license"],
    }
    if players[source].rank ~= "user" then
        TriggerClientEvent("adminmenu:cbItemsList", source, items)
        TriggerClientEvent("adminmenu:cbReportTable", source, reportsTable)
        TriggerClientEvent("adminmenu:updatePlayers", source, players)
    end
end)

AddEventHandler("playerDropped", function(reason)
    local source = source
    players[source] = nil
    reportsTable[source] = nil
    updateReportsForStaff()
end)

RegisterNetEvent("adminmenu:setStaffState")
AddEventHandler("adminmenu:setStaffState", function(newVal, sneaky)
    local source = source
    TriggerClientEvent("adminmenu:cbStaffState", source, newVal)
    local byState = {
        [true] = "~q~[Staff] ~y~%s ~s~est désormais ~g~actif ~s~en staffmode.",
        [false] = "~q~[Staff] ~y~%s ~s~a ~q~désactivé ~s~son staffmode."
    }
    if newVal then
        inService[source] = true
    else
        inService[source] = nil
    end
    if not sneaky then
        for k,player in pairs(players) do
            if player.rank ~= "user" and inService[k] ~= nil then
                TriggerClientEvent("esx:showNotification", k, byState[newVal]:format(GetPlayerName(source)))
            end
        end
    end
end)

RegisterNetEvent("adminmenu:goto")
AddEventHandler("adminmenu:goto", function(target)
    local source = source
    local rank = players[source].rank
    if not canUse("teleport", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local coords = GetEntityCoords(GetPlayerPed(target))
    TriggerClientEvent("adminmenu:setCoords", source, coords)
    if isWebhookSet(logs_cfg.webhook.onTeleport) then
        sendWebhook(("L'utilisateur %s s'est téléporté sur %s"):format(GetPlayerName(source), GetPlayerName(target)), "grey", logs_cfg.webhook.onItemGive)
    end
end)

RegisterNetEvent("adminmenu:bring")
AddEventHandler("adminmenu:bring", function(target, coords)
    local source = source
    local rank = players[source].rank
    if not canUse("teleport", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    TriggerClientEvent("adminmenu:setCoords", target, coords)
    if isWebhookSet(logs_cfg.webhook.onTeleport) then
        sendWebhook(("L'utilisateur %s a téléporté %s sur lui"):format(GetPlayerName(source), GetPlayerName(target)), "grey", logs_cfg.webhook.onItemGive)
    end
end)

RegisterNetEvent("adminmenu:tppc")
AddEventHandler("adminmenu:tppc", function(target, coords)
    local source = source
    local rank = players[source].rank
    if not canUse("tppc", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    TriggerClientEvent("adminmenu:setCoords", target, vector3(215.76, -810.12, 30.73))
    TriggerClientEvent("esx:showNotification", source, "~g~Téléportation effectuée")
end)

RegisterNetEvent("adminmenu:give")
AddEventHandler("adminmenu:give", function(target, itemName, qty)
    local source = source
    local rank = players[source].rank
    if not canUse("give", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(tonumber(target))
    if xPlayer then
        xPlayer.addInventoryItem(itemName, tonumber(qty))
        TriggerClientEvent("esx:showNotification", source, ("~g~Give de %sx%s au joueur %s effectué"):format(qty, itemName, GetPlayerName(target)))
        if isWebhookSet(logs_cfg.webhook.onItemGive) then
            sendWebhook(("L'utilisateur %s a give %sx%s a %s"):format(GetPlayerName(source), qty, itemName, GetPlayerName(target)), "grey", logs_cfg.webhook.onItemGive)
        end
    else
        TriggerClientEvent("esx:showNotification", source, "~q~Ce joueur n'est plus connecté")
    end
end)

RegisterNetEvent("adminmenu:message")
AddEventHandler("adminmenu:message", function(target, message)
    local source = source
    local rank = players[source].rank
    if not canUse("mess", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    TriggerClientEvent("esx:showNotification", source, ("~g~Message envoyé à %s"):format(GetPlayerName(target)))
    TriggerClientEvent("esx:showNotification", target, ("~q~Message du staff~s~: %s"):format(message))
    if isWebhookSet(logs_cfg.webhook.onMessage) then
        sendWebhook(("L'utilisateur %s a envoyé un message à %s:\n\n__%s__"):format(GetPlayerName(source), GetPlayerName(target), message), "grey", logs_cfg.webhook.onMessage)
    end
end)

RegisterNetEvent("adminmenu:kick")
AddEventHandler("adminmenu:kick", function(target, message)
    local source = source
    local rank = players[source].rank
    if not canUse("kick", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    TriggerClientEvent("esx:showNotification", source, ("~g~Expulsion de %s effectuée"):format(GetPlayerName(target)))
    local name = GetPlayerName(target)
    DropPlayer(target, ("[Admin] Expulsé: %s"):format(message))
    if isWebhookSet(logs_cfg.webhook.onKick) then
        sendWebhook(("L'utilisateur %s a expulsé %s pour la raison:\n\n__%s__"):format(GetPlayerName(source), name, message), "grey", logs_cfg.webhook.onKick)
    end
end)

RegisterNetEvent("adminmenu:revive")
AddEventHandler("adminmenu:revive", function(target)
    local source = source
    local rank = players[source].rank
    if not canUse("revive", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    TriggerClientEvent("esx:showNotification", source, ("~g~Revive de %s effectué"):format(GetPlayerName(target)))
    TriggerClientEvent('EMS:ReviveClientPlayer', target)
    local TargetPlayer = ESX.GetPlayerFromId(target)
    TargetPlayer.showNotification('~w~Vous avez été réanimer par un staff.')
    local name = GetPlayerName(target)
    if isWebhookSet(logs_cfg.webhook.onRevive) then
        sendWebhook(("L'utilisateur %s a revive %s"):format(GetPlayerName(source), name), "grey", logs_cfg.webhook.onRevive)
    end
end)

RegisterNetEvent("adminmenu:heal")
AddEventHandler("adminmenu:heal", function(target)
    local source = source
    local rank = players[source].rank
    if not canUse("heal", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    TriggerClientEvent("esx:showNotification", source, ("~g~Heal de %s effectué"):format(GetPlayerName(target)))
    TriggerClientEvent('esx_status:healPlayer', target)
    local name = GetPlayerName(target)
    if isWebhookSet(logs_cfg.webhook.onHeal) then
        sendWebhook(("L'utilisateur %s a heal %s"):format(GetPlayerName(source), name), "grey", logs_cfg.webhook.onHeal)
    end
end)

RegisterNetEvent("adminmenu:warn")
AddEventHandler("adminmenu:warn", function(target, reason)
    local source = source
    local rank = players[source].rank
    if not canUse("warn", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local license = getLicense(target)
    if warnedPlayers[license] == nil then
        warnedPlayers[license] = 0
    end
    warnedPlayers[license] = (warnedPlayers[license] + 1)
    TriggerClientEvent("esx:showNotification", source, ("~g~Warn envoyé à %s"):format(GetPlayerName(target)))
    TriggerClientEvent("esx:showNotification", target, ("~q~Vous avez reçu un avertissement~s~: %s"):format(reason))
    TriggerClientEvent("adminmenu:receivewarn", target, reason)
    print(json.encode(warnedPlayers[license]))
    if warnedPlayers[license] > 2 then
        DropPlayer(target, "3 Avertissements atteints ! Vous pourrez vous reconnecter au prochain reboot.")
    end
    print(warnedPlayers[license])
end)



RegisterNetEvent("adminmenu:wipe")
AddEventHandler("adminmenu:wipe", function(target)
    local source = source
    local rank = players[source].rank
    if not canUse("wipe", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(target)
    local name = GetPlayerName(target)
    if xPlayer then
        DropPlayer(target, "Wipe en cours...")
        MySQL.Sync.execute("DELETE FROM users WHERE identifier='" .. xPlayer.identifier .. "'")
        MySQL.Sync.execute("DELETE FROM billing WHERE identifier='" .. xPlayer.identifier .. "'")
        MySQL.Sync.execute("DELETE FROM open_car WHERE owner='" .. xPlayer.identifier .. "'")
        MySQL.Sync.execute("DELETE FROM owned_vehicles WHERE owner='" .. xPlayer.identifier .. "'")
        MySQL.Sync.execute("DELETE FROM addon_inventory_items WHERE owner='" .. xPlayer.identifier .. "'")
        MySQL.Sync.execute("DELETE FROM addon_account_data WHERE owner='" .. xPlayer.identifier .. "'")
        MySQL.Sync.execute("DELETE FROM user_licenses WHERE owner='" .. xPlayer.identifier .. "'")
        MySQL.Sync.execute("DELETE FROM datastore_data WHERE owner='" .. xPlayer.identifier .. "'")
        MySQL.Sync.execute("DELETE FROM playerstattoos WHERE identifier='" .. xPlayer.identifier .. "'")
        MySQL.Sync.execute("DELETE FROM ParaziaRP_houses WHERE owner='" .. xPlayer.identifier .. "'")
        if isWebhookSet(logs_cfg.webhook.onWipe) then
            sendWebhook(("L'utilisateur %s a wipe %s"):format(GetPlayerName(source), name), "grey", logs_cfg.webhook.onWipe)
        end
    end
end)

RegisterNetEvent("adminmenu:clearvéhicules")
AddEventHandler("adminmenu:clearvéhicules", function(target)
    local source = source
    local rank = players[source].rank
    if not canUse("clearvéhicules", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(target)
    local name = GetPlayerName(target)
    if xPlayer then
        MySQL.Sync.execute("DELETE FROM open_car WHERE owner='" .. xPlayer.identifier .. "'")
        MySQL.Sync.execute("DELETE FROM owned_vehicles WHERE owner='" .. xPlayer.identifier .. "'")
        if isWebhookSet(logs_cfg.webhook.onWipe) then
            sendWebhook(("L'utilisateur %s a wipe %s"):format(GetPlayerName(source), name), "grey", logs_cfg.webhook.onWipe)
        end
    end
end)

RegisterNetEvent("adminmenu:spawnVehicle")
AddEventHandler("adminmenu:spawnVehicle", function(model, target)
    local source = source
    local rank = players[source].rank
    if not canUse("vehicles", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    if target ~= nil then
        TriggerClientEvent("esx:spawnVehicle", target, model)
    else
        TriggerClientEvent("esx:spawnVehicle", source, model)
    end
end)

RegisterNetEvent("adminmenu:setGroup")
AddEventHandler("adminmenu:setGroup", function(target, group)
    local source = source
    local rank = players[source].rank
    if not canUse("setGroup", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(target)
    if xPlayer then
        xPlayer.setGroup(group)
        ESX.SavePlayer(xPlayer, function() end)
        players[source].rank = group
        TriggerClientEvent("adminmenu:cbPermLevel", target, group)
        TriggerClientEvent("esx:showNotification", source, ("~g~Changement du rang de %s effectué"):format(GetPlayerName(target)))
        for source, player in pairs(players) do
            if isStaff(source) then
                TriggerClientEvent("adminmenu:updatePlayers", source, players)
            end
        end
        local name = GetPlayerName(target)
        if isWebhookSet(logs_cfg.webhook.onGroupChange) then
            sendWebhook(("L'utilisateur %s a changé le groupe de %s pour le groupe: __%s__"):format(GetPlayerName(source), name, group), "red", logs_cfg.webhook.onGroupChange)
        end
    else
        TriggerClientEvent("esx:showNotification", source, "~q~Ce joueur n'est plus connecté")
    end
end)

RegisterNetEvent("adminmenu:clearInv")
AddEventHandler("adminmenu:clearInv", function(target)
    local source = source
    local rank = players[source].rank
    if not canUse("clearInventory", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(target)
    for i = 1, #xPlayer.inventory, 1 do
        if xPlayer.inventory[i].count > 0 then
            xPlayer.setInventoryItem(xPlayer.inventory[i].name, 0)
        end
    end
    TriggerClientEvent("esx:showNotification", source, ("~g~Clear inventaire de %s effectuée"):format(GetPlayerName(target)))
    if isWebhookSet(logs_cfg.webhook.onClear) then
        sendWebhook(("L'utilisateur %s a clear inventaire %s"):format(GetPlayerName(source), GetPlayerName(target)), "grey", logs_cfg.webhook.onClear)
    end
end)


RegisterNetEvent("adminmenu:clearLoadout")
AddEventHandler("adminmenu:clearLoadout", function(target)
    local source = source
    local rank = players[source].rank
    if not canUse("clearLoadout", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(target)
    for i = #xPlayer.loadout, 1, -1 do
        xPlayer.removeWeapon(xPlayer.loadout[i].name)
    end
    TriggerClientEvent("esx:showNotification", source, ("~g~Clear des armes de %s effectuée"):format(GetPlayerName(target)))
    if isWebhookSet(logs_cfg.webhook.onClear) then
        sendWebhook(("L'utilisateur %s a clear les armes de %s"):format(GetPlayerName(source), GetPlayerName(target)), "grey", logs_cfg.webhook.onClear)
    end
end)

RegisterNetEvent("adminmenu:addMoney")
AddEventHandler("adminmenu:addMoney", function(target, ammount)
    local source = source
    local rank = players[source].rank
    if not canUse("giveMoney", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(target)
    xPlayer.addAccountMoney("cash", ammount)
    TriggerClientEvent("esx:showNotification", source, ("~g~Give d'argent à %s effectuée"):format(GetPlayerName(target)))
    if isWebhookSet(logs_cfg.webhook.onMoneyGive) then
        sendWebhook(("L'utilisateur %s a give %s$ à %s"):format(GetPlayerName(source), ammount, GetPlayerName(target)), "grey", logs_cfg.webhook.onMoneyGive)
    end
end)

RegisterNetEvent("adminmenu:addMoneysale")
AddEventHandler("adminmenu:addMoneysale", function(target, ammount)
    local source = source
    local rank = players[source].rank
    if not canUse("giveMoney", rank) then
        DropPlayer(source, "Permission invalide")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(target)
    xPlayer.addAccountMoney("dirtycash", ammount)
    TriggerClientEvent("esx:showNotification", source, ("~g~Give d'argent à %s effectuée"):format(GetPlayerName(target)))
    if isWebhookSet(logs_cfg.webhook.onMoneyGive) then
        sendWebhook(("L'utilisateur %s a give %s$ à %s"):format(GetPlayerName(source), ammount, GetPlayerName(target)), "grey", logs_cfg.webhook.onMoneyGive)
    end
end)

-- Players updaters task
Citizen.CreateThread(function()
    while true do
        Wait(15000)
        for source, player in pairs(players) do
            if isStaff(source) then
                TriggerClientEvent("adminmenu:updatePlayers", source, players)
                TriggerClientEvent("adminmenu:cbReportTable", source, reportsTable)
            end
        end
    end
end)

RegisterServerEvent("euhtesserieuxmek")
AddEventHandler("euhtesserieuxmek", function()
    local _source = source
    DropPlayer(_source, "Le cheat ... c'est mal !")
end)

AddEventHandler("clearPedTasksEvent", function(source, data)
    local _source = source
    DropPlayer(_source, "Le cheat ... c'est mal !")
end)

RegisterServerEvent("adminmenu:Jail")
AddEventHandler("adminmenu:Jail", function(id, temps)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getGroup() ~= "user" then
        TriggerEvent("esx_jail:sendToJail", id, temps)
    else
        DropPlayer(source, "Le cheat ... c'est mal !")
    end
end)

ESX.RegisterServerCallback('finalmenuadmin:getAllItems', function(source, cb)
    cb(items)
end)
  
ESX.RegisterServerCallback("finalmenuadmin:getAllGrade", function(source, cb, jobName)
    local gradeJobs = {}
  
    MySQL.Async.fetchAll("SELECT * FROM job_grades WHERE job_name = @job_name", {['job_name'] = jobName}, function(data)
        for _,v in pairs(data) do
        table.insert(gradeJobs, {
          gradeJob = v.grade,
          gradeLabel = v.label
        })
        end
        cb(gradeJobs)
    end)
end)
  
ESX.RegisterServerCallback("finalmenuadmin:getAllJobs", function(source, cb)
    local allJobs = {}
  
    MySQL.Async.fetchAll("SELECT * FROM jobs", {}, function(data)
        for _, v in pairs(data) do
        table.insert(allJobs, {
          NameSociety = v.name,
          LabelSociety = v.label
        })
        end
        cb(allJobs)
    end)
end)

ESX.RegisterServerCallback('adminmenu:getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)
  
    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout(),
            money = xPlayer.getAccounts()
        }
  
        cb(data)
    end
end)

-- Session counter task
-- TODO -> add report time elapsed
Citizen.CreateThread(function()
    while true do
        Wait(1000 * 60)
        for k, v in pairs(players) do
            players[k].timePlayed[1] = players[k].timePlayed[1] + 1
            if players[k].timePlayed[1] > 60 then
                players[k].timePlayed[1] = 0
                players[k].timePlayed[2] = players[k].timePlayed[2] + 1
            end
        end
        for k, v in pairs(reportsTable) do
            reportsTable[k].timeElapsed[1] = reportsTable[k].timeElapsed[1] + 1
            if reportsTable[k].timeElapsed[1] > 60 then
                reportsTable[k].timeElapsed[1] = 0
                reportsTable[k].timeElapsed[2] = reportsTable[k].timeElapsed[2] + 1
            end
        end
    end
end)

RegisterCommand("tppc", function(source, args, rawCommand)	-- /bringback [ID] will teleport player back where he was before /bring
	if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        local playerGroup = xPlayer.getGroup()

        if playerGroup ~= 'user' then
    		if args[1] and tonumber(args[1]) then
      			local targetId = tonumber(args[1])
      			local xTarget = ESX.GetPlayerFromId(targetId)
                if xTarget then
                    TriggerClientEvent("adminmenu:setCoords", args[1], vector3(215.76, -810.12, 30.73))
                    TriggerClientEvent("esx:showNotification", source, "~g~Téléportation effectuée")
      			else
                    TriggerClientEvent('esx:showNotification', source, 'Aucun joueur avec cette id !')
      			end
    		else
      			TriggerClientEvent("chatMessage", xPlayer.source, "Entrée invalide", 'TPPC')
    		end
  		end
	end
end, false)

RegisterCommand("tpm", function(source, args, rawCommand)	-- /bringback [ID] will teleport player back where he was before /bring
	if source ~= 0 then
        local xPlayer = ESX.GetPlayerFromId(source)
        local playerGroup = xPlayer.getGroup()

        if playerGroup ~= 'user' then
            TriggerClientEvent("prz_core:tpm", source)
  		end
	end
end, false)

RegisterNetEvent('ox_target:giveCar')
AddEventHandler('ox_target:giveCar', function(model, label, plate)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() ~= "_dev" then
        xPlayer.showNotification("~r~Vous n'avez pas la permisssion de faire cela !")
        return
    end

    LiteMySQL:Insert('owned_vehicles', {
        owner = xPlayer.identifier,
        plate = plate,
        label = label,
        vehicle = json.encode({ model = GetHashKey(model), plate = plate }),
        type = 'car',
        state = 1,
        boutique = 1,
    })
    xPlayer.showNotification("Vous vous êtes give le véhicule : " ..label)
end)

local blacklistPed, _ri, PlayerPeds = {
    [tostring(`a_c_chimp` & 0xffffffff)] = true,
    [tostring(`a_c_dolphin` & 0xffffffff)] = true,
    [tostring(`a_c_fish` & 0xffffffff)] = true,
    [tostring(`a_c_sharkhammer` & 0xffffffff)] = true,
    [tostring(`a_c_humpback` & 0xffffffff)] = true,
    [tostring(`a_c_killerwhale` & 0xffffffff)] = true
}, Citizen.ResultAsInteger(), {}
AddEventHandler("entityCreating", function(ENTITY)
    if not DoesEntityExist(ENTITY) then
        return CancelEvent()
    end
    local OWNER = Citizen.InvokeNative(508846628, ENTITY, _ri)
    if OWNER == nil then
        CancelEvent()
        return
    elseif OWNER == 0 then
        CancelEvent()
        return
    end
    local MODEL = GetEntityModel(ENTITY)
    local PTYPE = GetEntityPopulationType(ENTITY)
    local TYPE  = GetEntityType(ENTITY)
    if MODEL == 0 and PTYPE == 0  and TYPE ~= 3 then
        CancelEvent()
        print("aerodefence ban "..tostring(OWNER).." FDPENTITY"..tostring(MODEL & 0xffffffff))
        return
    end
    if blacklistPed[tostring(tostring(MODEL) & 0xffffffff)] then
        CancelEvent()
        print("aerodefence ban "..tostring(OWNER).." FDPENTITY"..tostring(MODEL & 0xffffffff))
        return
    end
    if TYPE == 2 then
        if not PlayerPeds[OWNER] then
            PlayerPeds[OWNER] = 0
        end
        PlayerPeds[OWNER] = PlayerPeds[OWNER] + 1
        if PlayerPeds[OWNER] > 90 then
            CancelEvent()
            print("SPAWN PED "..tostring(OWNER).." RL "..tostring(MODEL & 0xffffffff))
            return
        elseif PlayerPeds[OWNER] > 20 then
            CancelEvent()
            return
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        PlayerPeds = {}
        Citizen.Wait(6000)
    end
end)