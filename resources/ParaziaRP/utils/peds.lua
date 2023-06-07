
function SetWeaponDrops()
    local handle, ped = FindFirstPed()
    local finished = false

    repeat
        if not IsEntityDead(ped) then
            SetPedDropsWeaponsWhenDead(ped, false)
        end
        finished, ped = FindNextPed(handle)
    until not finished

    EndFindPed(handle)
end

Citizen.CreateThread(function()
    while true do
        SetWeaponDrops()
        Citizen.Wait(10000)
    end
end)

Citizen.CreateThread(function()
    for dispatchService = 1, 15 do
        EnableDispatchService(dispatchService, false)
        Citizen.Wait(10)
    end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
		SetRandomBoats(false)
		SetGarbageTrucks(false)
		SetCreateRandomCops(false)
		SetCreateRandomCopsNotOnScenarios(false)
		SetCreateRandomCopsOnScenarios(false)
		DisablePlayerVehicleRewards(PlayerId())
		SetPedDensityMultiplierThisFrame(0.3)
		SetParkedVehicleDensityMultiplierThisFrame(0.0)
		SetScenarioPedDensityMultiplierThisFrame(0.0, 0.0)
		SetRandomVehicleDensityMultiplierThisFrame(0.2)
		SetVehicleDensityMultiplierThisFrame(0.2)
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(100)
	  	local playerId = PlayerId()
	  	if GetPlayerWantedLevel(playerId) ~= 0 then
			SetPlayerWantedLevel(playerId, 0, false)
			SetPlayerWantedLevelNow(playerId, false)
	  	end
	end
end)

Citizen.CreateThread(function()
	while true do
		Citizen.Wait(0)
        HideHudComponentThisFrame(1) -- Wanted Stars
		HideHudComponentThisFrame(2) -- Weapon Icon
		HideHudComponentThisFrame(3) -- Cash
		HideHudComponentThisFrame(4) -- MP Cash
		HideHudComponentThisFrame(6) -- Vehicle Name
		HideHudComponentThisFrame(7) -- Area Name
		HideHudComponentThisFrame(8) -- Vehicle Class
		HideHudComponentThisFrame(9) -- Street Name
		HideHudComponentThisFrame(13) -- Cash Change
		HideHudComponentThisFrame(17) -- Save Game
		HideHudComponentThisFrame(20) -- Weapon Stats
        HideHudComponentThisFrame(21) -- COMPOSANTS_HUD
        HideHudComponentThisFrame(22) -- HUD_WEAPONS
	end
end)

Citizen.CreateThread(function()
    while true do
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_UNARMED"), 0.2) -- Dégat Cout de poing
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_NIGHTSTICK"), 0.3) -- Dégat Matraque
        Wait(0)
        N_0x4757f00bc6323cfe(GetHashKey("WEAPON_SNOWBALL"), 0.3) -- Dégat Matraque
        Wait(0)
        N_0x4757f00bc6323cfe(-1553120962, 0.5) -- Dégat Véhicule
        Wait(0)
    end
end)

Citizen.CreateThread( function()
	local resetCounter = 0
	local jumpDisabled = false
  	
  	while true do
        Citizen.Wait(100)

		if jumpDisabled and resetCounter > 0 and IsPedJumping(PlayerPedId()) and not (GetPedParachuteState(PlayerPedId()) == 1)then
			SetPedToRagdoll(PlayerPedId(), 500, 500, 3, 0, 0, 0)
			ESX.ShowNotification("Tu t'es pris pour un kangourou à sauter comme ça ?")
			resetCounter = 0
		end

		if not jumpDisabled and IsPedJumping(PlayerPedId()) then
			jumpDisabled = true
			resetCounter = 10
			Citizen.Wait(1200)
		end

		if resetCounter > 0 then
			resetCounter = resetCounter - 1
		else
			if jumpDisabled then
				resetCounter = 0
				jumpDisabled = false
			end
		end
	end
end)