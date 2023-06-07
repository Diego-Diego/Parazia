
local TeleportPoint = {
	--Text = {
		--positionFrom = vector3(),
		--positionTo = vector3()
	--}

    Coke = {
	    positionFrom = vector3(-1461.43, -640.76, 29.59),
	    positionTo = vector3(1088.32, -3187.83, -38.99),
		textantre = 'Appuyez sur ~INPUT_PICKUP~ pour accédé au labo de weed',
		textsortie = 'Appuyez sur ~INPUT_PICKUP~ pour sortir du labo de weed'
	},

    Weed = {
		positionFrom = vector3(1714.22, -1598.14, 113.81),
		positionTo = vector3(1065.73, -3183.59, -39.16),
		textantre = 'Appuyez sur ~INPUT_PICKUP~ pour accédé au labo de coke',
		textsortie = 'Appuyez sur ~INPUT_PICKUP~ pour sortir du labo de coke'
	},

	GalaxyClub = {
		positionFrom = vector3(321.01, 266.58, 104.47),
		positionTo = vector3(404.66, 243.94, 92.93),
		textantre = 'Appuyez sur ~INPUT_PICKUP~ pour accédé au garage Galaxy',
		textsortie = 'Appuyez sur ~INPUT_PICKUP~ pour sortir du garage Galaxy'
	},
}

Citizen.CreateThread(function()
	while true do
		local msec = 500
		local coords = GetEntityCoords(PlayerPedId(), false)

		for k, v in pairs(TeleportPoint) do
			if GetDistanceBetweenCoords(coords, v.positionFrom) < 2.0 then
				msec = 0
				ESX.ShowHelpNotification(v.textantre)

				if IsControlJustPressed(0, 38) then
					if k == 'GalaxyClub' then
						DoScreenFadeOut(400)
						SetEntityHeading(PlayerPedId(), 71.17)
						SetEntityHeading(GetVehiclePedIsIn(PlayerPedId(), true), 71.17)
						Citizen.Wait(400)
						SetPedCoordsKeepVehicle(PlayerPedId(), v.positionTo)
						Citizen.Wait(600)
						DoScreenFadeIn(600)
					else
						DoScreenFadeOut(400)
						Citizen.Wait(400)
						SetEntityCoords(PlayerPedId(), v.positionTo)
						Citizen.Wait(600)
						DoScreenFadeIn(600)
					end
				end
			end
			
			if GetDistanceBetweenCoords(coords, v.positionTo) < 2.0 then
				msec = 0
				ESX.ShowHelpNotification(v.textsortie)

				if IsControlJustPressed(0, 38) then
					if k == 'GalaxyClub' then
						DoScreenFadeOut(400)
						Citizen.Wait(400)
						SetPedCoordsKeepVehicle(PlayerPedId(), v.positionFrom)
						Citizen.Wait(600)
						DoScreenFadeIn(600)
					else
						DoScreenFadeOut(400)
						Citizen.Wait(400)
						SetEntityCoords(PlayerPedId(), v.positionFrom)
						Citizen.Wait(600)
						DoScreenFadeIn(600)
					end
				end
			end
		end
        Citizen.Wait(msec)
	end
end)