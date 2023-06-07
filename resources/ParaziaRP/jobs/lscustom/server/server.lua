ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
   
TriggerEvent('esx_society:registerSociety', 'lscustom', 'lscustom', 'society_lscustom', 'society_lscustom', 'society_lscustom', {type = 'public'})



--COFFRE

ESX.RegisterServerCallback('lscustom:playerinventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	local items   = xPlayer.inventory
	local all_items = {}
	
	for k,v in pairs(items) do
		if v.count > 0 then
			table.insert(all_items, {label = v.label, item = v.name,nb = v.count})
		end
	end

	cb(all_items)

	
end)

ESX.RegisterServerCallback('lscustom:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lscustom', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(all_items)
end)

RegisterServerEvent('lscustom:putStockItems')
AddEventHandler('lscustom:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count

	if xPlayer.job.name == 'lscustom' then
		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lscustom', function(inventory)
			if item_in_inventory >= count and count > 0 then
				xPlayer.removeInventoryItem(itemName, count)
				inventory.addItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~g~Dépot\n~s~- ~g~Coffre : ~s~Benny's \n~s~- ~o~Quantitée ~s~: "..count.."")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "~q~Vous n'en avez pas assez sur vous")
			end
		end)
	end
end)

RegisterServerEvent('lscustom:takeStockItems')
AddEventHandler('lscustom:takeStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'lscustom' then
		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lscustom', function(inventory)
				xPlayer.addInventoryItem(itemName, count)
				inventory.removeItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~q~Retrait\n~s~- ~g~Coffre : ~s~Benny's \n~s~- ~o~Quantitée ~s~: "..count.."")
		end)
	end
end)



-- Creation Kit 

RegisterServerEvent('lscustom:creationkitrepa')
AddEventHandler('lscustom:creationkitrepa', function(price, item, nombre) 
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'lscustom' then
		xPlayer.addInventoryItem(item, nombre) 
		TriggerClientEvent('esx:showNotification', source, "~g~Fabrication terminer : \n~s~-Objet : ~o~ Kit de réparation \n~s~-Prix : ~q~"..price.."$", "", 1)
	end
end)  

RegisterServerEvent('lscustom:creationkitcaro')
AddEventHandler('lscustom:creationkitcaro', function(price, item, nombre) 
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'lscustom' then
	    xPlayer.addInventoryItem(item, nombre) 
 	   	TriggerClientEvent('esx:showNotification', source, "~g~Fabrication terminer : \n~s~-Objet : ~o~Kit carroserie\n~s~-Prix : ~q~"..price.."$", "", 1)
	end
end) 



-- Utilisation Kit 

ESX.RegisterUsableItem('fixkit', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('fixkit', 1)

	TriggerClientEvent('pawal:onFixkit', _source)
	TriggerClientEvent('esx:showNotification', source, "Vous venez d'utilisé un ~q~~h~ Kit de réparation !")   
end)

ESX.RegisterUsableItem('carokit', function(source)
	local _source = source
	local xPlayer  = ESX.GetPlayerFromId(source)

	xPlayer.removeInventoryItem('carokit', 1)

	TriggerClientEvent('pawal:onCarokit', _source)
	TriggerClientEvent('esx:showNotification', source, "Vous venez d'utilisé un ~q~~h~ Kit de réparation Carrosserie !")    
end)

RegisterServerEvent('message:benny')
AddEventHandler('message:benny', function(PriseOuFin, message)
    local _source = source
    local _raison = PriseOuFin
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)


    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'lscustom' then
            TriggerClientEvent('message:benny', xPlayers[i], _raison, name, message)
        end
    end
end)