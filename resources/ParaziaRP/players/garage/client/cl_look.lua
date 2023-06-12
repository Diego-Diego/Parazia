
ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
		Citizen.Wait(0)
	end
end)

function OpenCloseVehicle()
	local playerPed = PlayerPedId()
	local coords = GetEntityCoords(playerPed, false)
	local vehicle, inveh = nil, false

	if IsPedInAnyVehicle(playerPed, false) then
		vehicle = GetVehiclePedIsIn(playerPed, false)
		inveh = true
	else
		vehicle = GetClosestVehicle(coords, 7.0, 0, 71)
	end

	ESX.TriggerServerCallback('esx_vehiclelock:mykey', function(gotkey)
		if gotkey then
			local locked = GetVehicleDoorLockStatus(vehicle)

			if locked == 1 or locked == 0 then
				SetVehicleDoorsLocked(vehicle, 2)
				PlayVehicleDoorCloseSound(vehicle, 1)
				ESX.ShowNotification("Vous avez ~g~fermé~s~ le véhicule.")
			elseif locked == 2 then
				SetVehicleDoorsLocked(vehicle, 1)
				PlayVehicleDoorOpenSound(vehicle, 0)
				ESX.ShowNotification("Vous avez ~g~ouvert~s~ le véhicule.")
			end
		else
			ESX.ShowNotification("~g~Vous n'avez pas les clés de ce véhicule.")
		end
	end, GetVehicleNumberPlateText(vehicle))
end

-- Key Controls
RegisterCommand("vehicule_lock", function()
    OpenCloseVehicle()
end, false)
RegisterKeyMapping("vehicule_lock", "Ouvrir/Fermer Véhicule", "keyboard", 'U')

Serrurier = {}
Serrurier.Zones = {
	place = {
			Pos = {x = -31.78, y = -1106.48, z =  26.42},
			Size  = {x = 0.45, y = 0.45, z = 0.45},
			Color = {r = 204, g = 204, b = 0},
			Type  = 22
		}
}

--Menu Serrurier
local open = false
local MyKeyAll = {}

function getAllKeyForMenu()
	ESX.TriggerServerCallback('esx_vehiclelock:getVehiclesnokey', function(Vehicles2)
		for i=1, #Vehicles2, 1 do
			model = Vehicles2[i].model
			modelname = GetDisplayNameFromVehicleModel(model)
			Vehicles2[i].model = GetLabelText(modelname)
		end
	
		for i=1, #Vehicles2, 1 do			
			table.insert(MyKeyAll, {model = Vehicles2[i].model, plaque = Vehicles2[i].plate})	
		end
	end)
end

RMenu.Add('lock', 'main', MowgliUI.CreateMenu("", "Séléctionner une cles à récupéré."))
RMenu:Get('lock', 'main').Closed = function()
    open = false
end

function OpenSerrurierMenu()
    if not open then
        open = true
		MowgliUI.Visible(RMenu:Get('lock', 'main'), true)
		getAllKeyForMenu()
		while open do 
            MowgliUI.IsVisible(RMenu:Get('lock', 'main'), true, true, true, function()
				if MyKeyAll == nil then
					MowgliUI.Separator("")
					MowgliUI.Separator("~g~Vous n'avez aucun cles à enregistrer.")
					MowgliUI.Separator("")
				else
					for k,v in pairs(MyKeyAll) do 
						MowgliUI.ButtonWithStyle(v.model, nil, {RightLabel = "Plaque :~g~ "..v.plaque}, true, function(_,_,s)
							if s then
								TriggerServerEvent('garage:RegisterNewKey', v.plaque)
								table.remove(MyKeyAll, k)
							end
						end)
					end
				end
            end, function()
            end)
        Citizen.Wait(0)
        end 
    else 
        open = false
    end
end