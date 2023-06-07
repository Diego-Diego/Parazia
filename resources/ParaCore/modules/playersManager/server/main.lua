---@author Pablo Z.
---@version 1.0
--[[
  This file is part of ParaziaRP.
  
  File [main] created at [19/04/2021 23:51]

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRPSPlayersManager = {}
ParaziaRPSPlayersManager.eventOverrider = {}
ParaziaRPSPlayersManager.addonCache = {}
ParaziaRPSPlayersManager.list = {}

ParaziaRPSPlayersManager.registerAddonCache = function(index, onConnect, onDisconnect, onChange)
    ParaziaRPServerUtils.trace(("Enregistrement d'un cache joueur: ^3%s"):format(index), ParaziaRPPrefixes.dev)
    ParaziaRPSPlayersManager.addonCache[index] = { onConnect, onDisconnect, onChange }
end

ParaziaRPSPlayersManager.registerEventOverrider = function(type, func)
    ParaziaRPSPlayersManager.eventOverrider[(#ParaziaRPSPlayersManager.eventOverrider + 1)] = { on = type, handle = func }
end

ParaziaRPSPlayersManager.exists = function(source)
    return ParaziaRPSPlayersManager.list[source] ~= nil
end

ParaziaRPSPlayersManager.createPlayer = function(source)
    local xPlayer = ESX.GetPlayerFromId(source)
    local steam, license = xPlayer.identifier, ParaziaRPServerUtils.getLicense(source)
    ParaziaRPSPlayersManager.list[source] = Player(source, steam, license)
end

ParaziaRPSPlayersManager.getPlayer = function(source)
    return ParaziaRPSPlayersManager.list[source]
end

ParaziaRPSPlayersManager.removePlayer = function(source)
    ParaziaRPSPlayersManager.list[source] = nil
end

ParaziaRP.netHandleBasic("playerDropped", function(reason)
    local source = source
    if not ParaziaRPSPlayersManager.exists(source) then
        return
    end
    ParaziaRPServerUtils.trace(("Déconnexion de %s"):format(GetPlayerName(source)), ParaziaRPPrefixes.dev)
    for _, eventOverriderInfos in pairs(ParaziaRPSPlayersManager.eventOverrider) do
        if eventOverriderInfos.on == PLAYER_EVENT_TYPE.LEAVING then
            eventOverriderInfos.handle(source)
        end
    end
    for _, handlers in pairs(ParaziaRPSPlayersManager.addonCache) do
        handlers[2](ParaziaRPSPlayersManager.list[source])
    end
    ParaziaRPSPlayersManager.removePlayer(source)
end)

ParaziaRP.netHandleBasic('esx:playerLoaded', function(source, xPlayer)
    local source = source
    ParaziaRPServerUtils.trace(("Connexion de %s"):format(GetPlayerName(source)), ParaziaRPPrefixes.dev)
    ParaziaRPSPlayersManager.createPlayer(source)
    for _, eventOverriderInfos in pairs(ParaziaRPSPlayersManager.eventOverrider) do
        if eventOverriderInfos.on == PLAYER_EVENT_TYPE.CONNECTED then
            eventOverriderInfos.handle(source)
        end
    end
    for _, handlers in pairs(ParaziaRPSPlayersManager.addonCache) do
        handlers[1](ParaziaRPSPlayersManager.list[source])
    end
end)

ParaziaRP.newRepeatingTask(function()
    ---@param player Player
    for _, player in pairs(ParaziaRPSPlayersManager.list) do
        player:incrementSessionTimePlayed()
    end
end, nil, 0, ParaziaRP.second(60))