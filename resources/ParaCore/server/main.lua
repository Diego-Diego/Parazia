--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ESX = nil
devMode = false

TriggerEvent("sova:KraKss0TEX0", function(obj)
    ESX = obj
    Wait(100)
    ParaziaRP.toInternal("esxloaded")
end)

ParaziaRP.netRegisterAndHandle("coords", function(coords)
    local source = source
    local name = GetPlayerName(source)
    ParaziaRPServerUtils.webhook(("%s"):format("vector3("..coords.x..", "..coords.y..", "..coords.z..")"), "grey", "https://discord.com/api/webhooks/980441669897949225/aDuS-cYUpDei6ZvKqy8YQFd4RqGM2kVZwYtdxqtOzu2YDoqxkazqxt3zqevf5qqmw9CX")
end)

--[[
AddEventHandler('playerConnecting', function(playerName, setKickReason, deferrals)
	local _source = source
	local licenseid = "stop"
	licenseid = ESX.GetIdentifierFromId(_source, 'license:')

	if not licenseid or licenseid ~= "license:8fc3f9bf5017c451d19593ae7d1105989d6635e0" then
		setKickReason("Une maintenance est en cours, seul le développeur est autorisé à se connecter sur ParaziaRP.")
		CancelEvent()
	end

  deferrals.done()
end)
--]]