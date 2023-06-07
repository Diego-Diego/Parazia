local destroyedRadars = {}

Citizen.CreateThread(function()
	destroyedRadars = json.decode(GetResourceKvpString('destroyedRadars'))
	if destroyedRadars == nil or type(destroyedRadars) ~= 'table' then
		destroyedRadars = {}
	end

	ESX.RegisterUsableItem('waze', function(source, xPlayer)
		local xPlayer = ESX.GetPlayerFromId(source)
		xPlayer.removeInventoryItem('waze', 1)
		xPlayer.triggerEvent('xr_speedradar:displayRadars')
		xPlayer.showNotification('~g~Votre waze est actif pour 1h')

		Citizen.SetTimeout(60 * 60 * 1000, function()
			xPlayer.triggerEvent('xr_speedradar:hideRadars')
			ESX.ShowNotification('~g~Le waze n\'est plus actif...')
		end)
	end)
end)

function ResetRadars()
	destroyedRadars = {}
	for RadarId,Radar in pairs(Radars.Radars) do
		destroyedRadars[RadarId] = false
	end

	SetResourceKvp('destroyedRadars', json.encode(destroyedRadars))
	TriggerClientEvent('xr_speedradar:syncRadars', -1, destroyedRadars)

	for _, xPlayerPolice in pairs(ESX.GetPlayersWithJob('police')) do
		xPlayerPolice.showNotification("~g~Réparation de tous les radars par un technicien...")
	end
end

TriggerEvent('cron:runAtDay', 6, 23, 0, ResetRadars)

RegisterNetEvent('xr_speedradar:destroyedRadar')
AddEventHandler('xr_speedradar:destroyedRadar', function(RadarId)
	destroyedRadars[RadarId] = true
	SetResourceKvp('destroyedRadars', json.encode(destroyedRadars))
	TriggerClientEvent('xr_speedradar:syncRadars', -1, destroyedRadars)

	for _, xPlayerPolice in pairs(ESX.GetPlayersWithJob('police')) do
		xPlayerPolice.showNotification('~g~Radar détruit~w~ près de la ~q~'.. Radars.Radars[RadarId].Name.."~w~.")
	end
end)

RegisterNetEvent('xr_speedradar:requestSyncRadars')
AddEventHandler('xr_speedradar:requestSyncRadars', function()
	TriggerClientEvent('xr_speedradar:syncRadars', source, destroyedRadars)
end)

RegisterNetEvent('xr_speedradar:flashed')
AddEventHandler('xr_speedradar:flashed', function(plate, vitesse, model, radarId)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayers = ESX.GetPlayers()

	vitesse = math.ceil(vitesse - 0.5)

	for _, xPlayerPolice in pairs(ESX.GetPlayersWithJob('police')) do
		xPlayerPolice.showNotification('~q~'.. model ..'~w~ immatriculé ~q~' .. plate .. '~w~ flashé à ~q~'.. vitesse .. 'KM/H~w~ près de la ~q~'.. Radars.Radars[radarId].Name.."~w~.")
	end

	if xPlayer.getAccount('bank').money >= Radars.BillPrice then
		xPlayer.showNotification('~q~Vous avez été flashé ! ~g~Vous avez payé ' .. Radars.BillPrice .. '$ depuis votre compte bancaire ...')
		xPlayer.removeAccountMoney('bank', Radars.BillPrice)
	else
		xPlayer.showNotification('~q~Vous avez été flashé ! ~g~Vous avez reçu une amende de ' .. Radars.BillPrice .. '$ ...')
		TriggerEvent('esx_billing:sendBill', source, 'society_police', 'Amende pour excès de vitesse', Radars.BillPrice)
	end
end)