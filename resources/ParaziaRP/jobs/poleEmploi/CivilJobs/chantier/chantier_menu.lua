
Citizen.CreateThread(function()
     ChantierMenu.Main = false
     RMenu.Add('Chantier', 'main', MowgliUI.CreateMenu("", ""))
     RMenu:Get('Chantier', 'main'):SetSubtitle("~q~Manager du chantier")
     RMenu:Get('Chantier', 'main').EnableMouse = false;
     RMenu:Get("Chantier", "main").Closed = function() ChantierMenu.Main = false FreezeEntityPosition(PlayerPedId(), false) end
end)
ChantierMenu = {
     Main = false,
}
local tafc = false
local taf2c = true
function openChantierMenu()
     if ChantierMenu.Main then
          ChantierMenu.Main = false
     else
          ChantierMenu.Main = true
         FreezeEntityPosition(PlayerPedId(), true)
         MowgliUI.Visible(RMenu:Get('Chantier', 'main'), true)
         Citizen.CreateThread(function()
             while ChantierMenu.Main do     
                 MowgliUI.IsVisible(RMenu:Get("Chantier","main"),true,true,true,function()   
                    MowgliUI.ButtonWithStyle("Demander à travailler sur le chantier", nil, {}, not tafc,function(h,a,s)
                         if s then
                              tafc = true
                              taf2c = false
                              MowgliUI.Popup({
                                   message = "Alors comme ça tu veux bosser sur le ~g~chantier~w~ hein ? Très bien, met ta tenue .",
                               })
                               RenderScriptCams(0, 1, 1500, 1, 1)
                               DestroyCam(cam, 1)
                               deleteMenuChantier()
                               AuTravailleChantier = true
                               --[[TriggerEvent('skinchanger:getSkin', function(skin)
                                   local clothesSkin = {
                                       ['bags_1'] = 0, ['bags_2'] = 0,
                                           ['tshirt_1'] = 59, ['tshirt_2'] = 0,
                                           ['torso_1'] = 56, ['torso_2'] = 0,
                                           ['arms'] = 30,
                                           ['pants_1'] = 31, ['pants_2'] = 0,
                                           ['shoes_1'] = 25, ['shoes_2'] = 0,
                                           ['mask_1'] = 0, ['mask_2'] = 0,
                                           ['bproof_1'] = 0, ['bproof_2'] = 0,
                                           ['helmet_1'] = 0, ['helmet_2'] = 0,
                                   }
                                   TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                                   tenueWeed = true
                               end)]]
                               StartTravailleChantier()
                         end
                    end)
                    MowgliUI.ButtonWithStyle("Arreter de travailler", nil, {}, not taf2c,function(h,a,s)
                         if s then
                              tafc = false
                              taf2c = true
                              MowgliUI.Popup({
                                   message = "haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.",
                               })
                               deleteMenuChantier()
                               RenderScriptCams(0, 1, 1500, 1, 1)
                               DestroyCam(cam, 1)
                               AuTravailleChantier = false
                               --[[ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
                                   local isMale = skin.sex == 0
                                   TriggerEvent('skinchanger:loadDefaultModel', isMale, function()
                                       ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin)
                                           TriggerEvent('skinchanger:loadSkin', skin)
                                           TriggerEvent('esx:restoreLoadout')
                                       end)
                                   end)
                               end)]]
                         end
                    end)
                 end, function()end, 1)
                 Citizen.Wait(0)
             end
          end)
     end
end
function deleteMenuChantier()
     MowgliUI.CloseAll()
     ChantierMenu.Main = false
     FreezeEntityPosition(PlayerPedId(), false)
end