
Citizen.CreateThread(function()
    MineMenu.Main = false
    RMenu.Add('Mine', 'main', MowgliUI.CreateMenu("", ""))
    RMenu:Get('Mine', 'main'):SetSubtitle("~q~Manager des ouvriers")
    RMenu:Get('Mine', 'main').EnableMouse = false;
    RMenu:Get("Mine", "main").Closed = function() MineMenu.Main = false FreezeEntityPosition(PlayerPedId(), false) end
end)
MineMenu = {
    Main = false,
}
local tafm = false
local taf2m = true
function openMineMenu()
    if MineMenu.Main then
         MineMenu.Main = false
    else
         MineMenu.Main = true
        FreezeEntityPosition(PlayerPedId(), true)
        MowgliUI.Visible(RMenu:Get('Mine', 'main'), true)
        Citizen.CreateThread(function()
            while MineMenu.Main do     
                MowgliUI.IsVisible(RMenu:Get("Mine","main"),true,true,true,function()   
                   MowgliUI.ButtonWithStyle("Demander à travailler sur le Mine", nil, {}, not tafm,function(h,a,s)
                        if s then
                            tafm = true
                            taf2m = false
                            MowgliUI.Popup({
                                message = "Alors comme ça tu veux bosser à la ~g~mine~w~ hein ? Très bien, met ta tenue .",
                            })
                            MowgliUI.Visible(RMenu:Get('mine', 'main'), not MowgliUI.Visible(RMenu:Get('mine', 'main')))
                            RenderScriptCams(0, 1, 1500, 1, 1)
                            DestroyCam(cam, 1)
                            AuTravaillemine = true
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
                            if not ESX.Game.IsSpawnPointClear(vector3(2843.071, 2784.613, 59.94376), 6.0) then
                                local veh = GetClosestVehicle(vector3(2843.071, 2784.613, 59.94376))
                                TriggerEvent("LS_LSPD:RemoveVeh", veh)
                            end
                            ESX.Game.SpawnVehicle(GetHashKey("sadler"), vector3(2843.071, 2784.613, 59.94376), 59.144374847412, function(veh)
                                SetVehicleOnGroundProperly(veh)
                                vehicle = NetworkGetNetworkIdFromEntity(veh)
                            end)
                            StartTravaillemine()
                        end
                   end)
                   MowgliUI.ButtonWithStyle("Arreter de travailler", nil, {}, not taf2m,function(h,a,s)
                        if s then
                            tafm = false
                            taf2m = true
                            MowgliUI.Popup({
                                message = "haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.",
                            })
                            MowgliUI.Visible(RMenu:Get('mine', 'main'), not MowgliUI.Visible(RMenu:Get('mine', 'main')))
                            RenderScriptCams(0, 1, 1500, 1, 1)
                            DestroyCam(cam, 1)
                            AuTravaillemine = false
                            endwork()
                            TriggerEvent("LS_LSPD:RemoveVeh", NetworkGetEntityFromNetworkId(vehicle))
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
function deleteMenuMine()
    MowgliUI.CloseAll()
    MineMenu.Main = false
    FreezeEntityPosition(PlayerPedId(), false)
end