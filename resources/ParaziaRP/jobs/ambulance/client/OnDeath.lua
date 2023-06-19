local SetEntityRagdoll = false
local IsTimeFinish = nil
local IsTimeDead = nil

local DrawText2D = function(text, x, y, size)
	SetTextScale(size, size)
	SetTextFont(4)
	SetTextProportional(1)
	SetTextEntry("STRING")
	SetTextCentre(1)
	SetTextColour(255, 255, 255, 155)
	SetTextOutline()

	AddTextComponentString(text)
	DrawText(x, y)
end

AddEventHandler('esx:onPlayerDeath', function()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, false)
	TriggerServerEvent('EMS:UpdateTableIsDead', true)
	Citizen.CreateThread(function()
		DoScreenFadeOut(800)

		while not IsScreenFadedOut() do
			Citizen.Wait(0)
		end
		
		RespawnPed(playerPed, {coords = coords, heading = 0.0})
		AnimpostfxStop('DeathFailOut')
		DoScreenFadeIn(800)
	end)
	SetEntityRagdoll = true
	Citizen.CreateThread(function()
		local DeathMenu = RageUI.CreateMenu('', "Vous êtes dans le coma")
		DeathMenu.Closable = false
		RageUI.Visible(DeathMenu, not RageUI.Visible(DeathMenu))
		IsTimeFinish = false
		IsTimeDead = 8 -- 5 minutes
		LunchTimer()
		SetEntityInvincible(playerPed, true)

		DisplayRadar(false)
		SetTimecycleModifier("NG_blackout")
		SetTimecycleModifierStrength(0.8999)

		while SetEntityRagdoll do
			Wait(0)
			DrawText2D('Vous êtes dans le Coma', 0.5, 0.9, 1.0)
			
			BlockTouche()
			RageUI.IsVisible(DeathMenu, function()
				RageUI.Separator('')
				RageUI.Separator('~q~Vous êtes inconscient')
				RageUI.Separator('Temps restant ~q~'..IsTimeDead..' ~w~minutes')
				RageUI.Separator('')
				RageUI.Button("Signalez votre situation", nil, {}, true, {
					onSelected = function() 
						TriggerServerEvent('ewen:CreateEmsSignal')
						--ESX.showNotification('Signal envoyé !')
					end
				})
				RageUI.Button('Réapparaître', nil,  {RightBadge = RageUI.BadgeStyle.Tick}, IsTimeFinish, {
					onSelected = function()
						TriggerServerEvent('ewen:RespawnHopital')
						SetEntityRagdoll = false
						SetEntityInvincible(PlayerPedId(), false)
						ESX.TriggerServerCallback('ewen:removeItemsAfterRPDeath', function() end)
						RageUI.CloseAll()
					end
				})
				--RageUI.Button('Réaparaitre rapidement (VIP)', nil,  {RightLabel = '~q~VIP Diamond~s~'}, IsVIP, {
					--onSelected = function()
						--TriggerServerEvent('ewen:RespawnVIP')
						--SetEntityRagdoll = false
						--SetEntityInvincible(PlayerPedId(), false)
						--RageUI.CloseAll()
					--end
				--})
			end)
			
			if not RageUI.Visible(DeathMenu) then
				DeathMenu = RMenu:DeleteType('DeathMenu', true)
			end

			if SetEntityRagdoll then
				SetPedToRagdoll(GetPlayerPed(-1), 1000, 1000, 0, 0, 0, 0)
			end
		end
	end)
end)

function LunchTimer()
	Citizen.CreateThread(function()
		while true do 
			Wait(1*60*1000)
			if IsTimeDead >= 1 then
				IsTimeDead = IsTimeDead-1
			else
				IsTimeFinish = true
				break
			end
		end
	end)
end

function RespawnPed(ped, spawn)
	SetEntityCoordsNoOffset(ped, spawn.coords, false, false, false, true)
	NetworkResurrectLocalPlayer(spawn.coords, spawn.heading, true, false)
	SetPlayerInvincible(ped, false)
	TriggerEvent('playerSpawned', spawn)
	ClearPedBloodDamage(ped)
