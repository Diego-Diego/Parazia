RegisterNetEvent('ewen:createGang', function(namegang, labelgang, positonCoffre, KitArme, Blanchiement)
	local posCoffre = json.encode(positonCoffre)
    local xPlayer = ESX.GetPlayerFromId(source)
	if KitArme then
		KitArme = 1 
	else 
		KitArme = 0
	end
	if Blanchiement then
		Blanchiement = 1 
	else 
		Blanchiement = 0
	end
    if xPlayer.getGroup() == '_dev' or xPlayer.getGroup() == 'gamemaster' or xPlayer.getGroup() == 'superadmin' then
		--local webhook = ''
		--SeaLogs(webhook, 'ParaziaRP', '\nNouveau Gang crée \nLe joueur qui crée le gang : __' .. GetPlayerName(xPlayer.source) .. '__\nNom du gang : '..namegang.. '\nLabel du Gang : '..labelgang..'\nPosition :'.. positonCoffre, 56108)
		MySQL.Async.execute("INSERT INTO `gangs` (`gangname`, `posCoffre`, `KitArme`, `Blanchiement`) VALUES (@gangname, @posCoffre, @KitArme, @Blanchiement) ", {
            ['@gangname'] = namegang,
            ['@posCoffre'] = posCoffre,
			['@KitArme'] = KitArme,
			['@Blanchiement'] = Blanchiement
        })
		MySQL.Async.execute("INSERT INTO `jobs` (`name`, `label`, `whitelisted`) VALUES (@name, @label, @whitelisted) ", {
            ['@name'] = namegang,
            ['@label'] = labelgang,
            ['@whitelisted'] = 1
        })
        MySQL.Async.execute("INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
            ['@job_name'] = namegang,
            ['@grade'] = 3,
            ['@name'] = "boss",
            ['@label'] = "Boss",
            ['@salary'] = 0,
            ['@skin_male'] = "{}",
            ['@skin_female'] = "{}"
        })
        MySQL.Async.execute("INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
            ['@job_name'] = namegang,
            ['@grade'] = 2,
            ['@name'] = "gerant",
            ['@label'] = "Gérant",
            ['@salary'] = 0,
            ['@skin_male'] = "{}",
            ['@skin_female'] = "{}"
        })
        MySQL.Async.execute("INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
            ['@job_name'] = namegang,
            ['@grade'] = 1,
            ['@name'] = "membre",
            ['@label'] = "Membre",
            ['@salary'] = 0,
            ['@skin_male'] = "{}",
            ['@skin_female'] = "{}"
        })
        MySQL.Async.execute("INSERT INTO `job_grades` (`job_name`, `grade`, `name`, `label`, `salary`, `skin_male`, `skin_female`) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)", {
            ['@job_name'] = namegang,
            ['@grade'] = 0,
            ['@name'] = "recrue",
            ['@label'] = "Recrue",
            ['@salary'] = 0,
            ['@skin_male'] = "{}",
            ['@skin_female'] = "{}"
        })
        MySQL.Async.execute("INSERT INTO `addon_account` (`name`, `label`, `shared`) VALUES (@name, @label, @shared) ", {
            ['@name'] = 'society_'..name,
            ['@label'] = label,
            ['@shared'] = 1
        })
        MySQL.Async.execute("INSERT INTO `addon_inventory` (`name`, `label`, `shared`) VALUES (@name, @label, @shared) ", {
            ['@name'] = 'society_'..name,
            ['@label'] = label,
            ['@shared'] = 1
        })
        MySQL.Async.execute("INSERT INTO `datastore` (`name`, `label`, `shared`) VALUES (@name, @label, @shared) ", {
            ['@name'] = 'society_'..name,
            ['@label'] = label,
            ['@shared'] = 1
        })
    end
end)

local GangsList = {}

