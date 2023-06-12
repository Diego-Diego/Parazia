local isMenuOpened, cat = false, "adminmenu"
local prefix = "~q~[Admin]~s~"
local filterArray = { "A", "B", "C", "D", "E", "F", "G", "H", "I", "J", "K", "L", "M", "N", "O", "P", "Q", "R", "S", "T", "U", "V", "W", "X", "Y", "Z" }
local filter = 1
local creditsSent = false

local TARGET_INVENTORY = {}

IS_IN_STAFF = false
ON_STAFF = false

isDelgunEnabled = false

IN_SPECTATE = false

showCoords = false

local hideTakenReports = false

local Items = {}     
local Armes = {}   
local ArgentSale = {} 
local ArgentCash = {}
local ArgentBank = {}

local allJobsServer = {}
local allGradeForJobSelected = {}



local function subCat(name)
    return cat .. name
end

local function msg(string)
    ESX.ShowNotification(string)
end

local function colorByState(bool)
    if bool then
        return "~g~"
    else
        return "~s~"
    end
end

local function statsSeparator()
    MowgliUI.Separator("Connectés: ~g~" .. connecteds .. " ~q~|~s~ Staff en ligne: ~o~" .. staff)
end

local function generateTakenBy(reportID)
    if localReportsTable[reportID].taken then
        return "~s~ | Pris par: ~o~" .. localReportsTable[reportID].takenBy
    else
        return ""
    end
end

local ranksRelative = {
    ["user"] = 1,
    ["helper"] = 2,
    ["modo"] = 3,
    ["admin"] = 4,
    ["superadmin"] = 5,
    ["gamemaster"] = 6,
    ["responsable"] = 7,
    ["_dev"] = 8
}

local ranksInfos = {
    [1] = { label = "Joueur", rank = "user" },
    [2] = { label = "Helper", rank = "helper" },
    [3] = { label = "Modérateur", rank = "modo" },
    [4] = { label = "Admin", rank = "admin" },
    [5] = { label = "Super Admin", rank = "superadmin" },
    [6] = { label = "Responsable L / I", rank = "gamemaster" },
    [7] = { label = "Responsable Staff", rank = "responsable" },
    [8] = { label = "Fondateur", rank = "_dev" }
}

local function getRankDisplay(rank)
    local ranks = {
        --["_dev"] = "~q~[Fondateur] ~s~",
        ["responsable"] = "~q~[Responsable Staff] ~s~",
        ["gamemaster"] = "~q~[Responsable L / I] ~s~",
        ["superadmin"] = "~q~[S.Admin] ~s~",
        ["admin"] = "~q~[Admin] ~s~",
        ["modo"] = "~q~[Modérateur] ~s~",
        ["helper"] = "~q~[Helper] ~s~",
    }
    return ranks[rank] or ""
end

local function getIsTakenDisplay(bool)
    if bool then
        return ""
    else
        return "~q~[EN ATTENTE]~s~ "
    end
end

local function starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

function getBaseSkin()
    ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
        local isMale = skin.sex == 0
        TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
            ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                TriggerEvent('skinchanger:loadSkin', skin)
                TriggerEvent('esx:restoreLoadout')
            end)
        end)

    end)
end

local selectedColor = 1
local cVarLongC = { 1, 2, 3, 4, 5, 6, 7, 8, 9, 10 }
local cVarLong = function()
    return cVarLongC[selectedColor]
end



function applySkinStaff()
    Citizen.CreateThread(function()
        while ON_STAFF do
            Wait(350)
            selectedColor = selectedColor + 1
            if selectedColor > #cVarLongC then
                selectedColor = 1
             end
        end
    end)
    Citizen.CreateThread(function()
        while ON_STAFF do 
            if not ON_STAFF then
                break
            end
            TriggerEvent('skinchanger:getSkin', function(skin)
                if skin.sex == 0 then
                    papillonOutfit = { 
                        ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                        ['torso_1'] = 178,   ['torso_2'] = cVarLong(),
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 17,
                        ['pants_1'] = 77,   ['pants_2'] = cVarLong(),
                        ['shoes_1'] = 55,   ['shoes_2'] = cVarLong(),
                        ['chain_1'] = 0,    ['chain_2'] = 0,
                        ['helmet_1'] = 91,    ['helmet_2'] = cVarLong(),
                        ['bags_1'] = 0,     ['bags_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_1'] = 0,
                        ['glasses_1'] = 0,  ['glasses_2'] = 0,
                    }
                else
                    papillonOutfit = { 
                        ['tshirt_1'] = 14,  ['tshirt_2'] = 0,
                        ['torso_1'] = 180,   ['torso_2'] = 4,
                        ['decals_1'] = 0,   ['decals_2'] = 0,
                        ['arms'] = 18,
                        ['pants_1'] = 79,   ['pants_2'] = 4,
                        ['shoes_1'] = 58,   ['shoes_2'] = 4,
                        ['chain_1'] = 0,    ['chain_2'] = 0,
                        ['helmet_1'] = 90,    ['helmet_2'] = 4,
                        ['bags_1'] = 0,     ['bags_2'] = 0,
                        ['bproof_1'] = 0,  ['bproof_1'] = 0,
                        ['glasses_1'] = 5,  ['glasses_2'] = 0,
                    }
                end
                TriggerEvent('skinchanger:loadClothes',skin, papillonOutfit)
            end)
            Citizen.Wait(350)
        end
    end)
end

RegisterCommand("+admin", function()
    if ESX.GetPlayerData()['group'] ~= 'user' then
        tcheckmoisa()
        openMenu()
    end
end, false)

