--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRPSZonesManager = {}
ParaziaRPSZonesManager.list = {}

ParaziaRPSZonesManager.createPublic = function(location, type, color, onInteract, helpText, drawDist, itrDist)
    local zone = Zone(location, type, color, onInteract, helpText, drawDist, itrDist, false)
    local marker = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
    ParaziaRPServerUtils.toAll("newMarker", marker)
    return zone.zoneID
end

ParaziaRPSZonesManager.createPrivate = function(location, type, color, onInteract, helpText, drawDist, itrDist, baseAllowed)
    local zone = Zone(location, type, color, onInteract, helpText, drawDist, itrDist, true, baseAllowed)
    local marker = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
    local players = ESX.GetPlayers()
    for k, v in pairs(players) do
        if zone:isAllowed(v) then
            ParaziaRPServerUtils.toClient("newMarker", v, marker)
        end
    end
    return zone.zoneID
end

ParaziaRPSZonesManager.addAllowed = function(zoneID, playerId)
    if not ParaziaRPSZonesManager.list[zoneID] then
        return
    end
    ---@type Zone
    local zone = ParaziaRPSZonesManager.list[zoneID]
    if zone:isAllowed(playerId) then
        print(ParaziaRP.prefix(ParaziaRPPrefixes.zones,("Tentative d'ajouter l'ID %s à la zone %s alors qu'il est déjà autorisé"):format(playerId,zoneID)))
        return
    end
    zone:addAllowed(playerId)
    local marker = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
    ParaziaRPServerUtils.toClient("newMarker", playerId, marker)
    ParaziaRPSZonesManager.list[zoneID] = zone
end

ParaziaRPSZonesManager.removeAllowed = function(zoneID, playerId)
    if not ParaziaRPSZonesManager.list[zoneID] then
        return
    end
    ---@type Zone
    local zone = ParaziaRPSZonesManager.list[zoneID]
    if not zone:isAllowed(playerId) then
        print(ParaziaRP.prefix(ParaziaRPPrefixes.zones,("Tentative de supprimer l'ID %s à la zone %s alors qu'il n'est déjà pas autorisé"):format(playerId,zoneID)))
        return
    end
    zone:removeAllowed(playerId)
    ParaziaRPServerUtils.toClient("delMarker", playerId, zoneID)
    ParaziaRPSZonesManager.list[zoneID] = zone
end

ParaziaRPSZonesManager.updatePrivacy = function(zoneID, newPrivacy)
    if not ParaziaRPSZonesManager.list[zoneID] then
        return
    end
    ---@type Zone
    local zone = ParaziaRPSZonesManager.list[zoneID]
    local wereAllowed = {}
    local wasRestricted = zone:isRestricted()
    if zone:isRestricted() then
        wereAllowed = zone.allowed
    end
    zone.allowed = {}
    zone:setRestriction(newPrivacy)
    if zone:isRestricted() then
        local players = ESX.GetPlayers()
        if not wasRestricted then
            for _, playerId in pairs(players) do
                local isAllowedtoSee = false
                for _, allowed in pairs(wereAllowed) do
                    if allowed == playerId then
                        isAllowedtoSee = true
                    end
                end
                if not isAllowedtoSee then
                    ParaziaRPServerUtils.toClient("delMarker", playerId, zone.zoneID)
                end
            end
        end
    else
        if wasRestricted then
            for _, playerId in pairs(players) do
                local isAllowedtoSee = false
                for _, allowed in pairs(wereAllowed) do
                    if allowed == playerId then
                        isAllowedtoSee = true
                    end
                end
                if isAllowedtoSee then
                    local marker = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
                    ParaziaRPServerUtils.toClient("newMarker", playerId, marker)
                end
            end
        end
    end
    ParaziaRPSZonesManager.list[zoneID] = zone
end

ParaziaRPSZonesManager.delete = function(zoneID)
    if not ParaziaRPSZonesManager.list[zoneID] then
        return
    end
    ---@type Zone
    local zone = ParaziaRPSZonesManager.list[zoneID]
    if zone:isRestricted() then
        local players = ESX.GetPlayers()
        for k, playerId in pairs(players) do
            if zone:isAllowed(playerId) then
                ParaziaRPServerUtils.toClient("delMarker", playerId, zoneID)
            end
        end
    else
        ParaziaRPServerUtils.toAll("delMarker", zoneID)
    end
end

ParaziaRPSZonesManager.updateOne = function(source)
    local markers = {}
    ---@param zone Zone
    for zoneID, zone in pairs(ParaziaRPSZonesManager.list) do
        if zone:isRestricted() then
            if zone:isAllowed(source) then
                markers[zoneID] = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
            end
        else
            markers[zoneID] = { id = zone.zoneID, type = zone.type, color = zone.color, help = zone.helpText, position = zone.location, distances = { zone.drawDist, zone.itrDist } }
        end
    end
    ParaziaRPServerUtils.toClient("cbZones", source, markers)
end

ParaziaRP.netRegisterAndHandle("requestPredefinedZones", function()
    local source = source
    ParaziaRPSZonesManager.updateOne(source)
end)

ParaziaRP.netRegisterAndHandle("interactWithZone", function(zoneID)
    local source = source
    if not ParaziaRPSZonesManager.list[zoneID] then
        DropPlayer("[ParaziaRP] Tentative d'intéragir avec une zone inéxistante.")
        return
    end
    ---@type Zone
    local zone = ParaziaRPSZonesManager.list[zoneID]
    zone:interact(source)
end)