Citizen.CreateThread(function()
    MySQL.Async.fetchAll('SELECT * FROM gangs', {}, function(Gangs)
        for i=1, #Gangs, 1 do
            GangsList[Gangs[i].gangname] = {}
            GangsList[Gangs[i].gangname].name = Gangs[i].gangname 
            GangsList[Gangs[i].gangname].posCoffre = json.decode(Gangs[i].posCoffre)
			GangsList[Gangs[i].gangname].KitArme = Gangs[i].KitArme
			GangsList[Gangs[i].gangname].Blanchiement = Gangs[i].Blanchiement
        end
		print('[^4LOAD^0][^4'..#Gangs..'^0] ont été load avec succès')
    end)
end)

RegisterNetEvent('ewen:initGangs', function()
    TriggerClientEvent('ewen:SendGangListToClient', source, GangsList)
end)

ESX.RegisterServerCallback('GangsBuilder:addArmoryWeapon', function(source, cb, weaponName, weaponAmmo)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.hasWeapon(weaponName) then
		TriggerEvent('esx_datastore:getSharedDataStore', 'society_'..xPlayer.job2.name, function(store)
			--if PermanantWeapon[weaponName] == nil then
				local weapons = store.get('weapons') or {}
				weaponName = string.upper(weaponName)
	
				table.insert(weapons, {
					name = weaponName,
					ammo = weaponAmmo
				})
	
				xPlayer.removeWeapon(weaponName)
				store.set('weapons', weapons)
				cb()
				--local webhook = ''
				--SeaLogs(webhook, 'ParaziaRP', '\nLe joueur : __' .. GetPlayerName(xPlayer.source) .. ' à déposer dans __\nNom du gang : '..xPlayer.job2.name.. '\nLabel du Gang : '..xPlayer.job2.label..'\nArme déposer :'.. weaponName, 56108)
			--else
				--xPlayer.showNotification('~q~ParaziaRP ~w~~n~Vous ne pouvez pas déposer les armes permanentes')
				--cb()
			--end
		end)
	else
		xPlayer.showNotification('Vous ne possédez pas cette arme !')
		cb()
	end
end)

ESX.RegisterServerCallback('GangsBuilder:getArmoryWeapons', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)
	TriggerEvent('esx_datastore:getSharedDataStore', 'society_' .. xPlayer.job2.name, function(store)
		local weapons = store.get('weapons') or {}
		cb(weapons)
	end)
end)

ESX.RegisterServerCallback('GangsBuilder:removeArmoryWeapon', function(source, cb, weaponName, weaponAmmo)
	local xPlayer = ESX.GetPlayerFromId(source)

	if not xPlayer.hasWeapon(weaponName) then
		TriggerEvent('esx_datastore:getSharedDataStore', 'society_' .. xPlayer.job2.name, function(store)
			--if PermanantWeapon[weaponName] == nil then
				local weapons = store.get('weapons') or {}
				weaponName = string.upper(weaponName)

				for i = 1, #weapons, 1 do
					if weapons[i].name == weaponName and weapons[i].ammo == weaponAmmo then
						table.remove(weapons, i)

						store.set('weapons', weapons)
						xPlayer.addWeapon(weaponName, weaponAmmo)
						--local webhook = ''
						--SeaLogs(webhook, 'ParaziaRP', '\nLe joueur : __' .. GetPlayerName(xPlayer.source) .. ' à retirer de __\nNom du gang : '..xPlayer.job2.name.. '\nLabel du Gang : '..xPlayer.job2.label..'\nArme retirer :'.. weaponName, 56108)
						break
					end
				end

				cb()
			--else
				--xPlayer.showNotification('~q~ParaziaRP ~w~~n~Vous ne pouvez pas déposer les armes permanentes')
				--cb()
			--end
		end)
	else
		xPlayer.showNotification('Vous possédez déjà cette arme !')
		cb()
	end
end)

