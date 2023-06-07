Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
        Citizen.Wait(5000)
    end

    while ESX.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    ESX.PlayerData = ESX.GetPlayerData()
end)

RegisterNetEvent('ewen:jobsbuilder')
AddEventHandler('ewen:jobsbuilder', function()
    OpenCreateEntrepriseFarmMenu()
end)

Citizen.CreateThread(function()
    Wait(2000)
    TriggerServerEvent('Mowgli:initFarmSociety')
end)

local EntrepriseFarmList = {}
local EntrepriseFarmListLoaded = false

RegisterNetEvent('Mowgli:SendEntrepriseFarmList')
AddEventHandler('Mowgli:SendEntrepriseFarmList', function(Table)
    EntrepriseFarmList = Table
    EntrepriseFarmListLoaded = true
end)

Citizen.CreateThread(function()
    while not EntrepriseFarmListLoaded do 
        Wait(1)
    end
    
    for k,v in pairs(EntrepriseFarmList) do
        Mowgli.EntrepriseFarmList = v
        local blip = AddBlipForCoord(Mowgli.EntrepriseFarmList.PosBoss.x, Mowgli.EntrepriseFarmList.PosBoss.y, Mowgli.EntrepriseFarmList.PosBoss.z)
        SetBlipSprite(blip, 181)
        SetBlipDisplay(blip, 4)
        SetBlipScale(blip, 0.8)
        SetBlipColour(blip, 38)
        SetBlipAsShortRange(blip, true)
        BeginTextCommandSetBlipName("STRING")
        AddTextComponentString("~q~Entreprise |~s~ ".. v.label)
        EndTextCommandSetBlipName(blip)

        if ESX.PlayerData.job.name == Mowgli.EntrepriseFarmList.name then 
            local blip = AddBlipForCoord(Mowgli.EntrepriseFarmList.PosRecolte.x, Mowgli.EntrepriseFarmList.PosRecolte.y, Mowgli.EntrepriseFarmList.PosRecolte.z)
            SetBlipSprite(blip, 501)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 43)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("~g~Récolte |~s~ ".. Mowgli.EntrepriseFarmList.label)
            EndTextCommandSetBlipName(blip)
            local blip = AddBlipForCoord(Mowgli.EntrepriseFarmList.PosTraitement.x, Mowgli.EntrepriseFarmList.PosTraitement.y, Mowgli.EntrepriseFarmList.PosTraitement.z)
            SetBlipSprite(blip, 501)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 43)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("~g~Traitement |~s~ ".. Mowgli.EntrepriseFarmList.label)
            EndTextCommandSetBlipName(blip)
            local blip = AddBlipForCoord(Mowgli.EntrepriseFarmList.PosVente.x, Mowgli.EntrepriseFarmList.PosVente.y, Mowgli.EntrepriseFarmList.PosVente.z)
            SetBlipSprite(blip, 501)
            SetBlipDisplay(blip, 4)
            SetBlipScale(blip, 0.8)
            SetBlipColour(blip, 43)
            SetBlipAsShortRange(blip, true)
            BeginTextCommandSetBlipName("STRING")
            AddTextComponentString("~g~Vente |~s~ ".. Mowgli.EntrepriseFarmList.label)
            EndTextCommandSetBlipName(blip)
        end
    end

    while true do
        local isProche = false
        for k,v in pairs(EntrepriseFarmList) do
            Mowgli.EntrepriseFarmList = v
           if ESX.PlayerData.job.name == Mowgli.EntrepriseFarmList.name then
               local CoffreAction = vector3(Mowgli.EntrepriseFarmList.PosBoss.x, Mowgli.EntrepriseFarmList.PosBoss.y, Mowgli.EntrepriseFarmList.PosBoss.z)

               local distanceCoffreAction = Vdist2(GetEntityCoords(PlayerPedId(), false), CoffreAction)

               if distanceCoffreAction < 50 then
                   isProche = true
               end
               if distanceCoffreAction < 3 then
                   ESX.ShowHelpNotification("~q~ParaziaRP\n~q~Appuyez sur ~INPUT_CONTEXT~ pour intéragir")
                   if IsControlJustPressed(1,51) then
                    Mowgli.Job.OpenSocietyMenu({label = ESX.PlayerData.job.label, name = ESX.PlayerData.job.name }, CoffreAction)
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

local farming = false
local WaitFarming = false

