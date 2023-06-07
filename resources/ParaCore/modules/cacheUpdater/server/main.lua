--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRPSCache = {}

ParaziaRPSCache.caches = {}
ParaziaRPSCache.relativesDb = {}

ParaziaRPSCache.getCache = function(index)
    return ParaziaRPSCache.caches[index] or {}
end

ParaziaRPSCache.addCacheRule = function(index, sqlTable, updateFrequency)
    ParaziaRPSCache.caches[index] = {}
    ParaziaRPSCache.relativesDb[sqlTable] = { index = index, interval = updateFrequency }
    ParaziaRPServerUtils.trace(("Ajout d'une règle de cache: ^2%s ^7sur ^3%s"):format(index,sqlTable), ParaziaRPPrefixes.sync)
end

ParaziaRPSCache.removeCacheRule = function(sql)
    ParaziaRPSCache.caches[ParaziaRPSCache.relativesDb[sql]] = nil
    ParaziaRP.cancelTaskNow(ParaziaRPSCache.relativesDb[sql].processId)
    ParaziaRPServerUtils.trace(("Retrait d'une règle de cache: ^2%s"):format(ParaziaRPSCache.relativesDb[sql].index), ParaziaRPPrefixes.sync)
    ParaziaRPSCache.relativesDb[sql] = nil
end

ParaziaRP.netHandle("esxloaded", function()
    while true do
        for sqlTable, infos in pairs(ParaziaRPSCache.relativesDb) do
            if not infos.processId then
                infos.processId = ParaziaRP.newRepeatingTask(function()
                    MySQL.Async.fetchAll(("SELECT * FROM %s"):format(sqlTable), {}, function(result)
                        if ParaziaRPSCache.caches[infos.index] ~= nil then
                            ParaziaRPSCache.caches[infos.index] = result
                        end
                    end)
                end, nil, 0, infos.interval)
            end
        end
        Wait(ParaziaRP.second(1))
    end
end)

