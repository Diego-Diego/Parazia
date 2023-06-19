local pma = exports["pma-voice"]
local currentChannel = 0
local itemCooldown = false
PlayerIsDead = false

AddEventHandler('esx:onPlayerDeath', function()
    PlayerIsDead = true
end)

ParaziaRPMenu = {
    Indexaccesories = 1,
    IndexClothes = 1,
    Indexinvetory = 1,
    IndexVetement = 1,
    Accesoires = 1,
    Indexdoor = 1,
    LimitateurIndex = 1,
    Item = true,
    Weapon = true,
    Radar = true,
    Vetement = true,
    ClesMenu = true,
    AccesoiresMenu = true,
    Report = true,
    ui = true,
    TickRadio = false,
    InfosRadio = false,
    Bruitages = true,
    Statut = "~g~Allumé",
    VolumeRadio = 1,
    jobChannels = {
        {job="police", "sheriff", "ambulance", "correctionnel", "gouvernement", "sheriff", min=1, max=8}
    },

    DoorState = {
        FrontLeft = false,
        FrontRight = false,
        BackLeft = false,
        BackRight = false,
        Hood = false,
        Trunk = false
    },

    voiture_limite = {
        "50 km/h",
        "80 km/h",
        "130 km/h",
        "Personalisée",
        "Désactiver"
    },

    AdemoFaim = 0,
    Soif= 0,
}

function startAnimAction(lib, anim)
	ESX.Streaming.RequestAnimDict(lib, function()
		TaskPlayAnim(plyPed, lib, anim, 8.0, 1.0, -1, 49, 0, false, false, false)
		RemoveAnimDict(lib)
	end)
end
Masque = true 

function GetCurrentWeight()
	local currentWeight = 0
	for i = 1, #ESX.PlayerData.inventory, 1 do
		if ESX.PlayerData.inventory[i].count > 0 then
			currentWeight = currentWeight + (ESX.PlayerData.inventory[i].weight * ESX.PlayerData.inventory[i].count)
		end
	end
	return currentWeight
end

local key = {}
local keyselect = {}

function meskeys()
	key = {}
	ESX.TriggerServerCallback('esx_vehiclelock:allkey', function(mykey)
    	key = mykey
	end)
end

AddEventHandler('esx_newui:updateBasics', function(basics)
	for i = 1, #basics, 1 do
		if basics[i].name == 'hunger' then
			ParaziaRPMenu.Faim = basics[i].percent
		elseif basics[i].name == 'thirst' then
			ParaziaRPMenu.Soif = basics[i].percent
		end
	end
end)

local BillData = {}