RegisterKeyMapping('+admin', 'Menu d\'administration', 'keyboard', 'F10')

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
  ESX.PlayerData = xPlayer
end)
RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)
	ESX.PlayerData.job = job
end)
RegisterNetEvent('esx:setJob2')
AddEventHandler('esx:setJob2', function(job2)
	ESX.PlayerData.job2 = job2
end)

local function getPlayerInv(player)
    
    Items = {}
    Armes = {}
    ArgentSale = {}
    ArgentCash = {}
    ArgentBank = {}
    
    ESX.TriggerServerCallback('adminmenu:getOtherPlayerData', function(data)
    
    
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'bank' and data.accounts[i].money > 0 then
                table.insert(ArgentBank, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'bank',
                    itemType = 'item_bank',
                    amount   = data.accounts[i].money
                })
    
                break
            end
        end
    
    
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'money' and data.accounts[i].money > 0 then
                table.insert(ArgentCash, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'money',
                    itemType = 'item_cash',
                    amount   = data.accounts[i].money
                })
    
                break
            end
        end
    
        for i=1, #data.accounts, 1 do
            if data.accounts[i].name == 'black_money' and data.accounts[i].money > 0 then
                table.insert(ArgentSale, {
                    label    = ESX.Math.Round(data.accounts[i].money),
                    value    = 'black_money',
                    itemType = 'item_account',
                    amount   = data.accounts[i].money
                })
    
                break
            end
        end
    
        for i=1, #data.weapons, 1 do
            table.insert(Armes, {
                label    = ESX.GetWeaponLabel(data.weapons[i].name),
                value    = data.weapons[i].name,
                right    = data.weapons[i].ammo,
                itemType = 'item_weapon',
                amount   = data.weapons[i].ammo
            })
        end
    
        for i=1, #data.inventory, 1 do
            if data.inventory[i].count > 0 then
                table.insert(Items, {
                    label    = data.inventory[i].label,
                    right    = data.inventory[i].count,
                    value    = data.inventory[i].name,
                    itemType = 'item_standard',
                    amount   = data.inventory[i].count
                })
            end
        end
    end, GetPlayerServerId(player))
end

function tcheckmoisa()
    ESX.TriggerServerCallback('finalmenuadmin:getAllItems', function(allItems)
        allItemsServer = allItems
    end)

    ESX.TriggerServerCallback('finalmenuadmin:getAllJobs', function(allJobs)
        allJobsServer = allJobs
    end)
end

