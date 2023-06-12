TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

LastRobbed = {}
local time = false

ESX.RegisterServerCallback('prz_atmrobbery:getRobbery', function(source, cb, entity) 
	if (LastRobbed[entity] ~= nil) and (LastRobbed[entity] ~= 0) then CheckTime(entity, ESX.GetPlayerFromId(source)) end
	if (LastRobbed[entity] == nil) or (LastRobbed[entity] == 0) then
		LastRobbed[entity] = 0
		cb(true)
	else
		cb(false)
	end
end)

RegisterNetEvent("prz_atmrobbery:stopAtm")
AddEventHandler("prz_atmrobbery:stopAtm", function(entity)
	LastRobbed[entity] = os.time()
end)

RegisterNetEvent("prz_atmrobbery:robberyAlert")
AddEventHandler("prz_atmrobbery:robberyAlert", function(coords)
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
		if xPlayer.job.name == ATM.AlertJob then
			TriggerClientEvent('esx:showNotification', xPlayers[i], "Un braquage d'atm a été lancer")
			TriggerClientEvent('prz_atmrobbery:setBlip', xPlayers[i], coords)
		end
	end
end)

RegisterNetEvent("prz_atmrobbery:giveCash")
AddEventHandler("prz_atmrobbery:giveCash", function()
	local _src = source
	local xPlayer = ESX.GetPlayerFromId(_src)
	local stolemoney = math.random(1000, 1500)

	--if xPlayer.addAccountMoney('dirtycash', stolemoney) ~= stolemoney then
	--	print("Cheateur détécter "..xPlayer.source)
	--	return
	--end

	xPlayer.addAccountMoney('dirtycash', stolemoney)
	xPlayer.showNotification('Vous avez reçu ~r~'..stolemoney.."$ pour le braquage d'atm")
	
	--
	local xPlayers = ESX.GetPlayers()
	for i=1, #xPlayers, 1 do
		local xPlayera = ESX.GetPlayerFromId(xPlayers[i])
		
		if xPlayera.job.name == "police" or xPlayera.job.name == "sheriff" then
			TriggerClientEvent('esx:showNotification', xPlayers[i], "Le braquage d'atm est terminer")
			TriggerClientEvent('prz_atmrobbery:killBlip', xPlayers[i])
		end
	end
end)

local compteur = 0 -- Variable pour stocker le compteur en secondes
function CheckTime(entity, xPlayer)
    compteur = os.time() - LastRobbed[entity] -- Calculer la différence entre le temps actuel et le début

    if (compteur) >= ATM.TimeWait then
		LastRobbed[entity] = 0
	else
		xPlayer.showNotification("~r~ Cette atm a déjà été braquer ! Il reste "..(ATM.TimeWait-compteur).." secondes avant de pouvoir à nouveau voler l'atm")
    end
end