openMenuF5 = function()

    local mainf5 = RageUI.CreateMenu("", "ID JOUEUR : ["..GetPlayerServerId(PlayerId()).."]")
    
    --Menu Principaux
    local invetory = RageUI.CreateSubMenu(mainf5, "ParaziaRP", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local keymanage = RageUI.CreateSubMenu(invetory, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local portefeuille = RageUI.CreateSubMenu(mainf5, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local vehicle = RageUI.CreateSubMenu(mainf5, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local vetmenu = RageUI.CreateSubMenu(mainf5, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local radio = RageUI.CreateSubMenu(mainf5, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local diversmenu = RageUI.CreateSubMenu(mainf5, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local pubs = RageUI.CreateSubMenu(mainf5, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")

    local actioninventory = RageUI.CreateSubMenu(invetory, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local gestion = RageUI.CreateSubMenu(mainf5, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local gestionjob = RageUI.CreateSubMenu(gestion, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local gestionjob2 = RageUI.CreateSubMenu(gestion, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local billingmenu = RageUI.CreateSubMenu(portefeuille, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local actionweapon = RageUI.CreateSubMenu(invetory, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local gestionlicense = RageUI.CreateSubMenu(portefeuille, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    local info = RageUI.CreateSubMenu(diversmenu, "", " ID : ["..GetPlayerServerId(PlayerId()).."]")
    mainf5.Closed = function()end 
    radio.EnableMouse = true
    RageUI.Visible(mainf5, not RageUI.Visible(mainf5))

    ESX.TriggerServerCallback("ronflex:getradio", function(cb)
        ParaziaRPMenu.InfosRadio = cb
    end)

    while mainf5 do
        Wait(0)

        RageUI.IsVisible(mainf5, function()

            RageUI.Button("Inventaire", "Accéder à votre inventaire", {LeftBadge = RageUI.BadgeStyle.Star}, true, { 
                onSelected = function()
                    meskeys()
                end
            }, invetory)

            RageUI.Button("Portefeuille", "Votre Portefeuille", {LeftBadge = RageUI.BadgeStyle.Star}, true, {}, portefeuille)

            if IsPedSittingInAnyVehicle(PlayerPedId()) then 
                RageUI.Button('Gestion véhicule', 'Actions sur le véhicule', {LeftBadge = RageUI.BadgeStyle.Star}, true, {}, vehicle)
            end

            RageUI.Button("Vêtements", "Actions sur vos vêtements", {LeftBadge = RageUI.BadgeStyle.Star}, true, {}, vetmenu)

            RageUI.Button("Animation", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {
                onSelected = function()
                    RageUI.CloseAll()
                    ExecuteCommand("emotemenu")
                end
            })

            if ESX.PlayerData.job.grade_name == "boss" or ESX.PlayerData.job2.grade_name == "boss" then
                RageUI.Button("Gestion", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {}, gestion)
            end

            RageUI.Button("Radio", "Accéder à la radio", {LeftBadge = RageUI.BadgeStyle.Star}, ParaziaRPMenu.InfosRadio, {
                onSelected = function()
                end
            }, radio)

            RageUI.Button("Pubs", "Publicités", {LeftBadge = RageUI.BadgeStyle.Star}, true, {}, pubs)

            RageUI.Button("Divers", "Actions diverses", {LeftBadge = RageUI.BadgeStyle.Star}, true, {}, diversmenu)
        
        end, function()
        end)

        RageUI.IsVisible(info, function()
            ESX.PlayerData = ESX.GetPlayerData()

            for i = 1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == 'bank'  then
                    RageUI.Separator('Argent en banque: ~q~'..ESX.PlayerData.accounts[i].money.."$")
                end
            end
			
            for i = 1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == 'cash'  then
                    RageUI.Separator('Argent en liquide: ~g~'..ESX.PlayerData.accounts[i].money.."$")
                end
            end

            for i = 1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == 'dirtycash'  then
                    RageUI.Separator('Argent non déclaré: ~g~'..ESX.PlayerData.accounts[i].money.."$")
                end
            end
            RageUI.Separator("Entreprise : ~q~"..ESX.PlayerData.job.label.."~s~ | Grade : ~q~"..ESX.PlayerData.job.grade_label)
            RageUI.Separator("Organisation : ~b~"..ESX.PlayerData.job2.label.."~s~ | Rang : ~b~"..ESX.PlayerData.job2.grade_label)	

            RageUI.SliderProgress("Faim", ParaziaRPMenu.Faim, 100, nil, {ProgressColor = {R = 0, G = 255, B = 124, A = 200},ProgressBackgroundColor = {R = 255, G = 255, B = 255, A = 200} }, true, {})

            RageUI.SliderProgress("Hydratation", ParaziaRPMenu.Soif, 100, nil, {ProgressColor = {R = 0, G = 212, B = 255, A = 200},ProgressBackgroundColor = {R = 255, G = 255, B = 255, A = 200} }, true, {})

        end, function()
        end)

        RageUI.IsVisible(gestion, function()
            if ESX.PlayerData.job.grade_name == "boss" then 
                RageUI.Button("Gestion Entreprise", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {
                    onSelected = function()
                        RefreshMoney()
                    end
                }, gestionjob)
            end

            if ESX.PlayerData.job2.grade_name == "boss" then 
                RageUI.Button("Gestion Organisation", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {
                    onSelected = function()
                        RefreshMoney2()
                    end
                }, gestionjob2)
            end
        end, function()
        end)

        RageUI.IsVisible(invetory, function()
            ESX.PlayerData = ESX.GetPlayerData()

            RageUI.Separator('Poids > '.. GetCurrentWeight() + 0.0 .. '/' .. ESX.PlayerData.maxWeight + 0.0)

            RageUI.List("Filtre", {"Aucun", "Inventaire", "Armes", "Vetements", "Accesoires", "Cles"}, ParaziaRPMenu.Indexinvetory, nil, {}, true, {
                onListChange = function(index)
                    ParaziaRPMenu.Indexinvetory = index 
                    if index == 1 then 
                        ParaziaRPMenu.Item, ParaziaRPMenu.Weapon, ParaziaRPMenu.Vetement, ParaziaRPMenu.AccesoiresMenu, ParaziaRPMenu.ClesMenu = true, true, true, true, true
                    elseif index == 2 then 
                        ParaziaRPMenu.Item, ParaziaRPMenu.Weapon, ParaziaRPMenu.Vetement, ParaziaRPMenu.AccesoiresMenu, ParaziaRPMenu.ClesMenu = true, false, false, false, false
                    elseif index == 3 then 
                        ParaziaRPMenu.Item, ParaziaRPMenu.Weapon, ParaziaRPMenu.Vetement, ParaziaRPMenu.AccesoiresMenu, ParaziaRPMenu.ClesMenu = false, true, false, false, false
                    elseif index == 4 then 
                        ParaziaRPMenu.Item, ParaziaRPMenu.Weapon, ParaziaRPMenu.Vetement, ParaziaRPMenu.AccesoiresMenu, ParaziaRPMenu.ClesMenu = false, false, true, false, false
                    elseif index == 5 then 
                        ParaziaRPMenu.Item, ParaziaRPMenu.Weapon, ParaziaRPMenu.Vetement, ParaziaRPMenu.AccesoiresMenu, ParaziaRPMenu.ClesMenu = false, false, false, true, false
                    elseif index == 6 then 
                        ParaziaRPMenu.Item, ParaziaRPMenu.Weapon, ParaziaRPMenu.Vetement, ParaziaRPMenu.AccesoiresMenu, ParaziaRPMenu.ClesMenu = false, false, false, false, true
                    end
                end
            })

            if ParaziaRPMenu.Item then 
                if #ESX.PlayerData.inventory > 0 then 
                    RageUI.Separator("↓ Item ↓")
                    for k, v in pairs(ESX.PlayerData.inventory) do 
                        if v.count > 0 then 
                            RageUI.Button("> "..v.label.."", nil,  {RightLabel = "Quantité : ~g~x"..v.count..""}, not itemCooldown, {
                                onSelected = function()
                                    count = v.count 
                                    label  = v.label
                                    name = v.name
                                    remove = v.canRemove
                                    Wait(100)
                                end
                            }, actioninventory)
                        end
                    end
                else
                    RageUI.Separator("~g~Aucun Item")
                end
            end

            if ParaziaRPMenu.Weapon then
                if #ESX.PlayerData.loadout > 0 then 
                    RageUI.Separator("↓ Armes ↓")
                    for i = 1, #ESX.PlayerData.loadout, 1 do
                        local ammo = GetAmmoInPedWeapon(PlayerPedId(), GetHashKey(ESX.PlayerData.loadout[i].name))
                        RageUI.Button("> "..ESX.PlayerData.loadout[i].label, nil, { RightLabel = "Munition(s) : ~g~x"..ammo }, true, {
                            onSelected = function()
                                ammoo = ammo
                                name = ESX.PlayerData.loadout[i].name 
                                label = ESX.PlayerData.loadout[i].label
                                buy = ESX.PlayerData.loadout[i].boutique
                            end
                        }, actionweapon)
                    end
                else
                    RageUI.Separator("~g~Aucune Armes")
                end
            end

            if ParaziaRPMenu.Vetement then 
                if ClothesPlayer ~= nil  then 
                    RageUI.Separator("Vetement")
                    for k, v in pairs(ClothesPlayer) do 
                        if v.label ~= nil and v.type == "vetement" and v.equip ~= "n" then 
                            RageUI.List("> Tenue "..v.label, {"Equiper", "Renomer", "Supprimer", "Donner"}, ParaziaRPMenu.IndexVetement, nil, {}, true, {
                                onListChange = function(Index)
                                    ParaziaRPMenu.IndexVetement = Index
                                end,
                                onSelected = function(Index)
                                    if Index == 1 then 
                                        startAnimAction('clothingtie', 'try_tie_neutral_a')
                                        Wait(1000)
                                        ExecuteCommand("me équipe une tenue")
                                        TriggerEvent("skinchanger:getSkin", function(skin)
                                            TriggerEvent("skinchanger:loadClothes", skin, json.decode(v.skin))
                                        end)
                                        TriggerEvent("skinchanger:getSkin", function(skin)
                                            TriggerServerEvent("esx_skin:save", skin)
                                        end)
                                    elseif Index == 2 then 
                                        local newname = KeyboardInput("Nouveau nom","Nouveau nom", "", 15)
                                        if newname then 
                                            TriggerServerEvent("ewen:RenameTenue", v.id, newname)
                                        end
                                    elseif Index == 3 then 
                                        TriggerServerEvent('ronflex:deletetenue', v.id)
                                    elseif Index == 4 then 
                                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                        if closestDistance ~= -1 and closestDistance <= 3 then
                                            local closestPed = GetPlayerPed(closestPlayer)
                                            TriggerServerEvent("ronflex:donnertenue", GetPlayerServerId(closestPlayer), v.id)
                                            RageUI.CloseAll()
                                        else
                                            ESX.ShowNotification("Personne aux alentours")
                                        end
                                    end
                                end,
                              
                            })
                        end
                    end
                else
                    RageUI.Separator("~g~Aucune Tenue")
                end
            end

            if ParaziaRPMenu.AccesoiresMenu then 
                if ClothesPlayer ~= nil then 
                    RageUI.Separator("Accesoires")
                    if not ClothesPlayer ~= nil then
                        for k, v in pairs(ClothesPlayer) do 
                            if v.label ~= nil and v.type ~= "vetement" then 
                                RageUI.List("> "..v.type..' '..v.label, {"Equiper", "Renomer", "Supprimer", "Donner"}, ParaziaRPMenu.IndexVetement, nil, {}, true, {
                                    onListChange = function(Index)
                                        ParaziaRPMenu.IndexVetement = Index
                                    end,
                                    onSelected = function(Index)
                                        if Index == 1 then 
                                            startAnimAction('clothingtie', 'try_tie_neutral_a')
                                            Wait(1000)
                                            ExecuteCommand("me équipe un "..v.type)
                                            TriggerEvent("skinchanger:getSkin", function(skin)
                                                TriggerEvent("skinchanger:loadClothes", skin, json.decode(v.skin))
                                            end)
                                            TriggerEvent("skinchanger:getSkin", function(skin)
                                                TriggerServerEvent("esx_skin:save", skin)
                                            end)
                                        elseif Index == 2 then 
                                            local newname = KeyboardInput("Nouveau nom","Nouveau nom", "", 15)
                                            if newname then 
                                                TriggerServerEvent("ewen:RenameTenue", v.id, newname)
                                            end
                                        elseif Index == 3 then 
                                            ExecuteCommand("me supprime le/la "..v.type.." ")
                                            TriggerServerEvent('ronflex:deletetenue', v.id)
                                        elseif Index == 4 then 
                                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                                            if closestDistance ~= -1 and closestDistance <= 3 then
                                                local closestPed = GetPlayerPed(closestPlayer)
                                                TriggerServerEvent("ronflex:donnertenue", GetPlayerServerId(closestPlayer), v.id)
                                                RageUI.CloseAll()
                                            else
                                                ESX.ShowNotification("Personne aux alentours")
                                            end
                                        end
                                    end
                                })
                            end
                        end
                    end
                else
                    RageUI.Separator("~g~Aucun Accésoire")
                end
            end

            if ParaziaRPMenu.ClesMenu then
                RageUI.Separator("Mes Cles")
                for k,v in pairs(key) do
                    RageUI.Button('Clé du véhicule', nil, {RightLabel = '[~q~'..v.plate..'~s~]'}, true, {
                        onSelected = function()
                            keyselect = v
                        end
                    }, keymanage)
                end
            end

        end, function()
        end)

        RageUI.IsVisible(keymanage, function()
            local player, distance = ESX.Game.GetClosestPlayer()

            RageUI.Button('Préter', nil, {RightLabel = ""}, true, {
                onSelected = function()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('garage:GiveTemporyKey', GetPlayerServerId(player), keyselect.plate)
                        print(keyselect.plate)
                        RageUI.CloseAll()
                    end
                end
            })

            RageUI.Button('Jeter', nil, {RightLabel = ""}, true, {
                onSelected = function()
                    TriggerServerEvent('garage:DeleteKey', keyselect.plate)
                    print(keyselect.plate)
                    RageUI.CloseAll()
                end
            })

        end, function()
        end)

        RageUI.IsVisible(portefeuille, function()

            local player, closestplayer = ESX.Game.GetClosestPlayer()

            RageUI.Separator('[Information Compte]')

            for i = 1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == 'bank'  then
                    RageUI.Button('Argent en banque: ~q~'..ESX.PlayerData.accounts[i].money.."$", nil, {RightLabel = ""}, true, {})
                end
            end
			
            for i = 1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == 'cash'  then
                    RageUI.Button('Argent en liquide: ~g~'..ESX.PlayerData.accounts[i].money.."$", nil, {RightLabel = ""}, true, {
                        onActive = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance ~= -1 and closestDistance <= 3 then
                                PlayerMakrer(closestPlayer)
                            end
                        end,
                        onSelected = function()
                            local check, quantity = CheckQuantity(KeyboardInput("Nombres d'argent que vous voulez donner", '', '', 100))
                            if check then 
                                local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

                                if closestDistance ~= -1 and closestDistance <= 3 then
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    if not IsPedSittingInAnyVehicle(closestPed) then
                                        TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_account', "cash", quantity)
                                        RageUI.GoBack()
                                    else
                                        ESX.ShowNotification("~g~Vous ne pouvez pas faire ceci dans un véhicule !")
                                    end
                                else
                                    ESX.ShowNotification('Aucun joueur proche !')
                                end
                            else
                                ESX.ShowNotification("Arguments Inssufisant")
                            end
                        end
                    })
                end
            end

            for i = 1, #ESX.PlayerData.accounts, 1 do
                if ESX.PlayerData.accounts[i].name == 'dirtycash'  then
                    RageUI.Button('Argent non déclaré: ~g~'..ESX.PlayerData.accounts[i].money.."$", nil, {RightLabel = ""}, true, {
                        onActive = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            if closestDistance ~= -1 and closestDistance <= 3 then
                                PlayerMakrer(closestPlayer)
                            end
                        end,
                        onSelected = function()
                            local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                            local check, quantity = CheckQuantity(KeyboardInput("Nombres d'argent que vous voulez donner", '', '', 100))
                            if check then 
                                if closestDistance ~= -1 and closestDistance <= 3 then
                                    local closestPed = GetPlayerPed(closestPlayer)
                                    if not IsPedSittingInAnyVehicle(closestPed) then
                                        TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_account', "dirtycash", quantity)
                                        RageUI.GoBack()
                                    else
                                        ESX.ShowNotification("~g~Vous ne pouvez pas faire ceci dans un véhicule !")
                                    end
                                else
                                    ESX.ShowNotification('Aucun joueur proche !')
                                end
                            else
                                ESX.ShowNotification("Arguments Inssufisant")
                            end
                        end
                    })
                end
            end
			
            RageUI.Button("> Accéder à vos factures", nil, {RightLabel = ">"}, true, {
                onSelected = function()
                    ESX.TriggerServerCallback('ewen:getFactures', function(bills) BillData = bills end)
                end
            }, billingmenu)

            RageUI.Separator("[Information Personnelles]")

            RageUI.Button("> Gestion License", nil, {RightLabel = ">"}, true, {}, gestionlicense)

        end, function()
        end)

        RageUI.IsVisible(vehicle, function()

            local pVeh = GetVehiclePedIsUsing(PlayerPedId())

            RageUI.Button("Allumer / Eteindre le moteur", nil, {RightLabel = ParaziaRPMenu.Statut}, true, {
                onSelected = function()
                    if GetIsVehicleEngineRunning(pVeh) then
                        ParaziaRPMenu.Statut = "~g~Eteint"

                        SetVehicleEngineOn(pVeh, false, false, true)
                        SetVehicleUndriveable(pVeh, true)
                    elseif not GetIsVehicleEngineRunning(pVeh) then
                        ParaziaRPMenu.Statut = "~g~Allumé"

                        SetVehicleEngineOn(pVeh, true, false, true)
                        SetVehicleUndriveable(pVeh, false)
                    end
                end
            })

            RageUI.List("Ouvrir / Fermer porte", {"Avant gauche", "Avant Droite", "Arrière Gauche", "Arrière Droite", "Capot", "Coffre"}, ParaziaRPMenu.Indexdoor, nil, {}, true, {
                onListChange = function(index)
                    ParaziaRPMenu.Indexdoor = index 
                end,
                onSelected = function(index)
                    
                    if index == 1 then
                        if not ParaziaRPMenu.DoorState.FrontLeft then
                            ParaziaRPMenu.DoorState.FrontLeft = true
                            SetVehicleDoorOpen(pVeh, 0, false, false)
                        elseif ParaziaRPMenu.DoorState.FrontLeft then
                            ParaziaRPMenu.DoorState.FrontLeft = false
                            SetVehicleDoorShut(pVeh, 0, false, false)
                        end
                    elseif index == 2 then
                        if not ParaziaRPMenu.DoorState.FrontRight then
                            ParaziaRPMenu.DoorState.FrontRight = true
                            SetVehicleDoorOpen(pVeh, 1, false, false)
                        elseif ParaziaRPMenu.DoorState.FrontRight then
                            ParaziaRPMenu.DoorState.FrontRight = false
                            SetVehicleDoorShut(pVeh, 1, false, false)
                        end
                    elseif index == 3 then
                        if not ParaziaRPMenu.DoorState.BackLeft then
                            ParaziaRPMenu.DoorState.BackLeft = true
                            SetVehicleDoorOpen(pVeh, 2, false, false)
                        elseif ParaziaRPMenu.DoorState.BackLeft then
                            ParaziaRPMenu.DoorState.BackLeft = false
                            SetVehicleDoorShut(pVeh, 2, false, false)
                        end
                    elseif index == 4 then
                        if not ParaziaRPMenu.DoorState.BackRight then
                            ParaziaRPMenu.DoorState.BackRight = true
                            SetVehicleDoorOpen(pVeh, 3, false, false)
                        elseif ParaziaRPMenu.DoorState.BackRight then
                            ParaziaRPMenu.DoorState.BackRight = false
                            SetVehicleDoorShut(pVeh, 3, false, false)
                        end
                    elseif index == 5 then 
                        if not ParaziaRPMenu.DoorState.Hood then
                            ParaziaRPMenu.DoorState.Hood = true
                            SetVehicleDoorOpen(pVeh, 4, false, false)
                        elseif ParaziaRPMenu.DoorState.Hood then
                            ParaziaRPMenu.DoorState.Hood = false
                            SetVehicleDoorShut(pVeh, 4, false, false)
                        end
                    elseif index == 6 then 
                        if not ParaziaRPMenu.DoorState.Trunk then
                            ParaziaRPMenu.DoorState.Trunk = true
                            SetVehicleDoorOpen(pVeh, 5, false, false)
                        elseif ParaziaRPMenu.DoorState.Trunk then
                            ParaziaRPMenu.DoorState.Trunk = false
                            SetVehicleDoorShut(pVeh, 5, false, false)
                        end
                    end
                end
            })

            RageUI.Button("Fermer toutes les portes", nil, {RightLabel =  ">"}, true, {
                onSelected = function ()
                    for door = 0, 7 do
                        SetVehicleDoorShut(pVeh, door, false)
                    end
                end
            })

            RageUI.List("Limitateur", ParaziaRPMenu.voiture_limite, ParaziaRPMenu.LimitateurIndex, nil, {}, true, {
                onListChange = function(i, item)
                    ParaziaRPMenu.LimitateurIndex = i
                end,

                onSelected = function(i, item)
                    if i == 1 then
                        SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 50.0/3.6)
                        ESX.ShowNotification("Limitateur de vitesse défini sur ~q~50 km/h")
                    elseif i == 2 then  
                        SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 80.0/3.6)
                        ESX.ShowNotification("Limitateur de vitesse défini sur ~q~80 km/h")
                    elseif i == 3  then
                        SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 130.0/3.6)
                        ESX.ShowNotification("Limitateur de vitesse défini sur ~q~130 km/h")
                    elseif i == 4 then
                        local speed = KeyboardInput("Indiquer la vitesse", "Indiquer la viteese", "", 10)
                        if speed ~= nil or speed ~= tostring("") then 
                            SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), ESX.Math.Round(speed, 1)/3.6)
                            ESX.ShowNotification("Limitateur de vitesse défini sur ~q~"..speed..'km/h')
                        else
                            return
                        end
                    elseif i == 5 then 
                        SetEntityMaxSpeed(GetVehiclePedIsIn(PlayerPedId(), false), 10000.0/3.6)    
                        ESX.ShowNotification("Limitateur de vitesse désactivé")
                    end
                end
            })

   
        
        end, function()
        end)

        RageUI.IsVisible(vetmenu, function()

            RageUI.List(" Vetement", {"Haut", "Bas", "Chaussures", "Sac", "Giltet par balle"}, ParaziaRPMenu.IndexClothes, nil, {LeftBadge = RageUI.BadgeStyle.Clothes}, true, {
                onListChange = function(index)
                    ParaziaRPMenu.IndexClothes = index 
                end, 
                onSelected = function(index)
                    ESX.TriggerServerCallback("esx_skin:getPlayerSkin", function(skin)
                        TriggerEvent("skinchanger:getSkin", function(skina)
                            if index == 1 then 
                                if skin.torso_1 ~= skina.torso_1 then
                                    ExecuteCommand("me remet son Haut")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["torso_1"] = skin.torso_1, ["torso_2"] = skin.torso_2, ["tshirt_1"] = skin.tshirt_1, ["tshirt_2"] = skin.tshirt_2, ["arms"] = skin.arms })
                                else
                                    ExecuteCommand("me retire son Haut")
                                    if skin.sex == 0 then
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["torso_1"] = 15, ["torso_2"] = 0, ["tshirt_1"] = 15, ["tshirt_2"] = 0, ["arms"] = 15 })
                                    else
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["torso_1"] = 15, ["torso_2"] = 0, ["tshirt_1"] = 15, ["tshirt_2"] = 0, ["arms"] = 15 })
                                    end
                                end
                            elseif index == 2 then 
                                if skin.pants_1 ~= skina.pants_1 then
                                    ExecuteCommand("me remet son Pantalon")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["pants_1"] = skin.pants_1, ["pants_2"] = skin.pants_2 })
                                else
                                    ExecuteCommand("me retire son Pantalon")
                                    if skin.sex == 0 then
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["pants_1"] = 21, ["pants_2"] = 0 })
                                    else
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["pants_1"] = 15, ["pants_2"] = 0 })
                                    end
                                end
                            elseif index == 3 then 
                                if skin.shoes_1 ~= skina.shoes_1 then
                                    ExecuteCommand("me remet ses Chaussures")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["shoes_1"] = skin.shoes_1, ["shoes_2"] = skin.shoes_2 })
                                else
                                    if skin.sex == 0 then
                                        ExecuteCommand("me enlève ses Chaussures")
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["shoes_1"] = 34, ["shoes_2"] = 0 })
                                    else
                                        TriggerEvent("skinchanger:loadClothes", skina, { ["shoes_1"] = 35, ["shoes_2"] = 0 })
                                    end
                                end
                            elseif index == 4 then
                                if skin.bags_1 ~= skina.bags_1 then
                                    ExecuteCommand("me retire son Sac")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["bags_1"] = skin.bags_1, ["bags_2"] = skin.bags_2 })
                                else
                                    ExecuteCommand("me retire son Sac")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["bags_1"] = 0, ["bags_2"] = 0 })
                                end
                            elseif index == 5 then 
                                if skin.bproof_1 ~= skina.bproof_1 then
                                    ExecuteCommand("me retire son Gilet par balle")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["bproof_1"] = skin.bproof_1, ["bproof_2"] = skin.bproof_2 })
                                else
                                    ExecuteCommand("me retire son Gilet par balle")
                                    TriggerEvent("skinchanger:loadClothes", skina, { ["bproof_1"] = 0, ["bproof_2"] = 0 })
                                end
                            end
                        end)
                    end)
                end
            })

            RageUI.List(' Accesoires', {"Masque","Chapeau", "Lunette", "Boucle d'oreilles", "Chaine"}, ParaziaRPMenu.Indexaccesories, nil, {LeftBadge = RageUI.BadgeStyle.Mask}, true, {
                onListChange = function(Index)
                    ParaziaRPMenu.Indexaccesories = Index;
                end,

                onSelected = function(Index)
                    if Index == 1 then
                        Wait(250)
                        setAccess('mask', plyPed)
                    elseif Index == 2 then
                        Wait(250)
                        setAccess('helmet', plyPed)
                    elseif Index == 3 then
                        Wait(250)
                        setAccess('glasses', plyPed)
                    elseif Index == 4 then
                        Wait(250)
                        setAccess('ears', plyPed)
                    elseif Index == 5 then
                        Wait(250)
                        setAccess('chain', plyPed)
                    end
                end
            })

        end, function()
        end)

        RageUI.IsVisible(radio, function()

            RageUI.Button("Allumer / Eteindre", "Vous permet d'allumer ou d'éteindre la radio", {RightLabel = ">"}, true, {
                onSelected = function()
                    if not ParaziaRPMenu.TickRadio then 
                        ParaziaRPMenu.TickRadio = true 
                        pma:setVoiceProperty("radioEnabled", true)
                        ESX.ShowNotification("Radio Allumé !")
                    else
                        ParaziaRPMenu.TickRadio = false
                        pma:setRadioChannel(0)
                        pma:setVoiceProperty("radioEnabled", false)
                        ESX.ShowNotification("Radio Eteinte !")
                    end
                end
            })

            if ParaziaRPMenu.TickRadio then
                RageUI.Separator("Radio: ~g~Allumée")

                if ParaziaRPMenu.Bruitages then 
                    RageUI.Separator("Bruitages: ~g~Activés")
                else
                    RageUI.Separator("Bruitages: ~g~Désactivés")
                end

                if ParaziaRPMenu.VolumeRadio*100 <= 20 then 
                    ColorRadio = "~g~" 
                elseif ParaziaRPMenu.VolumeRadio*100 <= 45 then 
                    ColorRadio ="~y~" 
                elseif ParaziaRPMenu.VolumeRadio*100 <= 65 then 
                    ColorRadio ="~o~" 
                elseif ParaziaRPMenu.VolumeRadio*100 <= 100 then 
                    ColorRadio ="~g~" 
                end 

                RageUI.Separator("Volume: "..ColorRadio..ESX.Math.Round(ParaziaRPMenu.VolumeRadio*100).."~s~ %")

                RageUI.Button("Se connecter à une fréquence ", "Choissisez votre fréquence", {RightLabel = ParaziaRPMenu.Frequence}, true, {
                    onSelected = function()
                                local verif, Frequence = CheckQuantity(KeyboardInput("Frequence", "Frequence", "", 10))
                                local PlayerData = ESX.GetPlayerData(_source)
                                local restricted = {}
                                
                                if Frequence > 500 then
                                    return
                                end
                                
                                for i,v in pairs(ParaziaRPMenu.jobChannels) do
                                    if Frequence >= v.min and Frequence <= v.max then
                                        table.insert(restricted, v)
                                    end
                                end
                            
                                if #restricted > 0 then
                                    for i,v in pairs(restricted) do
                                        if PlayerData.job.name == v.job and Frequence >= v.min and Frequence <= v.max then
                                            ParaziaRPMenu.Frequence = tostring(Frequence)
                                            pma:setRadioChannel(Frequence)
                                            ESX.ShowNotification("Fréquence définie sur "..Frequence.." MHZ")
                                            currentChannel = Frequence
                                            break
                                        elseif i == #restricted then
                                            ESX.ShowNotification('Echec de la connexion a la fréquence')
                                            break
                                        end
                                    end
                                else
                                    ParaziaRPMenu.Frequence = tostring(Frequence)
                                    pma:setRadioChannel(Frequence)
                                    ESX.ShowNotification("Fréquence définie sur "..Frequence.." MHZ")
                                    currentChannel = Frequence
                                end
                    end
                })

                RageUI.Button("Se déconnecter de la fréquence", "Vous permet de déconnecter de votre fréquence actuelle", {RightLabel = ">"}, true, {
                    onSelected = function()
                        pma:setRadioChannel(0)
                        ParaziaRPMenu.Frequence = "0"
                        ESX.ShowNotification("Vous vous êtes déconnecter de la fréquence")
                    end
                })

                RageUI.Button("Activer les bruitages", "Vous permet d'activer les bruitages'", {RightLabel = ">"}, true, {
                    onSelected = function()
                        if ParaziaRPMenu.Bruitages then 
                            ParaziaRPMenu.Bruitages = false
                            pma:setVoiceProperty("micClicks", false)
                            ESX.ShowNotification("Bruitages radio désactives")
                        else
                            ParaziaRPMenu.Bruitages = true 
                            ESX.ShowNotification("Bruitages radio activés")
                            pma:setVoiceProperty("micClicks", true)
                        end
                    end
                })
            else
                RageUI.Separator("Radio: ~g~Eteinte")
            end

        end, function()
            RageUI.PercentagePanel(ParaziaRPMenu.VolumeRadio, 'Volume', '0%', '100%', {
                onProgressChange = function(Percentage)
                    ParaziaRPMenu.VolumeRadio = Percentage
                    pma:setRadioVolume(Percentage)
                end
            }, 5) 
        end)

        RageUI.IsVisible(pubs, function()

         --   RageUI.Button("Twt", nil, {RightLabel = ">"}, false, {
         --       onSelected = function()
         --          local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', '', 50)
         --           if message ~= nil and message ~= "" then
         --             TriggerServerEvent('Twt', message)
         --           end
         --       end
         --  })

         --   RageUI.Button("Twt Anonyme", nil, {RightLabel = ">"}, false, {
         --       onSelected = function()
         --          local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', '', 50)
         --           if message ~= nil and message ~= "" then
         --               TriggerServerEvent('Ano', message)
         --           end
         --       end
         --   })

        --if (ESX.PlayerData.job and ESX.PlayerData.job.name ~= 'unemployed') then
        --    RageUI.Button("Pub entreprise", nil, {RightLabel = ">"}, true, {
        --        onSelected = function()
        --            local info = 'Entreprise'
        --            local message = KeyboardInput('Veuillez mettre le messsage à envoyer', '', '', 50)
        --            if message ~= nil and message ~= "" then
        --                TriggerServerEvent('Entreprise', message)
        --            end
        --        end
        --    })
        --end

        end, function()
        end)

        RageUI.IsVisible(diversmenu, function()

            RageUI.Button("Information", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {}, info)
            RageUI.Button("Rockstar Editor", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {
                onSelected = function()
                    OpenRockstarMenu()
                end
            })

            RageUI.Button("Gestion Interface", nil, {LeftBadge = RageUI.BadgeStyle.Star}, true, {
                onSelected = function()
                    RageUI.CloseAll()
                    ExecuteCommand("hud")
                end
            })

            RageUI.Checkbox("Activer le radar", "Vous permet d'activer ou de désactiver la minimap", ParaziaRPMenu.Radar, {}, {
                onChecked = function()
                end,
                onUnChecked = function()
                end,
                onSelected = function(Index)
                    DisplayRadar(ParaziaRPMenu.Radar)
                    ParaziaRPMenu.Radar = Index
                end
                
            })

            RageUI.Checkbox('Mode cinématique', nil, cinemamode, {}, {
                onChecked = function()
                    ExecuteCommand('noir')
                    cinemamode = true
                end,
                onUnChecked = function()
                    ExecuteCommand('noir')
                    cinemamode = false
                end,
            })

            RageUI.Checkbox('Mode drift', nil, driftmode, {}, {
                onChecked = function()
                    driftmode = not driftmode
                end,
                onUnChecked = function()
                    driftmode = false
                end,
                onSelected = function(Index)
                    driftmode = Index
                end
            })

            RageUI.Checkbox('Mode Vente de Drogue', nil, DispoVente, {}, {
                onChecked = function()
                    DispoVente = true
                end,
                onUnChecked = function()
                    DispoVente = false
                end,
                onSelected = function(Index)
                    DispoVente = Index
                end
            })

            RageUI.Checkbox('Désactiver les coups de crosse', nil, coupCrosse, {}, {
                onChecked = function()
                    Citizen.CreateThread(function()
                        while coupCrosse do
                            Citizen.Wait(0)
                            local ped = PlayerPedId()
                            if IsPedArmed(ped, 6) then
                                DisableControlAction(1, 140, true)
                                DisableControlAction(1, 141, true)
                                DisableControlAction(1, 142, true)
                            end
                        end
                    end)
                end,
                onUnChecked = function()
                    coupCrosse = false
                end,
                onSelected = function(Index)
                    coupCrosse = Index
                end
            })

        end, function()
        end)
        
        RageUI.IsVisible(gestionjob, function()
        
            if ESX.PlayerData.job.grade_name == "boss" then 

                if societymoney ~= nil then
                    RageUI.Separator("Argent dans la société : ~q~"..societymoney.."$")
                end

                RageUI.Separator("[Entreprise]")

                RageUI.Button("Recruter un employé", nil, {RightLabel = ">"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_recruterplayer", GetPlayerServerId(closestPlayer), ESX.PlayerData.job.name)
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Virer un employé", nil, {RightLabel = ">"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_virerplayer", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Promouvroir un employé", nil, {RightLabel = ">"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_promouvoirplayer", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Rétrograder un employé", nil, {RightLabel = ">"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_destituerplayer", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })
            end
        end, function()
        end)


        RageUI.IsVisible(gestionjob2, function()

            if ESX.PlayerData.job2.grade_name == "boss" then 

                if societymoney2 ~= nil then
                    RageUI.Separator("Argent dans le coffre~s~ : ~q~"..societymoney2.."$")
                end

                RageUI.Separator("[Organisation]")

                RageUI.Button("Recruter un employé", nil, {RightLabel = ">"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_recruterplayer2", GetPlayerServerId(closestPlayer), ESX.PlayerData.job2.name)
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Virer un employé", nil, {RightLabel = ">"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_virerplayer2", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Promouvroir un employé", nil, {RightLabel = ">"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_promouvoirplayer2", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })

                RageUI.Button("Rétrograder un employé", nil, {RightLabel = ">"}, true, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end, 
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            TriggerServerEvent("KorioZ-PersonalMenu:Boss_destituerplayer2", GetPlayerServerId(closestPlayer))
                        else
                            ESX.ShowNotification("Aucun joueur à proximité")
                        end
                    end
                })
            end

        end, function()
        end)

        RageUI.IsVisible(actioninventory, function()

            RageUI.Separator("Nom : ~q~"..tostring(label).." ~s~/ Quantité : ~g~"..tostring(count).."")

            RageUI.Button("> Utilser", nil, {RightLabel = ">"}, not itemCooldown, {
                onSelected = function()
                    itemCooldown = true
                    typee = "use"
                    TriggerServerEvent('esx:useItem', name)
                    ExecuteCommand("me utilise x1 "..label)
                    count = count - 1
                    if count < 0 then 
                        RageUI.GoBack()
                    end
                    Citizen.SetTimeout(1500, function() itemCooldown = false end)
                end
            })

            RageUI.Button("> Donner", nil, {RightLabel = ">"}, not itemCooldown, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        PlayerMakrer(closestPlayer)
                    end
                end,
                onSelected = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    local check, quantity = CheckQuantity(KeyboardInput("", "Indiquer le nombre à donner", "", 20))
                    if check then 
                        local closestPed = GetPlayerPed(closestPlayer)
                        if tonumber(quantity) > tonumber(count) then 
                            ESX.ShowNotification('Vous n\'en n\'avez pas asser')
                        else
                            --if not ESX.ContribItem(name) then 
                                itemCooldown = true
                                TriggerServerEvent('esx:giveInventoryItem', GetPlayerServerId(closestPlayer), 'item_standard', name, quantity)
                                ExecuteCommand("me donne un/une "..label.." à la personne")
                                RageUI.GoBack()
                                Citizen.SetTimeout(1500, function() itemCooldown = false end)
                            --else
                                --ESX.ShowNotification('Vous ne pouvez pas donner cette objets')
                            --end
                        end
                    else
                        ESX.ShowNotification('Arguments Manquants !')
                    end
                end
            })
            
        end , function()
        end)

        RageUI.IsVisible(actionweapon, function()
            RageUI.Separator("Nom : ~q~"..tostring(label).." ~s~/ Balles : ~g~"..tostring(ammoo).."")

            --if PermanantWeapon[name] ~= nil then 
                --RageUI.Separator("Vous ne pouvez pas donner cette arme")

            --else
                RageUI.Button("> Donner", nil, {RightLabel = ">"}, not buy, {
                    onActive = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            PlayerMakrer(closestPlayer)
                        end
                    end,
                    onSelected = function()
                        local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
    
                        if closestDistance ~= -1 and closestDistance <= 3 then
                            local closestPed = GetPlayerPed(closestPlayer)
                            TriggerServerEvent("esx:giveInventoryItem", GetPlayerServerId(closestPlayer), "item_weapon", name, nil)
                            RageUI.CloseAll()
                        else
                            ESX.ShowNotification("Personne aux alentours")
                        end
                    end
                })
            --end

        end, function()
        end)

        RageUI.IsVisible(billingmenu, function()
            if #BillData ~= 0 then
                for i = 1, #BillData, 1 do
                    RageUI.Button(BillData[i].label, nil, {RightLabel = '$' .. ESX.Math.GroupDigits(BillData[i].amount)}, true, {
                        onSelected = function()
                        ESX.TriggerServerCallback('esx_billing:payBill', function()
                            RageUI.GoBack()
                        end, BillData[i].id)
                    end})
                end
            else
                RageUI.Separator('~g~')
                RageUI.Separator('~g~Vous n\'avez pas de facture')
                RageUI.Separator('~g~')
            end
        end, function()
        end)
        
        RageUI.IsVisible(gestionlicense, function()

            RageUI.Separator("~q~↓ Carte D'identité ↓")
            
            RageUI.Button("> Montrer sa carte d'identité", nil, {RightLabel = '>'}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        PlayerMakrer(closestPlayer)
                    end
                end,
                onSelected = function()
                    ExecuteCommand('dikorgive')
                end
            })

            RageUI.Button("> Regarder sa carte d'identité", nil, {RightLabel = ">"}, true, {
                onSelected = function()
                    ExecuteCommand('dikorfdp')
                end
            })
        

            RageUI.Separator("~q~↓ Permis port d'arme(s) ↓")
            RageUI.Button("> Montrer son ppa", nil, {RightLabel = '>'}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        PlayerMakrer(closestPlayer)
                    end
                end,
                onSelected = function()
                    ExecuteCommand('dikorgive arms')
                end
            })

            RageUI.Button("> Regarder son ppa", nil, {RightLabel = ">"}, true, {
                onSelected = function()
                    ExecuteCommand('dikorfdp arms')
                end
            })

            RageUI.Separator("~q~↓ Permis conduire ↓")
            RageUI.Button("> Montrer son permis de conduire", nil, {RightLabel = '>'}, true, {
                onActive = function()
                    local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()
                    if closestDistance ~= -1 and closestDistance <= 3 then
                        PlayerMakrer(closestPlayer)
                    end
                end,
                onSelected = function()
                    ExecuteCommand('dikorgive driver')
                end
            })

            RageUI.Button("> Regarder son permis de conduire", nil, {RightLabel = ">"}, true, {
                onSelected = function()
                    ExecuteCommand('dikorfdp driver')
                end
            })
        end, function()
        end)

        if not RageUI.Visible(mainf5) and 
        not RageUI.Visible(info) and
        not RageUI.Visible(invetory) and 
        not RageUI.Visible(portefeuille) and 
        not RageUI.Visible(vetmenu) and 
        not RageUI.Visible(vehicle) and
        not RageUI.Visible(radio) and
        not RageUI.Visible(pubs) and 
        not RageUI.Visible(diversmenu) and 
        not RageUI.Visible(keymanage) and 
        not RageUI.Visible(actioninventory) and 
        not RageUI.Visible(gestion) and
        not RageUI.Visible(gestionjob) and
        not RageUI.Visible(gestionjob2) and 
        not RageUI.Visible(billingmenu) and 
        not RageUI.Visible(actionweapon) and 
        not RageUI.Visible(gestionlicense) and
        not RageUI.Visible(anims) and
        not RageUI.Visible(props) then
            mainf5 = RMenu:DeleteType("mainf5")
        end
    end
