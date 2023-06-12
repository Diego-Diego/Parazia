ParaziaRP.netRegisterAndHandle('esx_truck_inventory:putItem', function(itemName, type, count, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	if plate ~= nil then
		if type == 'item_standard' then
			local playerItem = xPlayer.getInventoryItem(itemName)

			if playerItem.count >= count and count > 0 then
				TriggerEvent('esx_addoninventory:getInventory', 'trunk', plate, function(inventory)
					xPlayer.removeInventoryItem(itemName, count)
					inventory.addItem(itemName, count)
					TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ~y~x' .. count .. '~s~ ~q~' .. ESX.GetItem(itemName).label .. '~s~')
				end)
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, '~q~Action Impossible~s~ : \n\nMontant invalide !')
			end
		elseif type == 'item_weapon' then
			local weaponName = string.upper(itemName)

			if xPlayer.hasWeapon(weaponName) then
				TriggerEvent('esx_datastore:getDataStore', 'trunk', plate, function(store)
					local weapons = store.get('weapons') or {}

					table.insert(weapons, {
						name = weaponName,
						ammo = count
					})

					store.set('weapons', weapons)
					xPlayer.removeWeapon(weaponName)
					TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez déposé ~y~x' .. count .. '~s~ ~q~' .. ESX.GetWeaponLabel(itemName) .. '~s~')
				end)
			else
				xPlayer.showNotification('~q~Action Impossible~s~ : \n\nVous ne possédez pas cette arme !')
			end
		end
	end
end)

ParaziaRP.netRegisterAndHandle('esx_truck_inventory:getItem', function(itemName, type, count, plate)
	local xPlayer = ESX.GetPlayerFromId(source)

	if plate ~= nil then
		if type == 'item_standard' then
			TriggerEvent('esx_addoninventory:getInventory', 'trunk', plate, function(inventory)
				local inventoryItem = inventory.getItem(itemName)

				if inventoryItem.count >= count and count > 0 then
					if xPlayer.canCarryItem(itemName, count) then
						inventory.removeItem(itemName, count)
						xPlayer.addInventoryItem(itemName, count)
						--TriggerClientEvent('esx:showNotification', xPlayer.source, _U('have_withdrawn', count, inventoryItem.label))
						TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ~y~x' .. count .. '~s~ ~q~' .. inventoryItem.label .. '~s~')
					else
						TriggerClientEvent('esx:showNotification', xPlayer.source, '~q~Action Impossible~s~ : \n\nVous n\'avez pas assez ~y~de place~s~ dans votre inventaire !')
					end
				else
					TriggerClientEvent('esx:showNotification', xPlayer.source, '~q~Action Impossible~s~ : \n\nIl n\'y a pas assez de ~q~cet objet~s~ dans votre coffre!')
				end
			end)
		elseif type == 'item_weapon' then
			TriggerEvent('esx_datastore:getDataStore', 'trunk', plate, function(store)
				local weaponName = string.upper(itemName)

				if not xPlayer.hasWeapon(weaponName) then
					local weapons = store.get('weapons') or {}

					for i = 1, #weapons, 1 do
						if weapons[i].name == weaponName and weapons[i].ammo == count then
							table.remove(weapons, i)

							store.set('weapons', weapons)
							xPlayer.addWeapon(weaponName, count)
							TriggerClientEvent('esx:showNotification', xPlayer.source, 'Vous avez pris ~y~x' .. count .. '~s~ ~q~' .. ESX.GetWeaponLabel(itemName) .. '~s~')
							break
						end
					end
				else
					xPlayer.showNotification('~q~Action Impossible~s~ : \n\nVous possédez déjà cette arme !')
				end
			end)
		end
	end
end)

ESX.RegisterServerCallback('esx_truck_inventory:getTrunkInventory', function(source, cb, plate)
	local items, weapons = 0, {}, {}


	TriggerEvent('esx_addoninventory:getInventory', 'trunk', plate, function(inventory)
		items = inventory.items
	end)

	TriggerEvent('esx_datastore:getDataStore', 'trunk', plate, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		items = items,
		weapons = weapons
	})
end)

ESX.RegisterServerCallback('esx_truck_inventory:getPlayerInventory', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	cb({
		items = xPlayer.inventory,
		weapons = xPlayer.getLoadout()
	})
end)

ESX.RegisterServerCallback('Ewen:GetPlayerData', function(source, cb, target)
    local xPlayer = ESX.GetPlayerFromId(target)
    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout(),
            money = xPlayer.getAccount('cash').money,
            blackmoney = xPlayer.getAccount('dirtycash').money,
            weapons = xPlayer.getLoadout()
        }
        cb(data)
    end
end)