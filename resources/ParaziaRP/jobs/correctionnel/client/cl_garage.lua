Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	ESX.PlayerData = xPlayer
end)


RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)

function SetVehicleMaxMods(vehicle)
	local props = {
		modEngine = 5,
		modBrakes = 5,
		modTransmission = 5,
		modSuspension = 5,
		modTurbo = true,
	}

	ESX.Game.SetVehicleProperties(vehicle, props)
end

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('', '~q~Véhicule')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenMenuGaragecorrectionnel()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 

                for k,v in pairs(cfg_correctionnel.Vehiculescorrectionnel) do
                RageUI.Button(v.buttoname, v.disc, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        if not ESX.Game.IsSpawnPointClear(vector3(v.spawnzone.x, v.spawnzone.y, v.spawnzone.z), 10.0) then
                            ESX.ShowNotification("~g~correctionnel\n~q~Point de spawn bloquée")
                        else
                            local model = GetHashKey(v.spawnname)
                            RequestModel(model)
                            while not HasModelLoaded(model) do Wait(10) end
                            local correctionnelveh = CreateVehicle(model, v.spawnzone.x, v.spawnzone.y, v.spawnzone.z, v.headingspawn, true, false)
                            local newPlate = GenerateSocietyPlate('BC')
                            SetVehicleNumberPlateText(correctionnelveh, newPlate)
                            TriggerServerEvent('garage:RegisterNewKey', newPlate)
                            SetVehicleFixed(correctionnelveh)
                            TaskWarpPedIntoVehicle(PlayerPedId(),  correctionnelveh,  -1)
                            SetVehRadioStation(correctionnelveh, 0)
                            SetVehicleMaxMods(correctionnelveh)
                            RageUI.CloseAll()
                        end
                    end
                })


              end
            end)
          Wait(0)
         end
      end)
   end
end


Citizen.CreateThread(function()
  while true do 
      local wait = 750
      if ESX.PlayerData.job and ESX.PlayerData.job.name == 'correctionnel' then
          for k in pairs(cfg_correctionnel.Position.GarageVehicule) do 
              local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
              local pos = cfg_correctionnel.Position.GarageVehicule
              local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

              if dist <= 5.0 then 
                  wait = 0
                  DrawMarker(cfg_correctionnel.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, cfg_correctionnel.MarkerSizeLargeur, cfg_correctionnel.MarkerSizeEpaisseur, cfg_correctionnel.MarkerSizeHauteur, cfg_correctionnel.MarkerColorR, cfg_correctionnel.MarkerColorG, cfg_correctionnel.MarkerColorB, cfg_correctionnel.MarkerOpacite, cfg_correctionnel.MarkerSaute, true, p19, cfg_correctionnel.MarkerTourne)  
              end

              if dist <= 2.0 then 
                  wait = 0
                  Visual.Subtitle(cfg_correctionnel.TextGarageVehicule, 1)
                  if IsControlJustPressed(1,51) then
                    OpenMenuGaragecorrectionnel()
                  end
              end
          end
      end
  Citizen.Wait(wait)
  end
end)

Citizen.CreateThread(function()
    while true do 
        local wait = 750
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'correctionnel' then
            for k in pairs(cfg_correctionnel.Position.RentreVehicule) do 
                local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
                local playerPed = PlayerPedId()
                local pos = cfg_correctionnel.Position.RentreVehicule
                local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

                if dist <= 5.0 then 
                    wait = 0
                    DrawMarker(cfg_correctionnel.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, cfg_correctionnel.MarkerSizeLargeur, cfg_correctionnel.MarkerSizeEpaisseur, cfg_correctionnel.MarkerSizeHauteur, cfg_correctionnel.MarkerColorR, cfg_correctionnel.MarkerColorG, cfg_correctionnel.MarkerColorB, cfg_correctionnel.MarkerOpacite, cfg_correctionnel.MarkerSaute, true, p19, cfg_correctionnel.MarkerTourne)  
                end

                if dist <= 2.0 then 
                    wait = 0
                    Visual.Subtitle(cfg_correctionnel.TextRentreVehicule, 1)
                    if IsControlJustPressed(1,51) then
                        local veh = GetVehiclePedIsIn(PlayerPedId(), false)
                        if veh ~= nil then 
                            DeleteEntity(veh) 
                        end
                    end
                end
            end
        end
        Citizen.Wait(wait)
    end
end)


