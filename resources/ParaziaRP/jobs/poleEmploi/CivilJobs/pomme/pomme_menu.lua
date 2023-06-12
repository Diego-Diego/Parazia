
Citizen.CreateThread(function()
    PommeMenu.Main = false
    RMenu.Add('Pomme', 'main', MowgliUI.CreateMenu("", ""))
    RMenu:Get('Pomme', 'main'):SetSubtitle("~q~Manager du champ")
    RMenu:Get('Pomme', 'main').EnableMouse = false;
    RMenu:Get("Pomme", "main").Closed = function() PommeMenu.Main = false FreezeEntityPosition(PlayerPedId(), false) end
end)
PommeMenu = {
    Main = false,
}
local tafp = false
local taf2p = true
function openPommeMenu()
    if PommeMenu.Main then
        PommeMenu.Main = false
    else
        PommeMenu.Main = true
        FreezeEntityPosition(PlayerPedId(), true)
        MowgliUI.Visible(RMenu:Get('Pomme', 'main'), true)
        Citizen.CreateThread(function()
            while PommeMenu.Main do     
                MowgliUI.IsVisible(RMenu:Get("Pomme","main"),true,true,true,function()   
                   MowgliUI.ButtonWithStyle("Demander à travailler sur le champ", nil, {}, not tafp,function(h,a,s)
                        if s then
                            tafp = true
                            taf2p = false
                            MowgliUI.Popup({
                                message = "Alors comme ça tu veu bosser pour le ~g~champ de pommes~w~ hein ? Très bien, vas-y !",
                            })
                            deleteMenuPomme()
                            RenderScriptCams(0, 1, 1500, 1, 1)
                            DestroyCam(cam, 1)
                            AuTravaillePomme = true
                            --[[TriggerEvent('skinchanger:getSkin', function(skin)
                                local clothesSkin = {
                                    ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                                    ['torso_1'] = 66,   ['torso_2'] = 1,
                                    ['decals_1'] = 0,   ['decals_2'] = 0,
                                    ['arms'] = 93,
                                    ['pants_1'] = 39,   ['pants_2'] = 1,
                                    ['shoes_1'] = 24,   ['shoes_2'] = 0,
                                    ['chain_1'] = 0,  ['chain_2'] = 0
                                }
                                TriggerEvent('skinchanger:loadClothes', skin, clothesSkin)
                            end)]]
                            StartTravaillePomme()
                        end
                   end)
                   MowgliUI.ButtonWithStyle("Arreter de travailler", nil, {}, not taf2p,function(h,a,s)
                        if s then
                            tafp = false
                            taf2p = true
                            MowgliUI.Popup({
                                message = "haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.",
                            })
                            deleteMenuPomme()
                            RenderScriptCams(0, 1, 1500, 1, 1)
                            DestroyCam(cam, 1)
                            AuTravaillePomme = false
                            endwork()
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
function deleteMenuPomme()
    MowgliUI.CloseAll()
    PommeMenu.Main = false
    FreezeEntityPosition(PlayerPedId(), false)
end