
ESX = nil
Citizen.CreateThread(function()
     while ESX == nil do
         TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
         Citizen.Wait(0)
     end
     while ESX.GetPlayerData().job == nil do
           Citizen.Wait(10)
     end
     if ESX.IsPlayerLoaded() then
           ESX.PlayerData = ESX.GetPlayerData()
     end
end)
PoleEmploi = {
     menu = false,
     CivilJobs = {
          {jobLabel = "Bûcheron", waypoint = vector2(-570.853, 5367.214)},
          {jobLabel = "Ouvrier", waypoint = vector2(-509.94, -1001.59)},
          {jobLabel = "Mineur", waypoint = vector2(2831.689, 2798.311)},
          {jobLabel = "Récolte d'orange", waypoint = vector2(2304.62, 5035.64)}
     },
     Pos = {
          Chantier = {
               {poscht = vector3(-509.94, -1001.59, 23.55)}
          },
          Bucheron = {
               {posbch = vector3(-570.853, 5367.214, 70.21643)}
          },
          Orange = {
               {posorg = vector3(2304.29, 5036.07, 44.29)}
          },
          Mine = {
               {posmine = vector3(2831.689, 2798.311, 57.49803)}
          },
          Jardin = {
               {posjdr = vector3(-1347.78, 113.09, 56.37)}
          }
     }
}

Citizen.CreateThread(function()
     while true do
          local pCoords2 = GetEntityCoords(GetPlayerPed(-1))
          local activerfps = false
          for k,v in pairs(PoleEmploi.Pos.Mine) do
               if #(pCoords2 - v.posmine) < 1.0 then
                       activerfps = true
                       MowgliUI.Text({ message = "Appuyer sur ~q~E~s~ pour parler au ~o~Chef des ouvriers", time_display = 1, })
                       if IsControlJustReleased(1, 51) then
                         openMineMenu()
                       end
               elseif #(pCoords2 - v.posmine) < 5.0 then
                       activerfps = true
                       DrawMarker(-1, v.posmine, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 254, 158, 0, 120, true, true, p19, true)
               end
          end
          for k,v in pairs(PoleEmploi.Pos.Jardin) do
               if #(pCoords2 - v.posjdr) < 1.0 then
                       activerfps = true
                       MowgliUI.Text({ message = "Appuyer sur ~q~E~s~ pour parler au ~o~Chef des jardiniers", time_display = 1, })
                       if IsControlJustReleased(1, 51) then
                         openJardinierMenu()
                       end
               elseif #(pCoords2 - v.posjdr) < 5.0 then
                       activerfps = true
                       DrawMarker(-1, v.posjdr, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 254, 158, 0, 120, true, true, p19, true)
               end
          end
          for k,v in pairs(PoleEmploi.Pos.Orange) do
               if #(pCoords2 - v.posorg) < 1.0 then
                       activerfps = true
                       MowgliUI.Text({ message = "Appuyer sur ~q~E~s~ pour parler au ~o~Chef du champ", time_display = 1, })
                       if IsControlJustReleased(1, 51) then
                         openPommeMenu()
                       end
               elseif #(pCoords2 - v.posorg) < 5.0 then
                       activerfps = true
                       DrawMarker(-1, v.posorg, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 254, 158, 0, 120, true, true, p19, true)
               end
          end
          for k,v in pairs(PoleEmploi.Pos.Chantier) do
               if #(pCoords2 - v.poscht) < 1.0 then
                       activerfps = true
                       MowgliUI.Text({ message = "Appuyer sur ~q~E~s~ pour parler au ~o~Chef de chantier", time_display = 1, })
                       if IsControlJustReleased(1, 51) then
                         openChantierMenu()
                       end
               elseif #(pCoords2 - v.poscht) < 5.0 then
                       activerfps = true
                       DrawMarker(-1, v.poscht, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 254, 158, 0, 120, true, true, p19, true)
               end
          end
          for k,v in pairs(PoleEmploi.Pos.Bucheron) do
               if #(pCoords2 - v.posbch) < 1.0 then
                       activerfps = true
                       MowgliUI.Text({ message = "Appuyer sur ~q~E~s~ pour parler au ~o~Chef des bûcherons", time_display = 1, })
                       if IsControlJustReleased(1, 51) then
                         openBucheronMenu()
                       end
               elseif #(pCoords2 - v.posbch) < 5.0 then
                       activerfps = true
                       DrawMarker(-1, v.posbch, 0.0, 0.0, 0.0, 0.0,0.0,0.0, 0.5, 0.5, 0.5, 254, 158, 0, 120, true, true, p19, true)
               end
          end
          if activerfps then
              Wait(1)
          else
              Wait(1800)
          end
      end
end)
function DeleteMenu()
     MowgliUI.CloseAll()
     PoleEmploi.menu = false
     FreezeEntityPosition(PlayerPedId(), false)
end
function GetKJobs()
     getTListjobs = {}
     ESX.TriggerServerCallback("kTeste:getJobs", function(kJobs) 
         for k,v in pairs(kJobs) do
             table.insert(getTListjobs,  {name = v.name, label = v.label,  whitelisted = v.whitelisted}) 
         end
     end)
 end
