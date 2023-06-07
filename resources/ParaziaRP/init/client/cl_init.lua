ParaziaRPClientUtils = {}

ParaziaRPClientUtils.toServer = function(eventName, ...)
    TriggerServerEvent("ParaziaRP:" .. ParaziaRP.hash(eventName), ...)
end