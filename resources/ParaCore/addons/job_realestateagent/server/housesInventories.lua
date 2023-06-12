--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRP.netRegisterAndHandle("depositHouse", function(houseId, itemName, depositCount)
    if not ParaziaRPSHousesManager.list[houseId] then
        return
    end
    local source = source
    local license = ParaziaRPServerUtils.getLicense(source)
    ---@type House
    local house = ParaziaRPSHousesManager.list[houseId]
    if not house:isOwner(source) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    local itemCount = xPlayer.getInventoryItem(itemName).count
    if itemCount < depositCount then
        ParaziaRPServerUtils.toClient("houseDepositFailed", source, "Erreur: Une erreur est survenue")
        return
    end
    local itemsAddedInHouse = house:addItem(itemName, depositCount, source)
    if not itemsAddedInHouse then
        ParaziaRPServerUtils.toClient("houseDepositFailed", source, "Erreur: Capacité maximale dépassée")
        return
    end
    xPlayer.removeInventoryItem(itemName, depositCount)
    itemCount = xPlayer.getInventoryItem(itemName).count
    ParaziaRPServerUtils.toClient("houseDepositSucceed", source, itemName, itemCount, depositCount)
end)

ParaziaRP.netRegisterAndHandle("removeFromHouse", function(houseId, itemName, removalCount)
    if not ParaziaRPSHousesManager.list[houseId] then
        return
    end
    local source = source
    local license = ParaziaRPServerUtils.getLicense(source)
    ---@type House
    local house = ParaziaRPSHousesManager.list[houseId]
    if not house:isOwner(source) then
        ParaziaRPServerUtils.toClient("houseDepositFailed", source, "Erreur: Une erreur est survenue")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    if house.inventory[itemName] == nil then
        return
    end
    local avaibleCount = house.inventory[itemName]
    if removalCount > avaibleCount then
        ParaziaRPServerUtils.toClient("houseDepositFailed", source, "Erreur: Une erreur est survenue")
        return
    end
    house:removeItem(itemName, removalCount, source)
    xPlayer.addInventoryItem(itemName, removalCount)
    itemCount = xPlayer.getInventoryItem(itemName).count
    ParaziaRPServerUtils.toClient("houseRemovalSucceed", source, itemName, itemCount, removalCount)
end)

ParaziaRP.netRegisterAndHandle("depositHouse:weapon", function(houseId, itemName, depositCount)
    if not ParaziaRPSHousesManager.list[houseId] then
        return
    end
    local source = source
    local license = ParaziaRPServerUtils.getLicense(source)
    ---@type House
    local house = ParaziaRPSHousesManager.list[houseId]
    if not house:isOwner(source) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.hasWeapon(itemName) then
		TriggerEvent('esx_datastore:getDataStore', 'property', house:getOwner(), function(store)
			local storeWeapons = store.get('weapons') or {}

			table.insert(storeWeapons, {
				name = itemName,
				ammo = depositCount
			})

			store.set('weapons', storeWeapons)
			xPlayer.removeWeapon(itemName)
            ParaziaRPServerUtils.toClient("houseDepositSucceed:weapon", source)
		end)
	else
		xPlayer.showNotification('Vous ne possédez pas cette arme !')
	end
end)

ParaziaRP.netRegisterAndHandle("removeFromHouse:weapon", function(houseId, itemName, removalCount)
    if not ParaziaRPSHousesManager.list[houseId] then
        return
    end
    local source = source
    local license = ParaziaRPServerUtils.getLicense(source)
    ---@type House
    local house = ParaziaRPSHousesManager.list[houseId]
    if not house:isOwner(source) then
        ParaziaRPServerUtils.toClient("houseDepositFailed", source, "Erreur: Une erreur est survenue")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_datastore:getDataStore', 'property', house:getOwner(), function(store)
        local storeWeapons = store.get('weapons') or {}
        local weaponName = nil
        local ammo = nil

        for i=1, #storeWeapons, 1 do
            if storeWeapons[i].name == itemName then
                weaponName = storeWeapons[i].name
                ammo = storeWeapons[i].ammo

                table.remove(storeWeapons, i)
                break
            end
        end

        store.set('weapons', storeWeapons)
        xPlayer.addWeapon(weaponName, ammo)
        ParaziaRPServerUtils.toClient("houseRemovalSucceed:weapon", source)
    end)
