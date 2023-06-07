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

-- Function --

function applySkinSpecificcorrectionnel(infos)
	TriggerEvent('skinchanger:getSkin', function(skin)
		local uniformObject
		if skin.sex == 0 then
			uniformObject = infos.variations.male
		else
			uniformObject = infos.variations.female
		end
		if uniformObject then
			TriggerEvent('skinchanger:loadClothes', skin, uniformObject)
		end

		infos.onEquip()
	end)
end

-- MENU FUNCTION --

local open = false 
local mainMenu6 = RageUI.CreateMenu('', '~q~Ouverture du cassier..')
mainMenu6.Display.Header = true 
mainMenu6.Closed = function()
  open = false
end

function Vestiairecorrectionnel()
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

              RageUI.Separator("↓ ~q~Tenues Civil ~s~↓")
			
              for _,infos in pairs(cfg_correctionnel.correctionnelCloak.clothes.specials) do
                RageUI.Button(infos.label, nil, {RightLabel = ">"}, true, {
                onSelected = function()
                    servicecorrectionnel = false
                    local info = 'fin'
                    TriggerServerEvent('correctionnel:PriseEtFinservice', info)
                     applySkinSpecificcorrectionnel(infos)
                     for k,v in pairs(cfg_correctionnel.armurie) do
                      for k,v in pairs(v.weapons) do
                      TriggerServerEvent("correctionnel:déposer", v)
                    end
                  end
                  end
                })	
              end

                RageUI.Separator("↓ ~y~Tenues de service ~s~↓")

                for _,infos in pairs(cfg_correctionnel.correctionnelCloak.clothes.grades) do
                  RageUI.Button(infos.label, nil, {RightLabel = ">"}, ESX.PlayerData.job.grade >= infos.minimum_grade, {
                    onSelected = function()
                        servicecorrectionnel = true
                        local info = 'prise'
                        TriggerServerEvent('correctionnel:PriseEtFinservice', info)
                        applySkinSpecificcorrectionnel(infos)
                      end
                    })
                end

            end)
          Wait(0)
         end
      end)
   end
end

Citizen.CreateThread(function()
  while true do
  local wait = 750
      if ESX.PlayerData.job and ESX.PlayerData.job.name == 'correctionnel' then
    for k in pairs(cfg_correctionnel.Position.Vestaire) do
              local plyCoords = GetEntityCoords(GetPlayerPed(-1), false)
              local pos = cfg_correctionnel.Position.Vestaire
              local dist = Vdist(plyCoords.x, plyCoords.y, plyCoords.z, pos[k].x, pos[k].y, pos[k].z)

              if dist <= cfg_correctionnel.MarkerDistance then
                  wait = 0
                  DrawMarker(cfg_correctionnel.MarkerType, pos[k].x, pos[k].y, pos[k].z, 0.0, 0.0, 0.0, 0.0,0.0,0.0, cfg_correctionnel.MarkerSizeLargeur, cfg_correctionnel.MarkerSizeEpaisseur, cfg_correctionnel.MarkerSizeHauteur, cfg_correctionnel.MarkerColorR, cfg_correctionnel.MarkerColorG, cfg_correctionnel.MarkerColorB, cfg_correctionnel.MarkerOpacite, cfg_correctionnel.MarkerSaute, true, p19, cfg_correctionnel.MarkerTourne)  
              end

              if dist <= 1.0 then
                  wait = 0
                  Visual.Subtitle(cfg_correctionnel.TextVestaire, 1)
                  if IsControlJustPressed(1,51) then
                    Vestiairecorrectionnel()
                  end
              end
          end
  end
  Citizen.Wait(wait)
  end
end)