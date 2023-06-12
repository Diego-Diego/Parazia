
local Couldown = false

local LocationVehicleStart = {
    {Label = 'Panto', Name = 'panto', Price = 1500}
}

function openLocation()
    local location = RageUI.CreateMenu("", "Location")
	RageUI.Visible(location, not RageUI.Visible(location))

	while location do
        Citizen.Wait(0)
        RageUI.IsVisible(location, function()
            if not Couldown then
                for k,v in pairs(LocationVehicleStart) do
                    RageUI.Button(v.Label, nil, {RightLabel = "~g~"..v.Price.."$"}, true, {
                        onSelected = function() 
                            local playerPed = GetPlayerPed(-1)
                            local coords    = GetEntityCoords(PlayerPedId())
                            ESX.Game.SpawnVehicle(v.Name, coords, 200.0, function(vehicle)
                                TaskWarpPedIntoVehicle(playerPed, vehicle, -1) 
                            end)
                            local newPlate = GenerateSocietyPlate('LOCATION')
                            SetVehicleNumberPlateText(vehicle, 'LOCATION') 
                            TriggerServerEvent('garage:RegisterNewKey', newPlate)
                            TriggerServerEvent('Location:Buy', v.Name, v.Price)
                            location = RMenu:DeleteType('location', true)
                            TriggerEvent('couldownlocation')
                        end
                    });
                 end
            else
                RageUI.Separator('~q~')
                RageUI.Separator('~q~Vous devez attendre 1 minutes')
                RageUI.Separator('~q~')
            end
        end)
        
		if not RageUI.Visible(location) then
			location = RMenu:DeleteType('location', true)
		end
	end
end

RegisterNetEvent('couldownlocation')
AddEventHandler('couldownlocation', function()
    Couldown = true 
    Wait(60000)
    Couldown = false
end)