function openMenu()
    if menuOpen then
        return
    end
    if permLevel == "user" then
        msg("~q~Vous n'avez pas accès à ce menu.")
        return
    end
    local selectedColor = 1
    local cVarLongC = { "~q~", "~q~", "~o~", "~y~", "~c~", "~g~", "~q~" }
    local cVar1, cVar2 = "~y~", "~q~"
    local cVarLong = function()
        return cVarLongC[selectedColor]
    end
    menuOpen = true

    RMenu.Add(cat, subCat("main"), MowgliUI.CreateMenu("", "Menu administratif"))
    RMenu:Get(cat, subCat("main")).Closed = function()
    end

    RMenu.Add(cat, subCat("players"), MowgliUI.CreateSubMenu(RMenu:Get(cat, subCat("main")), "", "Menu administratif"))
    RMenu:Get(cat, subCat("players")).Closed = function()
    end

    RMenu.Add(cat, subCat("reports"), MowgliUI.CreateSubMenu(RMenu:Get(cat, subCat("main")), "", "Menu administratif"))
    RMenu:Get(cat, subCat("reports")).Closed = function()
    end

    RMenu.Add(cat, subCat("param"), MowgliUI.CreateSubMenu(RMenu:Get(cat, subCat("main")), "", "Menu administratif"))
    RMenu:Get(cat, subCat("param")).Closed = function()
    end

    RMenu.Add(cat, subCat("reports_take"), MowgliUI.CreateSubMenu(RMenu:Get(cat, subCat("reports")), "", "Menu administratif"))
    RMenu:Get(cat, subCat("reports_take")).Closed = function()
    end

    RMenu.Add(cat, subCat("playersManage"), MowgliUI.CreateSubMenu(RMenu:Get(cat, subCat("players")), "", "Menu administratif"))
    RMenu:Get(cat, subCat("playersManage")).Closed = function()
    end

    RMenu.Add(cat, subCat("playersInventaire"), MowgliUI.CreateSubMenu(RMenu:Get(cat, subCat("playersManage")), "", "Menu administratif"))
    RMenu:Get(cat, subCat("playersInventaire")).Closed = function()
    end

    RMenu.Add(cat, subCat("setGroup"), MowgliUI.CreateSubMenu(RMenu:Get(cat, subCat("playersManage")), "", "Menu administratif"))
    RMenu:Get(cat, subCat("setGroup")).Closed = function()
    end

    RMenu.Add(cat, subCat("setjobMenu"), MowgliUI.CreateSubMenu(RMenu:Get(cat, subCat("playersManage")), "", "Menu administratif"))
    RMenu:Get(cat, subCat("setjobMenu")).Closed = function()
    end

    RMenu.Add(cat, subCat("setjobMenuSub"), MowgliUI.CreateSubMenu(RMenu:Get(cat, subCat("setjobMenu")), "", "Menu administratif"))
    RMenu:Get(cat, subCat("setjobMenuSub")).Closed = function()
    end

    RMenu.Add(cat, subCat("items"), MowgliUI.CreateSubMenu(RMenu:Get(cat, subCat("playersManage")), "", "Menu administratif"))
    RMenu:Get(cat, subCat("items")).Closed = function()
    end

    RMenu.Add(cat, subCat("vehicle"), MowgliUI.CreateSubMenu(RMenu:Get(cat, subCat("main")), "", "Menu administratif"))
    RMenu:Get(cat, subCat("vehicle")).Closed = function()
    end

    MowgliUI.Visible(RMenu:Get(cat, subCat("main")), true)
    Citizen.CreateThread(function()
        while menuOpen do
            Wait(800)
            if cVar1 == "~y~" then
                cVar1 = "~o~"
            else
                cVar1 = "~y~"
            end
            if cVar2 == "~q~" then
                cVar2 = "~s~"
            else
                cVar2 = "~q~"
            end
        end
    end)
    Citizen.CreateThread(function()
        while menuOpen do
            Wait(250)
            selectedColor = selectedColor + 1
            if selectedColor > #cVarLongC then
                selectedColor = 1
            end
        end
    end)
    Citizen.CreateThread(function()
        while menuOpen do
            local shouldStayOpened = false
            MowgliUI.IsVisible(RMenu:Get(cat, subCat("main")), true, true, true, function()
                shouldStayOpened = true
                statsSeparator()

                if isStaffMode then
                    MowgliUI.ButtonWithStyle("~q~Désactiver le Staff Mode", nil, {}, not serverInteraction, function(_, _, s)
                        if s then
                            serverInteraction = true
                            IS_IN_STAFF = false
                            blipsActive = false
                            ON_STAFF = false
                            NoClip(false)
                            showNames(false)
                            msg("~y~Désactivation du StaffMode...")
                            TriggerServerEvent("adminmenu:setStaffState", false)
                            Citizen.Wait(351)
                             getBaseSkin()
                        end
                    end)
                else
                    MowgliUI.ButtonWithStyle("~g~Activer le Staff Mode", nil, {}, not serverInteraction, function(_, _, s)
                        if s then
                            serverInteraction = true
                            IS_IN_STAFF = true
                            ON_STAFF = true
                            msg("~y~Activation du StaffMode...")
                            TriggerServerEvent("adminmenu:setStaffState", true)
                             applySkinStaff()
                        end
                    end)
                end

                MowgliUI.Separator("↓ ~g~Assistance ~s~↓")

                MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Gestion des reports (~q~" .. reportCount .. "~s~)", nil, { RightLabel = "→→" }, isStaffMode, function(_, _, s)
                end, RMenu:Get(cat, subCat("reports")))

                if isStaffMode then
                    MowgliUI.Separator("↓ ~y~Modération ~s~↓")

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Gestion joueurs", nil, { RightLabel = "→→" }, true, function()
                    end, RMenu:Get(cat, subCat("players")))
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Gestion véhicules", nil, { RightLabel = "→→" }, canUse("vehicles2", permLevel), function()
                    end, RMenu:Get(cat, subCat("vehicle")))
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Personnel", nil, { RightLabel = "→→" }, true, function()
                    end, RMenu:Get(cat, subCat("param")))



                end
            end, function()
            end, 1)

            MowgliUI.IsVisible(RMenu:Get(cat, subCat("players")), true, true, true, function()
                shouldStayOpened = true
                statsSeparator()
                MowgliUI.Checkbox(cVarLong() .. "→ " .. colorByState(showAreaPlayers) .. "Restreindre à ma zone", nil, showAreaPlayers, { Style = MowgliUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    showAreaPlayers = Checked;
                end, function()
                end, function()
                end)
                MowgliUI.Separator("↓ ~g~Joueurs ~s~↓")
                if not showAreaPlayers then
                    for source, player in pairs(localPlayers) do
                        if player.name == nil then player.name = "Joueur caractère spéciaux" end
                        MowgliUI.ButtonWithStyle(getRankDisplay(player.rank) .. "~s~[~o~" .. source .. "~s~] " .. cVarLong() .. "→ ~s~" .. player.name or "<Pseudo invalide>" .. " (~q~" .. player.timePlayed[2] .. "h " .. player.timePlayed[1] .. "min~s~)", nil, { RightLabel = "→→" }, ranksRelative[permLevel] >= ranksRelative[player.rank] and source ~= GetPlayerServerId(PlayerId()), function(_, _, s)
                            if s then
                                selectedPlayer = source
                            end
                        end, RMenu:Get(cat, subCat("playersManage")))
                    end
                else
                    for _, player in ipairs(GetActivePlayers()) do
                        local sID = GetPlayerServerId(player)
                        if localPlayers[sID] ~= nil then
                            if localPlayers[sID].name == nil then localPlayers[sID].name = "Joueur caractère spéciaux" end
                            MowgliUI.ButtonWithStyle(getRankDisplay(localPlayers[sID].rank) .. "~s~[~o~" .. sID .. "~s~] " .. cVarLong() .. "→ ~s~" .. localPlayers[sID].name or "<Pseudo invalide>" .. " (~q~" .. localPlayers[sID].timePlayed[2] .. "h " .. localPlayers[sID].timePlayed[1] .. "min~s~)", nil, { RightLabel = "→→" }, ranksRelative[permLevel] >= ranksRelative[localPlayers[sID].rank] and source ~= GetPlayerServerId(PlayerId()), function(_, _, s)
                                if s then
                                    selectedPlayer = sID
                                end
                            end, RMenu:Get(cat, subCat("playersManage")))
                        end
                    end
                end
            end, function()
            end, 1)

            MowgliUI.IsVisible(RMenu:Get(cat, subCat("reports")), true, true, true, function()
                shouldStayOpened = true
                statsSeparator()
                MowgliUI.Separator("↓ ~g~Paramètres ~s~↓")
                MowgliUI.Checkbox(colorByState(hideTakenReports) .. "Cacher les pris en charge", nil, hideTakenReports, { Style = MowgliUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                    hideTakenReports = Checked;
                end, function()
                end, function()
                end)
                MowgliUI.Separator("↓ ~y~Reports ~s~↓")
                for sender, infos in pairs(localReportsTable) do
                    if infos.taken then
                        if hideTakenReports == false then
                            MowgliUI.ButtonWithStyle(getIsTakenDisplay(infos.taken) .. "[~q~" .. infos.id .. "~s~] " .. cVarLong() .. "→ ~s~" .. infos.name, "~g~Créé il y a~s~: "..infos.timeElapsed[1].."m"..infos.timeElapsed[2].."h~n~~q~ID Unique~s~: #" .. infos.id .. "~n~~y~Description~s~: " .. infos.reason .. "~n~~o~Pris en charge par~s~: " .. infos.takenBy, { RightLabel = "→→" }, true, function(_, _, s)
                                if s then
                                    selectedReport = sender
                                end
                            end, RMenu:Get(cat, subCat("reports_take")))
                        end
                    else
                        MowgliUI.ButtonWithStyle(getIsTakenDisplay(infos.taken) .. "[~q~" .. infos.id .. "~s~] " .. cVarLong() .. "→ ~s~" .. infos.name, "~g~Créé il y a~s~: "..infos.timeElapsed[1].."m"..infos.timeElapsed[2].."h~n~~q~ID Unique~s~: #" .. infos.id .. "~n~~y~Description~s~: " .. infos.reason, { RightLabel = "→→" }, true, function(_, _, s)
                            if s then
                                selectedReport = sender
                            end
                        end, RMenu:Get(cat, subCat("reports_take")))
                    end
                end
            end, function()
            end, 1)

            MowgliUI.IsVisible(RMenu:Get(cat, subCat("param")), true, true, true, function()
                shouldStayOpened = true
                statsSeparator()
                MowgliUI.Separator("↓ ~g~Personnel ~s~↓")

                if ESX.GetPlayerData()['group'] ~= "user" then
                    MowgliUI.Checkbox(cVarLong() .. "→ ~s~NoClip", "Vous permet de vous déplacer librement sur toute la carte sous forme de caméra libre, pour ~q~augmenter la vitesse de celui-ci~s~ utiliser la molette", isNoClip, { Style = MowgliUI.CheckboxStyle.Tick, RightLabel = "" }, function(Hovered, Selected, Active, Checked)
                        isNoClip = Checked;
                    end, function()
                        NoClip(true)
                    end, function()
                        NoClip(false)
                    end)
                end
                if ESX.GetPlayerData()['group'] ~= "user" then
                    MowgliUI.Checkbox(cVarLong() .. "→ ~s~Affichage des GamerTags", nil, isNameShown, { Style = MowgliUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                        isNameShown = Checked;
                    end, function()
                        showNames(true)
                    end, function()
                        showNames(false)
                    end)
                end
                if ESX.GetPlayerData()['group'] ~= "user" then
                    MowgliUI.Checkbox(cVarLong() .. "→ ~s~Affichage des BLIPS", nil, blipsActive, { Style = MowgliUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                        blipsActive = Checked;
                    end, function()
                    end, function()
                    end)
                end
                if ESX.GetPlayerData()['group'] ~= "user" then
                    MowgliUI.Checkbox(cVarLong() .. "→ ~s~Activé Delgun", nil, isDelgunEnabled, { Style = MowgliUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                        isDelgunEnabled = Checked;
                    end, function()
                    end, function()
                    end)
                end
                if ESX.GetPlayerData()['group'] ~= "user" then
                    MowgliUI.Checkbox(cVarLong() .. "→ ~s~Coordonnees", nil, showCoords, { Style = MowgliUI.CheckboxStyle.Tick }, function(Hovered, Selected, Active, Checked)
                        showCoords = Checked;
                    end, function()
                    end, function()
                    end)
                end
                MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Vous téléportez sur un marker", nil, { RightLabel = "→→" }, true, function(_, _, s)
                    if s then
                        plyPed = PlayerPedId()
                        local waypointHandle = GetFirstBlipInfoId(8)

                        if DoesBlipExist(waypointHandle) then
                            Citizen.CreateThread(function()
                                local waypointCoords = GetBlipInfoIdCoord(waypointHandle)
                                local foundGround, zCoords, zPos = false, -500.0, 0.0

                                while not foundGround do
                                    zCoords = zCoords + 10.0
                                    RequestCollisionAtCoord(waypointCoords.x, waypointCoords.y, zCoords)
                                    Citizen.Wait(0)
                                    foundGround, zPos = GetGroundZFor_3dCoord(waypointCoords.x, waypointCoords.y, zCoords)

                                    if not foundGround and zCoords >= 2000.0 then
                                        foundGround = true
                                    end
                                end
                                SetPedCoordsKeepVehicle(plyPed, waypointCoords.x, waypointCoords.y, zPos)
                                msg("Vous avez été TP")
                            end)
                        else
                            msg("Pas de marqueur sur la carte")
                        end
                    end
                end)
                if ESX.GetPlayerData()['group'] == "_dev" then
                    MowgliUI.Separator("↓ ~g~Te changer ~s~↓")
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Normal", nil, { RightLabel = "→→" }, canUse("ped", permLevel), function(_, _, s)
                        if s then
                            ON_STAFF = false
                            Citizen.Wait(351)
                            getBaseSkin()
                        end
                    end)
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Vous mettre en ped", nil, { RightLabel = "→→" }, canUse("ped", permLevel), function(_, _, s)
                        if s then
                            local j1 = PlayerId()
                            local newped = input("Ped", "", 100, false)
                            if newped ~= nil and newped ~= "" then
                                local p1 = GetHashKey(newped)
                                RequestModel(p1)
                                while not HasModelLoaded(p1) do
                                    Wait(100)
                                end
                                SetPlayerModel(j1, p1)
                                SetModelAsNoLongerNeeded(p1)
                                msg('c\'est bon c\'est changer')
                            end
                        end
                    end)
                end
            end, function()
            end, 1)

            MowgliUI.IsVisible(RMenu:Get(cat, subCat("reports_take")), true, true, true, function()
                shouldStayOpened = true
                statsSeparator()
                if localReportsTable[selectedReport] ~= nil then
                    MowgliUI.Separator("ID du Report: ~q~#" .. localReportsTable[selectedReport].uniqueId .. " ~s~| ID de l'auteur: ~y~" .. selectedReport .. generateTakenBy(selectedReport))
                    MowgliUI.Separator("↓ ~g~Actions sur le report ~s~↓")
                    local infos = localReportsTable[selectedReport]
                    if not localReportsTable[selectedReport].taken then
                        MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Prendre en charge ce report", "~y~Description~s~: " .. infos.reason, { RightLabel = "→→" }, true, function(_, _, s)
                            if s then
                                TriggerServerEvent("adminmenu:takeReport", selectedReport)
                            end
                        end)
                    end
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Cloturer ce report", "~y~Description~s~: " .. infos.reason, { RightLabel = "→→" }, true, function(_, _, s)
                        if s then
                            TriggerServerEvent("adminmenu:closeReport", selectedReport)
                        end
                    end)
                    MowgliUI.Separator("↓ ~y~Actions rapides ~s~↓")
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Revive", "~y~Description~s~: " .. infos.reason, { RightLabel = "→→" }, canUse("revive", permLevel), function(_, _, s)
                        if s then
                            msg("~y~Revive du joueur en cours...")
                            TriggerServerEvent("adminmenu:revive", selectedReport)
                        end
                    end)

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Soigner", "~y~Description~s~: " .. infos.reason, { RightLabel = "→→" }, canUse("revive", permLevel), function(_, _, s)
                        if s then
                            msg("~y~Heal du joueur en cours...")
                            TriggerServerEvent("adminmenu:heal", selectedReport)
                        end
                    end)

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~TP sur lui", nil, { RightLabel = "→→" }, true, function(_, _, s)
                        if s then
                            TriggerServerEvent("adminmenu:goto", selectedReport)
                        end
                    end)
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~TP sur moi", nil, { RightLabel = "→→" }, true, function(_, _, s)
                        if s then
                            TriggerServerEvent("adminmenu:bring", selectedReport, GetEntityCoords(PlayerPedId()))
                        end
                    end)

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~TP Parking Central", "~y~Description~s~: " .. infos.reason, { RightLabel = "→→" }, canUse("tppc", permLevel), function(_, _, s)
                        if s then
                            msg("~y~Téléportation du joueur en cours...")
                            TriggerServerEvent("adminmenu:tppc", selectedReport)
                        end
                    end)

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~y~Actions avancées", "~y~Description~s~: " .. infos.reason.."~n~~q~Attention~s~: Cette action vous fera changer de menu", { RightLabel = "→→" }, GetPlayerServerId(PlayerId()) ~= selectedReport, function(_, _, s)
                        if s then
                            selectedPlayer = selectedReport
                        end
                    end,RMenu:Get(cat,subCat("playersManage")))
                else
                    MowgliUI.Separator("")
                    MowgliUI.Separator(cVar2 .. "Ce report n'est plus valide")
                    MowgliUI.Separator("")
                end
            end, function()
            end, 1)

            MowgliUI.IsVisible(RMenu:Get(cat, subCat("playersManage")), true, true, true, function()
                shouldStayOpened = true
                if not localPlayers[selectedPlayer] then
                    MowgliUI.Separator("")
                    MowgliUI.Separator(cVar2 .. "Ce joueur n'est plus connecté !")
                    MowgliUI.Separator("")
                else
                    statsSeparator()
                    MowgliUI.Separator("Gestion: ~y~" .. localPlayers[selectedPlayer].name .. " ~s~(~o~" .. selectedPlayer .. "~s~)")
                    MowgliUI.Separator("↓ ~g~Téléportation ~s~↓")
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~S'y téléporter", nil, { RightLabel = "→→" }, true, function(_, _, s)
                        if s then
                            TriggerServerEvent("adminmenu:goto", selectedPlayer)
                        end
                    end)
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Téléporter sur moi", nil, { RightLabel = "→→" }, true, function(_, _, s)
                        if s then
                            TriggerServerEvent("adminmenu:bring", selectedPlayer, GetEntityCoords(PlayerPedId()))
                        end
                    end)
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~TP Parking Central", nil, { RightLabel = "→→" }, true, function(_, _, s)
                        if s then
                            msg("~y~Téléportation du joueur en cours...")
                            TriggerServerEvent("adminmenu:tppc", selectedPlayer)
                        end
                    end)
                    MowgliUI.Separator("↓ ~y~Modération ~s~↓")
                    if (IN_SPECTATE) then
                        MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Spectate", nil, { RightLabel = "~g~Activé" }, true, function(_, _, s)
                            if s then
                                if GetEntityCoords(GetPlayerFromServerId(selectedPlayer)).x == 0 then
                                    Wait(50)
                                    SPECTATE_PLAYER(GetPlayerFromServerId(selectedPlayer))
                                else
                                    SPECTATE_PLAYER(GetPlayerFromServerId(selectedPlayer))
                                end
                            end
                        end)
                    else
                        MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Spectate", nil, { RightLabel = "~q~Désactivé" }, true, function(_, _, s)
                            if s then
                                if GetEntityCoords(GetPlayerFromServerId(selectedPlayer)).x == 0 then
                                    Wait(50)
                                    oldCoords = GetEntityCoords(GetPlayerPed(-1))
                                    SPECTATE_PLAYER(GetPlayerFromServerId(selectedPlayer))
                                else
                                    oldCoords = GetEntityCoords(GetPlayerPed(-1))
                                    SPECTATE_PLAYER(GetPlayerFromServerId(selectedPlayer))
                                end
                            end
                        end)
                    end
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Voir l\'inventaire", nil, { RightLabel = "→→" }, canUse("permInventaire", permLevel), function(_, _, s)
                        if s then
                            getPlayerInv(GetPlayerFromServerId(selectedPlayer))
                        end
                    end,RMenu:Get(cat,subCat("playersInventaire")))
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Message", nil, { RightLabel = "→→" }, canUse("mess", permLevel), function(_, _, s)
                        if s then
                            local reason = input("Message", "", 100, false)
                            if reason ~= nil and reason ~= "" then
                                msg("~y~Envoie du message en cours...")
                                TriggerServerEvent("adminmenu:message", selectedPlayer, reason)
                            end
                        end
                    end)
                    --[[MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Jail", nil, { RightLabel = "→→" }, canUse("jail", permLevel), function(_, _, s)
                        if s then
                            local temps = input("Jail", "", 100, false)
                            if temps ~= nil and temps ~= "" then
                                msg("~y~Jail du joueur en cours...")
                                TriggerServerEvent("adminmenu:Jail", selectedPlayer, temps * 60)
                            end
                        end
                    end)
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~UnJail", nil, { RightLabel = "→→" }, canUse("unjail", permLevel), function(_, _, s)
                        if s then
                            msg("~y~UnJail du joueur en cours...")
                            TriggerServerEvent('esx_jail:unjail', selectedPlayer)
                        end
                    end)]]
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Warn", nil, { RightLabel = "→→" }, canUse("warn", permLevel), function(_, _, s)
                        if s then
                            local reason = input("Warn", "", 100, false)
                            if reason ~= nil and reason ~= "" then
                                msg("~y~Envoie du warn en cours...")
                                TriggerServerEvent("adminmenu:warn", selectedPlayer, reason)
                            end
                        end
                    end)
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Kick", nil, { RightLabel = "→→" }, canUse("kick", permLevel), function(_, _, s)
                        if s then
                            local reason = input("Raison", "", 80, false)
                            if reason ~= nil and reason ~= "" then
                                msg("~y~Application de la sanction en cours...")
                                TriggerServerEvent("adminmenu:kick", selectedPlayer, reason)
                            end
                        end
                    end)
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Changer le groupe", nil, { RightLabel = "→→" }, canUse("setGroup", permLevel), function(_, _, s)
                    end, RMenu:Get(cat, subCat("setGroup")))
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Changer le job", nil, { RightLabel = "→→" }, canUse("setJob", permLevel), function(_, _, s)
                    end, RMenu:Get(cat, subCat("setjobMenu")))
                    MowgliUI.Separator("↓ ~o~Personnage ~s~↓")

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Revive", nil, { RightLabel = "→→" }, canUse("revive", permLevel), function(_, _, s)
                        if s then
                            msg("~y~Revive du joueur en cours...")
                            TriggerServerEvent("adminmenu:revive", selectedPlayer)
                        end
                    end)

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Soigner", nil, { RightLabel = "→→" }, canUse("revive", permLevel), function(_, _, s)
                        if s then
                            msg("~y~Heal du joueur en cours...")
                            TriggerServerEvent("adminmenu:heal", selectedPlayer)
                        end
                    end)

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Donner un véhicule", nil, { RightLabel = "→→" }, canUse("vehicles", permLevel), function(Hovered, Active, Selected)
                        if Selected then
                            local veh = CustomString()
                            if veh ~= nil then
                                if veh == "rt70" then msg("C'est la voiture à diego") return end
                                local model = GetHashKey(veh)
                                if IsModelValid(model) then
                                    RequestModel(model)
                                    while not HasModelLoaded(model) do
                                        Wait(1)
                                    end
                                    TriggerServerEvent("adminmenu:spawnVehicle", model, selectedPlayer)
                                else
                                    msg("Ce modèle n'existe pas")
                                end
                            end
                        end
                    end)

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Clear inventaire", nil, { RightLabel = "→→" }, canUse("clearInventory", permLevel), function(_, _, s)
                        if s then
                            msg("~y~Clear de l'inventaire du joueur en cours...")
                            TriggerServerEvent("adminmenu:clearInv", selectedPlayer)
                        end
                    end)
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Clear armes", nil, { RightLabel = "→→" }, canUse("clearLoadout", permLevel), function(_, _, s)
                        if s then
                            msg("~y~Clear des armes du joueur en cours...")
                            TriggerServerEvent("adminmenu:clearLoadout", selectedPlayer)
                        end
                    end)

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Give un item", nil, { RightLabel = "→→" }, canUse("give", permLevel), function(_, _, s)
                    end, RMenu:Get(cat, subCat("items")))

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Give de l'argent (~g~liquide~s~)", nil, { RightLabel = "→→" }, canUse("giveMoney", permLevel), function(_, _, s)
                        if s then
                            local qty = input("Quantité", "", 20, true)
                            if qty ~= nil then
                                msg("~y~Don de l'argent au joueur...")
                                TriggerServerEvent("adminmenu:addMoney", selectedPlayer, qty)
                            end
                        end
                    end)

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Give de l'argent sale (~g~liquide~s~)", nil, { RightLabel = "→→" }, canUse("giveMoney", permLevel), function(_, _, s)
                        if s then
                            local qty = input("Quantité", "", 20, true)
                            if qty ~= nil then
                                msg("~y~Don de l'argent au joueur...")
                                TriggerServerEvent("adminmenu:addMoneysale", selectedPlayer, qty)
                            end
                        end
                    end)

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Wipe", nil, { RightLabel = "→→" }, canUse("wipe", permLevel), function(_, _, s)
                        if s then
                            msg("~y~Wipe du joueur en cours...")
                            TriggerServerEvent("adminmenu:wipe", selectedPlayer)
                        end
                    end)

                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Wipe véhicules", nil, { RightLabel = "→→" }, canUse("clearvéhicules", permLevel), function(_, _, s)
                        if s then
                            msg("~y~Wipe des véhicules du joueur en cours...")
                            TriggerServerEvent("adminmenu:clearvéhicules", selectedPlayer)
                        end
                    end)

                end
            end, function()
            end, 1)

            MowgliUI.IsVisible(RMenu:Get(cat, subCat("playersInventaire")), true, true, true, function()
                shouldStayOpened = true
                statsSeparator()
                MowgliUI.Separator("↓ ~g~Money ~s~↓")

                for k,v  in pairs(ArgentBank) do
                    MowgliUI.ButtonWithStyle("Argent en banque :", nil, {RightLabel = v.label.."$"}, true, function(_, _, s)
                    end)
                end
    
                for k,v  in pairs(ArgentCash) do
                    MowgliUI.ButtonWithStyle("Argent Liquide :", nil, {RightLabel = v.label.."$"}, true, function(_, _, s)
                    end)
                end
    
                for k,v  in pairs(ArgentSale) do
                    MowgliUI.ButtonWithStyle("Argent sale :", nil, {RightLabel = v.label.."$"}, true, function(_, _, s)
                    end)
                end
        
                MowgliUI.Separator("↓ ~q~Objets ~s~↓")

                for k,v  in pairs(Items) do
                    MowgliUI.ButtonWithStyle(v.label, nil, {RightLabel = "~q~x"..v.right}, true, function(_, _, s)
                    end)
                end

                MowgliUI.Separator("↓ ~o~Armes ~s~↓")
    
                for k,v  in pairs(Armes) do
                    MowgliUI.ButtonWithStyle(v.label, nil, {RightLabel = "avec ~q~"..v.right.. " ~s~balle(s)"}, true, function(_, _, s)
                    end)
                end
            end, function()
            end, 1)

            MowgliUI.IsVisible(RMenu:Get(cat, subCat("items")), true, true, true, function()
                shouldStayOpened = true
                statsSeparator()
                MowgliUI.Separator("Gestion: ~y~" .. localPlayers[selectedPlayer].name .. " ~s~(~o~" .. selectedPlayer .. "~s~)")
                MowgliUI.List("Filtre:", filterArray, filter, nil, {}, true, function(_, _, _, i)
                    filter = i
                end)
                MowgliUI.Separator("↓ ~g~Items disponibles ~s~↓")
                for id, itemInfos in pairs(items) do
                    if starts(itemInfos.label:lower(), filterArray[filter]:lower()) then
                        MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~" .. itemInfos.label, nil, { RightLabel = "~q~Donner ~s~→→" }, true, function(_, _, s)
                            if s then
                                local qty = input("Quantité", "", 20, true)
                                if qty ~= nil then
                                    msg("~y~Give de l'item...")
                                    TriggerServerEvent("adminmenu:give", selectedPlayer, itemInfos.name, qty)
                                end
                            end
                        end)
                    end
                end
            end, function()
            end, 1)

            MowgliUI.IsVisible(RMenu:Get(cat, subCat("setGroup")), true, true, true, function()
                shouldStayOpened = true
                statsSeparator()
                MowgliUI.Separator("Gestion: ~y~" .. localPlayers[selectedPlayer].name .. " ~s~(~o~" .. selectedPlayer .. "~s~)")
                MowgliUI.Separator("↓ ~g~Rangs disponibles ~s~↓")
                for i = 1, #ranksInfos do
                    MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~" .. ranksInfos[i].label, nil, { RightLabel = "~q~Attribuer ~s~→→" }, ranksRelative[permLevel] > i, function(_, _, s)
                        if s then
                            msg("~y~Application du rang...")
                            TriggerServerEvent("adminmenu:setGroup", selectedPlayer, ranksInfos[i].rank)
                        end
                    end)
                end
            end, function()
            end, 1)

            MowgliUI.IsVisible(RMenu:Get(cat, subCat("setjobMenu")), true, true, true, function()
                shouldStayOpened = true
                statsSeparator()

                MowgliUI.Separator("↓ ~g~Jobs disponibles ~s~↓")
    
                for k,v in pairs(allJobsServer) do
                    MowgliUI.ButtonWithStyle(v.LabelSociety, nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                        nameSo = v.NameSociety
                        LabelSo = v.LabelSociety
                        ESX.TriggerServerCallback('finalmenuadmin:getAllGrade', function(allGrade)
                            allGradeForJobSelected = allGrade
                        end, v.NameSociety)
                        end
                    end, RMenu:Get(cat, subCat("setjobMenuSub")))
                end

            end, function()
            end)
    
            MowgliUI.IsVisible(RMenu:Get(cat, subCat("setjobMenuSub")), true, true, true, function()
                shouldStayOpened = true
                statsSeparator()

                MowgliUI.Separator("~y~Job sélectionner : "..LabelSo)
    
                for k,v in pairs(allGradeForJobSelected) do
                    MowgliUI.ButtonWithStyle(v.gradeLabel, nil, {}, true, function(Hovered, Active, Selected)
                        if (Selected) then
                        ESX.ShowNotification("~g~Setjob effectuer !")
                        ExecuteCommand("setjob "..selectedPlayer.." "..nameSo.." "..v.gradeJob)
                        end
                    end)
                end
            
            end, function()
            end)

            MowgliUI.IsVisible(RMenu:Get(cat, subCat("vehicle")), true, true, true, function()
                shouldStayOpened = true
                statsSeparator()
                MowgliUI.Separator("↓ ~g~Apparition ~s~↓")
                MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Spawn un véhicule", nil, { RightLabel = "→→" }, true, function(Hovered, Active, Selected)
                    if Selected then
                        local veh = CustomString()
                        if veh ~= nil then
                            local model = GetHashKey(veh)
                            if IsModelValid(model) then
                                RequestModel(model)
                                while not HasModelLoaded(model) do
                                    Wait(1)
                                end
                                TriggerServerEvent("adminmenu:spawnVehicle", model)
                            else
                                msg("Ce modèle n'existe pas")
                            end
                        end
                    end
                end)
                MowgliUI.Separator("↓ ~y~Gestion ~s~↓")
                MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Supprimer le véhicule", nil, { RightLabel = "→→" }, true, function(Hovered, Active, Selected)
                    if Active then
                        ClosetVehWithDisplay()
                    end
                    if Selected then
                        Citizen.CreateThread(function()
                            local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
                            NetworkRequestControlOfEntity(veh)
                            while not NetworkHasControlOfEntity(veh) do
                                Wait(1)
                            end
                            DeleteEntity(veh)
                            msg("~g~Véhicule supprimé")
                        end)
                    end
                end)
                MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Réparer le véhicule", nil, { RightLabel = "→→" }, true, function(Hovered, Active, Selected)
                    if Active then
                        ClosetVehWithDisplay()
                    end
                    if Selected then
                        local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
                        NetworkRequestControlOfEntity(veh)
                        while not NetworkHasControlOfEntity(veh) do
                            Wait(1)
                        end
                        SetVehicleFixed(veh)
                        SetVehicleDeformationFixed(veh)
                        SetVehicleDirtLevel(veh, 0.0)
                        SetVehicleEngineHealth(veh, 1000.0)
                        msg("~g~Véhicule réparé")
                    end
                end)

                MowgliUI.ButtonWithStyle(cVarLong() .. "→ ~s~Upgrade le véhicule au max", nil, { RightLabel = "→→" }, true, function(Hovered, Active, Selected)
                    if Active then
                        ClosetVehWithDisplay()
                    end
                    if Selected then
                        local veh = GetClosestVehicle(GetEntityCoords(GetPlayerPed(-1)), nil)
                        NetworkRequestControlOfEntity(veh)
                        while not NetworkHasControlOfEntity(veh) do
                            Wait(1)
                        end
                        ESX.Game.SetVehicleProperties(veh, {
                            modEngine = 3,
                            modBrakes = 3,
                            modTransmission = 3,
                            modSuspension = 3,
                            modTurbo = true
                        })
                        msg("~g~Véhicule amélioré")
                    end
                end)
            end, function()
            end, 1)

            if not shouldStayOpened and menuOpen then
                menuOpen = false
                RMenu:Delete(RMenu:Get(cat, subCat("main")))
                RMenu:Delete(RMenu:Get(cat, subCat("players")))
                RMenu:Delete(RMenu:Get(cat, subCat("reports")))
                RMenu:Delete(RMenu:Get(cat, subCat("reports_take")))
                RMenu:Delete(RMenu:Get(cat, subCat("vehicle")))
                RMenu:Delete(RMenu:Get(cat, subCat("playersInventaire")))
                RMenu:Delete(RMenu:Get(cat, subCat("setGroup")))
                RMenu:Delete(RMenu:Get(cat, subCat("items")))
                RMenu:Delete(RMenu:Get(cat, subCat("playersManage")))
            end
            Wait(0)
        end
    end)