end


Keys.Register("F5", "Menu_Interacion", "Menu F5", function()
    if not PlayerIsDead then 
        openMenuF5()
    end
end)

Citizen.CreateThread(function()
    while true do 
        Wait(5000)
        TriggerEvent("skinchanger:getSkin", function(skin)
            if skin.bags_1 == 0 then
                if ESX.PlayerData.maxWeight ~= 24 then 
                    TriggerServerEvent('ewen:ChangeWeightInventory', 24)
                end
            else
                if ESX.PlayerData.maxWeight ~= 40 then 
                    TriggerServerEvent('ewen:ChangeWeightInventory', 40)
                end
            end
        end)
        if GetCurrentWeight() > ESX.PlayerData.maxWeight then
            DrawMissionText('~q~Vous êtes trop lourd, Vous ne pouver plus courrir', 5000)
            DisableControlAction(0, 22, true)
            DisableControlAction(0, 21, true)
        end
    end
end)

local NoCourir = false
Citizen.CreateThread(function()
    while true do 
        Wait(5000)
        TriggerEvent("skinchanger:getSkin", function(skin)
            if skin.bags_1 == 0 then
                if ESX.PlayerData.maxWeight ~= 24 then 
                    TriggerServerEvent('ewen:ChangeWeightInventory', 24)
                end
            else
                if ESX.PlayerData.maxWeight ~= 40 then 
                    TriggerServerEvent('ewen:ChangeWeightInventory', 40)
                end
            end
        end)
        if GetCurrentWeight() > ESX.PlayerData.maxWeight then
            DrawMissionText('~q~Vous êtes trop lourd, Vous ne pouver plus courrir', 5000)
            NoCourir = true
        else 
            NoCourir = false
        end
    end
end)