Citizen.CreateThread(function()
    while true do
        local Open = false
        for k,v in pairs(EntrepriseFarmList) do
            Mowgli.EntrepriseFarmList = v
            if ESX.PlayerData.job.name == Mowgli.EntrepriseFarmList.name then
                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(Mowgli.EntrepriseFarmList.PosRecolte.x,Mowgli.EntrepriseFarmList.PosRecolte.y, Mowgli.EntrepriseFarmList.PosRecolte.z)) < 100 then
                    Open = true
                    if not farming then
                        if not WaitFarming then
                            ESX.ShowHelpNotification('~g~Intéraction ~w~~n~Appuyez sur ~g~E ~w~pour intéragir')
                            if IsControlJustPressed(1,51) then
                                farming = true
                                WaitFarming = true
                                TriggerServerEvent('framework:startActivity', Mowgli.EntrepriseFarmList.PosRecolte, Mowgli.EntrepriseFarmList.RecolteItem, 1, '0', ESX.PlayerData.job.name)
                            end
                        else
                            ESX.ShowHelpNotification('~q~ANTI-GLITCH ~w~~n~Merci de ne pas allez trop vite')
                        end
                    else
                        DrawMissionText("~g~Appuyez sur ~w~E ~g~pour arrêter l\'activité", 100)
                        if IsControlJustPressed(1,51) then
                            farming = false
                            TriggerServerEvent('framework:stopActivity')
                            Wait(5000)
                            WaitFarming = false
                        end
                    end
                end

                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(Mowgli.EntrepriseFarmList.PosRecolte.x,Mowgli.EntrepriseFarmList.PosRecolte.y, Mowgli.EntrepriseFarmList.PosRecolte.z)) > 100 and Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(Mowgli.EntrepriseFarmList.PosRecolte.x,Mowgli.EntrepriseFarmList.PosRecolte.y, Mowgli.EntrepriseFarmList.PosRecolte.z)) < 105 then
                    farming = false
                    TriggerServerEvent('framework:stopActivity')
                    Wait(5000)
                    WaitFarming = false
                end

                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(Mowgli.EntrepriseFarmList.PosTraitement.x,Mowgli.EntrepriseFarmList.PosTraitement.y, Mowgli.EntrepriseFarmList.PosTraitement.z)) > 100 and Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(Mowgli.EntrepriseFarmList.PosTraitement.x,Mowgli.EntrepriseFarmList.PosTraitement.y, Mowgli.EntrepriseFarmList.PosTraitement.z)) < 105 then
                    farming = false
                    TriggerServerEvent('framework:stopActivity')
                    Wait(5000)
                    WaitFarming = false
                end

                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(Mowgli.EntrepriseFarmList.PosVente.x,Mowgli.EntrepriseFarmList.PosVente.y, Mowgli.EntrepriseFarmList.PosVente.z)) > 100 and Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(Mowgli.EntrepriseFarmList.PosVente.x,Mowgli.EntrepriseFarmList.PosVente.y, Mowgli.EntrepriseFarmList.PosVente.z)) < 105 then
                    farming = false
                    TriggerServerEvent('framework:stopActivity')
                    Wait(5000)
                    WaitFarming = false
                end

                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(Mowgli.EntrepriseFarmList.PosTraitement.x,Mowgli.EntrepriseFarmList.PosTraitement.y, Mowgli.EntrepriseFarmList.PosTraitement.z)) < 100 then
                    Open = true
                    if not farming then
                        if not WaitFarming then
                            ESX.ShowHelpNotification('~g~Intéraction ~w~~n~Appuyez sur ~g~E ~w~pour intéragir')
                            if IsControlJustPressed(1,51) then
                                farming = true
                                WaitFarming = true
                                TriggerServerEvent('framework:startActivity', Mowgli.EntrepriseFarmList.PosTraitement, Mowgli.EntrepriseFarmList.RecolteItem, 2, Mowgli.EntrepriseFarmList.TraitementItem, ESX.PlayerData.job.name)
                            end
                        else
                            ESX.ShowHelpNotification('~q~ANTI-GLITCH ~w~~n~Merci de ne pas allez trop vite')
                        end
                    else
                        DrawMissionText("~g~Appuyez sur ~w~E ~g~pour arrêter l\'activité", 100)
                        if IsControlJustPressed(1,51) then
                            farming = false
                            TriggerServerEvent('framework:stopActivity')
                            Wait(5000)
                            WaitFarming = false
                        end
                    end
                end

                if Vdist2(GetEntityCoords(PlayerPedId(), false), vector3(Mowgli.EntrepriseFarmList.PosVente.x,Mowgli.EntrepriseFarmList.PosVente.y, Mowgli.EntrepriseFarmList.PosVente.z)) < 100 then
                    Open = true
                    if not farming then
                        
                        if not WaitFarming then
                            ESX.ShowHelpNotification('~g~Intéraction ~w~~n~Appuyez sur ~g~E ~w~pour intéragir')
                            if IsControlJustPressed(1,51) then
                                farming = true
                                TriggerServerEvent('framework:startActivity', Mowgli.EntrepriseFarmList.PosVente, '0', 3, Mowgli.EntrepriseFarmList.TraitementItem, ESX.PlayerData.job.name)
                            end
                        else
                            ESX.ShowHelpNotification('~q~ANTI-GLITCH ~w~~n~Merci de ne pas allez trop vite')
                        end
                    else
                        DrawMissionText("~g~Appuyez sur ~w~E ~g~pour arrêter l\'activité", 100)
                        if IsControlJustPressed(1,51) then
                            farming = false
                            TriggerServerEvent('framework:stopActivity')
                            Wait(5000)
                            WaitFarming = false
                        end
                    end
                end
            end

        end
                
        if Open then
          Wait(0)
      else
          Wait(1000)
      end
    end
