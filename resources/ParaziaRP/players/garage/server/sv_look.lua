ESX = nil

TriggerEvent("sova:KraKss0TEX0", function(obj)
	ESX = obj
end)

MySQL.ready(function()
	MySQL.Async.execute('DELETE FROM open_car WHERE NB = @NB', {
		['@NB'] = 2
	})
end)

ESX.RegisterServerCallback('esx_vehiclelock:getVehiclesnokey', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM open_car WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(result2)
		MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner', {
			['@owner'] = xPlayer.identifier
		}, function(result)
			local vehicles = {}

			for i = 1, #result, 1 do
				local found
				local vehicleData = json.decode(result[i].vehicle)

				for j = 1, #result2, 1 do
					if result2[j].plate == vehicleData.plate then
						found = true
					end
				end

				if not found then
					table.insert(vehicles, vehicleData)
				end
			end

			cb(vehicles)
		end)
	end)
end)

ESX.RegisterServerCallback('esx_vehiclelock:mykey', function(source, cb, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM open_car WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		local found = false

		if result[1] then
			found = true
		end

		cb(found)
	end)
end)

ESX.RegisterServerCallback('esx_vehiclelock:allkey', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.fetchAll('SELECT * FROM open_car WHERE owner = @owner', {
		['@owner'] = xPlayer.identifier
	}, function(result)
		local keys = {}

		for i = 1, #result, 1 do
			table.insert(keys, {
				plate = result[i].plate,
				NB = result[i].NB
			})
		end

		cb(keys)
	end)
end)

RegisterServerEvent('garage:RegisterNewKey')
AddEventHandler('garage:RegisterNewKey', function(plate)
	local _source = source
	xPlayer = ESX.GetPlayerFromId(_source)

	MySQL.Async.execute('INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plate, @NB)', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate,
		['@NB'] = 1
	}, function()
		TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez une nouvelle pair de clés ! ')
	end)
end)

RegisterServerEvent('garage:changevehicleowner')
AddEventHandler('garage:changevehicleowner', function(target, vehicle)
	if target == -1 then
		DropPlayer(source,'Désynchronisation avec le serveur ou détection de Cheat')
		return
	end
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerTarget = ESX.GetPlayerFromId(target)
	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = vehicle.plate
	}, function(result)
		if result[1] then
			if not result[1].boutique then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@target'] = xPlayerTarget.identifier,
					['@plate'] = vehicle.plate
				}, function()
					xPlayer.showNotification('Vous avez donner les clés du véhicule (~q~'..vehicle.plate..'~w~)')
					xPlayerTarget.showNotification('Vous avez reçu les clés du véhicule (~q~'..vehicle.plate..'~w~)')
				end)
			else
				DropPlayer(source,'Désynchronisation avec le serveur ou détection de Cheat')
			end
		else
			xPlayer.showNotification('Le véhicule ne vous appartient pas')
		end
	end)
end)

RegisterServerEvent('garage:ChangeVehicleAndKeyOwner')
AddEventHandler('garage:ChangeVehicleAndKeyOwner', function(target, plate, vehicleProps)
	local xPlayer = ESX.GetPlayerFromId(source)
	local xPlayerTarget = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll('SELECT * FROM owned_vehicles WHERE owner = @owner AND @plate = plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	}, function(result)
		if result[1] then
			local vehicle = json.decode(result[1].vehicle)

			if vehicle.model == vehicleProps.model and vehicle.plate == plate then
				MySQL.Async.execute('UPDATE owned_vehicles SET owner = @target WHERE owner = @owner AND plate = @plate', {
					['@owner'] = xPlayer.identifier,
					['@target'] = xPlayerTarget.identifier,
					['@plate'] = plate
				}, function()
					MySQL.Async.execute('DELETE FROM open_car WHERE owner = @owner AND plate = @plate', {
						['@owner'] = xPlayer.identifier,
						['@plate'] = plate
					}, function()
						MySQL.Async.execute('INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plate, @NB)', {
							['@owner'] = xPlayerTarget.identifier,
							['@plate'] = plate,
							['@NB'] = 1
						}, function()
							TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez donné votre clé, vous ne les avez plus !')
							TriggerClientEvent('esx:showNotification', xPlayerTarget.source, 'Vous avez reçu de nouvelle clé ')
						end)
					end)
				end)
			end
		else
			TriggerClientEvent('esx:showNotification', xPlayer.source, 'Le véhicule le plus proche ne vous appartient pas !')
		end
	end)
end)

RegisterServerEvent('garage:DeleteKey')
AddEventHandler('garage:DeleteKey', function(plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	MySQL.Async.execute('DELETE FROM open_car WHERE owner = @owner AND plate = @plate', {
		['@owner'] = xPlayer.identifier,
		['@plate'] = plate
	})
end)

RegisterServerEvent('garage:GiveTemporyKey')
AddEventHandler('garage:GiveTemporyKey', function(target, plate)
	local _source = source
	local xPlayerTarget = ESX.GetPlayerFromId(target)

	MySQL.Async.execute('INSERT INTO open_car (owner, plate, NB) VALUES (@owner, @plate, @NB)', {
		['@owner'] = xPlayerTarget.identifier,
		['@plate'] = plate,
		['@NB'] = 2
	}, function()
		TriggerClientEvent('esx:showNotification', _source, 'Vous avez prété votre clé')
		TriggerClientEvent('esx:showNotification', xPlayerTarget.source, 'Vous avez reçu un double de clé ')
	end)
end)