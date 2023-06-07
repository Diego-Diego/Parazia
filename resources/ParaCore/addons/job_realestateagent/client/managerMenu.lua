--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

tpAnim = false

local cat, desc, servInteract = "realestateagentmanager", "~g~Interaction avec la propriétée", false
local propertyInv, playerInv, invPlayer = {}, {}, {}
local sub = function(str)
    return cat .. "_" .. str
end
local info = { type = nil, message = nil, }

local function countItems(inventory)
    local count = 0
    for k, item in pairs(inventory) do
        count = count + item.count
    end
    return count
end

ParaziaRP.netRegisterAndHandle("houseDepositFailed", function(callbackMessage)
    servInteract = false
    info.type = 2
    info.message = callbackMessage
end)

ParaziaRP.netRegisterAndHandle("houseDepositSucceed", function(itemName, newCount, depositCout)
    playerInv[itemName].count = newCount
    if propertyInv[itemName] == nil then
        propertyInv[itemName] = {count = depositCout, label = playerInv[itemName].label}
    else
        propertyInv[itemName].count = (propertyInv[itemName].count + depositCout)
    end
    Wait(600)
    servInteract = false
    info.type = -1
    info.message = "Transfert effectué"
end)

ParaziaRP.netRegisterAndHandle("houseDepositSucceed:weapon", function()
    Wait(600)
    servInteract = false
    info.type = -1
    info.message = "Transfert effectué"
end)

ParaziaRP.netRegisterAndHandle("houseRemovalSucceed", function(itemName, newCount, removalCount)
    if not playerInv[itemName] then
        playerInv[itemName] = {count = removalCount, label = propertyInv[itemName].label}
    else
        playerInv[itemName].count = playerInv[itemName].count + removalCount
    end
    if (propertyInv[itemName].count - removalCount) <= 0 then
        propertyInv[itemName] = nil
    else
        propertyInv[itemName].count = (propertyInv[itemName].count - removalCount)
    end
    Wait(600)
    servInteract = false
    info.type = -1
    info.message = "Transfert effectué"
end)

ParaziaRP.netRegisterAndHandle("houseRemovalSucceed:weapon", function()
    Wait(600)
    servInteract = false
    info.type = -1
    info.message = "Transfert effectué"
end)