RegisterNetEvent('GangsBuilder:putStockItems', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_' .. xPlayer.job2.name, function(inventory)
		local sourceItem = xPlayer.getInventoryItem(itemName)

		if sourceItem.count >= count and count > 0 then
			xPlayer.removeInventoryItem(itemName, count)
			inventory.addItem(itemName, count)
			xPlayer.showNotification('~q~ParaziaRP ~w~~n~Vous avez déposer ~y~x'..count.. ' ~q~'.. ESX.GetItem(itemName).label)
			--local webhook = ''
			--SeaLogs(webhook, 'ParaziaRP', '\nLe joueur : __' .. GetPlayerName(xPlayer.source) .. ' à déposer dans __\nNom du gang : '..xPlayer.job2.name.. '\nLabel du Gang : '..xPlayer.job2.label..'\nItem déposer :'.. itemName..'\nQuantités : '.. count, 56108)
		else
			xPlayer.showNotification('~q~ParaziaRP ~w~~n~Vous n\'avez pas la quantité nécéssaire pour déposer dans le coffre')
		end
	end)
end)

ESX.RegisterServerCallback('GangsBuilder:getStockItems', function(source, cb)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_' .. xPlayer.job2.name, function(inventory)
		cb(inventory.items)
	end)
end)

RegisterNetEvent('GangsBuilder:getStockItem', function(itemName, count)
	local xPlayer = ESX.GetPlayerFromId(source)

	TriggerEvent('esx_addoninventory:getSharedInventory', 'society_' .. xPlayer.job2.name, function(inventory)
		local inventoryItem = inventory.getItem(itemName)

		if inventoryItem.count >= count and inventoryItem.count > 0 then
			if xPlayer.canCarryItem(itemName, count) then
				inventory.removeItem(itemName, count)
				xPlayer.addInventoryItem(itemName, count)
				--local webhook = ''
				--SeaLogs(webhook, 'ParaziaRP', '\nLe joueur : __' .. GetPlayerName(xPlayer.source) .. ' à retirer dans __\nNom du gang : '..xPlayer.job2.name.. '\nLabel du Gang : '..xPlayer.job2.label..'\nItem retirer :'.. itemName..'\nQuantités : '.. count, 56108)
				xPlayer.showNotification('~q~ParaziaRP ~w~~n~Vous avez retirer ~y~x'.. count.. ' ~q~' ..inventoryItem.label)
			else
				xPlayer.showNotification('~q~ParaziaRP ~w~~n~Vous ne pouvez pas prendre autant d\'objets sur vous')
			end
		else
			xPlayer.showNotification('~q~ParaziaRP ~w~~n~Le coffre ne contient pas la quantité que vous souhaitez prendre')
		end
	end)
end)

RegisterNetEvent('GangsBuilder:putInVehicle', function(target)
	local xPlayerTarget = ESX.GetPlayerFromId(target)

	if xPlayerTarget ~= nil then
		local cuffState = xPlayerTarget.get('cuffState')

		if cuffState.isCuffed then
			TriggerClientEvent('GangsBuilder:putInVehicle', target)
		end
	end
end)

RegisterNetEvent('GangsBuilder:OutVehicle', function(target)
	local xPlayerTarget = ESX.GetPlayerFromId(target)

	if xPlayerTarget ~= nil then
		local cuffState = xPlayerTarget.get('cuffState')

		if cuffState.isCuffed then
			TriggerClientEvent('GangsBuilder:OutVehicle', target)
		end
	end
end)

ESX.RegisterServerCallback('GangsBuilder:getOtherPlayerData', function(source, cb, target)
	local xPlayer = ESX.GetPlayerFromId(target)

	if xPlayer then
		cb({
			foundPlayer = true,
			inventory = xPlayer.inventory,
			weapons = xPlayer.loadout,
			accounts = xPlayer.accounts
		})
	else
		cb({foundPlayer = false})
	end
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

ESX.RegisterServerCallback('KraKss:GetGangMoney', function(source, cb)
    local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local jobName = xPlayer.job2.name
    if xPlayer then
        local gangDirtyMoney 
		MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = @a", {["@a"] = "society_"..jobName..""}, function(result)
			if result[1] then    
				gangDirtyMoney = result[1].money
				cb(gangDirtyMoney)
			end
		end)
	else
		return	
    end
end)

