ESX = nil
TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

local CurrentActionData = {}
local HasAlreadyEnteredMarker, OnJob = false, false
local LastStation, LastPart, LastPartNum, LastEntity, CurrentAction, CurrentActionMsg
isInShopMenu = false, false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    ESX.PlayerData = xPlayer
    ESX.PlayerLoaded = true
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    ESX.PlayerLoaded = false
    ESX.PlayerData = {}
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    ESX.PlayerData.job = job
end)

CreateThread(function()
	while true do
		local Sleep = 1000

		if CurrentAction then
			Sleep = 0
			ESX.ShowHelpNotification(CurrentActionMsg)
		end
		Wait(Sleep)
	end
end)

AddEventHandler('nightclub:hasEnteredMarker', function(station, part, partNum)
	if part == 'Garage' then
		CurrentAction = 'Garage'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour voir les ~p~vehicules"
		CurrentActionData = {}
    elseif part == 'deleteCar' then
		CurrentAction = 'deleteCar'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ranger le ~p~vehicule"
		CurrentActionData = {}
	elseif part == 'Shops' then
		CurrentAction = 'Shops'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~y~prendre des ingrédients"
		CurrentActionData = {}
	elseif part == 'Coffre' then
		CurrentAction = 'Coffre'
		CurrentActionMsg = "Appuyez sur ~INPUT_CONTEXT~ pour ~y~accéder au coffre"
		CurrentActionData = {}
	end
end)

AddEventHandler('nightclub:hasExitedMarker', function(station, part, partNum)
	if not isInShopMenu then
		RageUI.CloseAll()
		open = false
	end

	CurrentAction = nil
end)

-- Draw markers and more
CreateThread(function()
	while true do
		local Sleep = 1500

        Sleep = 500
        local playerPed = PlayerPedId()
        local playerCoords = GetEntityCoords(playerPed)
        local isInMarker, hasExited = false, false
        local currentStation, currentPart, currentPartNum

		if ESX.PlayerData.job and ESX.PlayerData.job.name == 'lux' then
			for k,v in pairs(_Lux.posEmployer) do
				local distance = #(playerCoords - v.Garage)

				if distance < _Lux.DrawDistance then
					DrawMarker(21, v.Garage, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.7, 0.7, 0.5, 76, 0, 153, 100, false, true, 2, false, false, false, false)
					Sleep = 0
	
					if distance < 1.5 then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Garage', i
					end
				end
			end
            for k,v in pairs(_Lux.posEmployer) do
				local distance = #(playerCoords - v.deleteCar)

				if distance < _Lux.DrawDistance then
					DrawMarker(21, v.deleteCar, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.7, 0.7, 0.5, 76, 0, 153, 100, false, true, 2, false, false, false, false)
					Sleep = 0
	
					if distance < 1.5 then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'deleteCar', i
					end
				end
			end
			for k,v in pairs(_Lux.posEmployer) do
				local distance = #(playerCoords - v.Shops)
			
				if distance < _Lux.DrawDistance then
					DrawMarker(21, v.Shops, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.7, 0.7, 0.5, 76, 0, 153, 100, false, true, 2, false, false, false, false)
					Sleep = 0
	
					if distance < 1.5 then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Shops', i
					end
				end
			end
			for k,v in pairs(_Lux.posEmployer) do
				local distance = #(playerCoords - v.Coffre)
			
				if distance < _Lux.DrawDistance then
					DrawMarker(21, v.Coffre, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.7, 0.7, 0.5, 76, 0, 153, 100, false, true, 2, false, false, false, false)
					Sleep = 0
	
					if distance < 1.5 then
						isInMarker, currentStation, currentPart, currentPartNum = true, k, 'Coffre', i
					end
				end
			end
		end

        if isInMarker and not HasAlreadyEnteredMarker or (isInMarker and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum)) then
            if (LastStation and LastPart and LastPartNum) and (LastStation ~= currentStation or LastPart ~= currentPart or LastPartNum ~= currentPartNum) then
                TriggerEvent('nightclub:hasExitedMarker', LastStation, LastPart, LastPartNum)
                hasExited = true
            end
            HasAlreadyEnteredMarker = true
            LastStation = currentStation
            LastPart = currentPart
            LastPartNum = currentPartNum
            TriggerEvent('nightclub:hasEnteredMarker', currentStation, currentPart, currentPartNum)
        end
        if not hasExited and not isInMarker and HasAlreadyEnteredMarker then
            HasAlreadyEnteredMarker = false
            TriggerEvent('nightclub:hasExitedMarker', LastStation, LastPart, LastPartNum)
        end

        Wait(Sleep)
	end
end)

RegisterCommand("nightclub:interact", function()
    if not CurrentAction then
		return
	end
	if not ESX.PlayerData.job or (ESX.PlayerData.job and not ESX.PlayerData.job.name == 'lux') then
		return
	end
	if CurrentAction == 'Garage' then
		openGarage()
    elseif CurrentAction == 'deleteCar' then
		deleteCar()
	elseif CurrentAction == 'Shops' then
		openShops()
	elseif CurrentAction == 'Coffre' then
		openCoffre()
	end
	CurrentAction = nil
end)
RegisterKeyMapping("nightclub:interact", "(ESX Lux) Interact", "keyboard", "E")

function deleteCar()
    local vehicule = 0
    local closest = 5000
    if IsPedInAnyVehicle(PlayerPedId(), false) then
        vehicule = GetVehiclePedIsIn(PlayerPedId(), false)
    else
        vehicule = GetVehiclePedIsIn(PlayerPedId(), true)
    end

    if vehicule == 0 or vehicule == nil then
        vehicule, closest = ESX.Game.GetClosestVehicle()
        if closest > 8.0 then
            vehicule = nil
        end
    end

    if vehicule == 0 or vehicule == nil then
        vehicule = lastExitedVeh
        if #(GetEntityCoords(PlayerPedId()) - GetEntityCoords(vehicule)) > 40 then
            vehicule = nil
        end
    end

    if vehicule ~= 0 and vehicule ~= nil then
        if NetworkGetNetworkIdFromEntity(vehicule) ~= nil then
            local vehicle = NetworkGetEntityFromNetworkId(NetworkGetNetworkIdFromEntity(vehicule))
            if DoesEntityExist(vehicle) then
                DeleteEntity(vehicle)
            end
        end
        --TriggerServerEvent('fl_controlvehicle:deleteKeyJobs', GetVehicleNumberPlateText(vehicule), NetworkGetNetworkIdFromEntity(vehicule))
    end
end