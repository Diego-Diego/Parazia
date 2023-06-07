TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)


local PlayerInventory, GangInventoryItem, GangInventoryWeapon, PlayerWeapon = {}, {}, {}, {}

local mainMenu = RageUI.CreateMenu("", "Quel actions voulez vous faire")
local PutMenu = RageUI.CreateSubMenu(mainMenu,"", "Choisissez l'objet à déposer")
local GetMenu = RageUI.CreateSubMenu(mainMenu,"", "Choisissez l'objet à prendre")


local open = false

mainMenu:DisplayGlare(false)
mainMenu.Closed = function()
    open = false
end

all_items = {}

    
function Chestfbi() 
    if open then 
		open = false
		RageUI.Visible(mainMenu, false)
		return
	else
		open = true 
		RageUI.Visible(mainMenu, true)
		CreateThread(function()
		while open do 
        RageUI.IsVisible(mainMenu, function()
            RageUI.Button("Prendre un objet", " ", {RightLabel = "→"}, true, {onSelected = function()
                getStockfbi()
            end},GetMenu);

            RageUI.Button("Déposer un objet", " ", {RightLabel = "→"}, true, {onSelected = function()
                getInventoryfbi()
            end},PutMenu);

            

        end)

        RageUI.IsVisible(GetMenu, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, " ", {RightLabel = "~g~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput('', '','', 100)
                    count = tonumber(count)
                    if count <= v.nb then
                        TriggerServerEvent("fbi:takeStockItems",v.item, count)
                    else
                        ESX.ShowNotification("~q~Vous n'en avez pas assez sur vous")
                    end
                    getStockfbi()
                end});
            end

        end)

        RageUI.IsVisible(PutMenu, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, " ", {RightLabel = "~g~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput('', '','', 100)
                    count = tonumber(count)
                    TriggerServerEvent("fbi:putStockItems",v.item, count)
                    getInventoryfbi()
                end});
            end
        end)



        Wait(0)
    end
 end)
 end
 end



function getInventoryfbi()
    ESX.TriggerServerCallback('fbi:playerinventory', function(inventory)               
                
        all_items = inventory
        
    end)
end

function getStockfbi()
    ESX.TriggerServerCallback('fbi:getStockItems', function(inventory)               
                
        all_items = inventory

    end)
end


Citizen.CreateThread(function()
    while true do
		local wait = 750
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' then
				for k in pairs(cfg_fbi.Position.Coffre) do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local pos = cfg_fbi.Position.Coffre
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

				if dist <= cfg_fbi.MarkerDistance then
					wait = 0
					DrawMarker(cfg_fbi.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, cfg_fbi.MarkerSizeLargeur, cfg_fbi.MarkerSizeEpaisseur, cfg_fbi.MarkerSizeHauteur, cfg_fbi.MarkerColorR, cfg_fbi.MarkerColorG, cfg_fbi.MarkerColorB, cfg_fbi.MarkerOpacite, cfg_fbi.MarkerSaute, true, p19, cfg_fbi.MarkerTourne)  
				end

				if dist <= 2.0 then
					wait = 0
					Visual.Subtitle(cfg_fbi.TextCoffre, 1)
					if IsControlJustPressed(1,51) then
						Chestfbi()
					end
				end
			end
		end
    Citizen.Wait(wait)
    end
end)