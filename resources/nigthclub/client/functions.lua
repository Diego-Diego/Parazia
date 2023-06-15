-- Create blips
CreateThread(function()
	local blip = AddBlipForCoord(-310.22, 222.3, 87.93)

	SetBlipSprite(blip, 475)
	SetBlipDisplay(blip, 4)
	SetBlipScale(blip, 0.9)
	SetBlipColour(blip, 5)
	SetBlipAsShortRange(blip, true)

	BeginTextCommandSetBlipName('STRING')
	AddTextComponentSubstringPlayerName("NightClub Lux")
	EndTextCommandSetBlipName(blip)
end)

function GetAvailableVehicleSpawnPoint(coords, key)
	local spawnPoints = _Lux.spawnPoint
	local found, foundSpawnPoint = false, nil

	for i=1, #spawnPoints, 1 do
		if ESX.Game.IsSpawnPointClear(coords, 1.0) then
			found, foundSpawnPoint = true, spawnPoints[key]
			break
		end
	end

	if found then
		return true, foundSpawnPoint
	else
		ESX.ShowNotification("~r~Il y a déjà un véhicule sur la place de parking~s~")
		return false
	end
end

function animsAction(animObj)
	Citizen.CreateThread(function()
		if not playAnim then
			local playerPed = PlayerPedId();
			if DoesEntityExist(playerPed) then -- Check if ped exist
				dataAnim = animObj

				-- Play Animation
				RequestAnimDict(dataAnim.lib)
				while not HasAnimDictLoaded(dataAnim.lib) do
					Citizen.Wait(0)
				end
				if HasAnimDictLoaded(dataAnim.lib) then
					local flag = 0
					if dataAnim.loop ~= nil and dataAnim.loop then
						flag = 1
					elseif dataAnim.move ~= nil and dataAnim.move then
						flag = 49
					end

					TaskPlayAnim(playerPed, dataAnim.lib, dataAnim.anim, 8.0, -8.0, -1, flag, 0, 0, 0, 0)
					playAnimation = true
				end

				-- Wait end animation
				repeat
					Citizen.Wait(0)
				until IsEntityPlayingAnim(playerPed, dataAnim.lib, dataAnim.anim, 3)
				playAnim = false
				TriggerEvent('ft_animation:ClFinish')
			end -- end ped exist
		end
	end)
end

function KeyboardInput(entryTitle, textEntry, inputText, maxLength)
	AddTextEntry(entryTitle, textEntry)
	DisplayOnscreenKeyboard(1, entryTitle, '', inputText, '', '', '', maxLength)
	blockinput = true

	while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
		Citizen.Wait(0)
	end

	if UpdateOnscreenKeyboard() ~= 2 then
		local result = GetOnscreenKeyboardResult()
		Citizen.Wait(500)
		blockinput = false
		return result
	else
		Citizen.Wait(500)
		blockinput = false
		return nil
	end
end