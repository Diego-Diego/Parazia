local KitArme = false
local Blanchiement = false
local namegang = 'Aucun'
local labelgang = 'Aucun'
local posCoffre = 'Aucune'

Citizen.CreateThread(function()
    Wait(2000)
    TriggerServerEvent('ewen:initGangs')
end)

local GangsList = {}
local GangLoaded = false

RegisterNetEvent('ewen:SendGangListToClient', function(table)
    GangsList = table
    GangLoaded = true
end)

Citizen.CreateThread(function()
    while not GangLoaded do 
        Wait(1)
    end

    while true do
        local isProche = false
        for k,v in pairs(GangsList) do
            ParaziaRP.Gang = v
           if ESX.PlayerData.job2.name == ParaziaRP.Gang.name then
               local CoffreAction = vector3(ParaziaRP.Gang.posCoffre.x, ParaziaRP.Gang.posCoffre.y, ParaziaRP.Gang.posCoffre.z)

               local distanceCoffreAction = Vdist2(GetEntityCoords(PlayerPedId(), false), CoffreAction)

               if distanceCoffreAction < 50 then
                   isProche = true
                   DrawMarker(25, ParaziaRP.Gang.posCoffre.x, ParaziaRP.Gang.posCoffre.y, ParaziaRP.Gang.posCoffre.z-0.98, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.55, 0.55, 0.55, 0, 209, 255, 255, false, false, 2, false, false, false, false)
               end
               if distanceCoffreAction < 3 then
                   ESX.ShowHelpNotification("~q~ParaziaRP Roleplay\n~q~Appuyez sur ~INPUT_CONTEXT~ pour intéragir")
                   if IsControlJustPressed(1,51) then
                        OpenCoffreGang(CoffreAction)
                   end
               end
           end
        end
        
		if isProche then
			Wait(0)
		else
			Wait(750)
		end
	end
end)

local ListWeaponKitArme = {
    {price = 10000, name = 'weapon_switchblade', label = 'Couteau de poche'},
    {price = 20000, name = 'weapon_machete', label = 'Machette'},
    {price = 200000, name = 'WEAPON_SNSPISTOL', label = 'Pétoire'},
    {price = 350000, name = 'WEAPON_PISTOL', label = 'Pisolet'},
    {price = 600000, name = 'WEAPON_PISTOL50', label = 'Calibre 50'},
    {price = 450000, name = 'WEAPON_HEAVYPISTOL', label = 'Pistolet Lourd'},
    {price = 950000, name = 'WEAPON_MACHINEPISTOL', label = 'Tec-9'},
    {price = 1000000, name = 'weapon_minismg', label = 'Mini SMG'},
    {price = 1200000, name = 'WEAPON_MICROSMG', label = 'Micro Uzi'},
    {price = 3200000, name = 'WEAPON_COMPACTRIFLE', label = 'Mini AK'},
}

