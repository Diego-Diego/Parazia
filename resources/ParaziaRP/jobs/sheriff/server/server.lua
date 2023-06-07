TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'sheriff', 'alerte sheriff', true, true)

TriggerEvent('esx_society:registerSociety', 'sheriff', 'sheriff', 'society_sheriff', 'society_sheriff', 'society_sheriff', {type = 'public'})


-- Coffre

ESX.RegisterServerCallback('sheriff:playerinventory', function(source, cb)
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


ESX.RegisterServerCallback('sheriff:getStockItems', function(source, cb)
	local all_items = {}
	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sheriff', function(inventory)
		for k,v in pairs(inventory.items) do
			if v.count > 0 then
				table.insert(all_items, {label = v.label,item = v.name, nb = v.count})
			end
		end

	end)
	cb(all_items)
end)

RegisterServerEvent('sheriff:putStockItems')
AddEventHandler('sheriff:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)
	local item_in_inventory = xPlayer.getInventoryItem(itemName).count

	if xPlayer.job.name == 'sheriff' then
		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sheriff', function(inventory)
			if item_in_inventory >= count and count > 0 then
				xPlayer.removeInventoryItem(itemName, count)
				inventory.addItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~g~Dépot\n~s~- ~g~Item ~s~: "..itemName.."\n~s~- ~o~Quantitée ~s~: "..count.."")
			else
				TriggerClientEvent('esx:showNotification', xPlayer.source, "~q~Vous n'en avez pas assez sur vous")
			end
		end)
	end
end)

RegisterServerEvent('sheriff:takeStockItems')
AddEventHandler('sheriff:takeStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		TriggerEvent('esx_addoninventory:getSharedInventory', 'society_sheriff', function(inventory)
				xPlayer.addInventoryItem(itemName, count)
				inventory.removeItem(itemName, count)
				TriggerClientEvent('esx:showNotification', xPlayer.source, "- ~q~Retrait\n~s~- ~g~Item ~s~: "..itemName.."\n~s~- ~o~Quantitée ~s~: "..count.."")
		end)
	end
end)

--- Prise de service

