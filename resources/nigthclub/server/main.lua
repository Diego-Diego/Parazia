ESX = nil
TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

RegisterNetEvent('nightclub:craftingCoktails')
AddEventHandler('nightclub:craftingCoktails', function(itemValue)
	local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.showNotification("Cocktail en cours ...")
    if itemValue == 'manhattan' then
        SetTimeout(5000, function()

            local aQuantity = xPlayer.getInventoryItem('whisky').count
            local bQuantity = xPlayer.getInventoryItem('verrouge').count
            local cQuantity = xPlayer.getInventoryItem('angostura').count
            local dQuantity = xPlayer.getInventoryItem('cerise').count

            if aQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de whisky !")
            elseif bQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de Vermouth rouge !")
            elseif cQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de Angostura bitters !")
            elseif dQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de Cerise confite !")
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= 10 then
                    xPlayer.showNotification("~r~Vous avez raté le craft !")
                    xPlayer.removeInventoryItem('whisky', 1)
                    xPlayer.removeInventoryItem('verrouge', 1)
                    xPlayer.removeInventoryItem('angostura', 1)
                    xPlayer.removeInventoryItem('cerise', 1)
                else
                    xPlayer.showNotification("~r~Vous avez réussi le craft !")
                    xPlayer.removeInventoryItem('whisky', 1)
                    xPlayer.removeInventoryItem('verrouge', 1)
                    xPlayer.removeInventoryItem('angostura', 1)
                    xPlayer.removeInventoryItem('cerise', 1)
                    xPlayer.addInventoryItem('manhattan', 1)
                end
            end

        end)
    end

    if itemValue == 'drymartini' then
        SetTimeout(5000, function()

            local aQuantity = xPlayer.getInventoryItem('gin').count
            local bQuantity = xPlayer.getInventoryItem('verdry').count
            local cQuantity = xPlayer.getInventoryItem('olive').count

            if aQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de gin !")
            elseif bQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de Vermouth dry !")
            elseif cQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez d'olive !")
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= 10 then
                    xPlayer.showNotification("~r~Vous avez raté le craft !")
                    xPlayer.removeInventoryItem('gin', 1)
                    xPlayer.removeInventoryItem('verdry', 1)
                    xPlayer.removeInventoryItem('olive', 1)
                else
                    xPlayer.showNotification("~r~Vous avez réussi le craft !")
                    xPlayer.removeInventoryItem('gin', 1)
                    xPlayer.removeInventoryItem('verdry', 1)
                    xPlayer.removeInventoryItem('olive', 1)
                    xPlayer.addInventoryItem('drymartini', 1)
                end
            end

        end)
    end

    if itemValue == 'oldfashioned' then
        SetTimeout(5000, function()

            local aQuantity = xPlayer.getInventoryItem('whisky').count
            local bQuantity = xPlayer.getInventoryItem('angostura').count
            local cQuantity = xPlayer.getInventoryItem('sucre').count
            local dQuantity = xPlayer.getInventoryItem('orangez').count

            if aQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de whisky !")
            elseif bQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de Angostura bitters !")
            elseif cQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de sucre !")
            elseif dQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de Zeste d'orange !")
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= 10 then
                    xPlayer.showNotification("~r~Vous avez raté le craft !")
                    xPlayer.removeInventoryItem('whisky', 1)
                    xPlayer.removeInventoryItem('angostura', 1)
                    xPlayer.removeInventoryItem('sucre', 1)
                    xPlayer.removeInventoryItem('orangez', 1)
                else
                    xPlayer.showNotification("~r~Vous avez réussi le craft !")
                    xPlayer.removeInventoryItem('whisky', 1)
                    xPlayer.removeInventoryItem('angostura', 1)
                    xPlayer.removeInventoryItem('sucre', 1)
                    xPlayer.removeInventoryItem('orangez', 1)
                    xPlayer.addInventoryItem('oldfashioned', 1)
                end
            end

        end)
    end

    if itemValue == 'maithai' then
        SetTimeout(5000, function()

            local aQuantity = xPlayer.getInventoryItem('rhum').count
            local bQuantity = xPlayer.getInventoryItem('rhum2').count
            local cQuantity = xPlayer.getInventoryItem('triplesec').count
            local dQuantity = xPlayer.getInventoryItem('sucrecan').count
            local eQuantity = xPlayer.getInventoryItem('siroporgeat').count
            local fQuantity = xPlayer.getInventoryItem('citronvert').count

            if aQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de Rhum blanc !")
            elseif bQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de Rhum ambré !")
            elseif cQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de Triple sec !")
            elseif dQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de sucre de canne !")
            elseif eQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de Sirot d'orgeat !")
            elseif fQuantity < 1 then
                xPlayer.showNotification("~r~Vous n'avez pas assez de citron vert !")
            else
                local chanceToMiss = math.random(100)
                if chanceToMiss <= 10 then
                    xPlayer.showNotification("~r~Vous avez raté le craft !")
                    xPlayer.removeInventoryItem('rhum', 1)
                    xPlayer.removeInventoryItem('rhum2', 1)
                    xPlayer.removeInventoryItem('triplesec', 1)
                    xPlayer.removeInventoryItem('sucrecan', 1)
                    xPlayer.removeInventoryItem('siroporgeat', 1)
                    xPlayer.removeInventoryItem('citronvert', 1)
                else
                    xPlayer.showNotification("~r~Vous avez réussi le craft !")
                    xPlayer.removeInventoryItem('rhum', 1)
                    xPlayer.removeInventoryItem('rhum2', 1)
                    xPlayer.removeInventoryItem('triplesec', 1)
                    xPlayer.removeInventoryItem('sucrecan', 1)
                    xPlayer.removeInventoryItem('siroporgeat', 1)
                    xPlayer.removeInventoryItem('citronvert', 1)
                    xPlayer.addInventoryItem('maithai', 1)
                end
            end

        end)
    end
end)

