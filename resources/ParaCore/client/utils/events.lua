--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRPClientUtils = {}

ParaziaRPClientUtils.toServer = function(eventName, ...)
    TriggerServerEvent("ParaziaRP:" .. ParaziaRP.hash(eventName), ...)
end