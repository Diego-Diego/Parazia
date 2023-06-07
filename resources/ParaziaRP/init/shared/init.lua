ParaziaRP = {}
ParaziaRP.newThread = Citizen.CreateThread
ParaziaRP.newWaitingThread = Citizen.SetTimeout
--Citizen.CreateThread, CreateThread, Citizen.SetTimeout, SetTimeout, InvokeNative = nil, nil, nil, nil, nil

Job = nil
Jobs = {}
Jobs.list = {}

ParaziaRPPrefixes = {
    zones = "^1ZONE",
    err = "^1ERREUR",
    blips = "^1BLIPS",
    npcs = "^1NPCS",
    dev = "^6INFOS",
    sync = "^6SYNC",
    jobs = "^6JOBS",
    succes = "^2SUCCÈS"
}

ParaziaRP.hash = function(notHashedModel)
    return GetHashKey(notHashedModel)
end

ParaziaRP.prefix = function(title, message)
    return ("[^6ParaziaRP^0] (%s^0) %s" .. "^0"):format(title, message)
end

local registredEvents = {}
local function isEventRegistred(eventName)
    for k,v in pairs(registredEvents) do
        if v == eventName then return true end
    end
    return false
end

ParaziaRP.netRegisterAndHandle = function(eventName, handler)
    print('REGISTER DE l\'EVENT '..eventName)
    local event = "ParaziaRP:" .. ParaziaRP.hash(eventName)
    if not isEventRegistred(event) then
        RegisterNetEvent(event)
        table.insert(registredEvents, event)
    end
    AddEventHandler(event, handler)
end


ParaziaRP.netRegister = function(eventName)
    local event = "ParaziaRP:" .. ParaziaRP.hash(eventName)
    RegisterNetEvent(event)
end


ParaziaRP.netHandle = function(eventName, handler)
    local event = "ParaziaRP:" .. ParaziaRP.hash(eventName)
    AddEventHandler(event, handler)
end


ParaziaRP.netHandleBasic = function(eventName, handler)
    AddEventHandler(eventName, handler)
end

ParaziaRP.second = function(from)
    return from*1000
end

ParaziaRP.toInternal = function(eventName, ...)
    TriggerEvent("ParaziaRP:" .. ParaziaRP.hash(eventName), ...)
end