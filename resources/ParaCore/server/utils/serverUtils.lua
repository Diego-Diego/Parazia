--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRPServerUtils = {}

ParaziaRPServerUtils.toClient = function(eventName, targetId, ...)
    TriggerClientEvent("ParaziaRP:" .. ParaziaRP.hash(eventName), targetId, ...)
end

ParaziaRPServerUtils.toAll = function(eventName, ...)
    TriggerClientEvent("ParaziaRP:" .. ParaziaRP.hash(eventName), -1, ...)
end

ParaziaRPServerUtils.registerConsoleCommand = function(command, func)
    RegisterCommand(command, function(source,args)
        if source ~= 0 then return end
        func(source, args)
    end, false)
end

ParaziaRPServerUtils.getLicense = function(source)
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
    return ""
end

ParaziaRPServerUtils.trace = function(message, prefix)
    print("[^4ParaziaRP^7] (" .. prefix .. "^7) " .. message .. "^7")
end

local webhookColors = {
    ["red"] = 16711680,
    ["green"] = 56108,
    ["grey"] = 8421504,
    ["orange"] = 16744192
}

ParaziaRPServerUtils.getIdentifiers = function(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for _, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers[_]
        end
        return identifiers
    end
end

ParaziaRPServerUtils.webhook = function(message, color, url)
    local DiscordWebHook = url
    local embeds = {
        {
            ["title"] = message,
            ["type"] = "rich",
            ["color"] = webhookColors[color],
            ["footer"] = {
                ["text"] = "ParaziaRP Logs",
            },
        }
    }
    PerformHttpRequest(DiscordWebHook, function(err, text, headers)
    end, 'POST', json.encode({ username = "ParaziaRP Logs", embeds = embeds }), { ['Content-Type'] = 'application/json' })
end

ParaziaRP.newRepeatingTask(function()
    local restrictedZones, publicZones = 0, 0
    local restrictedBlips, publicBlips = 0, 0
    local restrictedNpcs, publicNpcs = 0, 0
    ---@param zone Zone
    for _, zone in pairs(ParaziaRPSZonesManager.list) do
        if zone:isRestricted() then
            restrictedZones = restrictedZones + 1
        else
            publicZones = publicZones + 1
        end
    end
    ---@param blip Blip
    for _, blip in pairs(ParaziaRPSBlipsManager.list) do
        if blip:isRestricted() then
            restrictedBlips = restrictedBlips + 1
        else
            publicBlips = publicBlips + 1
        end
    end
    ---@param npc Npc
    for _, npc in pairs(ParaziaRPSNpcsManager.list) do
        if npc:isRestricted() then
            restrictedNpcs = restrictedNpcs + 1
        else
            publicNpcs = publicNpcs + 1
        end
    end
    ParaziaRPServerUtils.trace(("Zones: %s%i%s (+%s%i%s) | Blips: %s%i%s (+%s%i%s) | Npcs: %s%i%s (+%s%i%s)"):format(
            "^2",
            publicZones,
            "^7",
            "^3",
            restrictedZones,
            "^7",
            "^2",
            publicBlips,
            "^7",
            "^3",
            restrictedBlips,
            "^7",
            "^2",
            publicNpcs,
            "^7",
            "^3",
            restrictedNpcs,
            "^7"
    ), ParaziaRPPrefixes.dev)
end, nil, 0, ParaziaRP.second(30))