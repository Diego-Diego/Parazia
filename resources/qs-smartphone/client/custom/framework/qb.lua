--[[ 
    Hi dear customer or developer, here you can fully configure your server's 
    framework or you could even duplicate this file to create your own framework.

    If you do not have much experience, we recommend you download the base version 
    of the framework that you use in its latest version and it will work perfectly.
]]

if Config.Framework ~= "qb" then
    return
end

qb_menu_name = 'qb-menu'

Citizen.CreateThread(function()
    QBCore = exports['qb-core']:GetCoreObject()

    while QBCore.Functions.GetPlayerData().job == nil do
        Citizen.Wait(10)
    end

    PlayerData = QBCore.Functions.GetPlayerData()

    Citizen.Wait(200)

    TriggerServerEvent('qs-smartphone:server:btShare', false)
end)

RegisterNetEvent('QBCore:Client:OnPlayerLoaded')
AddEventHandler('QBCore:Client:OnPlayerLoaded', function(xPlayer)
    PlayerData = xPlayer
    if not firstTime then
        firstTime = true 
        LoadPhone()
    end
    TriggerServerEvent('smartphone:playerLoaded')
end)

RegisterNetEvent('QBCore:Client:OnPlayerUnload')
AddEventHandler('QBCore:Client:OnPlayerUnload', function()
    DebugPrint('multicharacter > Player logout!')
    deletePhone() -- Prop queda flotando permanentemente
    firstTime = false
    loading = false
    Config.PhoneApplications = configDefault
    while not firstTime do
        Citizen.Wait(100)
    end
    DebugPrint('multicharacter > Loading character again!')
end)

RegisterNetEvent('QBCore:Player:SetPlayerData', function(val)
    QBCore.PlayerData = val
    if actualJob ~= val.job.name then
        actualJob = val.job.name
        TriggerServerCallback('qs-smartphone:GetUserApps', function(apps)
            SendNUIMessage({
                action = "UpdateApplications",
                JobData = val.job,
                applications = Config.PhoneApplications
            })
        end)
    end
    local Inventory = QBCore.PlayerData.items
    HavePhone = HavePhoneQBCore(Inventory)
end)

function TriggerServerCallback(name, cb, ...)
    QBCore.Functions.TriggerCallback(name, cb, ...)
end

function GetPlayerIdentifier()
    return QBCore.Functions.GetPlayerData().citizenid
end

function GetPlayerDataFramework()
    return QBCore.Functions.GetPlayerData()
end

function GetJobFramework()
    return QBCore.Functions.GetPlayerData().job
end

function GetClosestVehicleFramework()
    return QBCore.Functions.GetClosestVehicle()
end

function GetVehicles()
    return QBCore.Functions.GetVehicles()
end

function GetClosestPlayer()
    return QBCore.Functions.GetClosestPlayer()
end

function Trim(number)
    return QBCore.Shared.Trim(number)
end

function SendTextMessage(msg, type)
    if type == 'inform' then
        QBCore.Functions.Notify(msg, 'primary', 5000)
    end
    if type == 'error' then
        QBCore.Functions.Notify(msg, 'error', 5000)
    end
    if type == 'success' then
        QBCore.Functions.Notify(msg, 'success', 5000)
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