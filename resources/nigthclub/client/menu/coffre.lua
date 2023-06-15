open100 = false
local mainMenu = RageUI.CreateMenu("", "Coffre du ~p~Lux~s~", nil, nil, "root_cause", "ban")
local GetMenu = RageUI.CreateSubMenu(mainMenu, "", "Coffre du ~p~Lux~s~", nil, nil, "root_cause", "ban")
local PutMenu = RageUI.CreateSubMenu(mainMenu, "", "Coffre du ~p~Lux~s~", nil, nil, "root_cause", "ban")

mainMenu.Closed = function()
    open100 = false
end

all_items = {}
function openCoffre()
    if (open100) then
        return
    end
    open100 = true

    RageUI.Visible(mainMenu, true)

    CreateThread(function()
        while (open100) do
            RageUI.IsVisible(mainMenu, function()
                RageUI.Button("Prendre un objet", nil, {RightLabel = "→→→"}, true, {onSelected = function()
                    getStocklux()
                end},GetMenu);
    
                RageUI.Button("Déposer un objet", nil, {RightLabel = "→→→"}, true, {onSelected = function()
                    getInventorylux()
                end},PutMenu);
            end)

            RageUI.IsVisible(GetMenu, function()
                for k,v in pairs(all_items) do
                    RageUI.Button(v.label, nil, {RightLabel = "x~p~"..v.nb}, true, {onSelected = function()
                        local count = KeyboardInput('', '','', 100)
                        count = tonumber(count)
                        if count <= v.nb then
                            TriggerServerEvent("nightclub:getStockItem",v.item, count)
                        else
                            ESX.ShowNotification("~q~Vous n'en avez pas assez sur vous")
                        end
                        getStocklux()
                    end});
                end
            end)
    
            RageUI.IsVisible(PutMenu, function()
                for k,v in pairs(all_items) do
                    RageUI.Button(v.label, nil, {RightLabel = "x~p~"..v.nb}, true, {onSelected = function()
                        local count = KeyboardInput('', '','', 100)
                        count = tonumber(count)
                        TriggerServerEvent("nightclub:putStockItems",v.item, count)
                        getInventorylux()
                    end});
                end    
           end)
           
           Wait(0)
        end
    end)
end

function getInventorylux()
    ESX.TriggerServerCallback('nightclub:getPlayerInventory', function(inventory)
        all_items = inventory
    end)
end

function getStocklux()
    ESX.TriggerServerCallback('nightclub:getStockItems', function(inventory)
        all_items = inventory
    end)
end