ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

AddEventHandler('esx:playerLoaded', function(source)
	TriggerEvent('esx_license:getLicenses', source, function(licenses)
		TriggerClientEvent('esx_dmvschool:loadLicenses', source, licenses)
	end)
end)

ESX.RegisterServerCallback('permis:PriceCar', function (source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount('cash').money >= 200 then 
        xPlayer.removeAccountMoney('cash', 200)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('permis:PriceBike', function (source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount('cash').money >= 150 then 
        xPlayer.removeAccountMoney('cash', 150)
		cb(true)
	else
		cb(false)
	end
end)

ESX.RegisterServerCallback('permis:PriceTruck', function (source, cb, price)
	local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount('cash').money >= 300 then 
        xPlayer.removeAccountMoney('cash', 300)
		cb(true)
	else
		cb(false)
	end
end)