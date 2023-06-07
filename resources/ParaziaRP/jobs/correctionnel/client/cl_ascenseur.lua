local lift = {
    teleport = {
        [0] =  {pos = vector3(-1095.927, -850.7149, 05.00121), name = "-1 - Parking et cellules"},
        [1] =  {pos = vector3(-1095.927, -850.7149, 10.30121), name = "-2 - Laboratoire et saisie"},
        [2] =  {pos = vector3(-1095.927, -850.7149, 14.10121), name = "-3 - Armurerie"},
        [3] =  {pos = vector3(-1095.927, -850.7149, 19.00121), name = " 1 - RDC"},
        [4] =  {pos = vector3(-1095.927, -850.7149, 23.00121), name = " 2 - Salle de pause"},
        [5] =  {pos = vector3(-1095.927, -850.7149, 27.00121), name = " 3 - Salle de dispatch et vestiaire"},
        [6] =  {pos = vector3(-1095.927, -850.7149, 31.00121), name = " 4 - Bureau"},
        [7] =  {pos = vector3(-1095.927, -850.7149, 34.00121), name = " 5 - Bureau hauts gradés"},
        [8] =  {pos = vector3(-1095.927, -850.7149, 38.30121), name = " 6 - Toit"},
    },
}

local function openMenu(select)
    local mainMenu = MowgliUI.CreateMenu("", "Ascenseur correctionnel")

    MowgliUI.Visible(mainMenu, not MowgliUI.Visible(mainMenu))

    while mainMenu do
        Wait(1)
        MowgliUI.IsVisible(mainMenu, true, true, false, function()
            for k,v in pairs(lift.teleport) do
                MowgliUI.ButtonWithStyle(v.name, nil, {}, v.pos ~= select.pos, function(h, a, s)
                    if s then
                        DoScreenFadeOut(800)

                        while not IsScreenFadedOut() do
                            Citizen.Wait(50)
                        end
                    
                        SetEntityCoordsNoOffset(PlayerPedId(), v.pos)
                        SetEntityHeading(PlayerPedId(), 33.0)
                        ESX.ShowNotification("Vous êtes bien arrivé a l'étage ~q~"..v.name.."~s~.")
                        MowgliUI.CloseAll()
                    
                        StopScreenEffect('DeathFailOut')
                        DoScreenFadeIn(800)
                    end
                end)
            end
        end)

        if not MowgliUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType("menu", true)
        end
    end
end

CreateThread(function()
    while true do
        local waiting = 250
        local myCoords = GetEntityCoords(PlayerPedId())

        for k,v in pairs(lift.teleport) do
            if #(myCoords-v.pos) < 1.0 then
                waiting = 1
                ESX.ShowHelpNotification("Appuyez sur ~INPUT_CONTEXT~ pour ~g~choisir votre étage~s~.")
                if IsControlJustReleased(0, 54) then
                    openMenu(v)
                end
            end
        end

        Wait(waiting)
    end
end)