-- Garage Helico

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('', '~q~Héhlico')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function OpenMenuGarageHelicorrectionnel()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 

              RageUI.Button("Ranger votre véhicule", nil, {RightLabel = "→→"}, true , {
                onSelected = function()
                  local veh,dist4 = GetClosestVehicle(playerCoords)
                  if dist4 < 4 then
                      DeleteEntity(veh)
                      RageUI.CloseAll()
                  end
                    end
                  })

              RageUI.Separator("~h~↓ Véhicules ↓")

                for k,v in pairs(cfg_correctionnel.Helicocorrectionnel) do
                RageUI.Button(v.buttonameheli, nil, {RightLabel = "→→"}, true , {
                    onSelected = function()
                        if not ESX.Game.IsSpawnPointClear(vector3(v.spawnzoneheli.x, v.spawnzoneheli.y, v.spawnzoneheli.z), 10.0) then
                        ESX.ShowNotification("~g~correctionnel\n~q~Point de spawn bloquée")
                        else
                        local model = GetHashKey(v.spawnnameheli)
                        RequestModel(model)
                        while not HasModelLoaded(model) do Wait(10) end
                        local correctionnelheli = CreateVehicle(model, v.spawnzoneheli.x, v.spawnzoneheli.y, v.spawnzoneheli.z, v.headingspawnheli, true, false)
                        SetVehicleNumberPlateText(correctionnelheli, "correctionnel"..math.random(50, 999))
                        SetVehicleFixed(correctionnelheli)
                        TaskWarpPedIntoVehicle(PlayerPedId(),  correctionnelheli,  -1)
                        SetVehRadioStation(correctionnelheli, 0)
                        RageUI.CloseAll()
                        end
                    end
                })


              end
            end)
          Wait(0)
         end
      end)
   end
end


Citizen.CreateThread(function()
  while true do 
      local wait = 750
      if ESX.PlayerData.job and ESX.PlayerData.job.name == 'correctionnel' then
          for k in pairs(cfg_correctionnel.Position.GarageHeli) do 
              local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
              local pos = cfg_correctionnel.Position.GarageHeli
              local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

              if dist <= 5.0 then 
                  wait = 0
                  DrawMarker(cfg_correctionnel.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, cfg_correctionnel.MarkerSizeLargeur, cfg_correctionnel.MarkerSizeEpaisseur, cfg_correctionnel.MarkerSizeHauteur, cfg_correctionnel.MarkerColorR, cfg_correctionnel.MarkerColorG, cfg_correctionnel.MarkerColorB, cfg_correctionnel.MarkerOpacite, cfg_correctionnel.MarkerSaute, true, p19, cfg_correctionnel.MarkerTourne)  
              end

              if dist <= 2.0 then 
                  wait = 0
                  Visual.Subtitle(cfg_correctionnel.TextGarageHeli, 1)
                  if IsControlJustPressed(1,51) then
                    OpenMenuGarageHelicorrectionnel()
                  end
              end
          end
      end
  Citizen.Wait(wait)
  end
end)


RMenu.Add('correctionnel', 'vehicle_option', RageUI.CreateMenu("", "~q~Option véhicule"))
RMenu:Get('correctionnel', 'vehicle_option'):DisplayGlare(true);
RMenu:Get('correctionnel', 'vehicle_option').Closed = function()
    open = false
end;

function OpencorrectionnelVehicleOptionMenu()
    if open then
        RageUI.Visible(RMenu:Get('correctionnel', 'vehicle_option'), false)
        open = false
        return
    end
    open = true
    RageUI.Visible(RMenu:Get('correctionnel', 'vehicle_option'), true)

    Citizen.CreateThread(function()
        while open do
            RageUI.IsVisible(RMenu:Get('correctionnel', 'vehicle_option'), function()
                local pPed = GetPlayerPed(-1)
                local pCoords = GetEntityCoords(pPed)
                local pInVeh = IsPedInAnyVehicle(pPed, false)
                

                if pInVeh then
                    local pVeh = GetVehiclePedIsIn(pPed, false)
                    local isInRightSeat = GetPedInVehicleSeat(pVeh, -1) == pPed
                    if isInRightSeat then
                        for i = 1,9 do
                            if DoesExtraExist(pVeh, i) then
                                if IsVehicleExtraTurnedOn(pVeh, i) then
                                    RageUI.Button("~q~Désactiver~s~ l'extra "..i, nil, {}, true, {
                                        onSelected = function()
                                            SetVehicleExtra(pVeh, i, true)
                                        end,
                                    }) 
                                else
                                    RageUI.Button("~g~Activer~s~ l'extra "..i, nil, {}, true, {
                                        onSelected = function()
                                            SetVehicleExtra(pVeh, i, false)
                                        end,
                                    }) 
                                end
                            end
                        end 
                    else
                        RageUI.Separator("Vous devez etre conducteur dans un véhicule")
                    end
                else
                    RageUI.Separator("Vous devez etre dans un véhicule")
                end
            end)
            Wait(1)
        end
    end)
end

Keys.Register('F4', 'F4', 'uvrir le menu géstion extra véhicule', function()
    if ESX.PlayerData.job and ESX.PlayerData.job.name == 'correctionnel' then
        OpencorrectionnelVehicleOptionMenu()
    end
end)