RegisterNetEvent("KraKss:SetGangMoney")
AddEventHandler("KraKss:SetGangMoney", function(money)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local jobName = xPlayer.job2.name
	local xDirty = xPlayer.getAccount("dirtycash").money
	local moneyToAdd = money
	print(xDirty)
	print(moneyToAdd)
	if xPlayer then
		if xPlayer.job2.name == jobName then
			if tonumber(xDirty) >= tonumber(moneyToAdd) then
				MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = @a", {["@a"] = "society_"..jobName..""}, function(result)
					if result[1] then
						xPlayer.removeAccountMoney('dirtycash', moneyToAdd)    
						MySQL.Async.execute("UPDATE addon_account_data SET money = @a WHERE account_name = @b", {
							["@a"] = result[1].money + moneyToAdd,
							["@b"] = "society_"..jobName..""
						}, function()
							TriggerClientEvent("esx:showNotification", _src, "Vous avez ajouté ~g~"..moneyToAdd.."$ ~s~à votre gang")
						end)
					end
				end)
			else
				TriggerClientEvent("esx:showNotification", _src, "~g~Vous n'avez pas assez d'argent sale")
			end
		else
			DropPlayer("[KraKss] Cheat | discord.gg/ParaziaRP")
			return
		end
	end
end)

RegisterNetEvent("KraKss:RemoveGangMoney")
AddEventHandler("KraKss:RemoveGangMoney", function(money)
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local jobName = xPlayer.job2.name
	local moneyToRemove = money
	if xPlayer then
		if xPlayer.job2.name == jobName then
			if xPlayer.job2.grade_name == "boss" then
				MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = @a", {["@a"] = "society_"..jobName..""}, function(result)
					if result[1] then
						if tonumber(result[1].money) >= tonumber(moneyToRemove) then
							xPlayer.addAccountMoney('dirtycash', moneyToRemove)    
							MySQL.Async.execute("UPDATE addon_account_data SET money = @a WHERE account_name = @b", {
								["@a"] = result[1].money - moneyToRemove,
								["@b"] = "society_"..jobName..""
							}, function()
								TriggerClientEvent("esx:showNotification", _src, "Vous avez retiré ~g~"..moneyToRemove.."$ ~s~à votre gang")
							end)
						else
							TriggerClientEvent("esx:showNotification", _src, "~g~Votre gang n'a pas assez d'argent")
						end
					end
				end)
			else
				TriggerClientEvent("esx:showNotification", _src, "Uniquement le boss du gang peut retirer l'argent")
			end
		else
			DropPlayer("[KraKss] Cheat | discord.gg/ParaziaRP")
			return
		end
	end
end)

local function HaveWeaponInLoadout(xPlayer, weapon)
    for i, v in pairs(xPlayer.loadout) do
        if (GetHashKey(v.name) == weapon) then
            return true;
        end
    end
    return false;
end

local SecurityWeaponGangsBuilder = {
	['weapon_switchblade'] = {price = 20000, hash = 'weapon_switchblade', label = 'Couteau de poche'},
    ['weapon_machete'] = {price = 40000, hash = 'weapon_machete', label = 'Machette'},
    ['WEAPON_SNSPISTOL'] = {price = 400000, hash = 'WEAPON_SNSPISTOL', label = 'Pétoire'},
    ['WEAPON_PISTOL'] = {price = 800000, hash = 'WEAPON_PISTOL', label = 'Pisolet'},
    ['WEAPON_PISTOL50'] = {price = 120000, hash = 'WEAPON_PISTOL50', label = 'Calibre 50'},
    ['WEAPON_HEAVYPISTOL'] = {price = 1000000, hash = 'WEAPON_HEAVYPISTOL', label = 'Pistolet Lourd'},
    ['WEAPON_MACHINEPISTOL'] = {price = 1000000, hash = 'WEAPON_MACHINEPISTOL', label = 'Tec-9'},
    ['WEAPON_MICROSMG'] = {price = 2200000, hash = 'WEAPON_MICROSMG', label = 'Micro Uzi'},
    ['WEAPON_COMPACTRIFLE'] = {price = 8200000, hash = 'WEAPON_COMPACTRIFLE', label = 'Mini AK'},
    ['weapon_minismg'] = {price = 2000000, hash = 'weapon_minismg', label = 'Mini SMG'},
}

