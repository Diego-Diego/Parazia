local ESX = nil
local hudOn = false
TriggerEvent("sova:KraKss0TEX0", function(obj) ESX = obj end)

local hunger;
local thirst;
local speedoOk = false
local showHud = false

AddEventHandler('playerSpawned', function(spawn)
    Wait(8000)
    ShowHUD()
end)

function ShowHUD()
    CreateThread(function()
        showHud = true
        while showHud do
            local xPlayer = ESX.GetPlayerData()
    
            for i = 1, #xPlayer.accounts, 1 do
                if xPlayer.accounts[i].name == "cash" then
                    cash = ValueCash(xPlayer.accounts[i].money)
                elseif xPlayer.accounts[i].name == "dirtycash" then
                    dirtyCash = ValueCash(xPlayer.accounts[i].money)
                end
            end
    
            TriggerEvent('esx_status:getStatus', 'hunger', function(status)
                hunger = status.getPercent()
            end)
            TriggerEvent('esx_status:getStatus', 'thirst', function(lul)
                thirst = lul.getPercent()
            end)
            SendNUIMessage({
                action = "updateHud",
                liquide = cash..'$',
                sale = dirtyCash..'$',
                bouf = hunger,
                soif = thirst,
                -- playerCount = PlayerHud(#playerCount),
                id = IdHud(GetPlayerServerId(PlayerId())),
                health = GetEntityHealth(PlayerPedId()) - 100,
                armour = GetPedArmour(PlayerPedId()),
                job = xPlayer.job.label.." - "..xPlayer.job.grade_label,
                job2 = xPlayer.job2.label.." - "..xPlayer.job2.grade_label,
            })
            if GetPedArmour(PlayerPedId()) > 1 then
                SendNUIMessage({
                    action = "setShield",
                    status = true,
                })
            else
                SendNUIMessage({
                    action = "setShield",
                    status = false,
                })
            end
            Wait(1800)
        end
    end)     
end
CreateThread(function()
    while true do
        if NetworkIsPlayerTalking(PlayerId()) then
            SendNUIMessage({
                action = "updateVoice",
                talking = true,
            })
        else
            SendNUIMessage({
                action = "updateVoice",
                talking = false,
            })
        end
        Wait(100)
    end
end)

RegisterCommand("hud", function()
    SetNuiFocus(true, true)
    SendNUIMessage({
        action = "setHudMenu",
    })
end)
RegisterNUICallback("close", function(data)
    SetNuiFocus(false, false)
end)


function PlayerHud(count)
    if count == 0 then
        return "000"
    elseif count > 0 and count < 10 then
        return "00"..count
    elseif count > 10 and count < 100 then
        return "0"..count
    elseif count > 100 and count < 1000 then
        return count
    end
end

function IdHud(count)
    if count == 0 then
        return "000"
    elseif count > 0 and count < 10 then
        return "00"..count
    elseif count > 10 and count < 100 then
        return "0"..count
    elseif count > 100 and count < 1000 then
        return count
    end
end

function SpeedHud(speed)
    if speed == 0 then
        return "000"
    elseif speed > 0 and speed < 10 then
        return "00"..speed
    elseif speed > 10 and speed < 100 then
        return "0"..speed
    elseif speed > 100 and speed < 1000 then
        return speed
    end
end

function ValueCash(value)
	local left,num,right = string.match(value,'^([^%d]*%d)(%d*)(.-)$')

	return left..(num:reverse():gsub('(%d%d%d)','%1' .. "."):reverse())..right
end

RegisterCommand("testhud", function()
    ShowHUD()
end)