ESX.RegisterUsableItem('manhattan', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('manhattan', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source,"~r~Vous avez bue un Manhattan")
end)

ESX.RegisterUsableItem('drymartini', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('drymartini', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source,"~r~Vous avez bue un Dry martini")
end)

ESX.RegisterUsableItem('oldfashioned', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('oldfashioned', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source,"~r~Vous avez bue un Old fashioned")
end)

ESX.RegisterUsableItem('maithai', function(source)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('maithai', 1)

	TriggerClientEvent('esx_status:add', source, 'drunk', 250000)
	TriggerClientEvent('esx_status:onDrinkAlcohol', source)
	TriggerClientEvent('esx:showNotification', source,"~r~Vous avez bue un Mai Thai")
end)

RegisterNetEvent('nightclub:buyItem')
AddEventHandler('nightclub:buyItem', function(itemName, price)
    local xPlayer  = ESX.GetPlayerFromId(source)
	local societyAccount = nil

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_lux', function(account)
		societyAccount = account
    end)

    if societyAccount ~= nil and societyAccount.money >= price then
		if xPlayer.canCarryItem(itemName, 1) then
            societyAccount.removeMoney(price)
            xPlayer.addInventoryItem(itemName, 1)
            xPlayer.showNotification("Item acheté !")
        else
            xPlayer.showNotification("Max d'item")
        end
    else
        xPlayer.showNotification('Pas assez d\'argent dans votre société')
    end
end)

RegisterServerEvent('nightclub:getStockItem')
AddEventHandler('nightclub:getStockItem', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lux', function(inventory)
        local item = inventory.getItem(itemName)

        if item.count >= count then
            inventory.removeItem(itemName, count)
            xPlayer.addInventoryItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Quantité invalid")
        end
    end)
end)

ESX.RegisterServerCallback('nightclub:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lux', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(all_items)
end)

RegisterServerEvent('nightclub:putStockItems')
AddEventHandler('nightclub:putStockItems', function(itemName, count)
    local xPlayer = ESX.GetPlayerFromId(source)
    
    TriggerEvent('esx_addoninventory:getSharedInventory', 'society_lux', function(inventory)
        local item = inventory.getItem(itemName)
        local playerItemCount = xPlayer.getInventoryItem(itemName).count

        if item.count >= 0 and count <= playerItemCount then
            xPlayer.removeInventoryItem(itemName, count)
            inventory.addItem(itemName, count)
        else
            TriggerClientEvent('esx:showNotification', xPlayer.source, "Quantité invalid")
        end

        TriggerClientEvent('esx:showNotification', xPlayer.source, _U('you_added') .. count .. ' ' .. item.label)
    end)
end)

ESX.RegisterServerCallback('nightclub:getPlayerInventory', function(source, cb)
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