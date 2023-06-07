
function OpenDMVSchoolMenu()
	local menu = RageUI.CreateMenu("", "Examen de la route")

    RageUI.Visible(menu, not RageUI.Visible(menu))

	while menu do
		Citizen.Wait(5)
        RageUI.IsVisible(menu, function()

			RageUI.Button("Permis voiture", nil, {RightLabel = '200$'}, true, {onSelected = function()
				RageUI.CloseAll()
				permisvoiture()
			end});


			RageUI.Button("Permis moto", nil, {RightLabel = '150$'}, true, {onSelected = function()
				RageUI.CloseAll()
				permismoto()
			end});

		
			RageUI.Button("Permis poids lourds", nil, {RightLabel = '300$'}, true, {onSelected = function()
				RageUI.CloseAll()
				permislourd()
			end});
        end)

        if not RageUI.Visible(menu) then
            menu = RMenu:DeleteType('menu', true)
        end
    end
end

DrawDistance    = 100.0
MaxErrors       = 5
SpeedMultiplier = 2.2369

VehicleModels = {
	car       = 'oracle2',
	motor  = 'double',
	drive_truck = 'mule'
}

SpeedLimits = {
	residence = 80,
	town      = 80,
	freeway   = 130
}

Zones = {

	DMVSchool = {
		Pos   = {x = 213.97, y = 391.20, z = 106.84},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = 1
	},

	VehicleSpawnPoint = {
		Pos   = {x = 206.770, y = 382.234, z = 107.2351, h = 250.40},
		Size  = {x = 1.5, y = 1.5, z = 1.0},
		Color = {r = 204, g = 204, b = 0},
		Type  = -1
	}

}

CheckPoints = {

	{
		Pos = {x = 232.52, y = 347.95, z = 104.83},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = 208.27, y = 221.86, z = 104.88},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = 129.65, y = -9.89, z = 66.96},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = 484.93, y = -161.013, z = 55.142},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = 504.30, y = -337.52, z = 43.24},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			setCurrentZoneType('freeway')
			ESX.ShowNotification("Il est temps d\'aller sur ~q~l'autoroute~s~, limite : ~q~130~s~ km/h")
		end
	},

	{
		Pos = {x = -987.00, y = -545.69, z = 17.64},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
			setCurrentZoneType('town')
			ESX.ShowNotification("Entrée en ~q~ville~s~, attention à votre vitesse, limite : ~q~80~s~ km/h")
		end
	},

	{
		Pos = {x = -1157.9725, y = -632.29, z = 21.80},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = -1527.57, y = -191.56, z = 54.01},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = -1070.88, y = -178.75, z = 37.17},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},

	{
		Pos = {x = -540.62, y = 110.61, z = 62.25},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			PlaySound(-1, 'RACE_PLACED', 'HUD_AWARDS', false, 0, true)
		end
	},


	{
		Pos = {x = 200.00, y = 390.41, z = 106.82},
		Action = function(playerPed, vehicle, setCurrentZoneType)
			ESX.Game.DeleteVehicle(vehicle)
		end
	}

}

function permisvoiture()
    ESX.TriggerServerCallback('permis:PriceCar', function(price)
        if price then
            StartDriveTest('car')
        else
            RageUI.CloseAll()
            ESX.ShowNotification("Vous n'avez pas assez ~g~d'argent~w~ pour payer votre examen")
        end
    end, 'car')
end


function permismoto()
    ESX.TriggerServerCallback('permis:PriceBike', function(price)
        if price then
            StartDriveTest('motor')
        else
            RageUI.CloseAll()
            ESX.ShowNotification("Vous n'avez pas assez ~g~d'argent~w~ pour payer votre examen")
        end
    end, 'motor')
end


function permislourd()
    ESX.TriggerServerCallback('permis:PriceTruck', function(price)
        if price then
            StartDriveTest('heavycar')
        else
            RageUI.CloseAll()
            ESX.ShowNotification("Vous n'avez pas assez ~g~d'argent~w~ pour payer votre examen")
        end
    end, 'heavycar')
end