Citizen.CreateThread(function()
	while true do
		if NoCourir then
			Citizen.Wait(10)
		else
			Wait(5000)
		end

		if NoCourir then
			DisableControlAction(0, 21, true) -- INPUT_SPRINT
			DisableControlAction(0, 22, true) -- INPUT_JUMP
			DisableControlAction(0, 24, true) -- INPUT_ATTACK
			DisableControlAction(0, 44, true) -- INPUT_COVER
			DisableControlAction(0, 45, true) -- INPUT_RELOAD
			DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
			DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
			DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
			DisableControlAction(0, 143, true) -- INPUT_MELEE_BLOCK
			DisableControlAction(0, 144, true) -- PARACHUTE DEPLOY
			DisableControlAction(0, 145, true) -- PARACHUTE DETACH
			DisableControlAction(0, 243, true) -- INPUT_ENTER_CHEAT_CODE
			DisableControlAction(0, 257, true) -- INPUT_ATTACK2
			DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
			DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
			DisableControlAction(0, 73, true) -- INPUT_X
		end
	end
end)


personal = {
    pedId = function()
        return PlayerPedId()
    end,

    headingped = function()
        return GetEntityHeading(personal.pedId())
    end
}

local PlayerProps = {}

Sotek = {
	pointing = false,
	handsUp = false,
	crouched = false
}

