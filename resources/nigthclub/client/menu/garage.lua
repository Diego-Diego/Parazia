open = false
local mainMenu = RageUI.CreateMenu("", "Garage du ~p~Lux~s~", nil, nil, "root_cause", "ban")
local subMenu = RageUI.CreateSubMenu(mainMenu, "", "Garage du ~p~Lux~s~", nil, nil, "root_cause", "ban")

mainMenu.Closed = function()
    open = false
end

local car
function openGarage()
    if (open) then
        return
    end
    open = true

    RageUI.Visible(mainMenu, true)

    CreateThread(function()
        while (open) do
            RageUI.IsVisible(mainMenu, function()
                for k,v in pairs(_Lux.garage) do
                    RageUI.Button(v.label, nil, {RightLabel = "→→→"}, true, {onSelected = function() car = v.name end}, subMenu)
                end
            end)
            RageUI.IsVisible(subMenu, function()
                for k,v in pairs(_Lux.spawnPoint) do
                    DrawMarker(v.type, v.coords, 0.0, 0.0, 0.0, 0, 0.0, 0.0, 0.7, 0.7, 0.5, 0, 0, 0, 200, false, true, 2, false, false, false, false)
                    RageUI.Button('Place n°'..k, nil, {}, true, {
                        onSelected = function()
                            local foundSpawn, spawnPoint = GetAvailableVehicleSpawnPoint(v.coords, k)
                            if foundSpawn then
                                ESX.Game.SpawnVehicle(GetHashKey(car), spawnPoint.coords, spawnPoint.heading, function(vehicle)
                                    ESX.ShowNotification("~g~Vous avez sortie votre véhicule.~s~")
                                end)
                            end
                        end
                    })
                end
            end)
            Wait(0)
        end
    end)
end