open10 = false
local mainMenu = RageUI.CreateMenu("", "Frigo du ~p~Lux~s~", nil, nil, "root_cause", "ban")
local subMenu = RageUI.CreateSubMenu(mainMenu, "", "Frigo du ~p~Lux~s~", nil, nil, "root_cause", "ban")

mainMenu.Closed = function()
    open10 = false
end

function openShops()
    if (open10) then
        return
    end
    open10 = true

    RageUI.Visible(mainMenu, true)

    CreateThread(function()
        while (open10) do
            RageUI.IsVisible(mainMenu, function()
                for k,v in pairs(_Lux.shopsItem) do
                    RageUI.Button(v.label, nil, {RightLabel = "~p~"..v.price.."$~s~"}, true, {
                        onSelected = function()
                            TriggerServerEvent('nightclub:buyItem', v.name, v.price)
                        end
                    })
                end
            end)
            Wait(0)
        end
    end)
end