RegisterNetEvent('Gangsbuilder:BuyWeapon', function(weapon, label)
	local xPlayer = ESX.GetPlayerFromId(source)
	if SecurityWeaponGangsBuilder[weapon] == nil then DropPlayer(source, 'euh t srx maik') return end

	if xPlayer.getAccount('dirtycash').money >= SecurityWeaponGangsBuilder[weapon].price then
        if not (HaveWeaponInLoadout(xPlayer, SecurityWeaponGangsBuilder[weapon].hash)) then
			xPlayer.removeAccountMoney('dirtycash', SecurityWeaponGangsBuilder[weapon].price) 
			xPlayer.addWeapon(SecurityWeaponGangsBuilder[weapon].hash, 250)
			xPlayer.showNotification(' Vous avez acheter ~q~'..label)
		else
			xPlayer.showNotification('~q~ParaziaRP ~w~~n~Vous avez déjà cette arme sur vous !')
		end
	else
		xPlayer.showNotification('~q~ParaziaRP ~w~~n~Vous n\'avez pas l\'argent nécéssaire.')
	end
end)

RegisterCommand('gangs', function(source,args)
	local xPlayer = ESX.GetPlayerFromId(source)

	if xPlayer.getGroup() == '_dev' or xPlayer.getGroup() == 'gamemaster' or xPlayer.getGroup() == 'superadmin' then
		TriggerClientEvent('Open:GangMenuAdmin', source)
	end
end)

RegisterNetEvent('ewen:UpdateGangs', function(value)
	local xPlayer = ESX.GetPlayerFromId(source)
	local NewCoffrePos = json.encode(value.CoffrePos)
	if xPlayer.getGroup() == '_dev' or xPlayer.getGroup() == 'gamemaster' or xPlayer.getGroup() == 'superadmin' then
		if GangsList[value.name] then
			GangsList[value.name].posCoffre = json.decode(NewCoffrePos)
			GangsList[value.name].KitArme = value.KitArme
			GangsList[value.name].Blanchiement = value.Blanchiement
			TriggerClientEvent('ewen:SendGangListToClient', -1, GangsList)
			MySQL.Async.execute('UPDATE gangs SET posCoffre = @posCoffre, KitArme = @KitArme, Blanchiement = @Blanchiement WHERE gangname = @gangname',{
				['@gangname'] = value.name,
				['@posCoffre'] = NewCoffrePos,
				['@KitArme'] = value.KitArme,
				['@Blanchiement'] = value.Blanchiement,
			})
		end
	end
end)

RegisterNetEvent('ewen:DeleteGangs', function(value)
	local xPlayer = ESX.GetPlayerFromId(source)
	if xPlayer.getGroup() == '_dev' or xPlayer.getGroup() == 'gamemaster' or xPlayer.getGroup() == 'superadmin' then
		if GangsList[value] then
			GangsList[value] = nil
			TriggerClientEvent('ewen:SendGangListToClient', -1, GangsList)
			MySQL.Async.execute('DELETE FROM gangs WHERE `gangname` = @gangname', {
				['@gangname'] = value
			})
		end
	end
end)

RegisterServerEvent('ewen:blanchiement')
AddEventHandler('ewen:blanchiement', function(argent)
	local _source = source
	local xPlayer = ESX.GetPlayerFromId(source)

	local argent = ESX.Math.Round(tonumber(argent))

	if argent > 0 and xPlayer.getAccount('dirtycash').money >= argent then
		xPlayer.removeAccountMoney('dirtycash', argent)
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Roberto', '~y~Blanchiement', 'Patiente ~q~10 secondes', 'CHAR_MP_ROBERTO', 8)
		Citizen.Wait(10000)
		
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Roberto', '~y~Blanchiement', 'Tu as reçu : ' .. ESX.Math.GroupDigits(argent) .. ' ~g~$', 'CHAR_MP_ROBERTO', 8)
		xPlayer.addAccountMoney('cash', argent)
	else
		TriggerClientEvent('esx:showAdvancedNotification', xPlayer.source, 'Roberto', '~y~Blanchiement', '~q~Montant invalide', 'CHAR_MP_ROBERTO', 8)
	end
end)