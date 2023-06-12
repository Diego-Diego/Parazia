ParaziaRPServerUtils = {}

ParaziaRPServerUtils.toClient = function(eventName, targetId, ...)
    TriggerClientEvent("ParaziaRP:" .. ParaziaRP.hash(eventName), targetId, ...)
end

ParaziaRPServerUtils.toAll = function(eventName, ...)
    TriggerClientEvent("ParaziaRP:" .. ParaziaRP.hash(eventName), -1, ...)
end

ParaziaRPServerUtils.registerConsoleCommand = function(command, func)
    RegisterCommand(command, function(source,args)
        if source ~= 0 then return end
        func(source, args)
    end, false)
end

ParaziaRPServerUtils.getLicense = function(source)
    for k, v in pairs(GetPlayerIdentifiers(source)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
    return ""
end

ParaziaRPServerUtils.trace = function(message, prefix)
    print("[^6ParaziaRP^0] (^6" .. prefix .. "^0) ^6" .. message .. "^0")
end

local webhookColors = {
    ["red"] = 16711680,
    ["green"] = 56108,
    ["grey"] = 8421504,
    ["orange"] = 16744192
}

ParaziaRPServerUtils.getIdentifiers = function(source)
    if (source ~= nil) then
        local identifiers = {}
        local playerIdentifiers = GetPlayerIdentifiers(source)
        for _, v in pairs(playerIdentifiers) do
            local before, after = playerIdentifiers[_]:match("([^:]+):([^:]+)")
            identifiers[before] = playerIdentifiers[_]
        end
        return identifiers
    end
end