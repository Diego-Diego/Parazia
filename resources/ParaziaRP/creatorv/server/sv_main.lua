ESX = nil

TriggerEvent(_Config.getESX, function(lib) ESX = lib end)

RegisterServerEvent(Prefix..":setBuckets")
AddEventHandler(Prefix..":setBuckets", function(InOrOut)
    local _src = source
    if InOrOut then
        SetPlayerRoutingBucket(_src, GetPlayerIdentifier(_src))
    else
        SetPlayerRoutingBucket(_src, 0)
    end
end)

zoneProtection = 50

RegisterServerEvent(Prefix..':setToPlayer:legalstartpack')
AddEventHandler('rz-game:creator:setToPlayer:legalstartpack', function()
	local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local coords = GetEntityCoords(GetPlayerPed(_src))
    local interactionPos = _Config.cloakPoint
    if #(coords - interactionPos) < zoneProtection then
        xPlayer.addMoney(_Config.StarterPack.Legal.cashMoney)
        xPlayer.addAccountMoney('bank', _Config.StarterPack.Legal.bankMoney)
        TriggerClientEvent('esx:showNotification', source, "Vous avez choisis le starter pack : ~b~Legal")
        TriggerClientEvent('esx:showNotification', source, "+ ~g~".._Config.StarterPack.Legal.cashMoney.."~s~ $ en liquide\n+ ~b~".._Config.StarterPack.Legal.bankMoney.."~s~ $ en banque")
        if _ServerConfig.enableLogs then
            Server:ToDiscord(_ServerConfig.webhooksTitle, "[CREATION PERSO] " ..xPlayer.getName()..  " a choisis le starterPack légal !", _ServerConfig.webhooksColor)
        end
    else
        DropPlayer(source, 'Tentative de give : StarterPack')
        if _ServerConfig.enableLogs then
            Server:ToDiscord(_ServerConfig.webhooksTitle, "[CREATION PERSO] " ..xPlayer.getName()..  " a été expulsé pour tentative de triche.", _ServerConfig.webhooksColor)
        end
    end
end)

RegisterServerEvent(Prefix..':setToPlayer:illegalstartpack')
AddEventHandler(Prefix..':setToPlayer:illegalstartpack', function()
	local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local coords = GetEntityCoords(GetPlayerPed(_src))
    local interactionPos = _Config.cloakPoint
    if #(coords - interactionPos) < zoneProtection then
        xPlayer.addAccountMoney("black_money", _Config.StarterPack.Illegal.blackMoney)
        xPlayer.addAccountMoney('bank', _Config.StarterPack.Illegal.bankMoney)
        for k, v in pairs(_Config.StarterPack.Illegal.weapon) do
            xPlayer.addWeapon(v.name, 255)
            TriggerClientEvent('esx:showNotification', source, "Vous avez choisis le starter pack : ~y~illegal")
            TriggerClientEvent('esx:showNotification', source, "+ ~g~".._Config.StarterPack.Illegal.blackMoney.."~s~ $ en sale\n+ ~b~".._Config.StarterPack.Illegal.bankMoney.."~s~ $ en banque\n+ 1 "..v.label.."")
            if _ServerConfig.enableLogs then
                Server:ToDiscord(_ServerConfig.webhooksTitle, "[CREATION PERSO] " ..xPlayer.getName()..  " a choisis le starterPack illégal !", _ServerConfig.webhooksColor)
            end
        end
    else
        DropPlayer(source, 'Tentative de give : StarterPack')
        if _ServerConfig.enableLogs then
            Server:ToDiscord(_ServerConfig.webhooksTitle, "[CREATION PERSO] " ..xPlayer.getName()..  " a été expulsé pour tentative de triche.", _ServerConfig.webhooksColor)
        end
    end
end)

RegisterServerEvent(Prefix..':identity:SetFirstName')
AddEventHandler(Prefix..':identity:SetFirstName', function(ID, firstname)
    local identifier = ESX.GetPlayerFromId(ID).identifier
    Server:SetFirstName(identifier, firstname)
end)

RegisterServerEvent(Prefix..':identity:SetLastName')
AddEventHandler(Prefix..':identity:SetLastName', function(ID, lastname)
    local identifier = ESX.GetPlayerFromId(ID).identifier
    Server:SetLastName(identifier, lastname)
end)

RegisterServerEvent(Prefix..':identity:SetDOB')
AddEventHandler(Prefix..':identity:SetDOB', function(ID, dateofbirth)
    local identifier = ESX.GetPlayerFromId(ID).identifier
    Server:SetDOB(identifier, dateofbirth)
end)

RegisterServerEvent(Prefix..':identity:SetSex')
AddEventHandler(Prefix..':identity:SetSex', function(ID, sex)
    local identifier = ESX.GetPlayerFromId(ID).identifier
    Server:SetSex(identifier, sex)
end)

RegisterServerEvent(Prefix..':identity:SetSex2')
AddEventHandler(Prefix..':identity:SetSex2', function(ID, sex2)
    local identifier = ESX.GetPlayerFromId(ID).identifier
    Server:SetSex2(identifier, sex2)
end)

RegisterServerEvent(Prefix..':identity:SetHeight')
AddEventHandler(Prefix..':identity:SetHeight', function(ID, height)
    local identifier = ESX.GetPlayerFromId(ID).identifier
    Server:SetHeight(identifier, height)
end)

AddEventHandler('esx:playerLoaded', function(source)
	Server:getIdentity(source, function(data)
		if data.firstname == nil or data.firstname == '' then
			TriggerClientEvent(Prefix..':identity:identityCheck', source, false)
			TriggerClientEvent(Prefix..':identity:showRegisterIdentity', source)
		else
			TriggerClientEvent(Prefix..':identity:identityCheck', source, true)
		end
	end)
end)

AddEventHandler('onResourceStart', function(resource)
	if resource == GetCurrentResourceName() then
		Citizen.Wait(1000)
		local xPlayers = ESX.GetPlayers()

		for i = 1, #xPlayers, 1 do
			local xPlayer = ESX.GetPlayerFromId(xPlayers[i])

			if xPlayer then
				Server:getIdentity(xPlayer.source, function(data)
					if data.firstname == nil or data.firstname == '' then
						TriggerClientEvent(Prefix..':identity:identityCheck', xPlayer.source, false)
						TriggerClientEvent(Prefix..':identity:showRegisterIdentity', xPlayer.source)
					else
						TriggerClientEvent(Prefix..':identity:identityCheck', xPlayer.source, true)
					end
				end)
			end
		end
	end
end)

ESX.AddGroupCommand('rgi', '_dev', function(source, args, user)
	if args[1] == nil then
		TriggerClientEvent('0TEX0:cmdRegister', source)
	else
		TriggerClientEvent('0TEX0:cmdRegister', args[1])
	end
end, {help = ''})