--Bouton pour les anims
function renderanim(label,desc, value, anim,loop)
    RageUI.Button(label, "/e ~q~"..desc, {RightLabel = ""}, true, {
        onSelected = function()
            DestroyAllProps()
            Sotek.handsUp = false

            startAnim(value, anim,loop)
        end
    })
end

function renderanimoneprops(label,desc, value, anim,loop, name,bone,PropPlacement)
    RageUI.Button(label, "/e ~q~"..desc, {RightLabel = "(props)"}, true, {
        onSelected = function()
            DestroyAllProps()
            Sotek.handsUp = false

            local PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(PropPlacement)
            
            AddPropToPlayer(name, bone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 )
            startAnim(value, anim,loop)
        end
    })
end

function renderanimtwoprops(label,desc, value, anim,loop, name,bone,PropPlacement,name2,bone2, SecondPlacement)
    RageUI.Button(label, "/e ~q~"..desc, {RightLabel = ""}, true, {
        onSelected = function()
            DestroyAllProps()
            Sotek.handsUp = false
            local PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(PropPlacement)
            local SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6 = table.unpack(SecondPlacement)
            AddPropToPlayer(name, bone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 )
            AddPropToPlayer(name2, bone2, SecondPropPl1, SecondPropPl2, SecondPropPl3, SecondPropPl4, SecondPropPl5, SecondPropPl6)

            startAnim(value, anim,loop)
        end
    })
