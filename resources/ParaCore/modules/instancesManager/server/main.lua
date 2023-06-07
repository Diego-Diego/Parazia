--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local playerRestrictedBuckets = 5000

ParaziaRP.netRegisterAndHandle("setBucket", function(bucketID)
    local source = source
    SetPlayerRoutingBucket(source, bucketID)
    ParaziaRPServerUtils.trace(("Le joueur %s est désormais sur le bucket %s"):format(GetPlayerName(source), bucketID), ParaziaRPPrefixes.sync)
end)

ParaziaRP.netRegisterAndHandle("genPlayerBucket", function()
    local source = source
    local bucketID = (playerRestrictedBuckets+source)
    SetPlayerRoutingBucket(source, bucketID)
    ParaziaRPServerUtils.trace(("Le joueur %s est désormais sur le bucket %s"):format(GetPlayerName(source), bucketID), ParaziaRPPrefixes.sync)
end)

ParaziaRP.netRegisterAndHandle("setOnPublicBucket", function()
    local source = source
    SetPlayerRoutingBucket(source, 0)
    ParaziaRPServerUtils.trace(("Le joueur %s est désormais sur le bucket ^2public"):format(GetPlayerName(source)), ParaziaRPPrefixes.sync)
end)