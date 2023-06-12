
--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil
menuIsOpened = false

ParaziaRP.newThread(function()
    Wait(1500)
    while ESX == nil do
        TriggerEvent("sova:KraKss0TEX0", function(obj)
            ESX = obj
        end)
        Wait(1)
    end
    ESX.PlayerData = ESX.GetPlayerData()
    while ESX.GetPlayerData().job == nil do
        Wait(1)
    end
    Job = ESX.PlayerData.job
    if Jobs.list[Job.name] ~= nil and Jobs.list[Job.name].onChange ~= nil then
        Jobs.list[Job.name].onChange()
    end
    ParaziaRP.toInternal("esxloaded")
    ParaziaRPClientUtils.toServer("jobInitiated", Job)
end)

RegisterNetEvent("esx:setJob")
AddEventHandler("esx:setJob", function(job)
    ESX.PlayerData = ESX.GetPlayerData()
    Job = ESX.PlayerData.job
    ParaziaRPClientUtils.toServer("jobUpdated", job)
end)

local antispam = false
RegisterCommand("co", function()
    if antispam then return end
    ParaziaRPClientUtils.toServer("coords", GetEntityCoords(PlayerPedId()))
    antispam = true
    ParaziaRP.newWaitingThread(500, function()
        antispam = false
    end)
end)

-- Delete type vehicle
Citizen.CreateThread(function()
    while true do
        Citizen.Wait(50)
        
        SetVehicleModelIsSuppressed(GetHashKey("rubble"), true)
        SetVehicleModelIsSuppressed(GetHashKey("taco"), true)
        SetVehicleModelIsSuppressed(GetHashKey("biff"), true)
        SetVehicleModelIsSuppressed(GetHashKey("blimp"), true)
        SetVehicleModelIsSuppressed(GetHashKey("blimp2"), true)
    end
end)