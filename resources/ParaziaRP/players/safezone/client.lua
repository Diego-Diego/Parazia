
Citizen.CreateThread(function()
	while true do
		local _, _, _, hour, minute = GetUtcTime()
		NetworkOverrideClockTime(hour, minute, 0)
		Citizen.Wait(60000)
	end
end)

local safeZones = {
	vector3(-821.2, -127.65, 28.18),
	vector3(218.76, -802.87, 30.09),
	-- vector3(429.54, -981.86, 30.71),
	vector3(233.12, -419.19, -118.2), 
	vector3(245.5, -324.2, -118.77),
	vector3(-38.22, -1100.84, 26.42),
	vector3(238.25, -406.03, 47.92), 
    vector3(-327.5899, -759.2454, 53.2465), -- parking rouge
	vector3(295.68, -586.45, 43.14), --EMS
    vector3(-334.7071, -138.0281, 39.0111), -- Ls Custom
    vector3(-65.37, 68.95, 71.81), -- Concess
    vector3(1865.4819, 2604.5498, 45.6721), -- Prison 
    vector3(221.3575, -862.7800, 32.9302), -- PC 
	vector3(-211.34, -1322.06, 30.89),
	vector3(1642.58, 2569.52, 45.56), 
	vector3(207.88, -190.37, 54.6),
	vector3(1763.81, 2486.9, 46.56),
	vector3(-1384.82, -591.79, 30.32), 
	vector3(482.998, 4812.112, -58.384),
	vector3(-1418.713, -447.427, 35.909),
}

local disabledSafeZonesKeys = {
	{group = 2, key = 37, message = '~g~Vous ne pouvez pas sortir d\'arme\ndans un lieux public'},
	{group = 0, key = 24, message = '~g~Vous ne pouvez pas faire ceci \ndans un lieux public'},
	{group = 0, key = 69, message = '~g~Vous ne pouvez pas faire ceci \ndans un lieux public'},
	{group = 0, key = 92, message = '~g~Vous ne pouvez pas faire ceci \ndans un lieux public'},
	{group = 0, key = 106, message = '~g~Vous ne pouvez pas faire ceci \ndans un lieux public'},
	{group = 0, key = 168, message = '~g~Vous ne pouvez pas faire ceci \ndans un lieux public'},
	{group = 0, key = 160, message = '~g~Vous ne pouvez pas faire ceci \ndans un lieux public'},
	{group = 0, key = 160, message = '~g~Vous ne pouvez pas faire ceci \ndans un lieux public'},

}

local notifIn, notifOut = false, false
local closestZone = 1

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end

	while true do
		local plyPed = PlayerPedId()
		local plyCoords = GetEntityCoords(plyPed, false)
		local minDistance = 50000

		for i = 1, #safeZones, 1 do
			local dist = #(safeZones[i] - plyCoords)

			if dist < minDistance then
				minDistance = dist
				closestZone = i
			end
		end

		Citizen.Wait(15000)
	end
end)

Citizen.CreateThread(function()
	while not NetworkIsPlayerActive(PlayerId()) do
		Citizen.Wait(0)
	end

	while true do
		local plyPed = PlayerPedId()
		local plyCoords = GetEntityCoords(plyPed, false)
		local dist = #(safeZones[closestZone] - plyCoords)

		if dist <= 50 then
			Wait(0)
		else
			Wait(750)
		end

		if dist <= 50 --[[and ESX.PlayerData.job.name ~= 'police' and ESX.PlayerData.job.name ~= 'gouvernement' and ESX.PlayerData.job.name ~= 'ambulance']] then
			if not notifIn then
				NetworkSetFriendlyFireOption(false)
				SetCurrentPedWeapon(plyPed, `WEAPON_UNARMED`, true)
				ESX.ShowNotification("~g~Vous êtes dans un lieux public")

				notifIn = true
				notifOut = false
			end
		else
			if not notifOut then
				NetworkSetFriendlyFireOption(true)
				ESX.ShowNotification("~g~Vous n\'êtes plus dans un lieux public")

				notifOut = true
				notifIn = false
			end
		end

		if notifIn then

			DisablePlayerFiring(player, true)

			for i = 1, #disabledSafeZonesKeys, 1 do
				DisableControlAction(disabledSafeZonesKeys[i].group, disabledSafeZonesKeys[i].key, true)

				if IsDisabledControlJustPressed(disabledSafeZonesKeys[i].group, disabledSafeZonesKeys[i].key) then
					SetCurrentPedWeapon(player, `WEAPON_UNARMED`, true)

					if disabledSafeZonesKeys[i].message then
						ESX.ShowNotification(disabledSafeZonesKeys[i].message)
						break
					end
				end
			end
		end
	end
end)

Citizen.CreateThread(function()
    while true do
        Citizen.Wait(5000)
        for _,player in ipairs(GetActivePlayers()) do
            local ped = GetPlayerPed(-1)
            local everyone = GetPlayerPed(player)
            local everyoneveh = GetVehiclePedIsUsing(everyone)
			if IsPedInAnyVehicle(everyone, false) then
				if GetVehicleClass(everyoneveh) ~= 14 and GetVehicleClass(everyoneveh) ~= 15 and GetVehicleClass(everyoneveh) ~= 16 then
					SetEntityNoCollisionEntity(ped, everyoneveh, false)
					SetEntityNoCollisionEntity(everyoneveh, ped, false)
				end
			else
				if GetVehicleClass(everyoneveh) ~= 14 and GetVehicleClass(everyoneveh) ~= 15 and GetVehicleClass(everyoneveh) ~= 16 then
					SetEntityNoCollisionEntity(ped, everyone, false)
				end
			end
        end
    end
end)

function GetSafeZone()
	return notifIn
end