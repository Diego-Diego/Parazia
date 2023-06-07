ESX = nil 

TriggerEvent("sova:KraKss0TEX0", function(obj) ESX = obj end)

local laboBuilderZone = false

CreateThread(function()
    InitMarkerLabo()
end)

function InitMarkerLabo()
    laboBuilderZone = true
    CreateThread(function()
        while laboBuilderZone do
            local playerPed = PlayerPedId()
            local InZone = false
            local playerPos = GetEntityCoords(playerPed)

            for k, v in pairs(_Config.LaboBuild.Labo) do
                local dst = GetDistanceBetweenCoords(playerPos, v.PositionEnter, true)

                if dst < 10.0 then
                    InZone = true
                    DrawMarker(21, v.PositionEnter.x, v.PositionEnter.y, v.PositionEnter.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 200, 0, 1, 2, 0, nil, nil, 0)
                    if dst < 2.0 then
                        Visual.Subtitle("Appuyer sur [~g~E~s~] pour entré dans le labo de ~g~"..v.TypeDeLabo)
                        if IsControlJustReleased(1, 38) then
                            DoScreenFadeOut(2000)
                            Wait(3000)
                            SetEntityCoords(playerPed, v.PositionTpLabo.x, v.PositionTpLabo.y, v.PositionTpLabo.z)
                            DoScreenFadeIn(3500)
                        end
                    end
                end
            end
            for k, v in pairs(_Config.LaboBuild.Labo) do
                local dst = GetDistanceBetweenCoords(playerPos, v.PositionSortieLabo, true)

                if dst < 10.0 then
                    InZone = true
                    DrawMarker(21, v.PositionSortieLabo.x, v.PositionSortieLabo.y, v.PositionSortieLabo.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 200, 0, 1, 2, 0, nil, nil, 0)
                    if dst < 2.0 then
                        Visual.Subtitle("Appuyer sur [~g~E~s~] pour entré dans le labo de ~g~"..v.TypeDeLabo)
                        if IsControlJustReleased(1, 38) then
                            DoScreenFadeOut(2000)
                            Wait(3000)
                            SetEntityCoords(playerPed, v.PositionEnter.x, v.PositionEnter.y, v.PositionEnter.z)
                            DoScreenFadeIn(3500)
                        end
                    end
                end
            end
            for k, v in pairs(_Config.LaboBuild.Labo) do
                local dst = GetDistanceBetweenCoords(playerPos, v.PositionRecolteLabo, true)

                if dst < 10.0 then
                    InZone = true
                    DrawMarker(21, v.PositionRecolteLabo.x, v.PositionRecolteLabo.y, v.PositionRecolteLabo.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 200, 0, 1, 2, 0, nil, nil, 0)
                    if dst < 2.0 then
                        Visual.Subtitle("Appuyer sur [~g~E~s~] pour récolter de la ~g~"..v.TypeDeLabo)
                        if IsControlJustReleased(1, 38) then
                            RecolteMenu(v)
                        end
                    end
                end
            end
            for k, v in pairs(_Config.LaboBuild.Labo) do
                local dst = GetDistanceBetweenCoords(playerPos, v.PositionTraitementLabo, true)

                if dst < 10.0 then
                    InZone = true
                    DrawMarker(21, v.PositionTraitementLabo.x, v.PositionTraitementLabo.y, v.PositionTraitementLabo.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 200, 0, 1, 2, 0, nil, nil, 0)
                    if dst < 2.0 then
                        Visual.Subtitle("Appuyer sur [~g~E~s~] pour traiter de la ~g~"..v.TypeDeLabo)
                        if IsControlJustReleased(1, 38) then
                            TraitementMenu(v)
                        end
                    end
                end
            end
            for k, v in pairs(_Config.LaboBuild.Labo) do
                local dst = GetDistanceBetweenCoords(playerPos, v.PositionVente, true)

                if dst < 10.0 then
                    InZone = true
                    DrawMarker(21, v.PositionVente.x, v.PositionVente.y, v.PositionVente.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 255, 255, 255, 200, 0, 1, 2, 0, nil, nil, 0)
                    if dst < 2.0 then
                        Visual.Subtitle("Appuyer sur [~g~E~s~] pour vendre de la ~g~"..v.TypeDeLabo)
                        if IsControlJustReleased(1, 38) then
                            VenteMenu(v)
                        end
                    end
                end
            end
            if not InZone then
                Wait(500)
            else
                Wait(1)
            end
        end
    end)
end