--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRPSNpcsManager = {}
ParaziaRPSNpcsManager.list = {}

ParaziaRPSNpcsManager.createPublic = function(model, ai, frozen, position, animation, onCreate)
    local npc = Npc(model, ai, frozen, position, animation, false)
    npc:setOnCreate(onCreate or function() end)
    ParaziaRPServerUtils.toAll("newNpc", npc)
    return npc
end

ParaziaRPSNpcsManager.createPrivate = function(model, ai, frozen, position, animation, baseAllowed, onCreate)
    local npc = Npc(model, ai, frozen, position, animation, true, baseAllowed)
    local players = ESX.GetPlayers()
    for k, v in pairs(players) do
        if npc:isAllowed(v) then
            ParaziaRPServerUtils.toClient("newNpc", v, npc)
        end
    end
    return npc
end

ParaziaRPSNpcsManager.addAllowed = function(npcId, playerId)
    if not ParaziaRPSNpcsManager.list[npcId] then
        return
    end
    ---@type Npc
    local npc = ParaziaRPSNpcsManager.list[npcId]
    if npc:isAllowed(playerId) then
        print(ParaziaRP.prefix(ParaziaRPPrefixes.npcs,("Tentative d'ajouter l'ID %s au npc %s alors qu'il est déjà autorisé"):format(playerId, npcId)))
        return
    end
    npc:addAllowed(playerId)
    ParaziaRPServerUtils.toClient("newNpc", playerId, npc)
    ParaziaRPSNpcsManager.list[npcId] = npc
end

ParaziaRPSNpcsManager.removeAllowed = function(npcId, playerId)
    if not ParaziaRPSNpcsManager.list[npcId] then
        return
    end
    ---@type Npc
    local npc = ParaziaRPSNpcsManager.list[npcId]
    if not npc:isAllowed(playerId) then
        print(ParaziaRP.prefix(ParaziaRPPrefixes.npcs,("Tentative de supprimer l'ID %s au blip %s alors qu'il n'est déjà pas autorisé"):format(playerId, npcId)))
        return
    end
    npc:removeAllowed(playerId)
    ParaziaRPServerUtils.toClient("delNpc", playerId, npcId)
    ParaziaRPSNpcsManager.list[npcId] = npc
end

ParaziaRPSNpcsManager.updateOne = function(source)
    local npcs = {}
    ---@param npc Npc
    for npcId, npc in pairs(ParaziaRPSNpcsManager.list) do
        if npc:isRestricted() then
            if npc:isAllowed(source) then
                npcs[npcId] = npc
            end
        else
            npcs[npcId] = npc
        end
    end
    ParaziaRPServerUtils.toClient("cbNpcs", source, npcs)
end

ParaziaRP.netRegisterAndHandle("requestPredefinedNpcs", function()
    local source = source
    ParaziaRPSNpcsManager.updateOne(source)
end)

