ESX = nil

local menuIsOpen = false
local avaibleVehicles = nil
local colorVar = "~o~"
local hasLoadedAllModels = false
local currentPreviewVehicle = 1
local heading = 0.0
local currentPreviewVeh = nil
local currentPreviewModel = nil
local awaitingServerCallback = false
local cam = nil

local currentGarage = nil
local ownedVehicles = nil
local awaitingOwnedVehicles = true
local awaitingVehicleOut = false
local requestedOutVehicle = {}

RegisterNetEvent("esx_aerodealer:callbackAeronefs")
AddEventHandler("esx_aerodealer:callbackAeronefs", function(vehs)
    ownedVehicles = vehs
end)

RegisterNetEvent("esx_aerodealer:serverCallback")
AddEventHandler("esx_aerodealer:serverCallback", function(success)
    if success then
        awaitingServerCallback = false
        PlaySoundFrontend(-1, "BASE_JUMP_PASSED", "HUD_AWARDS", 1)
        ESX.ShowNotification(msg_aeronef_purchassed)
    else
        awaitingServerCallback = false
        ESX.ShowNotification(msg_no_enough_money)
    end
end)

RegisterNetEvent("esx_aerodealer:callbackVehicles")
AddEventHandler("esx_aerodealer:callbackVehicles", function(vehicles)
    avaibleVehicles = vehicles
end)


local function loadModels()
    Citizen.CreateThread(function()
        for k,v in pairs(avaibleVehicles) do
            local model = GetHashKey(v.model)
            RequestModel(model)
            while not HasModelLoaded(model) do Wait(1) end
        end
        hasLoadedAllModels = true
        if menuIsOpen then
            cam = CreateCam("DEFAULT_SCRIPTED_CAMERA", 0)
            SetCamCoord(cam, 1715.57, 3276.43, 51.81)
            SetCamActive(cam, true)
            SetCamFov(cam, 30.0)
            PointCamAtCoord(cam, preview_position)
            RenderScriptCams(1, 2500, 2500, 0, 0)
        end
    end)
end

