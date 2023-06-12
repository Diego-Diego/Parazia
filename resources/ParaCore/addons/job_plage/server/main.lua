---@author Pablo Z.
---@version 1.0
--[[
  This file is part of ParaziaRP.
  
  File [main] created at [18/04/2021 16:41]

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRPSCache.addCacheRule("plage", "paraziarp_plage", ParaziaRP.second(10))

--ParaziaRP.netHandle("esxloaded", function()
    --ParaziaRPSBlipsManager.createPublic(vector3(-2218.05, -622.87, 15.04), 0, 0, 0, "~q~Entreprise |~s~ Plage", true)
--end)

ParaziaRP.netRegisterAndHandle("plageRequestItem", function(item)
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getJob().name ~= "plage" then
        return
    end
    local itemsCache = ParaziaRPSCache.getCache("plagefood")
    if not itemsCache[item] then return end
    xPlayer.addInventoryItem(itemsCache[item].item, 1)
    ParaziaRPServerUtils.toClient("plageCbItem", source)
end)