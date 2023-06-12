Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

local TeleportPoint = {
	Bank = {
		positionFrom = vector3(124.46, -1959.29, 15.22),
		positionTo = vector3(125.59, -1956.94, 20.56)
	},
	FBI = {
		positionFrom = vector3(138.86, -762.85, 45.75),
		positionTo = vector3(136.07, -761.97, 242.15)
	},
	NAVY = {
		positionFrom = vector3(-2360.85, 3249.5, 32.81),
		positionTo = vector3(-2360.73, 3249.6, 92.9)
	},
	EMS = {
		positionFrom = vector3(332.52, -595.4, 43.28),
		positionTo = vector3(339.95, -584.51, 74.17)
	},
	HANGAR = {
		positionFrom = vector3(-1266.89, -2960.55, -48.49),
		positionTo = vector3(-1268.49, -2962.24, -48.49)
	},
	VDA = {
		positionFrom = vector3(-299.49, 2201.76, 131.84),
		positionTo = vector3(894.44, -3245.79, -98.26)
	}
}

Drawing = setmetatable({}, Drawing)
Drawing.__index = Drawing

function Drawing.draw3DText(coords, text, fontId, scaleX, scaleY, r, g, b, a)
	local camCoords = GetGameplayCamCoords()
	local distance = GetDistanceBetweenCoords(camCoords, coords, 1)

	local scale = (1 / distance) * 10
	local fov = (1 / GetGameplayCamFov()) * 100
	local scale = scale * fov

	SetTextScale(scaleX * scale, scaleY * scale)
	SetTextFont(fontId)
	SetTextProportional(1)
	SetTextColour(r, g, b, a)
	SetTextDropshadow(0, 0, 0, 0, 255)
	SetTextEdge(2, 0, 0, 0, 150)
	SetTextDropShadow()
	SetTextOutline()
	BeginTextCommandDisplayText("STRING")
	SetTextCentre(1)
	AddTextComponentSubstringPlayerName(text)
	SetDrawOrigin(coords.x, coords.y, coords.z + 2, 0)
	EndTextCommandDisplayText(0.0, 0.0)
	ClearDrawOrigin()
end

function Drawing.drawMissionText(text, showtime)
	ClearPrints()
	BeginTextCommandPrint("STRING")
	AddTextComponentSubstringPlayerName(text)
	EndTextCommandPrint(showtime, 1)
end

Citizen.CreateThread(function()
	while true do
		local Timer = 500
		local coords = GetEntityCoords(PlayerPedId(), false)

		for k, v in pairs(TeleportPoint) do
			if GetDistanceBetweenCoords(coords, v.positionFrom) < 25.0 then
				Timer = 0
				DrawMarker(21, v.positionFrom, vector3(0.0, 0.0, 0.0), vector3(0.0, 180.0, 0.0), vector3(0.5, 0.5, 0.5), 255, 255, 255, 100, true, false, 2, false)
				
				if GetDistanceBetweenCoords(coords, v.positionFrom) < 1.5 then
					Timer = 0
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~")

					if IsControlJustPressed(0, 38) then
						DoScreenFadeOut(400)
						Citizen.Wait(10)
						SetEntityCoords(PlayerPedId(), v.positionTo)
						Citizen.Wait(20)
						DoScreenFadeIn(600)
					end
				end
			end

			if GetDistanceBetweenCoords(coords, v.positionTo) < 25.0 then
				DrawMarker(21, v.positionTo, vector3(0.0, 0.0, 0.0), vector3(0.0, 180.0, 0.0), vector3(0.5, 0.5, 0.5), 255, 255, 255, 100, true, false, 2, false)
				
				if GetDistanceBetweenCoords(coords, v.positionTo) < 1.5 then
					ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~")

					if IsControlJustPressed(0, 38) then
						DoScreenFadeOut(400)
						Citizen.Wait(10)
						SetEntityCoords(PlayerPedId(), v.positionFrom)
						Citizen.Wait(20)
						DoScreenFadeIn(600)
					end
				end
			end
		end
		Citizen.Wait(Timer)
	end
end)

