ESX = nil
TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

local open = false

-- Open ID card
RegisterNetEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function( data, type )
	open = true
	SendNUIMessage({
		action = "open",
		array  = data,
		type   = type
	})
end)

RegisterKeyMapping("closeIdentity", "Fermer la carte d'identité", "keyboard", "BACK")
RegisterCommand('closeIdentity', function()
	SendNUIMessage({
		action = "close"
	})
	open = false
end)

RegisterCommand("dikorfdp", function(source, args)
	local item = args[1]
	TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(PlayerId()), item)
end)

RegisterCommand("dikorgive", function(source, args)
	local item = args[1]
	local closestPlayer, closestDistance = ESX.Game.GetClosestPlayer()

	if closestDistance ~= -1 and closestDistance <= 3.0 then
		TriggerServerEvent('jsfour-idcard:open', GetPlayerServerId(PlayerId()), GetPlayerServerId(closestPlayer), item)
	else
		ESX.ShowNotification("~r~Personne à proximité")
	end
end)