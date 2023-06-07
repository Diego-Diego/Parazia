
ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

local PlayerData = {}

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
     PlayerData = xPlayer
end)

RegisterNetEvent('esx:setJob')
AddEventHandler('esx:setJob', function(job)  
	PlayerData.job = job  
	Citizen.Wait(5000) 
end)

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
		Citizen.Wait(10)
    end
    while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
    end
    if ESX.IsPlayerLoaded() then

		ESX.PlayerData = ESX.GetPlayerData()

    end
end)

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

function Menuf6Burger()
    local fBurgerf6 = MowgliUI.CreateMenu("", "Interactions")
    fBurgerf6:SetRectangleBanner(153, 50, 204)
    MowgliUI.Visible(fBurgerf6, not MowgliUI.Visible(fBurgerf6))
    while fBurgerf6 do
        Citizen.Wait(0)
            MowgliUI.IsVisible(fBurgerf6, true, true, true, function()

                MowgliUI.Separator("↓ Facture ↓")

                MowgliUI.ButtonWithStyle("Facture",nil, {RightLabel = "→"}, true, function(_,_,s)
                    local player, distance = ESX.Game.GetClosestPlayer()
                    if s then
                        local raison = ""
                        local montant = 0
                        AddTextEntry("FMMC_MPM_NA", "Objet de la facture")
                        DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Donnez le motif de la facture :", "", "", "", "", 30)
                        while (UpdateOnscreenKeyboard() == 0) do
                            DisableAllControlActions(0)
                            Wait(0)
                        end
                        if (GetOnscreenKeyboardResult()) then
                            local result = GetOnscreenKeyboardResult()
                            if result then
                                raison = result
                                result = nil
                                AddTextEntry("FMMC_MPM_NA", "Montant de la facture")
                                DisplayOnscreenKeyboard(1, "FMMC_MPM_NA", "Indiquez le montant de la facture :", "", "", "", "", 30)
                                while (UpdateOnscreenKeyboard() == 0) do
                                    DisableAllControlActions(0)
                                    Wait(0)
                                end
                                if (GetOnscreenKeyboardResult()) then
                                    result = GetOnscreenKeyboardResult()
                                    if result then
                                        montant = result
                                        result = nil
                                        if player ~= -1 and distance <= 3.0 then
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_Burger', ('burger'), montant)
                                            TriggerEvent('esx:showAdvancedNotification', 'Fl~g~ee~s~ca ~g~Bank', 'Facture envoyée : ', 'Vous avez envoyé une facture d\'un montant de : ~g~'..montant.. '$ ~s~pour cette raison : ~q~' ..raison.. '', 'CHAR_BANK_FLEECA', 9)
                                        else
                                            ESX.ShowNotification("~q~Probleme~s~: Aucuns joueurs proche")
                                        end
                                    end
                                end
                            end
                        end
                    end
                end)
                end, function() 
                end)
    
                if not MowgliUI.Visible(fBurgerf6) then
                    fBurgerf6 = RMenu:DeleteType("Burger", true)
        end
    end
end

Keys.Register('F6', 'burger', 'Ouvrir le menu Burger', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'burger' then
    	Menuf6Burger()
	end
end)

function OpenPrendreMenu()
    local PrendreMenu = MowgliUI.CreateMenu("", "Nos produits")
    PrendreMenu:SetRectangleBanner(153, 50, 204)
        MowgliUI.Visible(PrendreMenu, not MowgliUI.Visible(PrendreMenu))
    while PrendreMenu do
        Citizen.Wait(0)
            MowgliUI.IsVisible(PrendreMenu, true, true, true, function()
            for k,v in pairs(BurgerBar.item) do
            MowgliUI.ButtonWithStyle(v.Label.. ' Prix: ' .. v.Price .. '€', nil, { }, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('fBurger:bar', v.Name, v.Price)
                end
            end)
        end
                end, function() 
                end)
    
                if not MowgliUI.Visible(PrendreMenu) then
                    PrendreMenu = RMenu:DeleteType("Burger", true)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'burger' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Burger.pos.MenuPrendre.position.x, Burger.pos.MenuPrendre.position.y, Burger.pos.MenuPrendre.position.z)
        if dist3 <= 7.0 and Burger.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Burger.pos.MenuPrendre.position.x, Burger.pos.MenuPrendre.position.y, Burger.pos.MenuPrendre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 153, 50, 204, 255, 0, 1, 2, 0, nil, nil, 0)
            end
            if dist3 <= 2.0 then
                Timer = 0   
                        MowgliUI.Text({ message = "Appuyez sur ~q~[E]~s~ pour accéder au bar", time_display = 1 })
                        if IsControlJustPressed(1,51) then           
                            OpenPrendreMenu()
                    end   
                end
            end 
        Citizen.Wait(Timer)
    end
