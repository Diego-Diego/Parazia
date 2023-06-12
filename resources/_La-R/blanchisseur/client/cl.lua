local ESX = nil
local menu = false
TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

local mainMenu = LaundererUI.CreateMenu("Blanchisseur", "Blanchissement") 
mainMenu.EnableMouse = true
mainMenu:DisplayPageCounter(true)

local SliderPannel = {
    Minimum = 0,
    Index = 1,
}

mainMenu.Closed = function() 
    SliderPannel.Index = 1 
    menu = false 
end

function openMenu()
    if menu then menu = false LaundererUI.Visible(mainMenu, false)
    else menu = true LaundererUI.Visible(mainMenu, true)
        CreateThread(function()
            while menu do 
                LaundererUI.IsVisible(mainMenu, function()  
                    LaundererUI.Separator("Le blanchisseur prends ~b~"..Launderer.Percent.."%")   
                    LaundererUI.Separator("Votre Argent sale: ~g~"..ESX.PlayerData.accounts[2].money.." $")                   
                    if ESX.PlayerData.accounts[2].money >= 2 then
                        LaundererUI.Line(93, 182, 229, 255)  
                        LaundererUI.Button('Argent à blanchir', false , {RightLabel = "$"..SliderPannel.Index}, true , {})
                        LaundererUI.Button('Blanchir', false, {RightLabel = "$"..Round(SliderPannel.Index * Launderer.Percentage)}, true, {
                            onSelected = function() 
                                Progress = true
                                FreezeEntityPosition(PlayerPedId(), true)
                                mainMenu.Closable = false
                            end
                        })              
                        LaundererUI.SliderPanel(SliderPannel.Index, SliderPannel.Minimum, "~b~Quantité", ESX.PlayerData.accounts[2].money, {
                            onSliderChange = function(Index)
                                SliderPannel.Index = Index
                            end
                        }, 3)
                        
                        if Progress == true then
                            LaundererUI.PercentagePanel(Launderer.PercentagePannel, '~b~Blanchiment en cours', '', '', {}, 4)
                            if Launderer.PercentagePannel < 1.0 and SliderPannel.Index <= 1000 then
                                Launderer.PercentagePannel = Launderer.PercentagePannel + 0.008 -- durée du chargement en fonction du montant
                            elseif Launderer.PercentagePannel < 1.0 and SliderPannel.Index >= 1000 then
                                Launderer.PercentagePannel = Launderer.PercentagePannel + 0.0008
                            elseif Launderer.PercentagePannel < 1.0 and SliderPannel.Index >= 5000 then
                                Launderer.PercentagePannel = Launderer.PercentagePannel + 0.0003
                            elseif Launderer.PercentagePannel < 1.0 and SliderPannel.Index >= 10000 then
                                Launderer.PercentagePannel = Launderer.PercentagePannel + 0.00005
                            elseif Launderer.PercentagePannel < 1.0 and SliderPannel.Index >= 25000 then
                                Launderer.PercentagePannel = Launderer.PercentagePannel + 0.000004
                            else
                                local FinalPercentage = Round(SliderPannel.Index * Launderer.Percentage)
                                FreezeEntityPosition(PlayerPedId(), false)                                                        
                                TriggerServerEvent('kWhiten', FinalPercentage, SliderPannel.Index) 
                                Launderer.PercentagePannel = 0.0
                                Progress = false
                                mainMenu.Closable = true
                            end
                        end  
                    end                
                end)                
            Wait(0)
            end
        end)
    end
end

Citizen.CreateThread(function()
    local co = GetEntityCoords(PlayerPedId())
    local distPed = GetDistanceBetweenCoords(co, coPed, false)    
    local ped = "u_m_m_streetart_01" 
    RequestModel(ped)    
    while not HasModelLoaded(ped) do
        Citizen.Wait(100)
    end    
    local pedCreated = CreatePed(0, ped, LaundererPos[1], false, false) 
    SetBlockingOfNonTemporaryEvents(pedCreated, true)
    SetEntityInvincible(pedCreated, true)
    FreezeEntityPosition(pedCreated, true)
end) 

function RefreshPlayerData()
    Citizen.CreateThread(function()
        ESX.PlayerData = ESX.GetPlayerData()
    end)
end

Citizen.CreateThread(function()
    while true do
    local wait = 1000
        for k,v in pairs(LaundererPos) do
            local co = GetEntityCoords(PlayerPedId())
            local dist = Vdist(co.x, co.y, co.z, v.x, v.y, v.z)
            
            if dist <= 2 then 
                wait = 0                 
                if IsControlJustPressed(1,51) then                      
                    RefreshPlayerData()
                    openMenu()
                end            
            else 
                LaundererUI.CloseAll()
            end 
        end
        
    Citizen.Wait(wait)
    end
end) 