end

RegisterNetEvent('EMS:ReviveClientPlayer')
AddEventHandler('EMS:ReviveClientPlayer', function()
	SetEntityRagdoll = false
	PlayerIsDead = false
	TriggerServerEvent('EMS:UpdateTableIsDead', false)
	ClearTimecycleModifier()
	DisplayRadar(true)
end)

-- disable keys
local Keys = {
	['ESC'] = 322, ['F1'] = 288, ['F2'] = 289, ['F3'] = 170, ['F5'] = 166, ['F6'] = 167, ['F7'] = 168, ['F8'] = 169, ['F9'] = 56, ['F10'] = 57,
	['~'] = 243, ['1'] = 157, ['2'] = 158, ['3'] = 160, ['4'] = 164, ['5'] = 165, ['6'] = 159, ['7'] = 161, ['8'] = 162, ['9'] = 163, ['-'] = 84, ['='] = 83, ['BACKSPACE'] = 177,
	['TAB'] = 37, ['Q'] = 44, ['W'] = 32, ['E'] = 38, ['R'] = 45, ['T'] = 245, ['Y'] = 246, ['U'] = 303, ['P'] = 199, ['['] = 39, [']'] = 40, ['ENTER'] = 18,
	['CAPS'] = 137, ['A'] = 34, ['S'] = 8, ['D'] = 9, ['F'] = 23, ['G'] = 47, ['H'] = 74, ['K'] = 311, ['L'] = 182,
	['LEFTSHIFT'] = 21, ['Z'] = 20, ['X'] = 73, ['C'] = 26, ['V'] = 0, ['B'] = 29, ['N'] = 249, ['M'] = 244, [','] = 82, ['.'] = 81,
	['LEFTCTRL'] = 36, ['LEFTALT'] = 19, ['SPACE'] = 22, ['RIGHTCTRL'] = 70,
	['HOME'] = 213, ['PAGEUP'] = 10, ['PAGEDOWN'] = 11, ['DELETE'] = 178,
	['LEFT'] = 174, ['RIGHT'] = 175, ['TOP'] = 27, ['DOWN'] = 173,
	['NENTER'] = 201, ['N4'] = 108, ['N5'] = 60, ['N6'] = 107, ['N+'] = 96, ['N-'] = 97, ['N7'] = 117, ['N8'] = 61, ['N9'] = 118
}

