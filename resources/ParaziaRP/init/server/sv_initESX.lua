ESX = nil
ESXLoaded = false
TriggerEvent('sova:KraKss0TEX0', function(obj) 
    ESX = obj 
    ESXLoaded = true
end)

Citizen.CreateThread(function()
	while true do
		TriggerClientEvent('xr_core:updatePlayerCount', -1, GetNumPlayerIndices())
		Citizen.Wait(5000)
	end
end)