local function DrawTopNotification(txt, beep)
	SetTextComponentFormat("jamyfafi")
	AddTextComponentString(txt)
	if string.len(txt) > 99 and AddLongString then AddLongString(txt) end
	DisplayHelpTextFromStringLabel(0, 0, beep, -1)
end

Citizen.CreateThread(function()
    while true do

        local wait = 750
        local v1 = vector3(232.2857, 365.2615, 106.0308)
        local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
        local autoecole = Vdist2(plyCoords, 232.2857, 365.2615, 106.0308)
        if autoecole < 1 then
            wait = 5
            DrawTopNotification("Appuyez sur ~INPUT_TALK~ pour passer votre ~q~examen~w~ avec John")
            if IsControlJustPressed(1,51) then 	
				OpenDMVSchoolMenu()
            end
        end
        Citizen.Wait(wait)
    end
end)

local color = {r = 255, g = 255, b = 255, alpha = 255}

ESX = nil
local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint, DriveErrors = 0, 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

function StartDriveTest(type)
	ESX.Game.SpawnVehicle(VehicleModels[type], Zones.VehicleSpawnPoint.Pos, Zones.VehicleSpawnPoint.Pos.h, function(vehicle)
		CurrentTest       = 'car'
		CurrentTestType   = type
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'residence'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)

		local playerPed   = PlayerPedId()
		Citizen.Wait(0)
		TimerBar = AddTimerBar3D("ERREUR :",{text=DriveErrors.."/5"})
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleFuelLevel(vehicle, 100.0)
		DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
	end)
end

function StopDriveTest(success)
	if success then
		TriggerServerEvent('11_controlLicense', CurrentTestType, true)
		RemoveTimerBar3D()
		ESX.ShowNotification("Vous avez ~q~réussi~s~ votre examen de conduite")
	else
		ESX.ShowNotification("Vous avez ~g~échoué~s~ votre examen de conduite")
	end

	CurrentTest     = nil
	CurrentTestType = nil
end

function SetCurrentZoneType(type)
CurrentZoneType = type
end

RegisterNetEvent('esx_dmvschool:loadLicenses')
AddEventHandler('esx_dmvschool:loadLicenses', function(licenses)
	Licenses = licenses
end)

local auto = {
    {x = 213.97, y = 391.20, z = 106.84}
}

local function DrawTopNotification(txt, beep)
	SetTextComponentFormat("jamyfafi")
	AddTextComponentString(txt)
	if string.len(txt) > 99 and AddLongString then AddLongString(txt) end
	DisplayHelpTextFromStringLabel(0, 0, beep, -1)
end

-- Drive test
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentTest == 'car' then
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				ESX.ShowNotification("Votre test de conduite ~q~terminé~s~")

				if DriveErrors < MaxErrors then
					StopDriveTest(true)
				else
					StopDriveTest(false)
				end
			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(6, CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)

-- Speed / Damage control
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentTest == 'car' then

			local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed, false) then

				local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * SpeedMultiplier
				local tooMuchSpeed = false

				for k,v in pairs(SpeedLimits) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true

							UpdateTimerBar3D(TimerBar, {text=DriveErrors.."/5"})
							ESX.ShowNotification("Vous roulez trop ~q~vite~s~, la ~q~vitesse limite~s~ : ~q~"..v.."~s~ km/h")
						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)
				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1

					UpdateTimerBar3D(TimerBar, {text=DriveErrors.."/5"})
					ESX.ShowNotification("Vous avez ~g~endommagé~s~ le véhicule")

					-- avoid stacking faults
					LastVehicleHealth = health
					Citizen.Wait(1500)
				end
				
				if DriveErrors == 5 then 
					local PlayerPed = PlayerPedId()
					DoScreenFadeOut(800)
					Citizen.Wait(1500)
					ESX.Game.DeleteVehicle(vehicle)
					RemoveTimerBar3D()
					RemoveBlip(CurrentBlip)
					StopDriveTest(false)
					SetEntityCoords(PlayerPed, 213.702346,390.401367,106.8510)
					SetEntityHeading(PlayerPed, 348.58)
					DoScreenFadeIn(800)
					break
				end

			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)

--------- Bar