end)


RegisterNetEvent('framework:farmanimation')
AddEventHandler('framework:farmanimation', function()
	local dict, anim = 'random@domestic', 'pickup_low'
	local playerPed = PlayerPedId()
    ESX.Streaming.RequestAnimDict(dict)
	TaskPlayAnim(playerPed, dict, anim, 8.0, 1.0, 1000, 16, 0.0, false, false, false)
end)

OpenCreateEntrepriseFarmMenu = function()
    local main = RageUI.CreateMenu("", "~q~Création d\'une entreprise farm")

    RageUI.Visible(main, not RageUI.Visible(main))

    while main do 
        Citizen.Wait(0)
        RageUI.IsVisible(main, function()
            RageUI.Button('Name du job ( sans espace )', nil, {}, true, {
                onSelected = function() 
                    local string = tostring(KeyboardInput('Nom du job', '', '', 999))
                    if string ~= "" then
                        namejob = string
                    end
                end
            });
            if namejob ~= nil then
                RageUI.Separator(namejob)
            end
            RageUI.Button('Label du job ( Nom affiché au joueurs )', nil, {}, true, {
                onSelected = function() 
                    local string = tostring(KeyboardInput('Label ?', '', '', 999))
                    if string ~= "" then
                        labeljob = string
                    end
                end
            });
            if labeljob ~= nil then
                RageUI.Separator(labeljob)
            end
            RageUI.Button('name de l\'item récolte ( sans espace )', nil, {}, true, {
                onSelected = function() 
                    local string = tostring(KeyboardInput('Nom item', '', '', 999))
                    if string ~= "" then
                        namerecolteitem = string
                    end
                end
            });
            if namerecolteitem ~= nil then
                RageUI.Separator(namerecolteitem)
            end
            RageUI.Button('Label de l\'item récolte', nil, {}, true, {
                onSelected = function() 
                    local string = tostring(KeyboardInput('Label item récolte ?', '', '', 999))
                    if string ~= "" then
                        labelrecolteitem = string
                    end
                end
            });
            if labelrecolteitem ~= nil then
                RageUI.Separator(labelrecolteitem)
            end
            RageUI.Button('Position de la récolte', nil, {}, true, {
                onSelected = function() 
                    PositionRecolte = GetEntityCoords(PlayerPedId(), true)
                end
            });
            if PositionRecolte ~= nil then
                RageUI.Separator(PositionRecolte)
            end
            RageUI.Button('name de l\'item traitement ( sans espace )', nil, {}, true, {
                onSelected = function() 
                    local string = tostring(KeyboardInput('Item traitement', '', '', 999))
                    if string ~= "" then
                        nametraitementitem = string
                    end
                end
            });
            if nametraitementitem ~= nil then
                RageUI.Separator(nametraitementitem)
            end
            RageUI.Button('Label de l\'item traitement', nil, {}, true, {
                onSelected = function() 
                    local string = tostring(KeyboardInput('Label Item traitement', '', '', 999))
                    if string ~= "" then
                        labeltraitementitem = string
                    end
                end
            });
            if labeltraitementitem ~= nil then
                RageUI.Separator(labeltraitementitem)
            end
            RageUI.Button('Position du Traitement', nil, {}, true, {
                onSelected = function() 
                    PositionTraitement = GetEntityCoords(PlayerPedId(), true)
                end
            });
            if PositionTraitement ~= nil then
                RageUI.Separator(PositionTraitement)
            end
            RageUI.Button('Position de la vente', nil, {}, true, {
                onSelected = function() 
                    PositionVente = GetEntityCoords(PlayerPedId(), true)
                end
            });
            if PositionVente ~= nil then
                RageUI.Separator(PositionVente)
            end
            RageUI.Button('Position du coffre entreprise', nil, {}, true, {
                onSelected = function() 
                    PositionCoffreEntreprise = GetEntityCoords(PlayerPedId(), true)
                end
            });
            if PositionCoffreEntreprise ~= nil then
                RageUI.Separator(PositionCoffreEntreprise)
            end
            RageUI.Button('~g~Confirmer', nil, {}, true, {
                onSelected = function() 
                    print(labeltraitementitem)
                    TriggerServerEvent('Mowgli:CreateFarmEntreprise', namejob, labeljob, namerecolteitem, labelrecolteitem, PositionRecolte, nametraitementitem, labeltraitementitem, PositionTraitement, PositionVente, PositionCoffreEntreprise)
                    RageUI.CloseAll()
                end
            });
        end)
        if not RageUI.Visible(main) then
            main = RMenu:DeleteType('main', true)
        end
    end
end

