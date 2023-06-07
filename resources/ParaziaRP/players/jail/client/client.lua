
--[[
  This file is part of Ronflex Shop.

  Copyright (c) Ronflex Shop - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil


Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent(Jail.ESX..'sova:KraKss0TEX0', function(obj) ESX = obj end)
        Citizen.Wait(0)
    end
end)

local JailTime = 0

RegisterNetEvent("requestRequetteJailTime")
AddEventHandler("requestRequetteJailTime", function(result)
    JailTime = result
    if JailTime == 0 then
        JailUI.CloseAll()
    end 
end)


RegisterNetEvent("ronflex:menujail")
AddEventHandler("ronflex:menujail", function(time, raison, staffname)
    local mainjail = JailUI.CreateMenu("", "Vous êtes emprisonnée")
    mainjail.Closable = false 
    
    JailUI.Visible(mainjail, not JailUI.Visible(mainjail))

    inJail = true 


    while mainjail do 

        Wait(0)

      
        JailUI.IsVisible(mainjail, function()
            if tostring(JailTime) == "1" then 
                JailUI.Separator("Temps restant:~g~ 1 minute")
            else
                JailUI.Separator("Temps restant:~g~ "..ESX.Math.Round(JailTime).." minutes")
            end


            if raison ~= nil then 
                JailUI.Button("Raison: ~o~"..raison.."", nil, {}, true, {})
            else
                JailUI.Button("Raison: ~o~ Indéfinie", nil, {}, true, {})
            end

            if staffname ~= nil then 
                JailUI.Button("Nom du staff: ~g~"..staffname, nil, {}, true, {})
            else
                JailUI.Button("> CONSOLE", nil, {}, true, {})
            end

        end, function()
        end)

        if not JailUI.Visible(mainjail) then 
            mainjail = RMenu:DeleteType('mainjail')
        end
    end
end)

Citizen.CreateThread(function()
    Wait(2500)
    TriggerServerEvent("requestjailtime")
    while true do
        if tonumber(JailTime) >= 1 then
            Wait(60000)
            JailTime = JailTime - 1
            TriggerServerEvent("UpdateJailTick", JailTime)
        end
        if tonumber(JailTime) == 0 then 
            JailUI.CloseAll()
        end
        Wait(2500)
    end
end)

Citizen.CreateThread(function()
    while true do
        if tonumber(JailTime) >= 1 then
            if #(GetEntityCoords(PlayerPedId()) - Jail.PointEntrer) > 25 then
                SetEntityCoords(PlayerPedId(), Jail.PointEntrer)
            end
            if tonumber(JailTime) == 1 then 
                DrawMissionText('~w~Vous avez été mis en prison par un membre du staff\nVous sortirez dans ~q~'..ESX.Math.Round(JailTime)..' ~w~minute', 100)
            else
                DrawMissionText('~w~Vous avez été mis en prison par un membre du staff\nVous sortirez dans ~q~'..ESX.Math.Round(JailTime)..' ~w~minutes', 100)
            end
        end
        if tonumber(JailTime) >= 1 then
            Wait(0)
        else
            Wait(2500)
        end
    end

end)

function DrawMissionText(msg, time)
    ClearPrints()
    BeginTextCommandPrint('STRING')
    AddTextComponentSubstringPlayerName(msg)
    EndTextCommandPrint(time, 1)
end

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/jail', 'Id, temps, raison')
    TriggerEvent('chat:addSuggestion', '/jailoffline', 'license, temps, raison ')
    TriggerEvent('chat:addSuggestion', '/unjail', 'Id')
end)

AddEventHandler('esx:onPlayerDeath', function(aa)
    TriggerServerEvent("ronflex:updatejailplayerider", true)
end)

-- CHANGEMENT BY SANDLIFE - JAIL

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/jail', 'Id, temps, raison')

end)

-- CHANGEMENT BY SANDLIFE - JAILOFFLINE

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/jailoffline', 'license, temps, raison ')

end)


-- CHANGEMENT BY SANDLIFE - JAILOFFLINE

Citizen.CreateThread(function()
    TriggerEvent('chat:addSuggestion', '/unjail', 'Id')

end)