local function openMenu()
    cam = nil
    currentPreviewModel = nil
    currentPreviewVeh = nil
    previewHeading = 0.0
    hasLoadedAllModels = false
    avaibleVehicles = nil
    if awaitingServerCallback then 
        ESX.ShowNotification(msg_awaiting_server_response)
    return end
    if menuIsOpen then return end
    TriggerServerEvent("esx_aerodealer:requestVehicles")
    FreezeEntityPosition(PlayerPedId(), true)
    menuIsOpen = true
    RMenu.Add("aerodealer", "aerodealer_main", RageUI.CreateMenu("",menu_airplanedealer_subtitle))
    RMenu.Add('aerodealer', 'aerodealer_fetch', RageUI.CreateSubMenu(RMenu:Get('aerodealer', 'aerodealer_main'), "", menu_airplanedealer_subtitle))
    RMenu:Get("aerodealer", "aerodealer_main").Closed = function() end
    RMenu:Get("aerodealer", "aerodealer_fetch").Closed = function() end
    RMenu:Get("aerodealer", "aerodealer_fetch").Closable = false
    RageUI.Visible(RMenu:Get("aerodealer",'aerodealer_main'),true)

    Citizen.CreateThread(function()
        while menuIsOpen do
            Wait(800)
            if colorVar == "~o~" then colorVar = "~r~" else colorVar = "~o~" end
        end
    end)

    Citizen.CreateThread(function()
        while menuIsOpen do
            if currentPreviewVeh then 
                heading = heading + 0.2
                SetEntityHeading(currentPreviewVeh, heading) 
            end
            Wait(1)
        end
    end)

    Citizen.CreateThread(function()
        while menuIsOpen do
            shouldStayOpened = false

            RageUI.IsVisible(RMenu:Get("aerodealer",'aerodealer_main'),true,true,true,function()
                shouldStayOpened = true
                if not avaibleVehicles then
                    RageUI.Separator("") RageUI.Separator(colorVar..msg_awaiting_server_infos) RageUI.Separator("")
                else
                    RageUI.ButtonWithStyle(menu_airplanedealer_button_showVehicles, nil, {RightLabel = "~s~→→"}, true, function(Hovered,Active,Selected)
                        if Selected then 
                            loadModels()
                        end
                        
                    end, RMenu:Get("aerodealer","aerodealer_fetch"))
                end
            end, function()    
            end, 1)

            RageUI.IsVisible(RMenu:Get("aerodealer",'aerodealer_fetch'),true,true,true,function()
                shouldStayOpened = true
                if not hasLoadedAllModels then
                    RageUI.Separator("") RageUI.Separator(colorVar..msg_loading_airplanedealer_vehicles) RageUI.Separator("")
                else
                    local requestModel = nil
                    RageUI.ButtonWithStyle("~r~Sortir", nil, {RightLabel = "~s~→→"}, true, function(Hovered,Active,Selected)
                        if Selected then 
                            shouldStayOpened = false
                        end
                    end)
                    RageUI.Separator("↓ "..colorVar.."Véhicules disponibles ~s~↓")
                    for k, v in pairs(avaibleVehicles) do 
                        RageUI.ButtonWithStyle("~y~"..v.label, nil, {RightLabel = "~g~"..ESX.Math.GroupDigits(tonumber(v.price)).."$ ~s~→→"}, true, function(Hovered,Active,Selected)
                            if Active then
                                requestModel = v.model
                            end
                            if Selected then
                                print(k)
                                TriggerServerEvent("esx_aerodealer:buyVehicle", k, ESX.Game.GetVehicleProperties(currentPreviewVeh))
                                awaitingServerCallback = true
                                shouldStayOpened = false
                            end
                        end)
                    end
                    if requestModel and requestModel ~= currentPreviewModel then
                        if currentPreviewVeh then DeleteEntity(currentPreviewVeh) end
                        currentPreviewModel = requestModel
                        currentPreviewVeh = CreateVehicle(GetHashKey(requestModel), preview_position, 0, false, false)
                        SetEntityAsMissionEntity(currentPreviewVeh, 1,1)
                        SetEntityAlpha(currentPreviewVeh, 155, false)
                    end
                end
            end, function()    
            end, 1)

            Wait(0)
            if not shouldStayOpened then menuIsOpen = false end
        end
        if currentPreviewVeh then DeleteEntity(currentPreviewVeh) end
        RenderScriptCams(0, 0, 0, 0, 0)
        FreezeEntityPosition(PlayerPedId(), false)
        RMenu:Delete("aerodealer","aerodealer_main")
        RMenu:Delete("aerodealer","aerodealer_fetch")
        menuIsOpen = false
    end)
end

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent(trigger, function(obj) ESX = obj end) -- REMPLACEZ CETTE LIGNE EN FONCTION DE VOTRE SERVEUR !
		Citizen.Wait(0)
	end

    DecorRegister("owner", 3)
    DecorRegister("vehicleID", 3)

    local blip = AddBlipForCoord(buy_marker)
    SetBlipAsShortRange(blip, true)
    SetBlipSprite(blip, 572)
    BeginTextCommandSetBlipName('STRING')
    AddTextComponentSubstringPlayerName(blip_airplanedealer)
    EndTextCommandSetBlipName(blip)
    SetBlipColour(blip, 5)

    local interval = 0
    while true do
        interval = 150
        local position = GetEntityCoords(PlayerPedId())
        local distance = GetDistanceBetweenCoords(buy_marker, position, true)
        if distance <= 100 then
            interval = 1
            DrawMarker(22, buy_marker, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.45, 0.45, 0.45, 255,0,0, 255, 55555, false, true, 2, false, false, false, false)
            if distance <= 1.5 then
                ESX.ShowHelpNotification(help_open_airplanedealer)
                if IsControlJustPressed(0, 51) then
                    openMenu()
                end
            end 
        end

        Wait(interval)
    end
end)