local ScreenCoords = { baseX = 0.918, baseY = 0.984, titleOffsetX = 0.012, titleOffsetY = -0.009, valueOffsetX = 0.0785, valueOffsetY = -0.0165, pbarOffsetX = 0.047, pbarOffsetY = 0.0015 }
local Sizes = {	timerBarWidth = 0.165, timerBarHeight = 0.035, timerBarMargin = 0.038, pbarWidth = 0.0616, pbarHeight = 0.0105 }

local activeBars = {}
function AddTimerBar3D(title, itemData)
	if not itemData then return end
	RequestStreamedTextureDict("timerbars", true)

	local barIndex = #activeBars + 1
	activeBars[barIndex] = {
		title = title,
		text = itemData.text,
		textColor = itemData.color or { 255, 255, 255, 255 },
		percentage = itemData.percentage,
		endTime = itemData.endTime,
		pbarBgColor = itemData.bg or { 155, 155, 155, 255 },
		pbarFgColor = itemData.fg or { 255, 255, 255, 255 }
	}

	return barIndex
end

function RemoveTimerBar3D()
	activeBars = {}
	SetStreamedTextureDictAsNoLongerNeeded("timerbars")
end

function UpdateTimerBar3D(barIndex, itemData)
	if not activeBars[barIndex] or not itemData then return end
	for k,v in pairs(itemData) do
		activeBars[barIndex][k] = v
	end
end

local HideHudComponentThisFrame = HideHudComponentThisFrame
local GetSafeZoneSize = GetSafeZoneSize
local DrawSprite = DrawSprite
local DrawText2 = DrawText2
local DrawRect = DrawRect
local SecondsToClock = SecondsToClock
local GetGameTimer = GetGameTimer
local textColor = { 200, 100, 100 }
local math = math

function SecondsToClock1(seconds)
	seconds = tonumber(seconds)

	if seconds <= 0 then
		return "00:00"
	else
		mins = string.format("%02.f", math.floor(seconds / 60))
		secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end

function DrawText2(intFont, strText, floatScale, intPosX, intPosY, color, boolShadow, intAlign, addWarp)
	SetTextFont(intFont)
	SetTextScale(floatScale, floatScale)

	if boolShadow then
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
	end

	SetTextColour(color[1], color[2], color[3], 255)
	if intAlign == 0 then
		SetTextCentre(true)
	else
		SetTextJustification(intAlign or 1)
		if intAlign == 2 then
			SetTextWrap(.0, addWarp or intPosX)
		end
	end

	SetTextEntry("jamyfafi")
	AddLongString(strText)

	DrawText(intPosX, intPosY)
end

function AddLongString(txt)
	local maxLen = 100
	for i = 0, string.len(txt), maxLen do
		local sub = string.sub(txt, i, math.min(i + maxLen, string.len(txt)))
		AddTextComponentString(sub)
	end
end

Citizen.CreateThread(function()
	while true do
		local attente = 2000

		local safeZone = GetSafeZoneSize()
		local safeZoneX = (1.0 - safeZone) * 0.5
		local safeZoneY = (1.0 - safeZone) * 0.5

		if #activeBars > 0 then
			attente = 1
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)

			for i,v in pairs(activeBars) do
				local drawY = (ScreenCoords.baseY - safeZoneY) - (i * Sizes.timerBarMargin);
				DrawSprite("timerbars", "all_black_bg", ScreenCoords.baseX - safeZoneX, drawY, Sizes.timerBarWidth, Sizes.timerBarHeight, 0.0, 255, 255, 255, 160)
				DrawText2(0, v.title, 0.3, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY + ScreenCoords.titleOffsetY, v.textColor, false, 2)

				if v.percentage then
					local pbarX = (ScreenCoords.baseX - safeZoneX) + ScreenCoords.pbarOffsetX;
					local pbarY = drawY + ScreenCoords.pbarOffsetY;
					local width = Sizes.pbarWidth * v.percentage;

					DrawRect(pbarX, pbarY, Sizes.pbarWidth, Sizes.pbarHeight, v.pbarBgColor[1], v.pbarBgColor[2], v.pbarBgColor[3], v.pbarBgColor[4])

					DrawRect((pbarX - Sizes.pbarWidth / 2) + width / 2, pbarY, width, Sizes.pbarHeight, v.pbarFgColor[1], v.pbarFgColor[2], v.pbarFgColor[3], v.pbarFgColor[4])
				elseif v.text then
					DrawText2(0, v.text, 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, v.textColor, false, 2)
				elseif v.endTime then
					local remainingTime = math.floor(v.endTime - GetGameTimer())
					DrawText2(0, SecondsToClock1(remainingTime / 1000), 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, remainingTime <= 0 and textColor or v.textColor, false, 2)
				end
				wait = 5
			end
		end
		Wait(attente)
	end
