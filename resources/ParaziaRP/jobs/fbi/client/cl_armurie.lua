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

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('', 'Interaction')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  FreezeEntityPosition(PlayerPedId(), false)
  open = false
end

function OpenArmuriefbi()
     if open then 
         open = false
         RageUI.Visible(mainMenu6, false)
         return
     else
         open = true 
         RageUI.Visible(mainMenu6, true)
         CreateThread(function()
         while open do 
            RageUI.IsVisible(mainMenu6,function() 
              
              RageUI.Separator("↓ ~y~   Déposer ses armes  ~s~↓")

                RageUI.Button("~g~Déposer ses armes", nil, {RightLabel = "→→"}, true , {
                  onSelected = function() 
                    for k,v in pairs(cfg_fbi.armurie) do
                      for k,v in pairs(v.weapons) do
                      TriggerServerEvent("fbi:déposer", v)
                    end
                  end
                    end
                  })

                RageUI.Separator("↓ Récupèrer un équipement ↓")
                if servicefbi then
                for k,v in pairs(cfg_fbi.armurie) do
                    RageUI.Button("Équipement ~q~"..v.grade, nil, { RightLabel = "→→" }, ESX.PlayerData.job.grade >= v.minimum_grade, {
                        onSelected = function()
                            for k,v in pairs(v.weapons) do
                                TriggerServerEvent("fbi:equipement", v)
                            end
                            ESX.ShowNotification("Armes de service récupérer.")
                        end,
                    })
                end
              else
                RageUI.Separator("~q~Vous n\'êtes pas en service")
              end

                end)
                Wait(0)
               end
            end)
         end
      end
      

----OUVRIR LE MENU------------

local position = {
	{x = 144.59, y = -761.77, z = 242.15}
}

Citizen.CreateThread(function()
    while true do

      local wait = 750

        for k in pairs(position) do
        if ESX.PlayerData.job and ESX.PlayerData.job.name == 'fbi' then 
            local plyCoords = GetEntityCoords(PlayerPedId(), false)
            local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, position[k].x, position[k].y, position[k].z)

            if dist <= 5.0 then
            wait = 0
            DrawMarker(22, 144.59, -761.77,  242.15, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.3, 0.3, 0.3, 40, 53, 147, 255, true, true, p19, true)  

        
            if dist <= 1.0 then
               wait = 0
                Visual.Subtitle("Appuyer sur ~q~[E]~s~ pour intéragir", 1) 
                if IsControlJustPressed(1,51) then
                  FreezeEntityPosition(PlayerPedId(), true)
                    OpenArmuriefbi()
            end
        end
    end
    end
    Citizen.Wait(wait)
    end
end
end)









