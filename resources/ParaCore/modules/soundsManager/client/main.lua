--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]
ESX = nil

ParaziaRP.newThread(function()
	while ESX == nil do
		TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

ParaziaRPClientSoundsManager = {}

ParaziaRPClientSoundsManager.playSound = function(soundFile, soundVolume)
    SendNUIMessage({
        transactionType = 'playSound',
        transactionFile = soundFile,
        transactionVolume = soundVolume
    })
end

ParaziaRPClientSoundsManager.playSound3d = function(soundFile, soundVolume, coords, heading)
    SendNUIMessage({
        playSound3d = true,
        transactionFile = soundFile,
        transactionVolume = soundVolume,
        audioCoords = coords,
        audioRot = heading or 0.0,
    })
end

ParaziaRPClientSoundsManager.playYouTube = function(id, url, volume, isLoop)
    PlayUrl(id,url,volume,isLoop)
end