end)

local CurrentAction     = nil
local CurrentActionMsg  = nil
local CurrentActionData = nil
local Licenses          = {}
local CurrentTest       = nil
local CurrentTestType   = nil
local CurrentVehicle    = nil
local CurrentCheckPoint, DriveErrors = 0, 0
local LastCheckPoint    = -1
local CurrentBlip       = nil
local CurrentZoneType   = nil
local IsAboveSpeedLimit = false
local LastVehicleHealth = nil

function DrawMissionText(msg, time)
	ClearPrints()
	BeginTextCommandPrint('STRING')
	AddTextComponentSubstringPlayerName(msg)
	EndTextCommandPrint(time, true)
end

function StartDriveTest(type)
	ESX.Game.SpawnVehicle(VehicleModels[type], Zones.VehicleSpawnPoint.Pos, Zones.VehicleSpawnPoint.Pos.h, function(vehicle)
		CurrentTest       = 'car'
		CurrentTestType   = type
		CurrentCheckPoint = 0
		LastCheckPoint    = -1
		CurrentZoneType   = 'residence'
		DriveErrors       = 0
		IsAboveSpeedLimit = false
		CurrentVehicle    = vehicle
		LastVehicleHealth = GetEntityHealth(vehicle)

		local playerPed   = PlayerPedId()
		Citizen.Wait(0)
		TimerBar = AddTimerBar3D("ERREUR :",{text=DriveErrors.."/5"})
		TaskWarpPedIntoVehicle(playerPed, vehicle, -1)
		SetVehicleFuelLevel(vehicle, 100.0)
		DecorSetFloat(vehicle, "_FUEL_LEVEL", GetVehicleFuelLevel(vehicle))
	end)
end

function StopDriveTest(success)
	if success then
		TriggerServerEvent('11_controlLicense', CurrentTestType, true)
		RemoveTimerBar3D()
		ESX.ShowNotification("Vous avez ~q~réussi~s~ votre examen de conduite")
	else
		ESX.ShowNotification("Vous avez ~g~échoué~s~ votre examen de conduite")
	end

	CurrentTest     = nil
	CurrentTestType = nil
end

function SetCurrentZoneType(type)
CurrentZoneType = type
end

local auto = {
    {x = 213.97, y = 391.20, z = 106.84}
}

local function DrawTopNotification(txt, beep)
	SetTextComponentFormat("jamyfafi")
	AddTextComponentString(txt)
	if string.len(txt) > 99 and AddLongString then AddLongString(txt) end
	DisplayHelpTextFromStringLabel(0, 0, beep, -1)
end

-- Drive test
Citizen.CreateThread(function()
	while true do

		Citizen.Wait(0)

		if CurrentTest == 'car' then
			local playerPed      = PlayerPedId()
			local coords         = GetEntityCoords(playerPed)
			local nextCheckPoint = CurrentCheckPoint + 1

			if CheckPoints[nextCheckPoint] == nil then
				if DoesBlipExist(CurrentBlip) then
					RemoveBlip(CurrentBlip)
				end

				CurrentTest = nil

				ESX.ShowNotification("Votre test de conduite ~q~terminé~s~")

				if DriveErrors < MaxErrors then
					StopDriveTest(true)
				else
					StopDriveTest(false)
				end
			else

				if CurrentCheckPoint ~= LastCheckPoint then
					if DoesBlipExist(CurrentBlip) then
						RemoveBlip(CurrentBlip)
					end

					CurrentBlip = AddBlipForCoord(CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z)
					SetBlipRoute(CurrentBlip, 1)

					LastCheckPoint = CurrentCheckPoint
				end

				local distance = GetDistanceBetweenCoords(coords, CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, true)

				if distance <= 100.0 then
					DrawMarker(6, CheckPoints[nextCheckPoint].Pos.x, CheckPoints[nextCheckPoint].Pos.y, CheckPoints[nextCheckPoint].Pos.z, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 1.5, 1.5, 1.5, 102, 204, 102, 100, false, true, 2, false, false, false, false)
				end

				if distance <= 3.0 then
					CheckPoints[nextCheckPoint].Action(playerPed, CurrentVehicle, SetCurrentZoneType)
					CurrentCheckPoint = CurrentCheckPoint + 1
				end
			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)

