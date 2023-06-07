ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
   
TriggerEvent('esx_society:registerSociety', 'mcustom', 'MCustom', 'society_mcustom', 'society_mcustom', 'society_mcustom', {type = 'public'})

RegisterServerEvent('Ouvre:mcustom')
AddEventHandler('Ouvre:mcustom', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	if xPlayer.job.name == 'mcustom' then
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'MCustom\'s', '~q~Annonce', 'Le mcustom\'s est ~g~ouvert !', 'CHAR_CARSITE3', 8)
		end
	end
end)

RegisterServerEvent('Ferme:mcustom')
AddEventHandler('Ferme:mcustom', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	if xPlayer.job.name == 'mcustom' then
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'MCustom\'s', '~q~Annonce', 'Plus aucun mécano est en ~q~ville~s~!', 'CHAR_CARSITE3', 8)
		end
	end
end)

RegisterServerEvent('Recru:mcustom')
AddEventHandler('Recru:mcustom', function()
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers	= ESX.GetPlayers()
	if xPlayer.job.name == 'mcustom' then
		for i=1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
			TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'MCustom\'s', '~q~Annonce', '~y~Recrutement en cours, rendez-vous au mcustom\'s', 'CHAR_CARSITE3', 8)
		end
	end
end)

RegisterCommand('meca', function(source, args, rawCommand)
  local _source = source
  local xPlayer = ESX.GetPlayerFromId(_source)
  if xPlayer.job.name == "mcustom" then
      local src = source
      local msg = rawCommand:sub(5)
      local args = msg
      if player ~= false then
          local name = GetPlayerName(source)
          local xPlayers	= ESX.GetPlayers()
      for i=1, #xPlayers, 1 do
          local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
          TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'MCustom\'s', '~q~Annonce', ''..msg..'', 'CHAR_CARSITE3', 0)
      end
  else
      TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~q~Erreur' , '~q~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_CARSITE3', 0)
  end
else
  TriggerClientEvent('esx:showAdvancedNotification', _source, 'Avertisement', '~q~Erreur' , '~q~Tu n\'es pas membre de cette entreprise pour faire cette commande', 'CHAR_CARSITE3', 0)
end
end, false)



--COFFRE

ESX.RegisterServerCallback('mcustom:playerinventory', function(source, cb)
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

ESX.RegisterServerCallback('mcustom:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mcustom', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(all_items)
end)

RegisterServerEvent('mcustom:putStockItems')
AddEventHandler('mcustom:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count

	if xPlayer.job.name == 'mcustom' then
		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mcustom', function(inventory)
			if item_in_inventory >= count and count > 0 then
				xPlayer.removeInventoryItem(itemName, count)
				inventory.addItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~g~Dépot\n~s~- ~g~Coffre : ~s~mcustom's \n~s~- ~o~Quantitée ~s~: "..count.."")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "~q~Vous n'en avez pas assez sur vous")
			end
		end)
	end
end)

RegisterServerEvent('mcustom:takeStockItems')
AddEventHandler('mcustom:takeStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'mcustom' then
		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_mcustom', function(inventory)
				xPlayer.addInventoryItem(itemName, count)
				inventory.removeItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~q~Retrait\n~s~- ~g~Coffre : ~s~mcustom's \n~s~- ~o~Quantitée ~s~: "..count.."")
		end)
	end
end)



-- Creation Kit 

RegisterServerEvent('mcustom:creationkitrepa')
AddEventHandler('mcustom:creationkitrepa', function(price, item, nombre) 
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'mcustom' then
		xPlayer.addInventoryItem(item, nombre) 
		TriggerClientEvent('esx:showNotification', source, "~g~Fabrication terminer : \n~s~-Objet : ~o~ Kit de réparation \n~s~-Prix : ~q~"..price.."$", "", 1)
	end
end)  

RegisterServerEvent('mcustom:creationkitcaro')
AddEventHandler('mcustom:creationkitcaro', function(price, item, nombre) 
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.job.name == 'mcustom' then
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

RegisterServerEvent('message:mcustom')
AddEventHandler('message:mcustom', function(PriseOuFin, message)
    local _source = source
    local _raison = PriseOuFin
    local xPlayer = ESX.GetPlayerFromId(_source)
    local xPlayers = ESX.GetPlayers()
    local name = xPlayer.getName(_source)


    for i = 1, #xPlayers, 1 do
        local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
        if thePlayer.job.name == 'mcustom' then
            TriggerClientEvent('message:mcustom', xPlayers[i], _raison, name, message)
        end
    end
end)