end

function renderscenario(label,desc, anim)
RageUI.Button(label, "/e ~q~"..desc, {RightLabel = ""}, true, {
    onSelected = function()
        DestroyAllProps()
        Sotek.handsUp = false
        startScenario(anim)
    end
})
end

function renderscenario2(label,desc, anim)
RageUI.Button(label, "/e ~q~"..desc, {RightLabel = ""}, true, {
    onSelected = function()
        DestroyAllProps()
        startScenario2(anim)
    end
})
end

function renderanimonePtfs(label,desc, value, anim,loop, name,bone,PropPlacement, name3,asset,PtfxPlacement)
	RageUI.Button(label, "/e ~q~"..desc, {RightLabel = ""}, true, {
		onSelected = function()
			Ptfx = true	 	
			DestroyAllProps()
			ESX.ShowNotification('Appuyer  ~y~ G ~s~sur utiliser l\'attaque spécial.')
			Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, PtfxScale = table.unpack(PtfxPlacement)
			PtfxAsset = asset
			PtfxName = name3
			PtfxPrompt = true
			PtfxThis(PtfxAsset)
			PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 = table.unpack(PropPlacement)
			AddPropToPlayer(name, bone, PropPl1, PropPl2, PropPl3, PropPl4, PropPl5, PropPl6 )
			startAnim(value, anim,loop)
		end
	})