RegisterNetEvent("sound:Nice")
AddEventHandler("sound:Nice", function()
     PlaySoundFrontend(-1, "Hack_Success", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
end)
RegisterNetEvent("sound:Error")
AddEventHandler("sound:Error", function()
     PlaySoundFrontend(-1, "Hack_Failed", "DLC_HEIST_BIOLAB_PREP_HACKING_SOUNDS", 1)
end)

--[[Citizen.CreateThread(function()
     PoleMenu.Main = false
     RMenu.Add('poleemploi', 'main', MowgliUI.CreateMenu("", "~q~Menu~s~ Pole Emploi"))
     RMenu:Get('poleemploi', 'main').EnableMouse = false;
     RMenu:Get("poleemploi", "main").Closed = function() PoleMenu.Main = false 
     end
end)

PoleMenu = {
     Main = false,
}

function openPoleMenu()
     if PoleMenu.Main then
          PoleMenu.Main = false
     else
          PoleMenu.Main = true
         MowgliUI.Visible(RMenu:Get('poleemploi', 'main'), true)
         Citizen.CreateThread(function()
             while PoleMenu.Main do     
                    MowgliUI.IsVisible(RMenu:Get('poleemploi', 'main'), true, true, true, function()

                         MowgliUI.ButtonWithStyle("~g~Travaillé~s~ : Vigneron", nil, {}, true, function(Hovered, Active, Selected)
                              if (Selected) then
                                   TriggerServerEvent('powx_joblisting:setJobVigneron')
                                   ESX.ShowAdvancedNotification('Pole Emploi', '~q~Annonce Pole Emploi', 'Vous etes désormais ~q~Vigneron.', 'CHAR_SEALIFE', 8)
                              end
                         end)

                         MowgliUI.ButtonWithStyle("~g~Travaillé~s~ : Tabac", nil, {}, true, function(Hovered, Active, Selected)
                              if (Selected) then
                              TriggerServerEvent('powx_joblisting:setJobTabac')
                              ESX.ShowAdvancedNotification('Pole Emploi', '~q~Annonce Pole Emploi', 'Vous etes désormais ~q~Tabac.', 'CHAR_SEALIFE', 8)
                              end
                         end)

                         MowgliUI.ButtonWithStyle("~g~Travaillé~s~ : Brasseur", nil, {}, true, function(Hovered, Active, Selected)
                              if (Selected) then
                              TriggerServerEvent('powx_joblisting:setJobBrasseur')
                              ESX.ShowAdvancedNotification('Pole Emploi', '~q~Annonce Pole Emploi', 'Vous etes désormais ~q~Brasseur.', 'CHAR_SEALIFE', 8)
                              end
                         end)

                         MowgliUI.ButtonWithStyle("~g~Travaillé~s~ : Abatteur", nil, {}, true, function(Hovered, Active, Selected)
                              if (Selected) then
                              TriggerServerEvent('powx_joblisting:setJobAbatteur')
                              ESX.ShowAdvancedNotification('Pole Emploi', '~q~Annonce Pole Emploi', 'Vous etes désormais ~q~Abatteur.', 'CHAR_SEALIFE', 8)
                              end
                         end)

                         MowgliUI.ButtonWithStyle("~g~Travaillé~s~ : Blé", nil, {}, true, function(Hovered, Active, Selected)
                              if (Selected) then
                              TriggerServerEvent('powx_joblisting:setJobBle')
                              ESX.ShowAdvancedNotification('Pole Emploi', '~q~Annonce Pole Emploi', 'Vous etes désormais ~q~Blé.', 'CHAR_SEALIFE', 8)
                              end
                         end)

                         MowgliUI.ButtonWithStyle("~g~Redevenir~s~ : Chômeur", nil, {}, true, function(Hovered, Active, Selected)
                              if (Selected) then
                              TriggerServerEvent('powx_joblisting:setJobChômeur')
                              ESX.ShowAdvancedNotification('Pole Emploi', '~q~Annonce Pole Emploi', 'Vous avais pris désormais votre Depart a la retraite', 'CHAR_SEALIFE', 8)
                              end
                         end)

                    end, function()
                    end)
                    Citizen.Wait(0)
               end
          end)
     end
end

local PoleEmploi = {
     {x = -267.09, y = -959.78, z = 30.22}
} 

Citizen.CreateThread(function()
     while true do
         att = 500
         local pCoords = GetEntityCoords(GetPlayerPed(-1), false)
         for k,v in pairs(PoleEmploi) do
             local mPos = Vdist(pCoords.x, pCoords.y, pCoords.z, PoleEmploi[k].x, PoleEmploi[k].y, PoleEmploi[k].z)
             if not PoleMenu.Main then
                 if mPos <= 10.0 then
                     DrawMarker(23, PoleEmploi[k].x, PoleEmploi[k].y, PoleEmploi[k].z, 0.0, 0.0, 0.0, 0.0, 0.0, 0.0, 0.5, 0.5, 0.5, 0, 89, 255, 170, 0, 0, 0, 1, nil, nil, 0)
                     att = 1
                     if mPos <= 1.4 then
                         ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour parler au Pôle Emploi")
                         if IsControlJustPressed(0, 51) then
                             openPoleMenu()
                         end
                     end
                 end
             end
         end
         Citizen.Wait(att)
     end
 end)]]