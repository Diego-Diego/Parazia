
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

function Menuf6Unicorn()
    local fUnicornf6 = MowgliUI.CreateMenu("", "Interactions")
    MowgliUI.Visible(fUnicornf6, not MowgliUI.Visible(fUnicornf6))
    while fUnicornf6 do
        Citizen.Wait(0)
            MowgliUI.IsVisible(fUnicornf6, true, true, true, function()

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
                                            TriggerServerEvent('esx_billing:sendBill', GetPlayerServerId(player), 'society_unicorn', ('Vanilla Unicorn'), montant)
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
    
                if not MowgliUI.Visible(fUnicornf6) then
                    fUnicornf6 = RMenu:DeleteType("Vanilla Unicorn", true)
        end
    end
end

Keys.Register('F6', 'Unicorn', 'Ouvrir le menu Vanilla Unicorn', function()
	if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then
    	Menuf6Unicorn()
	end
end)

function OpenPrendreMenu()
    local PrendreMenu = MowgliUI.CreateMenu("", "Nos produits")
    PrendreMenu:SetRectangleBanner(147, 112, 219)
        MowgliUI.Visible(PrendreMenu, not MowgliUI.Visible(PrendreMenu))
    while PrendreMenu do
        Citizen.Wait(0)
            MowgliUI.IsVisible(PrendreMenu, true, true, true, function()
            for k,v in pairs(UnicornBar.item) do
            MowgliUI.ButtonWithStyle(v.Label.. '', nil, { }, true, function(Hovered, Active, Selected)
              if (Selected) then
                  TriggerServerEvent('fUnicorn:bar', v.Name)
                end
            end)
        end
                end, function() 
                end)
    
                if not MowgliUI.Visible(PrendreMenu) then
                    PrendreMenu = RMenu:DeleteType("Vanilla Unicorn", true)
        end
    end
end


Citizen.CreateThread(function()
    while true do
        local Timer = 500
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then
        local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
        local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Unicorn.pos.MenuPrendre.position.x, Unicorn.pos.MenuPrendre.position.y, Unicorn.pos.MenuPrendre.position.z)
        if dist3 <= 7.0 and Unicorn.jeveuxmarker then
            Timer = 0
            DrawMarker(20, Unicorn.pos.MenuPrendre.position.x, Unicorn.pos.MenuPrendre.position.y, Unicorn.pos.MenuPrendre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 147, 112, 219, 255, 0, 1, 2, 0, nil, nil, 0)
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



function Coffreunicorn()
    local Cunicorn = MowgliUI.CreateMenu("", "Vanilla Unicorn")
    Cunicorn:SetRectangleBanner(147, 112, 219)
        MowgliUI.Visible(Cunicorn, not MowgliUI.Visible(Cunicorn))
            while Cunicorn do
            Citizen.Wait(0)
            MowgliUI.IsVisible(Cunicorn, true, true, true, function()

                MowgliUI.Separator("↓ Objet / Arme ↓")

                    MowgliUI.ButtonWithStyle("Retirer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            UnicornRetirerobjet()
                            MowgliUI.CloseAll()
                        end
                    end)
                    
                    MowgliUI.ButtonWithStyle("Déposer",nil, {RightLabel = ""}, true, function(Hovered, Active, Selected)
                        if Selected then
                            UnicornDeposerobjet()
                            MowgliUI.CloseAll()
                        end
                    end)
                end, function()
                end)
            if not MowgliUI.Visible(Cunicorn) then
            Cunicorn = RMenu:DeleteType("Cunicorn", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then
            local plycrdjob = GetEntityCoords(GetPlayerPed(-1), false)
            local jobdist = Vdist(plycrdjob.x, plycrdjob.y, plycrdjob.z, Unicorn.pos.coffre.position.x, Unicorn.pos.coffre.position.y, Unicorn.pos.coffre.position.z)
            if jobdist <= 10.0 and Unicorn.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Unicorn.pos.coffre.position.x, Unicorn.pos.coffre.position.y, Unicorn.pos.coffre.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 147, 112, 219, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if jobdist <= 1.0 then
                    Timer = 0
                        MowgliUI.Text({ message = "Appuyez sur ~q~[E]~s~ pour accéder au coffre", time_display = 1 })
                        if IsControlJustPressed(1,51) then
                        Coffreunicorn()
                    end   
                end
            end 
        Citizen.Wait(Timer)   
    end
end)


-- Garage

function GarageUnicorn()
  local GUnicorn = MowgliUI.CreateMenu("", "Vanilla Unicorn")
  GUnicorn:SetRectangleBanner(147, 112, 219)
    MowgliUI.Visible(GUnicorn, not MowgliUI.Visible(GUnicorn))
        while GUnicorn do
            Citizen.Wait(0)
                MowgliUI.IsVisible(GUnicorn, true, true, true, function()
                    MowgliUI.ButtonWithStyle("Ranger la voiture", nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then   
                        local veh,dist4 = GetClosestVehicle(playerCoords)
                        if dist4 < 4 then
                            DeleteEntity(veh)
                            MowgliUI.CloseAll()
                            end 
                        end
                    end) 

                    for k,v in pairs(GUnicornvoiture) do
                    MowgliUI.ButtonWithStyle(v.nom, nil, {RightLabel = "→"},true, function(Hovered, Active, Selected)
                        if (Selected) then
                        Citizen.Wait(1)  
                            spawnuniCarUnicorn(v.modele)
                            MowgliUI.CloseAll()
                            end
                        end)
                    end
                end, function()
                end)
            if not MowgliUI.Visible(GUnicorn) then
            GUnicorn = RMenu:DeleteType("Garage", true)
        end
    end
end

Citizen.CreateThread(function()
        while true do
            local Timer = 500
            if ESX.PlayerData.job and ESX.PlayerData.job.name == 'unicorn' then
            local plyCoords3 = GetEntityCoords(GetPlayerPed(-1), false)
            local dist3 = Vdist(plyCoords3.x, plyCoords3.y, plyCoords3.z, Unicorn.pos.garage.position.x, Unicorn.pos.garage.position.y, Unicorn.pos.garage.position.z)
            if dist3 <= 10.0 and Unicorn.jeveuxmarker then
                Timer = 0
                DrawMarker(20, Unicorn.pos.garage.position.x, Unicorn.pos.garage.position.y, Unicorn.pos.garage.position.z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.3, 0.3, 0.3, 147, 112, 219, 255, 0, 1, 2, 0, nil, nil, 0)
                end
                if dist3 <= 3.0 then
                Timer = 0   
                    MowgliUI.Text({ message = "Appuyez sur ~q~[E]~s~ pour accéder au garage", time_display = 1 })
                    if IsControlJustPressed(1,51) then           
                        GarageUnicorn()
                    end   
                end
            end 
        Citizen.Wait(Timer)
     end
end)

function spawnuniCarUnicorn(car)
    local car = GetHashKey(car)

    RequestModel(car)
    while not HasModelLoaded(car) do
        RequestModel(car)
        Citizen.Wait(0)
    end

    local x, y, z = table.unpack(GetEntityCoords(GetPlayerPed(-1), false))
    local vehicle = CreateVehicle(car, Unicorn.pos.spawnvoiture.position.x, Unicorn.pos.spawnvoiture.position.y, Unicorn.pos.spawnvoiture.position.z, Unicorn.pos.spawnvoiture.position.h, true, false)
    SetEntityAsMissionEntity(vehicle, true, true)
    local newPlate = GenerateSocietyPlate('UNICORN')
    SetVehicleNumberPlateText(vehicle, newPlate)
    TriggerServerEvent('garage:RegisterNewKey', newPlate)
    SetPedIntoVehicle(GetPlayerPed(-1),vehicle,-1)
end



itemstock = {}
function UnicornRetirerobjet()
    local Stockunicorn = MowgliUI.CreateMenu("", "Vanilla Unicorn")
    Stockunicorn:SetRectangleBanner(147, 112, 219)
    ESX.TriggerServerCallback('funicorn:getStockItems', function(items) 
    itemstock = items
   
    MowgliUI.Visible(Stockunicorn, not MowgliUI.Visible(Stockunicorn))
        while Stockunicorn do
            Citizen.Wait(0)
                MowgliUI.IsVisible(Stockunicorn, true, true, true, function()
                        for k,v in pairs(itemstock) do 
                            if v.count > 0 then
                            MowgliUI.ButtonWithStyle(v.label, nil, {RightLabel = v.count}, true, function(Hovered, Active, Selected)
                                if Selected then
                                    local count = KeyboardInput("Combien ?", "", "", 2)
                                    TriggerServerEvent('funicorn:getStockItem', v.name, tonumber(count))
                                    UnicornRetirerobjet()
                                end
                            end)
                        end
                    end
                end, function()
                end)
            if not MowgliUI.Visible(Stockunicorn) then
            Stockunicorn = RMenu:DeleteType("Coffre", true)
        end
    end
     end)
end

local PlayersItem = {}
function UnicornDeposerobjet()
    local StockPlayer = MowgliUI.CreateMenu("", "Vanilla Unicorn")
    StockPlayer:SetRectangleBanner(147, 112, 219)
    ESX.TriggerServerCallback('funicorn:getPlayerInventory', function(inventory)
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
                                            local count = KeyboardInput("Combien ?", '' , '', 8)
                                            TriggerServerEvent('funicorn:putStockItems', item.name, tonumber(count))
                                            UnicornDeposerobjet()
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