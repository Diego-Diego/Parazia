--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

---toInternal
---@public
---@return void
ParaziaRP.toInternal = function(eventName, ...)
    TriggerEvent("ParaziaRP:" .. ParaziaRP.hash(eventName), ...)
end

local registredEvents = {}
local function isEventRegistred(eventName)
    for k,v in pairs(registredEvents) do
        if v == eventName then return true end
    end
    return false
end
---netRegisterAndHandle
---@public
---@return void
ParaziaRP.netRegisterAndHandle = function(eventName, handler)
    local event = "ParaziaRP:" .. ParaziaRP.hash(eventName)
    if not isEventRegistred(event) then
        RegisterNetEvent(event)
        table.insert(registredEvents, event)
    end
    AddEventHandler(event, handler)
end

---netRegister
---@public
---@return void
ParaziaRP.netRegister = function(eventName)
    local event = "ParaziaRP:" .. ParaziaRP.hash(eventName)
    RegisterNetEvent(event)
end

---netHandle
---@public
---@return void
ParaziaRP.netHandle = function(eventName, handler)
    local event = "ParaziaRP:" .. ParaziaRP.hash(eventName)
    AddEventHandler(event, handler)
end

---netHandleBasic
---@public
---@return void
ParaziaRP.netHandleBasic = function(eventName, handler)
    AddEventHandler(eventName, handler)
end

---hash
---@public
---@return any
ParaziaRP.hash = function(notHashedModel)
    return GetHashKey(notHashedModel)
end

---second
---@public
---@return number
ParaziaRP.second = function(from)
    return from*1000
end