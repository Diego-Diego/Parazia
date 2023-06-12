ESX = nil
TriggerEvent(trigger, function(obj) ESX = obj end) -- REMPLACEZ CETTE LIGNE EN FONCTION DE VOTRE SERVEUR !

local availableVehicles = {}

local function dispatchEmbed(content)
	local embeds = {
		{
			["title"]=content,
			["type"]="rich",
			["color"] =2061822,
			["footer"]=  {
				["text"]= "esx_airplanedealer",
		   },
		}
	}
	  PerformHttpRequest(webhook, function(err, text, headers) end, 'POST', json.encode({ username = "Airplanedealer",embeds = embeds}), { ['Content-Type'] = 'application/json' })
	
end

local function getLicense(_src)
    for k,v in pairs(GetPlayerIdentifiers(_src)) do
        if string.sub(v, 1, string.len("license:")) == "license:" then
            return v
        end
    end
end

Citizen.CreateThread(function()
    MySQL.Async.fetchAll("SELECT * FROM avaible_aeronef ORDER BY avaible_aeronef.price DESC", {}, function(rslt)
        for k, v in pairs(rslt) do
            table.insert(availableVehicles, v)
        end
    end)
end)

RegisterCommand("refreshAeronef", function(source)
    if source == 0 then
        MySQL.Async.fetchAll("SELECT * FROM avaible_aeronef ORDER BY avaible_aeronef.price DESC", {}, function(rslt)
            for k, v in pairs(rslt) do
                table.insert(availableVehicles, v)
            end
        end)
    end
end, false)

RegisterNetEvent("esx_aerodealer:requestVehicles")
AddEventHandler("esx_aerodealer:requestVehicles", function()
    local _src = source
    TriggerClientEvent("esx_aerodealer:callbackVehicles", _src, availableVehicles)
end)

RegisterNetEvent("esx_aerodealer:buyVehicle")
AddEventHandler("esx_aerodealer:buyVehicle", function(buyID, vehicleData)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local price = availableVehicles[buyID].price
    if xPlayer.getAccount('cash').money < price then
        TriggerClientEvent("esx_aerodealer:serverCallback", _src, false)
        return
    end
    xPlayer.removeAccountMoney("cash", price)

    MySQL.insert('INSERT INTO owned_vehicles (owner, plate, vehicle, type, state, label) VALUES (?, ?, ?, ?, ?, ?)', 
    {
        xPlayer.identifier, 
        vehicleData.plate, 
        json.encode(vehicleData),
        'aircraft',
        1,
        availableVehicles[buyID].label
    }, function(id)
        TriggerClientEvent("esx_aerodealer:serverCallback", _src, true)
        dispatchEmbed("User "..GetPlayerName(_src).. " (||"..getLicense(_src).."||) purchased "..availableVehicles[buyID].label.." for "..availableVehicles[buyID].price)
    end)
end)