end

function PtfxStart()
    if PtfxNoProp then
      PtfxAt = PlayerPedId()
    else
      PtfxAt = prop
    end
    UseParticleFxAssetNextCall(PtfxAsset)
    Ptfx = StartNetworkedParticleFxLoopedOnEntityBone(PtfxName, PtfxAt, Ptfx1, Ptfx2, Ptfx3, Ptfx4, Ptfx5, Ptfx6, GetEntityBoneIndexByName(PtfxName, "VFX"), 1065353216, 0, 0, 0, 1065353216, 1065353216, 1065353216, 0)
    SetParticleFxLoopedColour(Ptfx, 1.0, 1.0, 1.0)
    table.insert(PlayerParticles, Ptfx)
end

function PtfxStop()
	for a,b in pairs(PlayerParticles) do
	  StopParticleFxLooped(b, false)
	  table.remove(PlayerParticles, a)
	end
end

function PtfxThis(asset)
	while not HasNamedPtfxAssetLoaded(asset) do
	  RequestNamedPtfxAsset(asset)
	  Wait(10)
	end
	UseParticleFxAssetNextCall(asset)
end

function FPtfx()
	Citizen.CreateThread(function()
		while Ptfx do	
		  if PtfxPrompt then
			if IsControlPressed(1, 47) then
			  PtfxStart()
			  Wait(300)
			  PtfxStop()
			end
		  end
		  Citizen.Wait(1)
		end
	end)
end

function renderwalk(label,value)
    RageUI.Button(label, false, {RightLabel = ""}, true, {
        onSelected = function()
            Sotek.handsUp = false
            startAttitude(value)
        end
    })
end

function LoadPropDict(model)
    while not HasModelLoaded(GetHashKey(model)) do
        RequestModel(GetHashKey(model))
        Wait(10)
    end
end
      