ParaziaRP.netRegisterAndHandle("openManagerPropertyMenu", function(onlinePlayers, allowedPlayers, license, houseId, isPublic, inventories, capacity)
    info.type = nil
    local depositIndex = 1
    local depositList = {}
    local function depositAbility(have, wantToDeposit)
        if have < wantToDeposit then
            return { ret = false, display = "~q~Qté. insuffisante" }
        else
            return { ret = true, display = ("Déposer x~q~%i ~s~→→"):format(wantToDeposit) }
        end
    end

    local function removalAbility(have, wantToDeposit)
        if have < wantToDeposit then
            return { ret = false, display = "~q~Qté. insuffisante" }
        else
            return { ret = true, display = ("Retirer x~q~%i ~s~→→"):format(wantToDeposit) }
        end
    end

    for i = 1, 64 do
        depositList[i] = ("~o~%i~s~"):format(i)
    end
    propertyInv = inventories[1]
    playerInv = inventories[2]
    if menuIsOpened or tpAnim then
        return
    end
    for k, v in pairs(onlinePlayers) do
        if v.license == license then
            onlinePlayers[k] = nil
        end
    end
    local autorisationTable = {}
    for k, v in pairs(onlinePlayers) do
        autorisationTable[v.license] = { can = false, id = v }
    end
    for k, v in pairs(allowedPlayers) do
        if autorisationTable[v] ~= nil then
            autorisationTable[v].can = true
        end
    end
    FreezeEntityPosition(PlayerPedId(), true)
    ESX.TriggerServerCallback('prz_property:getPropertyInventory', function(inventory)
        invPlayer = inventory
    end, ESX.GetPlayerData().identifier)
    menuIsOpened = true
    RMenu.Add(cat, sub("main"), RageUI.CreateMenu(nil, desc, nil, nil, "root_cause", "shopui_title_dynasty8"))
    RMenu:Get(cat, sub("main")).Closed = function()
    end
    RMenu.Add(cat, sub("invite"), RageUI.CreateSubMenu(RMenu:Get(cat, sub("main")), nil, desc, nil, nil, "root_cause", "shopui_title_dynasty8"))
    RMenu:Get(cat, sub("invite")).Closed = function()
    end
    RMenu.Add(cat, sub("safe"), RageUI.CreateSubMenu(RMenu:Get(cat, sub("main")), nil, desc, nil, nil, "root_cause", "shopui_title_dynasty8"))
    RMenu:Get(cat, sub("safe")).Closed = function()
    end
    RMenu.Add(cat, sub("safe_deposit"), RageUI.CreateSubMenu(RMenu:Get(cat, sub("safe")), nil, desc, nil, nil, "root_cause", "shopui_title_dynasty8"))
    RMenu:Get(cat, sub("safe_deposit")).Closed = function()
    end
    RageUI.Visible(RMenu:Get(cat, sub("main")), true)
    local alert, warn = "~s~", "~y~"
    local function colorByType(type)
        if type == 1 then
            return warn
        elseif type == -1 then
            return "~g~"
        else
            return alert
        end
    end
    ParaziaRP.newThread(function()
        while menuIsOpened do
            Wait(800)
            if alert == "~s~" then
                alert = "~q~"
            else
                alert = "~s~"
            end
            if warn == "~y~" then
                warn = "~o~"
            else
                warn = "~y~"
            end
        end
    end)
    ParaziaRP.newThread(function()
        while menuIsOpened do
            local shouldStayOpened = false
            local function tick()
                shouldStayOpened = true
            end
            RageUI.IsVisible(RMenu:Get(cat, sub("main")), true, true, true, function()
                tick()
                RageUI.Separator("↓ ~g~Gestion de la propriétée ~s~↓")
                RageUI.ButtonWithStyle("Liste des autorisations", nil, { RightLabel = "→→" }, true, function(_, _, s)
                end, RMenu:Get(cat, sub("invite")))
                RageUI.ButtonWithStyle("Coffre fort", nil, { RightLabel = "→→" }, true, function(_, _, s)
                    if s then                        
                        info.message = nil
                    end
                end, RMenu:Get(cat, sub("safe")))
            end, function()
            end)
            RageUI.IsVisible(RMenu:Get(cat, sub("safe")), true, true, true, function()
                tick()
                if info.message ~= nil then
                    RageUI.Separator(("%s%s"):format(colorByType(info.type), info.message))
                end
                RageUI.Separator(("Capacité: ~o~%i~s~/~o~%i"):format(countItems(propertyInv), capacity))
                RageUI.Separator("↓ ~g~Gestion du coffre fort ~s~↓")
                RageUI.ButtonWithStyle("Déposer des objets", nil, { RightLabel = "→→" }, not servInteract, function(_, _, s)
                    if s then
                        info.message = nil
                    end
                end, RMenu:Get(cat, sub("safe_deposit")))
                RageUI.Separator("↓ ~y~Objets disponibles ~s~↓")
                RageUI.List("Quantité à retirer:", depositList, depositIndex, nil, {}, true, function(_, _, _, i)
                    depositIndex = i
                end)
                for itemName, itemInfos in pairs(propertyInv) do
                    if itemInfos.count > 0 then
                        RageUI.ButtonWithStyle(("%s ~s~(~q~%i~s~)"):format(itemInfos.label, itemInfos.count), nil, { RightLabel = removalAbility(itemInfos.count, depositIndex).display }, not servInteract, function(_, _, s)
                            if s then
                                if not depositAbility(itemInfos.count, depositIndex).ret then
                                    info.type = 2
                                    info.message = ("Il n'y a pas assez de %s"):format(itemInfos.label)
                                else
                                    if not servInteract then
                                        servInteract = true
                                        info.type = 1
                                        info.message = "Transaction avec le serveur en cours..."
                                        ParaziaRPClientUtils.toServer("removeFromHouse", houseId, itemName, depositIndex)
                                    end
                                end
                            end
                        end)
                    end
                end
                RageUI.Separator("↓ ~g~Armes ~s~↓")
                if #ESX.PlayerData.loadout > 0 then 
                    for i=1, #invPlayer.weapons, 1 do
                        local weapon = invPlayer.weapons[i]

                        RageUI.ButtonWithStyle(ESX.GetWeaponLabel(weapon.name) .. ' [~g~' .. weapon.ammo .. '~s~]', nil, {}, not servInteract, function(_, _, s)
                            if s then
                                if not servInteract then
                                    servInteract = true
                                    info.type = 1
                                    info.message = "Transaction avec le serveur en cours..."
                                    ParaziaRPClientUtils.toServer("removeFromHouse:weapon", houseId, weapon.name)
                                    RageUI.CloseAll()
                                end
                            end
                        end)
                    end
                end
                if invPlayer.blackMoney > 0 then
                    RageUI.Separator("↓ ~g~Argent Sale ~s~↓")
                    RageUI.ButtonWithStyle("Argent Sale : ~r~"..ESX.Math.GroupDigits(invPlayer.blackMoney).."$~s~", nil, { RightLabel = ">>" }, not servInteract, function(_, _, s)
                        if s then
                            if not servInteract then
                                local check, quantity = CheckQuantity(KeyboardInput("Nombres d'argent que vous voulez mettre", '', '', 100))
                                if check then 
                                    servInteract = true
                                    info.type = 1
                                    info.message = "Transaction avec le serveur en cours..."
                                    ParaziaRPClientUtils.toServer("removeFromHouse:blackmoney", houseId, quantity)
                                    RageUI.CloseAll()
                                else
                                    ESX.ShowNotification("Arguments Inssufisant")
                                end
                            end
                        end
                    end)
                end
            end, function()
            end)
            RageUI.IsVisible(RMenu:Get(cat, sub("safe_deposit")), true, true, true, function()
                tick()
                if info.message ~= nil then
                    RageUI.Separator(("%s%s"):format(colorByType(info.type), info.message))
                end
                RageUI.Separator(("Capacité: ~o~%i~s~/~o~%i"):format(countItems(propertyInv), capacity))
                RageUI.Separator("↓ ~g~Déposer des objets ~s~↓")
                RageUI.List("Quantité à déposer:", depositList, depositIndex, nil, {}, true, function(_, _, _, i)
                    depositIndex = i
                end)
                RageUI.Separator("↓ ~y~Vos objets ~s~↓")
                
                for i = 1, #ESX.GetPlayerData().accounts, 1 do
                    if ESX.GetPlayerData().accounts[i].name == 'dirtycash'  then
                        if ESX.PlayerData.accounts[i].money > 0 then
                            RageUI.ButtonWithStyle("Argent Sale : ~r~"..ESX.GetPlayerData().accounts[i].money.."$~s~", nil, { RightLabel = ">>" }, not servInteract, function(_, _, s)
                                if s then
                                    if not servInteract then
                                        local check, quantity = CheckQuantity(KeyboardInput("Nombres d'argent que vous voulez mettre", '', '', 100))
                                        if check then 
                                            servInteract = true
                                            info.type = 1
                                            info.message = "Transaction avec le serveur en cours..."
                                            ParaziaRPClientUtils.toServer("depositHouse:blackmoney", houseId, quantity)
                                            RageUI.CloseAll()
                                        else
                                            ESX.ShowNotification("Arguments Inssufisant")
                                        end
                                    end
                                end
                            end)
                        end
                    end
                end
                for itemName, itemInfos in pairs(playerInv) do
                    if itemInfos.count > 0 then
                        RageUI.ButtonWithStyle(("%s ~s~(~q~%i~s~)"):format(itemInfos.label, itemInfos.count), nil, { RightLabel = depositAbility(itemInfos.count, depositIndex).display }, not servInteract, function(_, _, s)
                            if s then
                                if not depositAbility(itemInfos.count, depositIndex).ret then
                                    info.type = 2
                                    info.message = ("Vous n'avez pas assez de %s"):format(itemInfos.label)
                                else
                                    if not servInteract then
                                        servInteract = true
                                        info.type = 1
                                        info.message = "Transaction avec le serveur en cours..."
                                        ParaziaRPClientUtils.toServer("depositHouse", houseId, itemName, depositIndex)
                                    end
                                end
                            end
                        end)
                    end
                end
                
                RageUI.Separator("↓ ~y~Vos Armes ~s~↓")
                if #ESX.GetPlayerData().loadout > 0 then 
                    for i = 1, #ESX.GetPlayerData().loadout, 1 do
                        local ammo = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(ESX.GetPlayerData().loadout[i].name))

                        RageUI.ButtonWithStyle("> "..ESX.GetPlayerData().loadout[i].label, nil, { RightLabel = "Munition(s) : ~g~x"..ammo.." >>" }, not servInteract, function(_, _, s)
                            if s then
                                if not servInteract then
                                    servInteract = true
                                    info.type = 1
                                    info.message = "Transaction avec le serveur en cours..."
                                    ParaziaRPClientUtils.toServer("depositHouse:weapon", houseId, ESX.GetPlayerData().loadout[i].name, ammo)
                                    RageUI.CloseAll()
                                end
                            end
                        end)
                    end
                else
                    RageUI.Separator("~g~Aucune Armes")
                end
            end, function()
            end)
            RageUI.IsVisible(RMenu:Get(cat, sub("invite")), true, true, true, function()
                tick()
                RageUI.Separator("↓ ~g~Gestion des autorisations ~s~↓")
                RageUI.ButtonWithStyle("Appliquer les autorisations", nil, { RightLabel = "→→" }, true, function(_, _, s)
                    if s then
                        ESX.ShowNotification("~o~Application des modifications en cours...")
                        ParaziaRPClientUtils.toServer("setHouseAlloweds", houseId, autorisationTable, isPublic)
                        shouldStayOpened = false
                    end
                end)
                RageUI.Checkbox("Propriétée publique:", nil, isPublic, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    isPublic = Checked
                end, function()
                end, function()
                end)
                if not isPublic then
                    RageUI.Separator("↓ ~y~Autorisations ~s~↓")
                    for k, v in pairs(onlinePlayers) do
                        RageUI.Checkbox(("~o~%s ~s~→ ~y~%s"):format(k, v.name), nil, autorisationTable[v.license].can, { Style = RageUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                            autorisationTable[v.license].can = Checked
                        end, function()
                        end, function()
                        end)
                    end
                end
            end, function()
            end)
            if not shouldStayOpened and menuIsOpened then
                menuIsOpened = false
            end
            Wait(0)
        end
        FreezeEntityPosition(PlayerPedId(), false)
        RMenu:Delete(cat, sub("main"))
        RMenu:Delete(cat, sub("invite"))
        RMenu:Delete(cat, sub("safe"))
        RMenu:Delete(cat, sub("safe_deposit"))
    end)
end)

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end

function CheckQuantity(number)
    number = tonumber(number)

    if type(number) == "number" then
        number = ESX.Math.Round(number)

        if number > 0 then
            return true, number
        end
    end

    return false, number
end