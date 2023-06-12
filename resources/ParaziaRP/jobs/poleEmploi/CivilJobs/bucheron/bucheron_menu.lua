
Citizen.CreateThread(function()
    BucheronMenu.Main = false
    RMenu.Add('Bucheron', 'main', MowgliUI.CreateMenu("", "Bûcheron"))
    RMenu:Get('Bucheron', 'main'):SetSubtitle("~q~Manager des bûcherons")
    RMenu:Get('Bucheron', 'main').EnableMouse = false;
    RMenu:Get("Bucheron", "main").Closed = function() BucheronMenu.Main = false FreezeEntityPosition(PlayerPedId(), false) end
end)
BucheronMenu = {
    Main = false,
}
local tafb = false
local taf2b = true
function openBucheronMenu()
    if BucheronMenu.Main then
        BucheronMenu.Main = false
    else
        BucheronMenu.Main = true
        FreezeEntityPosition(PlayerPedId(), true)
        MowgliUI.Visible(RMenu:Get('Bucheron', 'main'), true)
        Citizen.CreateThread(function()
            while BucheronMenu.Main do     
                MowgliUI.IsVisible(RMenu:Get("Bucheron","main"),true,true,true,function()   
                   MowgliUI.ButtonWithStyle("Demander à travailler sur le chantier", nil, {}, not tafb,function(h,a,s)
                        if s then
                            tafb = true
                            taf2b = false
                            MowgliUI.Popup({
                                message = "Alors comme ça tu veu bosser pour les ~g~bucherons~w~ hein ? Très bien, met ta tenue .",
                            })
                            deleteMenuBucheron()
                            RenderScriptCams(0, 1, 1500, 1, 1)
                            DestroyCam(cam, 1)
                            AuTravaillebucheron = true
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
                            end)]]
                            StartTravaillebucheron()
                        end
                   end)
                   MowgliUI.ButtonWithStyle("Arreter de travailler", nil, {}, not taf2b,function(h,a,s)
                        if s then
                            tafb = false
                            taf2b = true
                            MowgliUI.Popup({
                                message = "haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.",
                            })
                            deleteMenuBucheron()
                            RenderScriptCams(0, 1, 1500, 1, 1)
                            DestroyCam(cam, 1)
                            AuTravaillebucheron = false
                            endwork()
                            --TriggerEvent("LS_LSPD:RemoveVeh", NetworkGetEntityFromNetworkId(vehicle))
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
function deleteMenuBucheron()
    MowgliUI.CloseAll()
    BucheronMenu.Main = false
    FreezeEntityPosition(PlayerPedId(), false)
end