end)



function CoffreBurger()
    local CBurger = MowgliUI.CreateMenu("", "Burger")
    CBurger:SetRectangleBanner(153, 50, 204)
        MowgliUI.Visible(CBurger, not MowgliUI.Visible(CBurger))
            while CBurger do
            Citizen.Wait(0)
            MowgliUI.IsVisible(CBurger, true, true, true, function()

                MowgliUI.Separator("↓ Objet / Arme ↓")

                    MowgliUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BurgerRetirerobjet()
                            MowgliUI.CloseAll()
                        end
                    end)
                    
                    MowgliUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            BurgerDeposerobjet()
                            MowgliUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not MowgliUI.Visible(CBurger) then
            CBurger = RMenu:DeleteType("CBurger", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'burger' then
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Burger.pos.coffre.position.x, Burger.pos.coffre.position.y, Burger.pos.coffre.position.z)
            if jobdist <= 10.0 and Burger.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Burger.pos.coffre.position.x, Burger.pos.coffre.position.y, Burger.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 153, 50, 204, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        MowgliUI.Text({ message = "Appuyez sur ~q~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        CoffreBurger()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)


-- Garage

function GarageBurger()
  local GBurger = MowgliUI.CreateMenu("", "Burger")
  GBurger:SetRectangleBanner(153, 50, 204)
    MowgliUI.Visible(GBurger, not MowgliUI.Visible(GBurger))
        while GBurger do
            Citizen.Wait(0)
                MowgliUI.IsVisible(GBurger, true, true, true, function()
                    MowgliUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            MowgliUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GBurgervoiture) do
                    MowgliUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarBurger(v.modele)
                            MowgliUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not MowgliUI.Visible(GBurger) then
            GBurger = RMenu:DeleteType("Garage", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'burger' then
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Burger.pos.garage.position.x, Burger.pos.garage.position.y, Burger.pos.garage.position.z)
            if dist3 <= 10.0 and Burger.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Burger.pos.garage.position.x, Burger.pos.garage.position.y, Burger.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 153, 50, 204, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    MowgliUI.Text({ message = "Appuyez sur ~q~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageBurger()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCarBurger(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Burger.pos.spawnvoiture.position.x, Burger.pos.spawnvoiture.position.y, Burger.pos.spawnvoiture.position.z, Burger.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local newPlate = GenerateSocietyPlate('burger')
    SetVehicleNumberPlateText(vehicle, newPlate)
    TriggerServerEvent('garage:RegisterNewKey', newPlate)
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
end



itemstock = {}
function BurgerRetirerobjet()
    local StockBurger = MowgliUI.CreateMenu("", "Burger")
    StockBurger:SetRectangleBanner(153, 50, 204)
    ESX.TriggerServerCallback('fBurger:getStockItems', function(items) 
    itemstock = items
   
    MowgliUI.Visible(StockBurger, not MowgliUI.Visible(StockBurger))
        while StockBurger do
            Citizen.Wait(0)
                MowgliUI.IsVisible(StockBurger, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            MowgliUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", "", 2)
                                    TriggerServerEvent('fBurger:getStockItem', v.name, tonumber(count))
                                    BurgerRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not MowgliUI.Visible(StockBurger) then
            StockBurger = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function BurgerDeposerobjet()
    local StockPlayer = MowgliUI.CreateMenu("", "Burger")
    StockPlayer:SetRectangleBanner(153, 50, 204)
    ESX.TriggerServerCallback('fBurger:getPlayerInventory', function(inventory)
        MowgliUI.Visible(StockPlayer, not MowgliUI.Visible(StockPlayer))
    while StockPlayer do
        Citizen.Wait(0)
            MowgliUI.IsVisible(StockPlayer, true, true, true, function()
                for i=1, #inventory.items, 1 do
                    if inventory ~= nil then
                         local item = inventory.items[i]
                            if item.count > 0 then
                                        MowgliUI.ButtonWithStyle(item.label, nil, {RightLabel = item.count}, true, function(Hovered, Active, Selected)
                                            if Selected then
                                            local count = KeyboardInput("Combien ?", '' ,'', 8)
                                            TriggerServerEvent('fBurger:putStockItems', item.name, tonumber(count))
                                            BurgerDeposerobjet()
                                        end
                                    end)
                                end
                            else
                                MowgliUI.Separator('Chargement en cours')
                            end
                        end
                    end, function()
                    end)
                if not MowgliUI.Visible(StockPlayer) then
                StockPlayer = RMenu:DeleteType("Coffre", true)
            end
        end
    end)
end