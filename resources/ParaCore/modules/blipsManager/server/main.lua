--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRPSBlipsManager = {}
ParaziaRPSBlipsManager.list = {}

ParaziaRPSBlipsManager.createPublic = function(position, sprite, color, scale, text, shortRange)
    local blip = Blip(position, sprite, color, scale, text, shortRange, false)
    ParaziaRPServerUtils.toAll("newBlip", blip)
    return blip.blipId
end

ParaziaRPSBlipsManager.createPrivate = function(position, sprite, color, scale, text, shortRange, baseAllowed)
    local blip = Blip(position, sprite, color, scale, text, shortRange, true, baseAllowed)
    local players = ESX.GetPlayers()
    for k, v in pairs(players) do
        if blip:isAllowed(v) then
            ParaziaRPServerUtils.toClient("newBlip", v, blip)
        end
    end
    return blip.blipId
end

ParaziaRPSBlipsManager.addAllowed = function(blipID, playerId)
    if not ParaziaRPSBlipsManager.list[blipID] then
        return
    end
    ---@type Blip
    local blip = ParaziaRPSBlipsManager.list[blipID]
    if blip:isAllowed(playerId) then
        print(ParaziaRP.prefix(ParaziaRPPrefixes.blips,("Tentative d'ajouter l'ID %s au blip %s alors qu'il est déjà autorisé"):format(playerId,blipID)))
        return
    end
    blip:addAllowed(playerId)
    ParaziaRPServerUtils.toClient("newBlip", playerId, blip)
    ParaziaRPSBlipsManager.list[blipID] = blip
end

ParaziaRPSBlipsManager.removeAllowed = function(blipID, playerId)
    if not ParaziaRPSBlipsManager.list[blipID] then
        return
    end
    ---@type Blip
    local blip = ParaziaRPSBlipsManager.list[blipID]
    if not blip:isAllowed(playerId) then
        print(ParaziaRP.prefix(ParaziaRPPrefixes.blips,("Tentative de supprimer l'ID %s au blip %s alors qu'il n'est déjà pas autorisé"):format(playerId,blipID)))
        return
    end
    blip:removeAllowed(playerId)
    ParaziaRPServerUtils.toClient("delBlip", playerId, blipID)
    ParaziaRPSBlipsManager.list[blipID] = blip
end

ParaziaRPSBlipsManager.updateOne = function(source)
    local blips = {}
    ---@param blip Blip
    for blipID, blip in pairs(ParaziaRPSBlipsManager.list) do
        if blip:isRestricted() then
            if blip:isAllowed(source) then
                blips[blipID] = blip
            end
        else
            blips[blipID] = blip
        end
    end
    ParaziaRPServerUtils.toClient("cbBlips", source, blips)
end

ParaziaRPSBlipsManager.delete = function(blipID)
    if not ParaziaRPSBlipsManager.list[blipID] then
        return
    end
    ---@type Zone
    local blip = ParaziaRPSBlipsManager.list[blipID]
    if blip:isRestricted() then
        local players = ESX.GetPlayers()
        for k, playerId in pairs(players) do
            if blip:isAllowed(playerId) then
                ParaziaRPServerUtils.toClient("delBlip", playerId, blipID)
            end
        end
    else
        ParaziaRPServerUtils.toAll("delBlip", blipID)
    end
end

ParaziaRP.netRegisterAndHandle("requestPredefinedBlips", function()
    local source = source
    ParaziaRPSBlipsManager.updateOne(source)
end)