function sendToDiscordWithSpecialURL(name,message,color,url)
    local DiscordWebHook = url
	local embeds = {
		{
			["title"]=message,
			["type"]="rich",
			["color"] =color,
			["footer"]=  {
			["text"]= "Aurezia sheriff",
			},
		}
	}
    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(cfg_sheriffWebhookRendezVoussheriff, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

RegisterNetEvent('sheriff:prisedeservice')
AddEventHandler('sheriff:prisedeservice', function()
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	sendToDiscordWithSpecialURL("Prise de service",xPlayer.getName().." à prise son service", 16744192, cfg_sheriffWebhookRendezVoussheriff)
end)

RegisterNetEvent('sheriff:quitteleservice')
AddEventHandler('sheriff:quitteleservice', function()
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	sendToDiscordWithSpecialURL("Fin de service",xPlayer.getName().." à quitter son service", 16744192, cfg_sheriffWebhookRendezVoussheriff)
end)

--- Accueil

local function sendToDiscordWithSpecialURL(Color, Title, Description)
	local Content = {
	        {
	            ["color"] = Color,
	            ["title"] = Title,
	            ["description"] = Description,
		        ["footer"] = {
	            ["text"] = "Aurezia sheriff",
	            ["icon_url"] = nil,
	            },
	        }
	    }
	PerformHttpRequest(cfg_sheriffWebhookRendezVoussheriff, function(err, text, headers) end, 'POST', json.encode({username = Name, embeds = Content}), { ['Content-Type'] = 'application/json' })
end

RegisterServerEvent("Rdv:sheriffMotif")
AddEventHandler("Rdv:sheriffMotif", function(nomprenom, numero, heurerdv, rdvmotif)
	local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    --local ident = xPlayer.getIdentifier()
	local date = os.date('*t')

	if date.day < 10 then date.day = '' .. tostring(date.day) end
	if date.month < 10 then date.month = '' .. tostring(date.month) end
	if date.hour < 10 then date.hour = '' .. tostring(date.hour) end
	if date.min < 10 then date.min = '' .. tostring(date.min) end
	if date.sec < 10 then date.sec = '' .. tostring(date.sec) end

	--if ident == 'steam:11' then--Special character in username just crash the server
	--else 
		sendToDiscordWithSpecialURL(16744192, "Nouveau Rendez-Vous\n\n```Nom : "..nomprenom.."\n\nNuméro de Téléphone: "..numero.."\n\nHeure du Rendez Vous : " ..heurerdv.."\n\nMotif du Rendez-vous : " ..rdvmotif.. "\n\n```Date : " .. date.day .. "." .. date.month .. "." .. date.year .. " | " .. date.hour .. " h " .. date.min .. " min " .. date.sec)
	--end
end)

RegisterServerEvent('Appel:sheriff')
AddEventHandler('Appel:sheriff', function()
    
	local xPlayers = ESX.GetPlayers()
	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'sheriff' then
		TriggerClientEvent('esx:showAdvancedNotification', xPlayers[i], 'sheriff', '~q~Accueil', 'Un policier est appelé à l\'accueil !', 'CHAR_ABIGAIL', 8)
        end
    end
end)

-- Infos sheriff
RegisterServerEvent('sheriff:PriseEtFinservice')
AddEventHandler('sheriff:PriseEtFinservice', function(PriseOuFin)
	local _source = source
	local _raison = PriseOuFin
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()
	local name = xPlayer.getName(_source)

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'sheriff' then
			TriggerClientEvent('sheriff:InfoService', xPlayers[i], _raison, name)
		end
	end
end)

-- Renfort

RegisterServerEvent('renfort')
AddEventHandler('renfort', function(coords, raison)
	local _source = source
	local _raison = raison
	local xPlayer = ESX.GetPlayerFromId(_source)
	local xPlayers = ESX.GetPlayers()

	for i = 1, #xPlayers, 1 do
		local thePlayer = ESX.GetPlayerFromId(xPlayers[i])
		if thePlayer.job.name == 'sheriff' then
			TriggerClientEvent('renfort:setBlip', xPlayers[i], coords, _raison)
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- FOUILLE ----
-----------------

--[[RegisterNetEvent('sheriff:confiscatePlayerItem')
AddEventHandler('sheriff:confiscatePlayerItem', function(target, itemType, itemName, amount)
    local _source = source
    local sourceXPlayer = ESX.GetPlayerFromId(_source)
    local targetXPlayer = ESX.GetPlayerFromId(target)

	if sourceXPlayer.job.name == 'sheriff' then
		if itemType == 'item_standard' then
			local targetItem = targetXPlayer.getInventoryItem(itemName)
			local sourceItem = sourceXPlayer.getInventoryItem(itemName)
			
				targetXPlayer.removeInventoryItem(itemName, amount)
				sourceXPlayer.addInventoryItem(itemName, amount)
				TriggerClientEvent("esx:showNotification", source, "Vous avez volé ~q~"..amount..' '..sourceItem.label.."~s~.")
				TriggerClientEvent("esx:showNotification", target, "Il t'a été volé ~q~"..amount..' '..sourceItem.label.."~s~.")
			else
				--TriggerClientEvent("esx:showNotification", source, "~q~quantité invalide")
			end
			
		if itemType == 'item_account' then
			targetXPlayer.removeAccountMoney(itemName, amount)
			sourceXPlayer.addAccountMoney   (itemName, amount)
			
			TriggerClientEvent("esx:showNotification", source, "Vous avez volé ~q~"..amount.."€ ~s~Argent sale~s~.")
			TriggerClientEvent("esx:showNotification", target, "Il t'a été volé ~q~"..amount.."€ ~s~Argent sale~s~.")
			
		elseif itemType == 'item_weapon' then
			if amount == nil then amount = 0 end
			targetXPlayer.removeWeapon(itemName, amount)
			sourceXPlayer.addWeapon   (itemName, amount)

			TriggerClientEvent("esx:showNotification", source, "Vous avez volé ~q~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~q~"..amount.."~s~ munitions.")
			TriggerClientEvent("esx:showNotification", target, "Il t'a été volé ~q~"..ESX.GetWeaponLabel(itemName).."~s~ avec ~q~"..amount.."~s~ munitions.")
		end
	end
end)]]


ESX.RegisterServerCallback('sheriff:getOtherPlayerData', function(source, cb, target, notify)
    local xPlayer = ESX.GetPlayerFromId(target)

    TriggerClientEvent("esx:showNotification", target, "~q~Tu es fouillé...")

    if xPlayer then
        local data = {
            name = xPlayer.getName(),
            job = xPlayer.job.label,
            grade = xPlayer.job.grade_label,
            inventory = xPlayer.getInventory(),
            accounts = xPlayer.getAccounts(),
            weapons = xPlayer.getLoadout()
        }

        cb(data)
    end
end)

--- Menotter
RegisterServerEvent('::{korioz#0110}::esx_sheriffjob:drag')
AddEventHandler('::{korioz#0110}::esx_sheriffjob:drag', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		local xPlayerTarget = ESX.GetPlayerFromId(target)

		if xPlayerTarget.get('cuffState').isCuffed then
			TriggerClientEvent('::{korioz#0110}::esx_sheriffjob:drag', target, xPlayer.source)
		end
	else
		print(('esx_sheriffjob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('::{korioz#0110}::esx_sheriffjob:putInVehicle')
AddEventHandler('::{korioz#0110}::esx_sheriffjob:putInVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		local xPlayerTarget = ESX.GetPlayerFromId(target)

		if xPlayerTarget.get('cuffState').isCuffed then
			TriggerClientEvent('::{korioz#0110}::esx_sheriffjob:putInVehicle', target)
		end
	else
		print(('esx_sheriffjob: %s attempted to put in vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

RegisterServerEvent('::{korioz#0110}::esx_sheriffjob:OutVehicle')
AddEventHandler('::{korioz#0110}::esx_sheriffjob:OutVehicle', function(target)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		local xPlayerTarget = ESX.GetPlayerFromId(target)

		if xPlayerTarget.get('cuffState').isCuffed then
			TriggerClientEvent('::{korioz#0110}::esx_sheriffjob:OutVehicle', target)
		end
	else
		print(('esx_sheriffjob: %s attempted to drag out from vehicle (not cop)!'):format(xPlayer.identifier))
	end
end)

-- Ppa

RegisterNetEvent('donner:ppa')
AddEventHandler('donner:ppa', function()

    local _source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local price = 2500
    local xMoney = xPlayer.getMoney()
	local societyAccount

	if xPlayer.job.name == 'sheriff' then
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_sheriff', function(account)
			societyAccount = account
		end)


				if price < societyAccount.money then

						societyAccount.removeMoney(price)

		else
			TriggerClientEvent('esx:showNotification', source, "Vous n'avez assez ~q~d\'argent dans votre société")
		end
	end
end)

----------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------------
---- FOUILLE ----
-----------------

ESX.RegisterServerCallback('sheriff:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	TriggerClientEvent("esx:showAdvancedNotification", target, "Vous êtes en train de vous faire fouiller.", 5000, "danger")

	if xPlayer then
		local data = {
			inventory = xPlayer.getInventory(),
			accounts = xPlayer.getAccounts(),
			weapons = xPlayer.getLoadout()
		}

		cb(data)
	end
end)


ESX.RegisterServerCallback('esx_sheriffjob:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @identifier", {
		['@identifier'] = xPlayer.identifier
	}, function(result)
		local data = {
			name = GetPlayerName(target),
			job = xPlayer.job,
			job2 = xPlayer.job2,
			inventory = xPlayer.inventory,
			accounts = xPlayer.accounts,
			weapons = xPlayer.loadout,
			firstname = result[1]['firstname'],
			lastname = result[1]['lastname'],
			sex = result[1]['sex'],
			dob = result[1]['dateofbirth'],
			height = result[1]['height']
		}
	
		--TriggerEvent('esx_license:getLicenses', target, function(licenses)
			--if licenses ~= nil then
				--data.licenses = licenses
			--end
		--end)
	
		cb(data)
	end)
end)


-- Plaque

ESX.RegisterServerCallback('sheriff:getVehicleInfos', function(source, cb, plate)

	MySQL.Async.fetchAll('SELECT owner, vehicle FROM owned_vehicles WHERE plate = @plate', {
		['@plate'] = plate
	}, function(result)

		local retrivedInfo = {
			plate = plate
		}

		if result[1] then
			MySQL.Async.fetchAll('SELECT firstname, lastname FROM users WHERE identifier = @identifier',  {
				['@identifier'] = result[1].owner
			}, function(result2)

				retrivedInfo.owner = result2[1].firstname .. ' ' .. result2[1].lastname

				retrivedInfo.vehicle = json.decode(result[1].vehicle)

				cb(retrivedInfo)

			end)
		else
			cb(retrivedInfo)
		end
	end)
end)

-- Facture

RegisterNetEvent("sheriff:SendFacture")
AddEventHandler("sheriff:SendFacture", function(target, price)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.job.name == 'sheriff' then
		TriggerEvent('esx_addonaccount:getSharedAccount', 'society_sheriff', function(account)
			if account ~= nil then
				societyAccount = account
				local xPlayer = ESX.GetPlayerFromId(target)
				xPlayer.removeAccountMoney('bank', price)
				societyAccount.addMoney(price)
				TriggerClientEvent("esx:showNotification", target, "Votre compte en banque à été réduit de ~q~"..price.."e~s~.", 5000, "danger")
				TriggerClientEvent("esx:showNotification", source, "Vous avez donné une amende de ~q~"..price.."~s~e", 5000, "danger")
			end
		end)
	end
end)

RegisterNetEvent("prz_armurie:sheriff")
AddEventHandler("prz_armurie:sheriff", function(weapon)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)

	if xPlayer.job.name == 'sheriff' then
		xPlayer.addWeapon(weapon, 250)
	end
end)

RegisterNetEvent("prz_armurie:sheriffdepo")
AddEventHandler("prz_armurie:sheriffdepo", function(weapon)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)

	if xPlayer.job.name == 'sheriff' then
		xPlayer.removeWeapon(weapon)
		TriggerClientEvent('esx:showNotification', source, "Vous avez posé tous vos armes")
	end
end)