end)

ParaziaRP.netRegisterAndHandle("depositHouse:blackmoney", function(houseId, depositCount)
    if not ParaziaRPSHousesManager.list[houseId] then
        return
    end
    local source = source
    local license = ParaziaRPServerUtils.getLicense(source)
    ---@type House
    local house = ParaziaRPSHousesManager.list[houseId]
    if not house:isOwner(source) then
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    local playerAccountMoney = xPlayer.getAccount('dirtycash').money

    if playerAccountMoney >= depositCount and depositCount > 0 then
        xPlayer.removeAccountMoney('dirtycash', depositCount)
        TriggerEvent('esx_addonaccount:getAccount', 'property_dirtycash', house:getOwner(), function(account)
            account.addMoney(depositCount)
        end)
        ParaziaRPServerUtils.toClient("houseDepositSucceed:weapon", source)
    else
        TriggerClientEvent('esx:showNotification', source, "~r~Quantité invalide")
    end
end)

ParaziaRP.netRegisterAndHandle("removeFromHouse:blackmoney", function(houseId, removalCount)
    if not ParaziaRPSHousesManager.list[houseId] then
        return
    end
    local source = source
    local license = ParaziaRPServerUtils.getLicense(source)
    ---@type House
    local house = ParaziaRPSHousesManager.list[houseId]
    if not house:isOwner(source) then
        ParaziaRPServerUtils.toClient("houseDepositFailed", source, "Erreur: Une erreur est survenue")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addonaccount:getAccount', 'property_dirtycash', house:getOwner(), function(account)
        local roomAccountMoney = account.money

        if roomAccountMoney >= removalCount then
            account.removeMoney(removalCount)
            xPlayer.addAccountMoney('dirtycash', removalCount)
            ParaziaRPServerUtils.toClient("houseRemovalSucceed:weapon", source)
        else
            TriggerClientEvent('esx:showNotification', source, "~r~Quantité invalide")
        end
    end)
end)

ParaziaRP.netRegisterAndHandle("removeFromHouse:weapon", function(houseId, itemName, removalCount)
    if not ParaziaRPSHousesManager.list[houseId] then
        return
    end
    local source = source
    local license = ParaziaRPServerUtils.getLicense(source)
    ---@type House
    local house = ParaziaRPSHousesManager.list[houseId]
    if not house:isOwner(source) then
        ParaziaRPServerUtils.toClient("houseDepositFailed", source, "Erreur: Une erreur est survenue")
        return
    end
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_datastore:getDataStore', 'property', house:getOwner(), function(store)
        local storeWeapons = store.get('weapons') or {}
        local weaponName = nil
        local ammo = nil

        for i=1, #storeWeapons, 1 do
            if storeWeapons[i].name == itemName then
                weaponName = storeWeapons[i].name
                ammo = storeWeapons[i].ammo

                table.remove(storeWeapons, i)
                break
            end
        end

        store.set('weapons', storeWeapons)
        xPlayer.addWeapon(weaponName, ammo)
        ParaziaRPServerUtils.toClient("houseRemovalSucceed:weapon", source)
    end)
end)

ESX.RegisterServerCallback('prz_property:getPropertyInventory', function(source, cb, owner)
	local xPlayer = ESX.GetPlayerFromId(source)
	local blackMoney = 0
	local weapons = {}

	TriggerEvent('esx_addonaccount:getAccount', 'property_dirtycash', xPlayer.identifier, function(account)
		blackMoney = account.money
	end)

	TriggerEvent('esx_datastore:getDataStore', 'property', xPlayer.identifier, function(store)
		weapons = store.get('weapons') or {}
	end)

	cb({
		blackMoney = blackMoney,
		weapons    = weapons
	})
end)