function BlockTouche()
	DisableControlAction(0, 19, true) -- INPUT_CHARACTER_WHEEL
	DisableControlAction(0, 21, true) -- INPUT_SPRINT
	DisableControlAction(0, 22, true) -- INPUT_JUMP
	DisableControlAction(0, 23, true) -- INPUT_ENTER
	DisableControlAction(0, 24, true) -- INPUT_ATTACK
	DisableControlAction(0, 25, true) -- INPUT_AIM
	DisableControlAction(0, 26, true) -- INPUT_LOOK_BEHIND
	DisableControlAction(0, 38, true) -- INPUT KEY
	DisableControlAction(0, 44, true) -- INPUT_COVER
	DisableControlAction(0, 45, true) -- INPUT_RELOAD
	DisableControlAction(0, 50, true) -- INPUT_ACCURATE_AIM
	DisableControlAction(0, 58, true) -- INPUT_THROW_GRENADE
	DisableControlAction(0, 59, true) -- INPUT_VEH_MOVE_LR
	DisableControlAction(0, 60, true) -- INPUT_VEH_MOVE_UD
	DisableControlAction(0, 61, true) -- INPUT_VEH_MOVE_UP_ONLY
	DisableControlAction(0, 62, true) -- INPUT_VEH_MOVE_DOWN_ONLY
	DisableControlAction(0, 63, true) -- INPUT_VEH_MOVE_LEFT_ONLY
	DisableControlAction(0, 64, true) -- INPUT_VEH_MOVE_RIGHT_ONLY
	DisableControlAction(0, 65, true) -- INPUT_VEH_SPECIAL
	DisableControlAction(0, 66, true) -- INPUT_VEH_GUN_LR
	DisableControlAction(0, 67, true) -- INPUT_VEH_GUN_UD
	DisableControlAction(0, 68, true) -- INPUT_VEH_AIM
	DisableControlAction(0, 69, true) -- INPUT_VEH_ATTACK
	DisableControlAction(0, 70, true) -- INPUT_VEH_ATTACK2
	DisableControlAction(0, 71, true) -- INPUT_VEH_ACCELERATE
	DisableControlAction(0, 72, true) -- INPUT_VEH_BRAKE
	DisableControlAction(0, 73, true) -- INPUT_VEH_DUCK
	DisableControlAction(0, 74, true) -- INPUT_VEH_HEADLIGHT
	DisableControlAction(0, 75, true) -- INPUT_VEH_EXIT
	DisableControlAction(0, 76, true) -- INPUT_VEH_HANDBRAKE
	DisableControlAction(0, 86, true) -- INPUT_VEH_HORN
	DisableControlAction(0, 92, true) -- INPUT_VEH_PASSENGER_ATTACK
	DisableControlAction(0, 114, true) -- INPUT_VEH_FLY_ATTACK
	DisableControlAction(0, 140, true) -- INPUT_MELEE_ATTACK_LIGHT
	DisableControlAction(0, 141, true) -- INPUT_MELEE_ATTACK_HEAVY
	DisableControlAction(0, 142, true) -- INPUT_MELEE_ATTACK_ALTERNATE
	DisableControlAction(0, 143, true) -- INPUT_MELEE_BLOCK
	DisableControlAction(0, 144, true) -- PARACHUTE DEPLOY
	DisableControlAction(0, 145, true) -- PARACHUTE DETACH
	DisableControlAction(0, 156, true) -- INPUT_MAP
	DisableControlAction(0, 157, true) -- INPUT_SELECT_WEAPON_UNARMED
	DisableControlAction(0, 158, true) -- INPUT_SELECT_WEAPON_MELEE
	DisableControlAction(0, 159, true) -- INPUT_SELECT_WEAPON_HANDGUN
	DisableControlAction(0, 160, true) -- INPUT_SELECT_WEAPON_SHOTGUN
	DisableControlAction(0, 161, true) -- INPUT_SELECT_WEAPON_SMG
	DisableControlAction(0, 162, true) -- INPUT_SELECT_WEAPON_AUTO_RIFLE
	DisableControlAction(0, 163, true) -- INPUT_SELECT_WEAPON_SNIPER
	DisableControlAction(0, 164, true) -- INPUT_SELECT_WEAPON_HEAVY
	DisableControlAction(0, 165, true) -- INPUT_SELECT_WEAPON_SPECIAL
	DisableControlAction(0, 183, true) -- GCPHONE
	DisableControlAction(0, 243, true) -- INPUT_ENTER_CHEAT_CODE
	DisableControlAction(0, 244, true) -- PERSONAL MENU
	DisableControlAction(0, 257, true) -- INPUT_ATTACK2
	DisableControlAction(0, 261, true) -- INPUT_PREV_WEAPON
	DisableControlAction(0, 262, true) -- INPUT_NEXT_WEAPON
	DisableControlAction(0, 263, true) -- INPUT_MELEE_ATTACK1
	DisableControlAction(0, 264, true) -- INPUT_MELEE_ATTACK2
	DisableControlAction(0, Keys['K'], true)
	DisableControlAction(0, Keys['L'], true)
	DisableControlAction(0, Keys['B'], true)
	DisableControlAction(0, Keys['U'], true)
	DisableControlAction(0, Keys['X'], true)
	DisableControlAction(0, Keys['F1'], true)
	DisableControlAction(0, Keys['F2'], true)
	DisableControlAction(0, Keys['F5'], true)
	DisableControlAction(0, Keys['F6'], true)
	DisableControlAction(0, Keys['F7'], true)
	DisableControlAction(0, Keys['F9'], true)
	DisableControlAction(0, Keys['F10'], true)
end