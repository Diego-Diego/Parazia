--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRP.netRegisterAndHandle('shareDisplay', function(idsToSend, text, pPedSID)
	local source = source
	ParaziaRPServerUtils.webhook(("%s: /me %s"):format(GetPlayerName(source), text), "grey", "https://discord.com/api/webhooks/1108062797545349130/TKwfUsfLqeAybX2krC8d3JmC2XW3Hf0BHjCdE48zk-xGqigKRDt9Nlpz-LfZykpi7izR")
	for k,v in pairs(idsToSend) do
		ParaziaRPServerUtils.toClient("shareDisplay", v, text, pPedSID)
	end
end)

AddEventHandler('chatMessage', function(source, name, message)
	CancelEvent()
end)