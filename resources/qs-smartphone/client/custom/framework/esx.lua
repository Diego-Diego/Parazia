--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "esx" then
    return
end

Citizen.CreateThread(function()
    local legacyEsx = pcall(function()
        ESX = exports['kFramework']:getSharedObject()
    end)
    if not legacyEsx then  
        TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
    end

	while QS == nil do
		TriggerEvent('qs-base:getSharedObject', function(ASD) QS = ASD end)
		Citizen.Wait(0)
	end

	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	
	ESX.PlayerData = ESX.GetPlayerData()

	Citizen.Wait(200)

	TriggerServerEvent('qs-smartphone:server:btShare', false)
end)

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
    PlayerData = xPlayer
    if not firstTime then 
        firstTime = true
        LoadPhone() 
    end
    if Config.UseESXchecks then
        TriggerServerEvent('qs-smartphone:CheckHavePhoneStatus')
    end
end)

RegisterNetEvent('esx:onPlayerLogout')
AddEventHandler('esx:onPlayerLogout', function()
    DebugPrint('multicharacter > Player logout!')
    deletePhone() -- Prop queda flotando permanentemente
    firstTime = false
    loading = false
    Config.PhoneApplications = configDefault
    while not firstTime do
        Citizen.Wait(100)
    end
    DebugPrint('multicharacter > Loading character again!')
    Citizen.Wait(1000)
    TriggerServerEvent('qs-smartphone:CheckHavePhoneStatus')
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
    TriggerServerCallback('qs-smartphone:GetUserApps', function(apps)
        SendNUIMessage({
            action = "UpdateApplications",
            JobData = job,
            applications = Config.PhoneApplications
        })
    end)
    ESX.PlayerData.job = job
end)

function TriggerServerCallback(name, cb, ...)
    ESX.TriggerServerCallback(name, cb, ...)
end

function GetPlayerIdentifier()
	return ESX.GetPlayerData().identifier
end

function GetPlayerDataFramework()
	return QS.GetPlayerData()
end

function GetJobFramework()
	return ESX.GetPlayerData().job
end

function GetClosestVehicleFramework()
	return ESX.Game.GetClosestVehicle()
end

function GetVehicles()
	return ESX.Game.GetVehicles()
end

function GetClosestPlayer()
	return ESX.Game.GetClosestPlayer()
end
 
function Trim(number)
	return ESX.Math.Trim(number)
end

function SendTextMessage(msg, type)
    if type == 'inform' then 
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)
    end
    if type == 'error' then 
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)
    end
    if type == 'success' then 
        SetNotificationTextEntry('STRING')
        AddTextComponentString(msg)
        DrawNotification(0,1)
    end
end

function ShowHelpNotification(msg)
    BeginTextCommandDisplayHelp("STRING")
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandDisplayHelp(0, 0, false, -1)
end
    
function DrawText3D(x, y, z, text)
	SetTextScale(0.4, 0.4)
    SetTextFont(4)
    SetTextProportional(1)
    SetTextColour(255, 255, 255, 215)
    SetTextEntry("STRING")
    SetTextCentre(true)
    AddTextComponentString(text)
    SetDrawOrigin(x,y,z, 0)
    DrawText(0.0, 0.0)
    ClearDrawOrigin()
end