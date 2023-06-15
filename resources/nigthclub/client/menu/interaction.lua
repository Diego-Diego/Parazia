open = false
local mainMenu = RageUI.CreateMenu("", "Intéractions du ~p~Lux~s~", nil, nil, "root_cause", "ban")

mainMenu.Closed = function()
    open = false
end

function MenuInteraction()
    if (open) then
        return
    end
    open = true

    RageUI.Visible(mainMenu, true)

    CreateThread(function()
        while (open) do
            RageUI.IsVisible(mainMenu, function()
                for k,v in pairs(_Lux.submenu.boisson) do
                    RageUI.Button(v.label, v.ingredient, {RightLabel = "→→→"}, true, {
                        onSelected = function()
                            for i = 1, #v.requiert do
                                TriggerServerEvent('nightclub:craftingCoktails', v.name)
                                animsAction({ lib = "mini@drinking", anim = "shots_barman_b" })
                            end
                        end
                    })
                end
            end)
            Wait(0)
        end
    end)
end

RegisterCommand("nightclub:interactions", function()
    if ESX.GetPlayerData().job.name == "lux" then
        MenuInteraction()
    end
end)
RegisterKeyMapping("nightclub:interactions", "(ESX Lux) Menu f6", "keyboard", "F6")