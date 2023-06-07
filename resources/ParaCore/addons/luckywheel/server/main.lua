---@author Pablo Z.
---@version 1.0
--[[
  This file is part of VisionRP.
  
  File [main] created at [21/04/2021 21:01]

  Copyright (c) VisionRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local availableRewards = {
    "adder",
    "mk8r"
}

local vendorNpc, vendorZone
local currentVehicle = availableRewards[math.random(1, #availableRewards)]

local currentlyAwaitingTurnPlayers = {}
local timedPlayers = {}

local paidTurns = {}

function CFXID(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for _, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers[_]
        end
        return identifiers
    else
        error("source is nil")
    end
end


AddEventHandler("addPaidTurn", function(license)
    if not paidTurns[license] then
        paidTurns[license] = 0
        MySQL.Async.insert("INSERT INTO VisionRP_luckwheel_paid (license) VALUES(@a)", {
            ['a'] = license
        })
    else
        paidTurns[license] = paidTurns[license] + 1
        MySQL.Async.execute("UPDATE VisionRP_luckwheel_paid SET ammount = ammount + 1 WHERE license = @a", {
            ['a'] = license
        })
    end
end)

AddEventHandler("removePaidTurn", function(license)
    if not paidTurns[license] then
        return
    end
    local final = (paidTurns[license] - 1)
    if final <= 0 then
        paidTurns[license] = nil
        MySQL.Async.execute("DELETE FROM VisionRP_luckwheel_paid WHERE license = @a", {
            ['a'] = license
        })
    else
        paidTurns[license] = final
        MySQL.Async.execute("UPDATE VisionRP_luckwheel_paid SET ammount = ammount - 1 WHERE license = @a", {
            ['a'] = license
        })
    end
end)

local function countPaidTurns(license)
    return paidTurns[license] or 0
end

local function recomp(str, source, color)
    ParaziaRPServerUtils.webhook(("Le joueur %s a gagné: %s"):format(GetPlayerName(source), str), color, "https://discord.com/api/webhooks/994016536144658452/OjW9opVMx6UV5e3tJaFIwdmiZ1xECno0wsSjpLlQufVxfC7Lo5Ynx4573NaNxOsWKIMl")
end

ParaziaRPServerUtils.registerConsoleCommand("luckywheelSetCar", function(source, args)
    currentVehicle = args[1]
    ParaziaRPServerUtils.trace("Véhicule de la roue changée !", ParaziaRPPrefixes.succes)
    ParaziaRPServerUtils.toAll("luckywheelVehicleChange", args[1])
end)

ParaziaRPSPlayersManager.registerEventOverrider(PLAYER_EVENT_TYPE.LEAVING, function(source)
    currentlyAwaitingTurnPlayers[source] = nil
end)

RegisterNetEvent("luckywheelRequestFinalPrice")
AddEventHandler("luckywheelRequestFinalPrice", function(vehicleProps)
    print("Received event")
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    ---@type Player
    local VisionRPPlayer = ParaziaRPSPlayersManager.getPlayer(source)
    if currentlyAwaitingTurnPlayers[source] == nil then
        return
    end
    if currentlyAwaitingTurnPlayers[source] == "free" then
        currentlyAwaitingTurnPlayers[source] = nil
        local ran = math.random(1, 30)
        if ran == 5 then
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, state) VALUES (@owner, @plate, @vehicle, @type, 1)', {
                ['@owner'] = xPlayer.identifier,
                ['@plate'] = vehicleProps.plate,
                ['@vehicle'] = json.encode(vehicleProps),
                ['@type'] = "car"
            })
            ParaziaRPServerUtils.toClient("advancedNotif", source, "~q~VisionRP", "~y~Roue de la chance", "~g~Félicitations ~s~! Vous avez gagné la ~q~voiture ~s~!", "CHAR_SEALIFE", 1)
            recomp("car", source, "red")
            return
        end
        --if ran <= 10 then
            --local expRandom = math.random(900, 1900)
            --VisionRPPlayer:setAddonCache("exp", (VisionRPPlayer:getAddonCache("exp") + expRandom), true)
            --ParaziaRPServerUtils.toClient("advancedNotif", source, "~q~VisionRP", "~y~Roue de la chance", ("~g~Félicitations ~s~! Vous avez gagné ~q~%s EXP !"):format(expRandom), "CHAR_SEALIFE", 1)
            --recomp(("%s exp"):format(expRandom), source, "orange")
            --return
        --end
        if ran <= 20 then
            local moneyRandom = math.random(5000, 13500)
            xPlayer.addAccountMoney('cash', moneyRandom)
            ParaziaRPServerUtils.toClient("advancedNotif", source, "~q~VisionRP", "~y~Roue de la chance", ("~g~Félicitations ~s~! Vous avez gagné ~g~%s$ ~s~!"):format(moneyRandom), "CHAR_SEALIFE", 1)
            recomp(("%s$"):format(moneyRandom), source, "green")
            return
        end
        ParaziaRPServerUtils.toClient("advancedNotif", source, "~q~VisionRP", "~y~Roue de la chance", "~q~Dommage ~s~! Vous n'avez rien gagné... Revenez une prochaine fois !", "CHAR_SEALIFE", 1)
        recomp("rien", source, "grey")
        return
    elseif currentlyAwaitingTurnPlayers[source] == "paid" then
        currentlyAwaitingTurnPlayers[source] = nil
        local ran, plate = math.random(1, 30), ParaziaRPGameUtils.GeneratePlate()
        if ran == 5 then
            -- INSERT INTO tebex_players_wallet (identifiers, transaction, price, currency, points) VALUES ('{id}', '{transaction}', '{packagePrice}', '{currency}', '1500')
            local identifier = ParaziaRPServerUtils.getIdentifiers(source);
            if (identifier['fivem']) then
                local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
                MySQL.Async.execute("INSERT INTO tebex_players_wallet (identifiers, transaction, price, currency, points) VALUES (@a, 'Roue', '0', 'EUR', '1500')", {
                    ['a'] = after
                })
            end
            ParaziaRPServerUtils.toClient("advancedNotif", source, "~q~VisionRP", "~y~Roue de la chance", "~g~Félicitations ~s~! Vous avez gagné la ~q~1500 Pultions~s~!", "CHAR_SEALIFE", 1)
            return
        end
        if ran <= 10 then
            MySQL.Async.execute('INSERT INTO owned_vehicles (owner, plate, vehicle, type, state) VALUES (@owner, @plate, @vehicle, @type, 1)', {
                ['@owner'] = xPlayer.identifier,
                ['@plate'] = vehicleProps.plate,
                ['@vehicle'] = "{\"model\":"..ParaziaRP.hash("mk8r")..",\"plate\":\""..plate.."\"}",
                ['@type'] = "car"
            })
            ParaziaRPServerUtils.toClient("advancedNotif", source, "~q~VisionRP", "~y~Roue de la chance", "~g~Félicitations ~s~! Vous avez gagné la ~q~MK8R ~s~!", "CHAR_SEALIFE", 1)
            return
        end
        if ran <= 20 then
            local moneyRandom = 250000
            xPlayer.addAccountMoney('cash', moneyRandom)
            ParaziaRPServerUtils.toClient("advancedNotif", source, "~q~VisionRP", "~y~Roue de la chance", ("~g~Félicitations ~s~! Vous avez gagné ~g~%s$ ~s~!"):format(moneyRandom), "CHAR_SEALIFE", 1)
            return
        end
        ParaziaRPServerUtils.toClient("advancedNotif", source, "~q~VisionRP", "~y~Roue de la chance", "~q~Dommage ~s~! Vous n'avez rien gagné... Revenez une prochaine fois !", "CHAR_SEALIFE", 1)
        recomp("rien", source, "grey")
        return
    end
    -- @TODO -> Faire une variante pour les payantes
end)

RegisterNetEvent("luckywheelRequestFreeTurn")
AddEventHandler("luckywheelRequestFreeTurn", function()
    local source = source
    local license = ParaziaRPServerUtils.getLicense(source)
    local time = os.time()
    local cd = time + ((60 * 60) * 24)
    if timedPlayers[license] ~= nil then
        return
    end
    MySQL.Async.fetchAll("INSERT INTO VisionRP_luckywheel (license,time) VALUES(@a,@b)", { ['a'] = license, ['b'] = cd })
    currentlyAwaitingTurnPlayers[source] = "free"
    timedPlayers[license] = cd
    ParaziaRPServerUtils.toClient("luckywheelCbTurn", source)
end)

RegisterNetEvent("luckywheelRequestPaidTurn")
AddEventHandler("luckywheelRequestPaidTurn", function()
    local source = source
    local license = ParaziaRPServerUtils.getLicense(source)
    if countPaidTurns(license) <= 0 then
        return
    end
    ParaziaRP.toInternal("removePaidTurn", license)
    currentlyAwaitingTurnPlayers[source] = "paid"
    ParaziaRPServerUtils.toClient("luckywheelCbTurn", source)
end)

RegisterNetEvent("luckywheelRequestCurrentVehicle")
AddEventHandler("luckywheelRequestCurrentVehicle", function()
    local source = source
    ParaziaRPServerUtils.toClient("luckywheelCbCurrentVehicle", source, currentVehicle)
end)

AddEventHandler("esxloaded", function()
    MySQL.Async.fetchAll("SELECT * FROM VisionRP_luckwheel_paid", {}, function(result)
        for k,v in pairs(result) do
            paidTurns[v.license] = v.ammount
        end
    end)
    vendorNpc = ParaziaRPSNpcsManager.createPublic("a_m_y_stbla_02", false, true, { coords = vector3(218.1947479248, -868.87200927734, 30.492116928101), heading = 255.41 }, "WORLD_HUMAN_HIKER_STANDING", nil)
    vendorNpc:setInvincible(true)
    vendorNpc:setFloatingText("Si tu veux faire tourner la roue ~q~VisionRP~s~, c'est par ici !", 8.5)

    vendorZone = ParaziaRPSZonesManager.createPublic(vector3(220.05, -869.4, 30.49), 22, { r = 3, g = 157, b = 252, a = 255 }, function(source)
        vendorNpc:playSpeechForPlayer("GENERIC_HI", "SPEECH_PARAMS_FORCE_NORMAL_CLEAR", source)
        local license = ParaziaRPServerUtils.getLicense(source)
        if timedPlayers[license] ~= nil then
            local time = os.time()
            if timedPlayers[license] <= time then
                timedPlayers[license] = nil
                MySQL.Async.execute("DELETE FROM VisionRP_luckywheel WHERE license = @a", { ['a'] = license })
                ParaziaRPServerUtils.toClient("luckywheelOpenMenu", source, true, countPaidTurns(license))
            else
                ParaziaRPServerUtils.toClient("luckywheelOpenMenu", source, false, countPaidTurns(license))
            end
        else
            ParaziaRPServerUtils.toClient("luckywheelOpenMenu", source, true, countPaidTurns(license))
        end
    end, "Appuyez sur ~INPUT_CONTEXT~ pour parler au vendeur de tickets", 15.0, 1.0)

    ParaziaRPSBlipsManager.createPublic(vector3(220.05, -869.4, 30.49), 681, 18, 0.8, "Roue de la chance", true)

    local time = os.time()
    MySQL.Async.fetchAll("SELECT * FROM VisionRP_luckywheel", {}, function(result)
        for k, v in pairs(result) do
            if v.time <= time then
                MySQL.Async.execute("DELETE FROM VisionRP_luckywheel WHERE license = @a", { ['a'] = v.license })
            else
                timedPlayers[v.license] = v.time
            end
        end
    end)
end)

RegisterNetEvent("luckywheelPaidTurn")
AddEventHandler("luckywheelPaidTurn", function()
    local source = source
    local price = 1500
    local license = ParaziaRPServerUtils.getLicense(source)
    local identifier = CFXID(source);
    if (identifier['fivem']) then
        local before, after = identifier['fivem']:match("([^:]+):([^:]+)")
        MySQL.Async.fetchAll("SELECT SUM(points) FROM tebex_players_wallet WHERE identifiers = @identifiers", {
            ['@identifiers'] = after
        }, function(result)
            local current = tonumber(result[1]["SUM(points)"]);
            if (current ~= nil) then
                if (current >= price) then
                    MySQL.Async.execute('INSERT INTO tebex_players_wallet (identifiers, transaction, price, currency, points) VALUES (@identifiers, @transaction, @price, @currency, @points)', {
                        ["@identifiers"] = after,
                        ["@transaction"] = "Achat d'un tour de roue de la fortune",
                        ["@price"] = '0',
                        ["@currency"] = 'Points',
                        ["@points"] = -500,
                    }, function(result)
                        ParaziaRP.toInternal("addPaidTurn", license)
                        ParaziaRPServerUtils.toClient("luckywheelPaidCbTurn", source)
                    end);
                else
                    ParaziaRPServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~q~VisionRP", "Vous ne procédez pas les points nécessaires pour un tour de roue de la fortune.", "CHAR_SEALIFE", 1)
                    ParaziaRPServerUtils.toClient("luckywheelPaidNotCbTurn", source)
                end
            else
                ParaziaRPServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~q~VisionRP",  "~q~Dommage~s~, Vous n'avez pas lié votre compte (~g~forum.cfx.re~s~) à fivem !", "CHAR_SEALIFE", 1)
                ParaziaRPServerUtils.toClient("luckywheelPaidNotCbTurn", source)
            end
        end);
    else
        AstraServerUtils.toClient("advancedNotif", source, "Roue de la fortune", "~q~VisionRP",  "~q~Dommage~s~, Vous n'avez pas lié votre compte (~g~forum.cfx.re~s~) à fivem !", "CHAR_SEALIFE", 1)
        AstraServerUtils.toClient("luckywheelPaidNotCbTurn", source)
    end
end)