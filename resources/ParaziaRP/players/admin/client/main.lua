isNoClip,NoClipSpeed,isNameShown,blipsActive = false,0.5,false,false
spawnInside = false
showAreaPlayers = false
selectedPlayer = nil
selectedReport = nil

localPlayers, connecteds, staff, items = {},0,0, {}
permLevel = nil

RegisterNetEvent("adminmenu:updatePlayers")
AddEventHandler("adminmenu:updatePlayers", function(table)
    localPlayers = table
    local count, sCount = 0, 0
    for source, player in pairs(table) do
        count = count + 1
        if player.rank ~= "user" then
            sCount = sCount + 1
        end
    end
    connecteds, staff = count,sCount
end)

RegisterNetEvent("adminmenu:setCoords")
AddEventHandler("adminmenu:setCoords", function(coords)
    SetEntityCoords(PlayerPedId(), coords, false, false, false, false)
end)

globalRanksRelative = {
    ["user"] = 0,
    ["helper"] = 1,
    ["modo"] = 2,
    ["admin"] = 3,
    ["superadmin"] = 4,
    ["responsable"] = 5,
    ["_dev"] = 6
}

RegisterNetEvent("adminmenu:cbPermLevel")
AddEventHandler("adminmenu:cbPermLevel", function(pLvl)
    permLevel = pLvl
    DecorSetInt(PlayerPedId(), "staffl", globalRanksRelative[pLvl])
end)

RegisterNetEvent("adminmenu:cbItemsList")
AddEventHandler("adminmenu:cbItemsList", function(table)
    items = table
end)

RegisterNetEvent("adminmenu:receivewarn")
AddEventHandler("adminmenu:receivewarn", function(reason)
    ESX.Scaleform.ShowFreemodeMessage('~q~Vous avez reçu un avertissement', '~q~'..reason, 5)
end)

Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
        Citizen.Wait(1)
    end
    if not DecorExistOn(PlayerPedId(), "isStaffMode") then
        DecorRegister("isStaffMode", 2)
    end
    TriggerServerEvent("fakeLoaded")
    while not permLevel do Wait(1) end
    if not DecorExistOn(PlayerPedId(), "staffl") then
        DecorRegister("staffl", 3)
    end
    DecorSetInt(PlayerPedId(), "staffl", globalRanksRelative[permLevel])
end)

RegisterCommand("+noclip-admin", function()
    if ESX.GetPlayerData()['group'] ~= 'user' and isStaffMode then
        NoClip(not isNoClip)
    else
        ESX.ShowNotification("~q~ParaziaRP\n~s~Vous n'êtes pas en mode staff !")
    end
end, false)
RegisterKeyMapping('+noclip-admin', 'Raccourci Noclip', 'keyboard', 'F11')


RegisterNetEvent("prz_core:tpm")
AddEventHandler("prz_core:tpm", function()
	local GetEntityCoords = GetEntityCoords
	local GetGroundZFor_3dCoord = GetGroundZFor_3dCoord
	local GetFirstBlipInfoId = GetFirstBlipInfoId
	local DoesBlipExist = DoesBlipExist
	local DoScreenFadeOut = DoScreenFadeOut
	local GetBlipInfoIdCoord = GetBlipInfoIdCoord
	local GetVehiclePedIsIn = GetVehiclePedIsIn

    local blipMarker = GetFirstBlipInfoId(8)
    if not DoesBlipExist(blipMarker) then
        ESX.ShowNotification("~r~Il n'y a pas de blips sur la map !", true, false, 140)
        return 'marker'
    end

    DoScreenFadeOut(650)
    while not IsScreenFadedOut() do
        Wait(0)
    end

    local ped, coords = PlayerPedId(), GetBlipInfoIdCoord(blipMarker)
    local vehicle = GetVehiclePedIsIn(ped, false)
    local oldCoords = GetEntityCoords(ped)

    -- Unpack coords instead of having to unpack them while iterating.
    -- 825.0 seems to be the max a player can reach while 0.0 being the lowest.
    local x, y, groundZ, Z_START = coords['x'], coords['y'], 850.0, 950.0
    local found = false
    FreezeEntityPosition(vehicle > 0 and vehicle or ped, true)

    for i = Z_START, 0, -25.0 do
        local z = i
        if (i % 2) ~= 0 then
            z = Z_START - i
        end

        NewLoadSceneStart(x, y, z, x, y, z, 50.0, 0)
        local curTime = GetGameTimer()
        while IsNetworkLoadingScene() do
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end
        NewLoadSceneStop()
        SetPedCoordsKeepVehicle(ped, x, y, z)

        while not HasCollisionLoadedAroundEntity(ped) do
            RequestCollisionAtCoord(x, y, z)
            if GetGameTimer() - curTime > 1000 then
                break
            end
            Wait(0)
        end

        -- Get ground coord. As mentioned in the natives, this only works if the client is in render distance.
        found, groundZ = GetGroundZFor_3dCoord(x, y, z, false)
        if found then
            Wait(0)
            SetPedCoordsKeepVehicle(ped, x, y, groundZ)
            break
        end
        Wait(0)
    end

    -- Remove black screen once the loop has ended.
    DoScreenFadeIn(650)
    FreezeEntityPosition(vehicle > 0 and vehicle or ped, false)

    if not found then
        -- If we can't find the coords, set the coords to the old ones.
        -- We don't unpack them before since they aren't in a loop and only called once.
        SetPedCoordsKeepVehicle(ped, oldCoords['x'], oldCoords['y'], oldCoords['z'] - 1.0)
        ESX.ShowNotification("Vous avez été tp avec succès", true, false, 140)
    end

    -- If Z coord was found, set coords in found coords.
    SetPedCoordsKeepVehicle(ped, x, y, groundZ)
    ESX.ShowNotification("Vous avez été tp avec succès", true, false, 140)
end)