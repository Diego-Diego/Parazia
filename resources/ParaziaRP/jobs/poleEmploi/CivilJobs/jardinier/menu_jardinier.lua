
Citizen.CreateThread(function()
    JardinierMenu.Main = false
    RMenu.Add('Jardinier', 'main', MowgliUI.CreateMenu("", ""))
    RMenu:Get('Jardinier', 'main'):SetSubtitle("~q~Manager des jardiniers")
    RMenu:Get('Jardinier', 'main').EnableMouse = false;
    RMenu:Get("Jardinier", "main").Closed = function() JardinierMenu.Main = false FreezeEntityPosition(PlayerPedId(), false) end
end)
JardinierMenu = {
    Main = false,
}
local tafj = false
local taf2j = true
local vehicle = nil
local ZoneDeSpawn = vector3(-1336.572, 118.7055, 56.51094)
function openJardinierMenu()
    if JardinierMenu.Main then
         JardinierMenu.Main = false
    else
         JardinierMenu.Main = true
        FreezeEntityPosition(PlayerPedId(), true)
        MowgliUI.Visible(RMenu:Get('Jardinier', 'main'), true)
        Citizen.CreateThread(function()
            while JardinierMenu.Main do     
                MowgliUI.IsVisible(RMenu:Get("Jardinier","main"),true,true,true,function()   
                   MowgliUI.ButtonWithStyle("Demander à travailler sur le Jardin", nil, {}, not tafj,function(h,a,s)
                        if s then
                            tafj = true
                            taf2j = false
                            MowgliUI.Popup({
                                message = "Alors comme ça tu veux bosser sur le ~g~Golf~w~ hein ? Très bien, change toi !",
                            })
                            MowgliUI.Visible(RMenu:Get('Jardinier', 'main'), not MowgliUI.Visible(RMenu:Get('Jardinier', 'main')))
                            RenderScriptCams(0, 1, 1500, 1, 1)
                            DestroyCam(cam, 1)
                            deleteMenuJardinier()
                            AuTravailleJardinier = true
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
                            local spawnRandom = vector3(ZoneDeSpawn.x+math.random(1,15), ZoneDeSpawn.y+math.random(1,15), ZoneDeSpawn.z)
                            ESX.Game.SpawnVehicle(1783355638, spawnRandom, 274.95318603516, function(veh)
                                vehicle = NetworkGetNetworkIdFromEntity(veh)
                                local blip = AddBlipForEntity(veh)
                                SetBlipSprite(blip, 559)
                                SetBlipFlashes(blip, true)
                            end)
                            StartTravailleJardinier()
                        end
                   end)
                   MowgliUI.ButtonWithStyle("Arreter de travailler", nil, {}, not taf2j,function(h,a,s)
                        if s then
                            tafj = false
                            taf2j = true
                            MowgliUI.Popup({
                                message = "haha ! Tu stop déja ! Allez prends ta paye feignant ! Merci de ton aide, revient quand tu veux.",
                            })
                            MowgliUI.Visible(RMenu:Get('Jardinier', 'main'), not MowgliUI.Visible(RMenu:Get('Jardinier', 'main')))
                            RenderScriptCams(0, 1, 1500, 1, 1)
                            DestroyCam(cam, 1)
                            deleteMenuJardinier()
                            AuTravailleJardinier = false
                            ESX.Game.DeleteVehicle(NetworkGetEntityFromNetworkId(vehicle))
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
function deleteMenuJardinier()
    MowgliUI.CloseAll()
    JardinierMenu.Main = false
    FreezeEntityPosition(PlayerPedId(), false)
end