function DestroyAllProps()
    for _,v in pairs(PlayerProps) do
        DeleteEntity(v)
    end
    PlayerHasProp = false
end

function AddPropToPlayer(prop1, bone, off1, off2, off3, rot1, rot2, rot3)
    local Player = personal.pedId()
    local x,y,z = table.unpack(GetEntityCoords(Player))
      
    if not HasModelLoaded(prop1) then
        LoadPropDict(prop1)
    end
      
    prop = CreateObject(GetHashKey(prop1), x, y, z+0.2,  true,  true, true)
    AttachEntityToEntity(prop, Player, GetPedBoneIndex(Player, bone), off1, off2, off3, rot1, rot2, rot3, true, true, false, true, 1, true)
    table.insert(PlayerProps, prop)
    PlayerHasProp = true
    SetModelAsNoLongerNeeded(prop1)
end

function startAttitude(anim)
    ESX.Streaming.RequestAnimSet(anim, function()
        SetPedMotionBlur(personal.pedId(), false)
        SetPedMovementClipset(personal.pedId(), anim, true)
        RemoveAnimSet(anim)
    end)
end

function startAnim(lib, anim,loop)
    ESX.Streaming.RequestAnimDict(lib, function()
        TaskPlayAnim(PlayerPedId(), lib, anim, 2.0, 2.0, 9999999999, loop, 0, false, false, false)
    end)
end

function startScenario(anim)
    PlayerPos = GetOffsetFromEntityInWorldCoords(PlayerPedId(), 0.0, 0 - 0.5, -0.5);
    TaskStartScenarioAtPosition(GetPlayerPed(-1), anim, PlayerPos['x'], PlayerPos['y'], PlayerPos['z'], GetEntityHeading(PlayerPedId()), 0, 1, false)
end 
        
function startScenario2(anim)
    TaskStartScenarioInPlace(GetPlayerPed(-1), anim, 0, true)
end 

function startPointing(plyPed)	
    ESX.Streaming.RequestAnimDict('anim@mp_point', function()
        SetPedConfigFlag(plyPed, 36, 1)
        TaskMoveNetworkByName(plyPed, 'task_mp_pointing', 0.5, 0, 'anim@mp_point', 24)
        RemoveAnimDict('anim@mp_point')
    end)
end
    
function stopPointing()
    local plyPed = personal.pedId()
    RequestTaskMoveNetworkStateTransition(plyPed, 'Stop')
    
    if not IsPedInjured(plyPed) then
        ClearPedSecondaryTask(plyPed)
    end
    
    SetPedConfigFlag(plyPed, 36, 0)
    ClearPedSecondaryTask(plyPed)
    pointing = false
end
    
function crouchandpointing(default)
    Citizen.CreateThread(function()
        while default do
                
            Citizen.Wait(100)
            if Sotek.crouched or Sotek.handsUp or Sotek.pointing then
                if not IsPedOnFoot(PlayerPedId()) then
                    ResetPedMovementClipset(plyPed, 0)
                    stopPointing()
                    Sotek.crouched, Sotek.handsUp, Sotek.pointing = false, false, false
                elseif Sotek.pointing then
                    local ped = PlayerPedId()
                    local camPitch = GetGameplayCamRelativePitch()
        
                    if camPitch < -70.0 then
                        camPitch = -70.0
                    elseif camPitch > 42.0 then
                        camPitch = 42.0
                    end
        
                    camPitch = (camPitch + 70.0) / 112.0
        
                    local camHeading = GetGameplayCamRelativeHeading()
                    local cosCamHeading = Cos(camHeading)
                    local sinCamHeading = Sin(camHeading)
        
                    if camHeading < -180.0 then
                        camHeading = -180.0
                    elseif camHeading > 180.0 then
                        camHeading = 180.0
                    end
        
                    camHeading = (camHeading + 180.0) / 360.0
                    local coords = GetOffsetFromEntityInWorldCoords(ped, (cosCamHeading * -0.2) - (sinCamHeading * (0.4 * camHeading + 0.3)), (sinCamHeading * -0.2) + (cosCamHeading * (0.4 * camHeading + 0.3)), 0.6)
                    local rayHandle, blocked = GetShapeTestResult(StartShapeTestCapsule(coords.x, coords.y, coords.z - 0.2, coords.x, coords.y, coords.z + 0.2, 0.4, 95, ped, 7))
        
                    SetTaskMoveNetworkSignalFloat(ped, 'Pitch', camPitch)
                    SetTaskMoveNetworkSignalFloat(ped, 'Heading', (camHeading * -1.0) + 1.0)
                    SetTaskMoveNetworkSignalBool(ped, 'isBlocked', blocked)
                    SetTaskMoveNetworkSignalBool(ped, 'isFirstPerson', N_0xee778f8c7e1142e2(N_0x19cafa3c87f7c2ff()) == 4)
                end
            end
        end
    end)
end
    
function EmoteCancel()
    PtfxPrompt = false
    PtfxStop()
    ClearPedTasks(GetPlayerPed(-1))
    DestroyAllProps()
    ResetPedMovementClipset(PlayerPedId())
end

Keys.Register('X', 'X', 'Annuler l\'emote', function()
	Ptfx = false
	local ped = GetPlayerPed(-1)

    if not PlayerIsDead then
        if Sotek.handsUp then 
            ClearPedSecondaryTask(personal.pedId())
        else	
            DestroyAllProps()
            ClearPedTasks(ped);
            ResetPedMovementClipset(PlayerPedId())
            Ptfx = false

        end
        Ptfx = false
    end
end)
Keys.Register('Y', 'Y', 'Lever les mains', function()
	local plyPed = personal.pedId()

    if not PlayerIsDead then
        if (DoesEntityExist(plyPed)) and not (IsEntityDead(plyPed)) and (IsPedOnFoot(plyPed)) then
            if Sotek.pointing then
                Sotek.pointing = false
            end

            Sotek.handsUp = not Sotek.handsUp

            if Sotek.handsUp then
                ESX.Streaming.RequestAnimDict('random@mugging3', function()
                    TaskPlayAnim(plyPed, 'random@mugging3', 'handsup_standing_base', 8.0, -8, -1, 49, 0, 0, 0, 0)
                    RemoveAnimDict('random@mugging3')
                end)
            else
                ClearPedSecondaryTask(plyPed)
            end
        end
    end
end)


Keys.Register('B', 'B', 'Pointer du doigt', function()
	local plyPed = personal.pedId()

    if not PlayerIsDead then
        if (DoesEntityExist(plyPed)) and (not IsEntityDead(plyPed)) and (IsPedOnFoot(plyPed)) then
            if Sotek.handsUp then
                Sotek.handsUp = false
            end

            Sotek.pointing = not Sotek.pointing

            if Sotek.pointing then
                startPointing(plyPed)
                crouchandpointing(true)
            else
                stopPointing(plyPed)
                crouchandpointing(false)
            end
        end
    end
end)

Keys.Register('LCONTROL', 'LCONTROL', 'S\'accroupir', function()
	local plyPed = PlayerPedId()

    if not PlayerIsDead then
        DisableControlAction(1, 36, true)

        if (DoesEntityExist(plyPed)) and (not IsEntityDead(plyPed)) and (IsPedOnFoot(plyPed)) then
            Sotek.crouched = not Sotek.crouched

            if Sotek.crouched then 
                crouchandpointing(true)

                ESX.Streaming.RequestAnimSet('move_ped_crouched', function()
                    SetPedMovementClipset(plyPed, 'move_ped_crouched', 0.25)
                    RemoveAnimSet('move_ped_crouched')
                end)
            else
                crouchandpointing(false)
                ResetPedMovementClipset(plyPed, 0)
            end
        end
    end
end)