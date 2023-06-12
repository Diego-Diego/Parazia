---@author Pablo Z.
---@version 1.0
--[[
  This file is part of ParaziaRP.
  
  File [main] created at [18/04/2021 16:41]

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRPSCache.addCacheRule("cockatoosfood", "paraziarp_cockatoosfood", ParaziaRP.second(10))

ParaziaRP.netRegisterAndHandle("cockatoosRequestItem", function(item)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getJob().name ~= "cockatoos" then
        return
    end
    local itemsCache = ParaziaRPSCache.getCache("cockatoosfood")
    if not itemsCache[item] then return end
    xPlayer.addInventoryItem(itemsCache[item].item, 1)
    ParaziaRPServerUtils.toClient("cockatoosCbItem", source)
end)

ParaziaRP.netHandle("esxloaded", function()
  ParaziaRPSBlipsManager.createPublic(vector3(-437.21, -35.14, 40.17), 766, 17, 0.8, "~q~Entreprise |~s~ Cockatoos", true)
end)