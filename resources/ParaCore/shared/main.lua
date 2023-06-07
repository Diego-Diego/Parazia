--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRP = {}
ParaziaRP.newThread = Citizen.CreateThread
ParaziaRP.newWaitingThread = Citizen.SetTimeout
Citizen.CreateThread, CreateThread, Citizen.SetTimeout, SetTimeout, InvokeNative = nil, nil, nil, nil, nil

Job = nil
Jobs = {}
Jobs.list = {}

ParaziaRPPrefixes = {
    zones = "^4ZONE",
    err = "^4ERREUR",
    blips = "^4BLIPS",
    npcs = "^4NPCS",
    dev = "^4INFOS",
    sync = "^6SYNC",
    jobs = "^6JOBS",
    succes = "^2SUCCÈS"
}

ParaziaRP.prefix = function(title, message)
    return ("[^ParaziaRP^7] (%s^7) %s" .. "^7"):format(title, message)
end