-- Speed / Damage control
Citizen.CreateThread(function()
	while true do
		Citizen.Wait(10)

		if CurrentTest == 'car' then

			local playerPed = PlayerPedId()

			if IsPedInAnyVehicle(playerPed, false) then

				local vehicle      = GetVehiclePedIsIn(playerPed, false)
				local speed        = GetEntitySpeed(vehicle) * SpeedMultiplier
				local tooMuchSpeed = false

				for k,v in pairs(SpeedLimits) do
					if CurrentZoneType == k and speed > v then
						tooMuchSpeed = true

						if not IsAboveSpeedLimit then
							DriveErrors       = DriveErrors + 1
							IsAboveSpeedLimit = true

							UpdateTimerBar3D(TimerBar, {text=DriveErrors.."/5"})
							ESX.ShowNotification("Vous roulez trop ~q~vite~s~, la ~q~vitesse limite~s~ : ~q~"..v.."~s~ km/h")
						end
					end
				end

				if not tooMuchSpeed then
					IsAboveSpeedLimit = false
				end

				local health = GetEntityHealth(vehicle)
				if health < LastVehicleHealth then

					DriveErrors = DriveErrors + 1

					UpdateTimerBar3D(TimerBar, {text=DriveErrors.."/5"})
					ESX.ShowNotification("Vous avez ~g~endommagé~s~ le véhicule")

					-- avoid stacking faults
					LastVehicleHealth = health
					Citizen.Wait(1500)
				end
				
				if DriveErrors == 5 then 
					local PlayerPed = PlayerPedId()
					DoScreenFadeOut(800)
					Citizen.Wait(1500)
					ESX.Game.DeleteVehicle(vehicle)
					RemoveTimerBar3D()
					RemoveBlip(CurrentBlip)
					StopDriveTest(false)
					SetEntityCoords(PlayerPed, 213.702346,390.401367,106.8510)
					SetEntityHeading(PlayerPed, 348.58)
					DoScreenFadeIn(800)
					break
				end

			end
		else
			-- not currently taking driver test
			Citizen.Wait(500)
		end
	end
end)

--------- Bar

local ScreenCoords = { baseX = 0.918, baseY = 0.984, titleOffsetX = 0.012, titleOffsetY = -0.009, valueOffsetX = 0.0785, valueOffsetY = -0.0165, pbarOffsetX = 0.047, pbarOffsetY = 0.0015 }
local Sizes = {	timerBarWidth = 0.165, timerBarHeight = 0.035, timerBarMargin = 0.038, pbarWidth = 0.0616, pbarHeight = 0.0105 }

local activeBars = {}
function AddTimerBar3D(title, itemData)
	if not itemData then return end
	RequestStreamedTextureDict("timerbars", true)

	local barIndex = #activeBars + 1
	activeBars[barIndex] = {
		title = title,
		text = itemData.text,
		textColor = itemData.color or { 255, 255, 255, 255 },
		percentage = itemData.percentage,
		endTime = itemData.endTime,
		pbarBgColor = itemData.bg or { 155, 155, 155, 255 },
		pbarFgColor = itemData.fg or { 255, 255, 255, 255 }
	}

	return barIndex
end

function RemoveTimerBar3D()
	activeBars = {}
	SetStreamedTextureDictAsNoLongerNeeded("timerbars")
end