end

SPECTATE_PLAYER = function(_player)
    local targetPed = GetPlayerPed(_player)

    IN_SPECTATE = not IN_SPECTATE

    if IN_SPECTATE then
        local targetx, targety, targetz = table.unpack(GetEntityCoords(targetPed, false))
        RequestCollisionAtCoord(targetx, targety, targetz)
        NetworkSetInSpectatorMode(true, targetPed)
        WHILE_SPECTATE()
    else
        local targetx, targety, targetz = table.unpack(GetEntityCoords(targetPed, false))
        RequestCollisionAtCoord(targetx, targety, targetz)
        NetworkSetInSpectatorMode(false, targetPed)
        SetEntityVisible(PlayerPedId(), true, 0)
        FreezeEntityPosition(PlayerPedId(), false)
        SetEntityCoords(PlayerPedId(), oldCoords, false)
        SetEntityCollision(PlayerPedId(), true, true)
    end
end

WHILE_SPECTATE = function()
    Citizen.CreateThread(function()
        while IN_SPECTATE do
            local p = GetPlayerFromServerId(selectedPlayer)
            local ped = GetPlayerPed(p)
            local coords = GetEntityCoords((ped), false)
            SetEntityVisible(PlayerPedId(), false, 0)
            FreezeEntityPosition(PlayerPedId(), false)
            SetEntityCoords(PlayerPedId(), coords + 0.5, false)
            FreezeEntityPosition(PlayerPedId(), true)
            SetEntityNoCollisionEntity(ped, GetPlayerPed(-1), true)
            Wait(10)
        end
    end)
end