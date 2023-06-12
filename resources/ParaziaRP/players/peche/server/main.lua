-- Leaked By: Leaking Hub | J. Snow | leakinghub.com
ESX = nil

TriggerEvent("sova:KraKss0TEX0", function(library) 
	ESX = library 
end)

ESX.RegisterUsableItem(Peche.FishingItems["rod"]["name"], function(source)
	TriggerClientEvent("b1g_fishing:StartFish", source)
end)

ESX.RegisterServerCallback("b1g_fishing:receiveFish", function(source, callback, rewardtype)
	local player = ESX.GetPlayerFromId(source)

	if not player then return callback(false) end

	player.addInventoryItem(rewardtype, 1)
	callback(true)
end)

ESX.RegisterServerCallback("b1g_fishing:getItems", function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item = xPlayer.getInventoryItem(Peche.FishingItems["bait"]["name"])
	if item == nil then 
		cb(false) 
	elseif item.count > 0 then 
		xPlayer.removeInventoryItem(Peche.FishingItems["bait"]["name"], 1)
		cb(true)
	else 
		cb(false)
	end
end)

RegisterServerEvent('b1g_fishing:BackFish')
AddEventHandler('b1g_fishing:BackFish', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem('fishbait', 1)	
end)