function UpdateTimerBar3D(barIndex, itemData)
	if not activeBars[barIndex] or not itemData then return end
	for k,v in pairs(itemData) do
		activeBars[barIndex][k] = v
	end
end

local HideHudComponentThisFrame = HideHudComponentThisFrame
local GetSafeZoneSize = GetSafeZoneSize
local DrawSprite = DrawSprite
local DrawText2 = DrawText2
local DrawRect = DrawRect
local SecondsToClock = SecondsToClock
local GetGameTimer = GetGameTimer
local textColor = { 200, 100, 100 }
local math = math

function SecondsToClock1(seconds)
	seconds = tonumber(seconds)

	if seconds <= 0 then
		return "00:00"
	else
		mins = string.format("%02.f", math.floor(seconds / 60))
		secs = string.format("%02.f", math.floor(seconds - mins * 60))
		return string.format("%s:%s", mins, secs)
	end
end

function DrawText2(intFont, strText, floatScale, intPosX, intPosY, color, boolShadow, intAlign, addWarp)
	SetTextFont(intFont)
	SetTextScale(floatScale, floatScale)

	if boolShadow then
		SetTextDropShadow(0, 0, 0, 0, 0)
		SetTextEdge(0, 0, 0, 0, 0)
	end

	SetTextColour(color[1], color[2], color[3], 255)
	if intAlign == 0 then
		SetTextCentre(true)
	else
		SetTextJustification(intAlign or 1)
		if intAlign == 2 then
			SetTextWrap(.0, addWarp or intPosX)
		end
	end

	SetTextEntry("jamyfafi")
	AddLongString(strText)

	DrawText(intPosX, intPosY)
end

function AddLongString(txt)
	local maxLen = 100
	for i = 0, string.len(txt), maxLen do
		local sub = string.sub(txt, i, math.min(i + maxLen, string.len(txt)))
		AddTextComponentString(sub)
	end
end

Citizen.CreateThread(function()
	while true do
		local attente = 2000

		local safeZone = GetSafeZoneSize()
		local safeZoneX = (1.0 - safeZone) * 0.5
		local safeZoneY = (1.0 - safeZone) * 0.5

		if #activeBars > 0 then
			attente = 1
			HideHudComponentThisFrame(6)
			HideHudComponentThisFrame(7)
			HideHudComponentThisFrame(8)
			HideHudComponentThisFrame(9)

			for i,v in pairs(activeBars) do
				local drawY = (ScreenCoords.baseY - safeZoneY) - (i * Sizes.timerBarMargin);
				DrawSprite("timerbars", "all_black_bg", ScreenCoords.baseX - safeZoneX, drawY, Sizes.timerBarWidth, Sizes.timerBarHeight, 0.0, 255, 255, 255, 160)
				DrawText2(0, v.title, 0.3, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.titleOffsetX, drawY + ScreenCoords.titleOffsetY, v.textColor, false, 2)

				if v.percentage then
					local pbarX = (ScreenCoords.baseX - safeZoneX) + ScreenCoords.pbarOffsetX;
					local pbarY = drawY + ScreenCoords.pbarOffsetY;
					local width = Sizes.pbarWidth * v.percentage;

					DrawRect(pbarX, pbarY, Sizes.pbarWidth, Sizes.pbarHeight, v.pbarBgColor[1], v.pbarBgColor[2], v.pbarBgColor[3], v.pbarBgColor[4])

					DrawRect((pbarX - Sizes.pbarWidth / 2) + width / 2, pbarY, width, Sizes.pbarHeight, v.pbarFgColor[1], v.pbarFgColor[2], v.pbarFgColor[3], v.pbarFgColor[4])
				elseif v.text then
					DrawText2(0, v.text, 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, v.textColor, false, 2)
				elseif v.endTime then
					local remainingTime = math.floor(v.endTime - GetGameTimer())
					DrawText2(0, SecondsToClock1(remainingTime / 1000), 0.425, (ScreenCoords.baseX - safeZoneX) + ScreenCoords.valueOffsetX, drawY + ScreenCoords.valueOffsetY, remainingTime <= 0 and textColor or v.textColor, false, 2)
				end
				wait = 5
			end
		end
		Wait(attente)
	end
end)