function OpenCoffreGang(pos)
	local menu = RageUI.CreateMenu("", "Actions Disponibles")
    local OpenBuyWeaponMenu = RageUI.CreateSubMenu(menu, '', 'Armes disponible')
    RageUI.Visible(menu, not RageUI.Visible(menu))

	while menu do
		Citizen.Wait(0)
        RageUI.IsVisible(menu, function()
            RageUI.Button('Déposer Objet', nil, {}, true, {
                onSelected = function()
                    OpenPutItemsGang()
                end
            })
            RageUI.Button('Prendre Objet', nil, {}, true, {
                onSelected = function()
                    OpenGetItemsGang()
                end
            })
            RageUI.Button('Déposer Armes', nil, {}, true, {
                onSelected = function()
                    openDepositWeaponGang()
                end
            })
            RageUI.Button('Prendre Armes', nil, {}, true, {
                onSelected = function()
                    openPutWeaponGang()
                end
            })
            RageUI.Button("Argent sale", nil, {}, true, {
                onSelected = function()
                    openDirtyMoney()
                end
            })
            if ESX.PlayerData.job2.grade_name == 'boss' then
                if GangsList[ESX.PlayerData.job2.name].KitArme == 1 or GangsList[ESX.PlayerData.job2.name].KitArme == true then 
                     RageUI.Button('Acheter Armes', nil, {}, true, {
                         onSelected = function() 
                      
                         end
                     }, OpenBuyWeaponMenu);
                end
            end
            if ESX.PlayerData.job2.grade_name == 'boss' then
                if GangsList[ESX.PlayerData.job2.name].Blanchiement == 1 or GangsList[ESX.PlayerData.job2.name].Blanchiement == true then 
                    RageUI.Button('Blanchiement', nil, {}, true, {
                        onSelected = function()
                            local argent = KeyboardInput("Combien d'agent as-tu ?", '' , '', 8)
                            TriggerServerEvent('ewen:blanchiement', argent)
                        end
                    })
                end
            end
        end)

        RageUI.IsVisible(OpenBuyWeaponMenu, function()
            if GangsList[ESX.PlayerData.job2.name].KitArme then
                for k,v in pairs(ListWeaponKitArme) do 
                    RageUI.Button(v.label, nil, {RightLabel = v.price..'$'}, true, {
                        onSelected = function() 
                            if GangsList[ESX.PlayerData.job2.name].KitArme then
                                TriggerServerEvent('Gangsbuilder:BuyWeapon', v.name, v.label)
                            end
                        end
                    })
                end
            end
        end)

        if not RageUI.Visible(menu) and not RageUI.Visible(OpenBuyWeaponMenu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

function refreshGangDirty()
    ESX.TriggerServerCallback('KraKss:GetGangMoney', function(result)
        blackIn = result
    end, GetPlayerServerId(PlayerId()))
end

function openDirtyMoney()
    local loaded = false
    local data
    local name
    local money
    local blackmoney
   
    ESX.TriggerServerCallback('Ewen:GetPlayerData', function(result)
        data = result
        name = result.name
        money = result.money
        blackmoney = result.blackmoney
        loaded = false
    end, GetPlayerServerId(PlayerId()))
    ESX.TriggerServerCallback('KraKss:GetGangMoney', function(result)
        blackIn = result
        loaded = true
    end, GetPlayerServerId(PlayerId()))
    while not loaded do 
        Wait(1)
    end
    local inventaireplayer = RageUI.CreateMenu("", "Inventaire")
    RageUI.Visible(inventaireplayer, not RageUI.Visible(inventaireplayer))
	while inventaireplayer do
		Citizen.Wait(0)
        RageUI.IsVisible(inventaireplayer, function()
            RageUI.Separator("Argent du gang : ~q~"..blackIn.."$")
            RageUI.Button("Déposer", nil, {}, true, {
                onSelected = function()
                    quantity = KeyboardInput('Combien voulez vous déposer ?', ('Combien voulez vous déposer ?'), '', 30)
                    if tonumber(quantity) > 0 then
                        TriggerServerEvent("KraKss:SetGangMoney", quantity)
                        Citizen.Wait(100)                        
                        refreshGangDirty()
                    else
                        ESX.ShowNotification("~g~Vous n'avez pas entré un nombre valide")
                    end                    
                end
            })
            RageUI.Button("Retirer", nil, {}, true, {
                onSelected = function()
                    quantity = KeyboardInput('Combien voulez vous retirer ?', ('Combien voulez vous retirer ?'), '', 30)
                    if tonumber(quantity) > 0 then
                        TriggerServerEvent("KraKss:RemoveGangMoney", quantity)
                        Citizen.Wait(100)
                        refreshGangDirty()
                    else
                        ESX.ShowNotification("~g~Vous n'avez pas entré un nombre valide")
                    end 
                end
            })
        end)
        if not RageUI.Visible(inventaireplayer) then
            inventaireplayer = RMenu:DeleteType('inventaireplayer', true)
        end
    end
end

function OpenGetItemsGang()
    local loaded = false
    local data = nil
    ESX.TriggerServerCallback('GangsBuilder:getStockItems', function(items)
        data = items
        loaded = true
    end)
    while not loaded do 
        Wait(1)
    end
    local inventaireplayer = RageUI.CreateMenu("", "Inventaire")
    RageUI.Visible(inventaireplayer, not RageUI.Visible(inventaireplayer))
	while inventaireplayer do
		Citizen.Wait(0)
        RageUI.IsVisible(inventaireplayer, function()
            for k,v in pairs(data) do
                if v.count ~= 0 then
                    RageUI.Button(v.label, nil, {RightLabel = '~q~Quantités : '..v.count}, true, {
                        onSelected = function()
                            quantity = KeyboardInput('Combien voulez vous déposer ?', ('Combien voulez vous déposer ?'), '', 30)
                            TriggerServerEvent('GangsBuilder:getStockItem', v.name, tonumber(quantity))
                            RageUI.CloseAll()
                            Wait(150)
                            OpenGetItemsGang()
                        end
                    })
                end
            end
        end)
        if not RageUI.Visible(inventaireplayer) then
            inventaireplayer = RMenu:DeleteType('inventaireplayer', true)
        end
    end
end

function OpenPutItemsGang()
    local loaded = false
    local data
    local name
    local money
    local blackmoney
   
    ESX.TriggerServerCallback('Ewen:GetPlayerData', function(result)
        data = result
        name = result.name
        money = result.money
        blackmoney = result.blackmoney
        loaded = true
    end, GetPlayerServerId(PlayerId()))
    while not loaded do 
        Wait(1)
    end
    local inventaireplayer = RageUI.CreateMenu("", "Inventaire")
    RageUI.Visible(inventaireplayer, not RageUI.Visible(inventaireplayer))
	while inventaireplayer do
		Citizen.Wait(0)
        RageUI.IsVisible(inventaireplayer, function()
            for k,v in pairs(data.inventory) do
                RageUI.Button(v.label, nil, {RightLabel = '~q~Quantités : '..v.count}, true, {
                    onSelected = function()
                        quantity = KeyboardInput('Combien voulez vous déposer ?', ('Combien voulez vous déposer ?'), '', 30)
                        TriggerServerEvent('GangsBuilder:putStockItems', v.name, tonumber(quantity))
                        RageUI.CloseAll()
                        Wait(150)
                        OpenPutItemsGang()
                    end
                })
            end
        end)
        if not RageUI.Visible(inventaireplayer) then
            inventaireplayer = RMenu:DeleteType('inventaireplayer', true)
        end
    end
end

function openDepositWeaponGang()
    local loaded = false
    local data
    local name
    local money
    local blackmoney
   
    ESX.TriggerServerCallback('Ewen:GetPlayerData', function(result)
        data = result
        name = result.name
        money = result.money
        blackmoney = result.blackmoney
        loaded = true
    end, GetPlayerServerId(PlayerId()))
    while not loaded do 
        Wait(1)
    end
    local inventaireplayer = RageUI.CreateMenu("", "Inventaire")
    RageUI.Visible(inventaireplayer, not RageUI.Visible(inventaireplayer))
	while inventaireplayer do
		Citizen.Wait(0)
        RageUI.IsVisible(inventaireplayer, function()
            for k,v in pairs(data.weapons) do
                RageUI.Button(v.label, nil, {}, true, {
                    onSelected = function()
                        --if PermanantWeapon[v.name] == nil then
                            ESX.TriggerServerCallback('GangsBuilder:addArmoryWeapon', function()
                                openDepositWeaponGang()
                            end, v.name, 250)
                        --else
                            --ESX.ShowNotification('Vous ne pouvez pas déposer les armes boutique dans les coffres')
                        --end
                    end
                })
            end
        end)
        if not RageUI.Visible(inventaireplayer) then
            inventaireplayer = RMenu:DeleteType('inventaireplayer', true)
        end
    end
end

function openPutWeaponGang()
    local loaded = false
    local data = nil
    ESX.TriggerServerCallback('GangsBuilder:getArmoryWeapons', function(weapons)
        data = weapons
        loaded = true
    end)
    while not loaded do 
        Wait(1)
    end
    local inventaireplayer = RageUI.CreateMenu("", "Inventaire")
    RageUI.Visible(inventaireplayer, not RageUI.Visible(inventaireplayer))
	while inventaireplayer do
		Citizen.Wait(0)
        RageUI.IsVisible(inventaireplayer, function()
            for k,v in pairs(data) do
                RageUI.Button(ESX.GetWeaponLabel(v.name), nil, {RightLabel = v.ammo}, true, {
                    onSelected = function()
                        ESX.TriggerServerCallback('GangsBuilder:removeArmoryWeapon', function()
                            openPutWeaponGang()
                        end, v.name, v.ammo)
                    end
                })
            end
        end)
        if not RageUI.Visible(inventaireplayer) then
            inventaireplayer = RMenu:DeleteType('inventaireplayer', true)
        end
    end
end

RegisterCommand("f7", function()
    if not GetSafeZone() then
        if not PlayerIsDead then
            OpenGangMenuF7()
        end
    end
end, false)
RegisterKeyMapping('f7', 'Menu Gang', 'keyboard', 'F7')

function OpenGangMenuF7()
    local inventaireplayer = RageUI.CreateMenu("", "~q~Faction")
    RageUI.Visible(inventaireplayer, not RageUI.Visible(inventaireplayer))
	while inventaireplayer do
		Citizen.Wait(0)
        RageUI.IsVisible(inventaireplayer, function()
            RageUI.Button('Fouiller', nil, {RightLabel = '>'}, true, {
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        OpenBodySearchMenu(GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('Aucun Joueurs au alentours')
                    end
                end
            });
            RageUI.Button('Mettre dans le véhicule', nil, {RightLabel = '>'}, true, {
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('GangsBuilder:putInVehicle', GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('Aucun Joueurs au alentours')
                    end
                end
            });
            RageUI.Button('Sortir du véhicule', nil, {RightLabel = '>'}, true, {
                onSelected = function()
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if distance ~= -1 and distance <= 3.0 then
                        TriggerServerEvent('GangsBuilder:OutVehicle', GetPlayerServerId(player))
                    else
                        ESX.ShowNotification('Aucun Joueurs au alentours')
                    end
                end
            });
            RageUI.Button("Ouvrir / fermer de force", nil, {RightLabel = "→"}, true , {
                onSelected = function()
                    local playerPed = PlayerPedId()
                    local vehicle = ESX.Game.GetVehicleInDirection()
                    local coords = GetEntityCoords(playerPed)
        
                    if IsPedSittingInAnyVehicle(playerPed) then
                        ESX.ShowNotification('Action impossible')
                        return
                    end
        
                    if DoesEntityExist(vehicle) then
                        isBusy = true
                        TaskStartScenarioInPlace(playerPed, 'WORLD_HUMAN_WELDING', 0, true)
                        Citizen.CreateThread(function()
                            Citizen.Wait(10000)
        
                            SetVehicleDoorsLocked(vehicle, 1)
                            SetVehicleDoorsLockedForAllPlayers(vehicle, false)
                            ClearPedTasksImmediately(playerPed)
        
                            ESX.ShowNotification('Véhicule dévérouiller')
                            isBusy = false
                        end)
                    else
                        ESX.ShowNotification('Pas de véhicules à proximité')
                    end
                end
            })
        end)
        if not RageUI.Visible(inventaireplayer) then
            inventaireplayer = RMenu:DeleteType('inventaireplayer', true)
        end
    end
end

RegisterNetEvent('GangsBuilder:putInVehicle', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, false)

	if IsAnyVehicleNearPoint(coords, 5.0) then
		local vehicle = GetClosestVehicle(coords, 5.0, 0, 71)

		if DoesEntityExist(vehicle) then
			local maxSeats = GetVehicleMaxNumberOfPassengers(vehicle)
			local freeSeat = nil

			for i = maxSeats - 1, 0, -1 do
				if IsVehicleSeatFree(vehicle,  i) then
					freeSeat = i
					break
				end
			end

			if freeSeat ~= nil then
				TaskWarpPedIntoVehicle(playerPed, vehicle, freeSeat)
			end
		end
	end
end)

RegisterNetEvent('GangsBuilder:OutVehicle', function()
	local ped = PlayerPedId()

	if not IsPedSittingInAnyVehicle(playerPed) then
		return
	end

	local vehicle = GetVehiclePedIsIn(playerPed, false)
	TaskLeaveVehicle(playerPed, vehicle, 16)
end)

function OpenBodySearchMenu(player)
    local loaded = false
    local data
    local name
    local money
    local blackmoney
   
    ESX.TriggerServerCallback('Ewen:GetPlayerData', function(result)
        data = result
        name = result.name
        money = result.money
        blackmoney = result.blackmoney
        loaded = true
    end, player)
    while not loaded do 
        Wait(1)
    end

    local InventoryMenu = RageUI.CreateMenu("", 'Menu Fouille')
    RageUI.Visible(InventoryMenu, not RageUI.Visible(promote))

	while InventoryMenu do
		Citizen.Wait(0)
        RageUI.IsVisible(InventoryMenu, function()
            RageUI.Separator('↓ Argents ↓')
            RageUI.Separator('Liquides : '.. money)
            RageUI.Separator('Argents Sale : '.. blackmoney)
            RageUI.Separator('↓ Objets ↓')
            for k,v in pairs(data.inventory) do
                RageUI.Button(v.label, nil, {RightLabel = '~q~Quantités : '..v.count}, true, {
                    onSelected = function()

                    end
                })
            end
            RageUI.Separator('↓ Armes ↓')
            for k,v in pairs(data.weapons) do
                RageUI.Button(v.label, nil, {RightLabel = '~q~Munitions : '..v.ammo}, true, {
                    onSelected = function()

                    end
                })
            end
        end)
        if not RageUI.Visible(InventoryMenu) then
            InventoryMenu = RMenu:DeleteType('InventoryMenu', true)
        end
    end
end

local gangpos = false
local BlipsGang = {}
RegisterCommand('gangpos', function()
    if ESX.PlayerData.group ~= 'user' then
        gangpos = not gangpos
        if gangpos then
            for k,v in pairs(GangsList) do
                ParaziaRP.Gang = v
                BlipsGang[ParaziaRP.Gang.name] = AddBlipForCoord(ParaziaRP.Gang.posCoffre.x, ParaziaRP.Gang.posCoffre.y, ParaziaRP.Gang.posCoffre.z)
                SetBlipSprite(BlipsGang[ParaziaRP.Gang.name], 429)
                SetBlipDisplay(BlipsGang[ParaziaRP.Gang.name], 4)
                SetBlipScale(BlipsGang[ParaziaRP.Gang.name], 0.4)
                SetBlipColour(BlipsGang[ParaziaRP.Gang.name], 0)
                SetBlipAsShortRange(BlipsGang[ParaziaRP.Gang.name], true)
                BeginTextCommandSetBlipName("STRING")
                AddTextComponentString(ParaziaRP.name)
                EndTextCommandSetBlipName(BlipsGang[ParaziaRP.Gang.name])
            end
        else
            for k,v in pairs(BlipsGang) do 
                RemoveBlip(v)
            end
        end
    end
end)

RegisterNetEvent('Open:GangMenuAdmin', function()
    while not GangLoaded do 
        Wait(1)
    end
    if ESX.GetPlayerData()['group'] == '_dev' or ESX.GetPlayerData()['group'] == 'responsable' or ESX.GetPlayerData()['group'] == 'superadmin' then 
        local SelectedGang = {}
        local NewCoffrePosition = nil
        local PositionChanged = false
        local KitArmeGang = false
        local BlanchiementGang = false
        local PositionChangedCoffre = false
        local FinishKitArmeValue = false
        local FinishBlanchiementValue = false
        local GangMenu = RageUI.CreateMenu('', 'Actions Disponible')
        local GangsBuilderMenu = RageUI.CreateSubMenu(GangMenu, '', 'Actions Disponible')
        local OpenListGangs = RageUI.CreateSubMenu(GangMenu, '', 'Actions Disponible')
        local OpenSelectedGang = RageUI.CreateSubMenu(OpenListGangs, '', 'Actions Disponible')
        local OpenDeleteListGang = RageUI.CreateSubMenu(GangMenu, '', 'Actions Disponible')
        local DeleteGang = RageUI.CreateSubMenu(OpenDeleteListGang, '', 'Actions Disponible')
        
        RageUI.Visible(GangMenu, not RageUI.Visible(GangMenu))

        while GangMenu do
            Citizen.Wait(0)
            RageUI.IsVisible(GangMenu, function()
                RageUI.Button('Crée un nouveau Gang', nil, {RightLabel = '>'}, true, {
                    onSelected = function()

                end},GangsBuilderMenu)
                RageUI.Button('Modifier un Gang', nil, {RightLabel = '>'}, true, {
                    onSelected = function()

                end}, OpenListGangs)
                RageUI.Button('Supprimer un Gang', nil, {RightLabel = '>'}, true, {
                    onSelected = function()

                end},OpenDeleteListGang)
            end)

            RageUI.IsVisible(GangsBuilderMenu, function()
                RageUI.Button('Nom du Gang', nil, {RightLabel = namegang}, true, {
                    onSelected = function()
                        namegang = KeyboardInput('Quelle nom veux tu mettre ?', ('Quelle nom veux tu mettre ?'), '', 15)
                end})
                RageUI.Button('Label du Gang', nil, {RightLabel = labelgang}, true, {
                    onSelected = function()
                        labelgang = KeyboardInput('Quelle nom veux tu mettre ?', ('Quelle nom veux tu mettre ?'), '', 15)
                end})
                RageUI.Button('Position du Coffre', nil, {}, true, {
                    onSelected = function()
                        posCoffre = GetEntityCoords(PlayerPedId())
                end})
                if posCoffre ~= 'Aucune' then
                    RageUI.Separator(posCoffre)
                end
                RageUI.Checkbox("Kit Arme", nil, KitArme, {}, {
                    onSelected = function(Index)
                        KitArme = Index
                    end
                })
                RageUI.Checkbox("Blanchiement", nil, Blanchiement, {}, {
                    onSelected = function(Index)
                        Blanchiement = Index
                    end
                })
                RageUI.Button('~g~Confirmer', nil, {}, true, {
                    onSelected = function()
                        TriggerServerEvent('ewen:createGang', namegang, labelgang, posCoffre, KitArme, Blanchiement)
                        RageUI.GoBack()
                        KitArme = false
                        Blanchiement = false
                        namegang = 'Aucun'
                        labelgang = 'Aucun'
                        posCoffre = 'Aucune'
                end})
            end)

            RageUI.IsVisible(OpenListGangs, function()
                for k,v in pairs(GangsList) do
                    RageUI.Button(v.name, nil, {RightLabel = '>'}, true, {
                        onSelected = function()
                            SelectedGang = v
                            NewCoffrePosition = nil
                            PositionChanged = false
                            KitArmeGang = false
                            BlanchiementGang = false
                            PositionChangedCoffre = false
                            FinishKitArmeValue = false
                            FinishBlanchiementValue = false
                    end}, OpenSelectedGang)
                end
            end)

            RageUI.IsVisible(OpenSelectedGang, function()
                if SelectedGang.name ~= nil then
                    RageUI.Separator('Modification de ~q~'..SelectedGang.name)
                    RageUI.Separator('↓ Coffre ↓')
                    RageUI.Separator('Positione Actuelle : vector3('..math.floor(SelectedGang.posCoffre.x)..', '..math.floor(SelectedGang.posCoffre.y)..', '..math.floor(SelectedGang.posCoffre.z)..')')
                    RageUI.Button('Changer la Position du Coffre', nil, {RightLabel = '>'}, true, {
                        onSelected = function()
                            NewCoffrePosition = GetEntityCoords(PlayerPedId())
                            PositionChangedCoffre = true
                        end
                    })
                    if NewCoffrePosition ~= nil then
                        RageUI.Separator('↓ Nouvelle Position ↓')
                        RageUI.Separator(NewCoffrePosition)
                    end
                    if not FinishKitArmeValue then
                        if SelectedGang.KitArme ~= 0 or SelectedGang.KitArme ~= false and SelectedGang.KitArme == 1 or SelectedGang.KitArme == true then
                            KitArmeGang = true
                            FinishKitArmeValue = true
                        end
                    end
                    if not FinishBlanchiementValue then
                        if SelectedGang.KitArme ~= 0 or SelectedGang.Blanchiement ~= false and SelectedGang.Blanchiement == 1 or SelectedGang.Blanchiement == true then
                            BlanchiementGang = true
                            FinishBlanchiementValue = true
                        end
                    end
                    RageUI.Checkbox("Kit Arme", nil, KitArmeGang, {}, {
                        onSelected = function(Index)
                            KitArmeGang = Index
                        end
                    })
                    RageUI.Checkbox("Blanchiement", nil, BlanchiementGang, {}, {
                        onSelected = function(Index)
                            BlanchiementGang = Index
                        end
                    })
                    RageUI.Button('~g~Confirmer', nil, {}, true, {
                        onSelected = function()
                            if not PositionChangedCoffre then
                                NewCoffrePosition = SelectedGang.posCoffre
                            end
                            TriggerServerEvent('ewen:UpdateGangs', {name = SelectedGang.name, CoffrePos = NewCoffrePosition, KitArme = KitArmeGang, Blanchiement = BlanchiementGang})
                            RageUI.GoBack()
                        end
                    })
                end
            end)
            RageUI.IsVisible(OpenDeleteListGang, function()
                for k,v in pairs(GangsList) do
                    RageUI.Button(v.name, nil, {RightLabel = '>'}, true, {
                        onSelected = function()
                            SelectedGang = v
                    end}, DeleteGang)
                end
            end)
            
            RageUI.IsVisible(DeleteGang, function()
                if SelectedGang.name ~= nil then
                    RageUI.Separator('Suppression de ~q~'..SelectedGang.name)
                    RageUI.Button('~g~Confirmer', nil, {}, true, {
                        onSelected = function()
                            TriggerServerEvent('ewen:DeleteGangs', SelectedGang.name)
                            RageUI.GoBack()
                        end
                    })
                end
            end)
            
            if not RageUI.Visible(GangMenu) and 
            not RageUI.Visible(GangsBuilderMenu) and 
            not RageUI.Visible(OpenListGangs) and 
            not RageUI.Visible(OpenSelectedGang) and 
            not RageUI.Visible(OpenDeleteListGang) and
            not RageUI.Visible(DeleteGang) then
                GangMenu = RMenu:DeleteType('GangMenu', true)
                SelectedGang = {}
            end
        end
    end
end)

RegisterNetEvent("fouiller:f7")
AddEventHandler("fouiller:f7", function()
    local player, distance = ESX.Game.GetClosestPlayer()
    if distance ~= -1 and distance <= 3.0 then
        OpenBodySearchMenu(GetPlayerServerId(player))
    else
        ESX.ShowNotification('Aucun Joueurs au alentours')
    end
end)