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

    
function Chestcorrectionnel() 
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
                getStockcorrectionnel()
            end},GetMenu);

            RageUI.Button("Déposer un objet", " ", {RightLabel = "→"}, true, {onSelected = function()
                getInventorycorrectionnel()
            end},PutMenu);

            

        end)

        RageUI.IsVisible(GetMenu, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, " ", {RightLabel = "~g~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput('', '','', 100)
                    count = tonumber(count)
                    if count <= v.nb then
                        TriggerServerEvent("correctionnel:takeStockItems",v.item, count)
                    else
                        ESX.ShowNotification("~q~Vous n'en avez pas assez sur vous")
                    end
                    getStockcorrectionnel()
                end});
            end

        end)

        RageUI.IsVisible(PutMenu, function()
            
            for k,v in pairs(all_items) do
                RageUI.Button(v.label, " ", {RightLabel = "~g~x"..v.nb}, true, {onSelected = function()
                    local count = KeyboardInput('', '','', 100)
                    count = tonumber(count)
                    TriggerServerEvent("correctionnel:putStockItems",v.item, count)
                    getInventorycorrectionnel()
                end});
            end
        end)



        Wait(0)
    end
 end)
 end
 end



function getInventorycorrectionnel()
    ESX.TriggerServerCallback('correctionnel:playerinventory', function(inventory)               
                
        all_items = inventory
        
    end)
end

function getStockcorrectionnel()
    ESX.TriggerServerCallback('correctionnel:getStockItems', function(inventory)               
                
        all_items = inventory

    end)
end


Citizen.CreateThread(function()
    while true do
		local wait = 750
			if ESX.PlayerData.job and ESX.PlayerData.job.name == 'correctionnel' then
				for k in pairs(cfg_correctionnel.Position.Coffre) do
				local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
				local pos = cfg_correctionnel.Position.Coffre
				local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

				if dist <= cfg_correctionnel.MarkerDistance then
					wait = 0
					DrawMarker(cfg_correctionnel.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, cfg_correctionnel.MarkerSizeLargeur, cfg_correctionnel.MarkerSizeEpaisseur, cfg_correctionnel.MarkerSizeHauteur, cfg_correctionnel.MarkerColorR, cfg_correctionnel.MarkerColorG, cfg_correctionnel.MarkerColorB, cfg_correctionnel.MarkerOpacite, cfg_correctionnel.MarkerSaute, true, p19, cfg_correctionnel.MarkerTourne)  
				end

				if dist <= 2.0 then
					wait = 0
					Visual.Subtitle(cfg_correctionnel.TextCoffre, 1)
					if IsControlJustPressed(1,51) then
						Chestcorrectionnel()
					end
				end
			end
		end
    Citizen.Wait(wait)
    end
end)