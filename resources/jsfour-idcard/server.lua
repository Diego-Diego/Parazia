local ESX = nil
TriggerEvent('sova:KraKss0TEX0', function(obj)
    ESX = obj
end)

-- Open ID card
RegisterServerEvent('jsfour-idcard:open')
AddEventHandler('jsfour-idcard:open', function(ID, targetID, type)
	local identifier = ESX.GetPlayerFromId(ID).identifier
	local _source 	 = ESX.GetPlayerFromId(targetID).source
	local show       = false

	MySQL.Async.fetchAll('SELECT firstname, lastname, dateofbirth, sex, height FROM users WHERE identifier = @identifier', {['@identifier'] = identifier},
	function (user)
		if (user[1] ~= nil) then
			MySQL.Async.fetchAll('SELECT licenses FROM users WHERE identifier = @identifier', {['@identifier'] = identifier}, 
			function(data)
				local data = json.decode(data[1].licenses)

				if type ~= nil then
					if type == 'driver' then
						if data["car"] or data["motor"] or data["heavycar"] then
							show = true
						end
					elseif type =='arms' then
						if data["weapon"] or data["weapon2"] or data["weapon3"] or data["weapon4"] then
							print("yess")
							show = true
						end
					end
				else
					show = true
				end

				if show then
					local array = {
						user = user,
						licenses = data
					}
					TriggerClientEvent('jsfour-idcard:open', _source, array, type)
				else
					TriggerClientEvent('esx:showNotification', _source, "~r~Vous n'avez pas se type de license..")
				end
			end)
		end
	end)
end)