Event = {
	{
		type = "package",
		message = "Une cargaison de drogue a été trouvée ! Viens la récupérer avant la police!",
		possibleZone = {
			vector3(-3233.36, -1239.27, 3.16),
			vector3(-2452.462, -305.4738, 3.530489),
			vector3(-1241.547, -1842.904, 2.140611),
			vector3(-1199.163, -1954.809, 4.497078),
			vector3(2826.995, -623.7655, 2.090363),
			vector3(-851.3315, 5767.705, 4.644025),
			vector3(488.5908, -3362.791, 6.069853),
			vector3(1106.406, -2638.728, 10.34015),
		},
		prop = {
			"bkr_prop_coke_box_01a",
			"bkr_prop_coke_doll_bigbox",
			"bkr_prop_weed_bigbag_01a",
			"bkr_prop_weed_bigbag_02a",
			"bkr_prop_weed_bigbag_03a",
			"bkr_prop_weed_bigbag_open_01a",
			"bkr_prop_weed_bucket_01a",
			"bkr_prop_weed_bucket_01b",
			"bkr_prop_weed_bucket_01c",
		},
		item = {
			"weed_pooch",
			"coke_pooch",
			"opium_pooch",
		},
	},
	{
		type = "money",
		message = "Un fourgon blindé vient de se faire pété ! Viens récupérer l'argent avant la police!",
		possibleZone = {
			vector3(1174.5800, -139.4591, 57.4230),
			vector3(1232.8441, -1440.5956, 35.2165),
			vector3(730.8676, -2017.0027, 29.2870),
			vector3(-44.1649, -2194.4561, 7.8116),
			vector3(-734.0126, 1153.8182, 262.7755),
			vector3(709.0113, -1577.7140, 9.7216),
			vector3(-458.5318, -1713.6885, 18.6391),
			vector3(-93.5515, -2444.2285, 6.0079),
		},
		prop = {
			"bkr_prop_moneypack_01a",
			"bkr_prop_moneypack_02a",
			"bkr_prop_moneypack_03a",
		},
	},
}


local minute = 60*1000
local eventStarted = true
Citizen.CreateThread(function()
	while true do
		Wait(2000)
		local i = math.random(1, #Event)
		local randomEvent = Event[i]
		local i = math.random(1, #randomEvent.possibleZone)
		local zone = randomEvent.possibleZone[i]
		TriggerClientEvent("RS_AutoEvents_SendEvent", -1, randomEvent, zone)
		Citizen.Wait(5*minute)
		if eventStarted then
			TriggerClientEvent("RS_AutoEvents_StopEvent", -1)
		end
		Citizen.Wait(120*minute)
	end
end)


RegisterNetEvent("RS_AUTOEVENT:Recuperer")
AddEventHandler("RS_AUTOEVENT:Recuperer", function()
	print("\n\n\nFIN DE L'EVENT RESELLER\n\n\n")
	TriggerClientEvent("RS_AutoEvents_StopEvent", -1)
	eventStarted = false
end)

ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

RegisterNetEvent("RS_AUTOEVENT:GetItem")
AddEventHandler("RS_AUTOEVENT:GetItem", function(item, nombre)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addInventoryItem(item, nombre)
end)

RegisterNetEvent("RS_AUTOEVENT:GetArgent")
AddEventHandler("RS_AUTOEVENT:GetArgent", function(nombre)
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.addAccountMoney('dirtycash', nombre)
end)