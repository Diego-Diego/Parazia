local sexIndex = 1
local identityValidate, characterValidate = false, false

function Client:openIdentityMenu()
    local mainMenu = RageUI.CreateMenu('', 'Veuillez saisir vos informations')
    mainMenu.Closable = false

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        Wait(0)

        RageUI.IsVisible(mainMenu, function()
            
            RageUI.Button('~c~→~s~ Prénom', nil, {RightLabel = "~b~"..playerInfo.surname}, true, {
                onSelected = function()
                    local firstname = Client:input("Votre Prénom", "", 15)
                    if firstname ~= nil then
                        TriggerServerEvent(Prefix..':identity:SetFirstName', GetPlayerServerId(PlayerId()), firstname)
                        playerInfo.surname = firstname
                    else
                        ESX.ShowNotification('~g~Il semblerait que vous n\'ayez pas entrer de prénom.')
                    end
                end
            })

            RageUI.Button('~c~→~s~ Nom', nil, {RightLabel = "~b~"..playerInfo.name}, true, {
                onSelected = function()
                    local name = Client:input("Votre Nom", "", 15)
                    if name ~= nil then
                        TriggerServerEvent(Prefix..':identity:SetLastName', GetPlayerServerId(PlayerId()), name)
                        playerInfo.name = name
                    else
                        ESX.ShowNotification('~g~Il semblerait que vous n\'ayez pas entrer de nom.')
                    end
                end
            })

            RageUI.Button('~c~→~s~ Taille', nil, {RightLabel = "~b~"..playerInfo.height}, true, {
                onSelected = function()
                    local height = Client:input("ex : 180", "", 3)
                    if height ~= nil then
                        TriggerServerEvent(Prefix..':identity:SetHeight', GetPlayerServerId(PlayerId()), height)
                        playerInfo.height = height
                    else
                        ESX.ShowNotification('~g~Il semblerait que vous n\'ayez pas entrer de taille.')
                    end
                end
            })

            RageUI.Button('~c~→~s~ Date de naissance', nil, {RightLabel = "~b~"..playerInfo.birthday}, true, {
                onSelected = function()
                    local birthday = Client:input("ex : 01/01/1999", "", 15)
                    if birthday ~= nil then
                        TriggerServerEvent(Prefix..':identity:SetDOB', GetPlayerServerId(PlayerId()), birthday)
                        playerInfo.birthday = birthday
                    else
                        ESX.ShowNotification('~g~Il semblerait que vous n\'ayez pas entrer de date d\'anniversaire.')
                    end
                end
            })

            RageUI.Button('~c~→~s~ Sexe', nil, {RightLabel = "~b~"..playerInfo.sex}, true, {
                onSelected = function()
                    local sex = Client:input("ex : m ou f", "", 1)
                    if sex == "m" then
                        TriggerServerEvent(Prefix..':identity:SetSex', GetPlayerServerId(PlayerId()), sex)
                        playerInfo.sex = sex
                    elseif sex == "f" then
                        TriggerServerEvent(Prefix..':identity:SetSex2', GetPlayerServerId(PlayerId()), sex)
                        playerInfo.sex = sex
                    else
                        ESX.ShowNotification('~b~Création identité~s~\nVous devez spécifier ~y~m~s~ ou ~y~f~s~')
                        sex = ""
                    end
                end
            })

            if playerInfo.surname ~= "" and playerInfo.name ~= "" and playerInfo.height ~= "" and playerInfo.birthday ~= "" and playerInfo.sex ~= "" then
                IdentityValidate = true
            end

            if not IdentityValidate then
                RageUI.Button('Valider & Continuer', '~g~Vous devez remplir toutes les informations ci-dessus pour pouvoir continuer la création du personnage.', {RightBadge = RageUI.BadgeStyle.Tick, Color = { HightLightColor = {209, 31, 46, 160}, BackgroundColor = {209, 31, 46, 160} }}, false, {})
            else
                RageUI.Button('Valider & Continuer', '~c~Prénom : ~q~'..playerInfo.surname..'           ~s~~c~Nom : ~q~'..playerInfo.name..'~s~~n~~c~Taille : ~q~'..playerInfo.height..'~s~~n~~c~Date de naissance : ~q~'..playerInfo.birthday..'~s~~n~~c~Sexe : ~q~'..playerInfo.sex, {RightBadge = RageUI.BadgeStyle.Tick, Color = { HightLightColor = {39, 227, 45, 160}, BackgroundColor = {39, 227, 45, 160} }}, true, {
                    onSelected = function()
                        ESX.ShowNotification('~b~Création perso~s~ \nVous avez créé votre identité.')
                        TriggerEvent('skinchanger:getSkin', function(skin)
                            TriggerServerEvent('esx_skin:save', skin)
                        end)
                        Wait(500)
                        Client:GoCloak()
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
        end
    end
end

RegisterCommand("salut", function()
    Client:openIdentityMenu()
end)

RegisterNetEvent("0TEX0:cmdRegister")
AddEventHandler("0TEX0:cmdRegister", function(player)
    Client:openIdentityMenu()
end)

function Client:openCreatorMenu()
    local mainMenu = RageUI.CreateMenu('', 'Démarrer votre nouvelle aventure.')
    local characterMenu = RageUI.CreateSubMenu(mainMenu, '', 'Faites l\'apparence du personnage.')
    local appearanceMenu = RageUI.CreateSubMenu(characterMenu, '', 'Choisissez votre apparence')
    local outfitMenu = RageUI.CreateSubMenu(characterMenu, '', 'Choisissez votre tenue')
    local accessMenu = RageUI.CreateSubMenu(characterMenu, '', 'Choisissez vos accessoires')

    mainMenu.Closable = false

    local iIndex = {
        visage = {
            iVisage = 1,
            iSkin = 1,
            iHair = 1,
            iBeard = 1,
            iSourcils = 1,
            iEyeColor = 1,
        },
        tenues = {
            Torso1 = 1,
            Torso2 = 1,
            TShirt1 = 1,
            TShirt2 = 1,
            Arms1 = 1,
            Arms2 = 1,
            Pants1 = 1,
            Pants2 = 2,
            Shoes1 = 1,
            Shoes2 = 1,
            Chaine1 = 1,
            Chaine2 = 1,
            Montre1 = 1,
            Montre2 = 1,
            Bracelets1 = 1,
            Bracelets2 = 1,
        },
    }

    local settings = {
        Coiffure = 1,
        Barbe = 1,
        OpaPercentBarbe = 0,
        OpaPercentSourcil = 0,
        ColorCheveux = {
            primary = { 1, 1 },
            secondary = { 1, 1 }
        },
        ColorBarbes = {
            primary = { 1, 1 },
        },
        ColorSourcils = {
            primary = { 1, 1 }
        }
    }

    appearanceMenu.EnableMouse = true;

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        Wait(0)

        RageUI.IsVisible(mainMenu, function()
            Client:CreatePlayerCam()
            FreezeEntityPosition(GetPlayerPed(-1), true)
            
            if not characterValidate then
                RageUI.Button('Créer ma tenue', nil, {}, true, {}, characterMenu)
            else
                RageUI.Button('Créer ma tenue', 'La création de votre personnage a déjà été validée. Désormais veuillez finaliser en continuant ci dessous.', {}, false, {}, characterMenu)
            end

            if not characterValidate then
                RageUI.Button('Valider & Continuer', '~g~Vous devez valider le physique de votre personnage pour pouvoir continuer.', {RightBadge = RageUI.BadgeStyle.Tick, Color = { HightLightColor = {209, 31, 46, 160}, BackgroundColor = {209, 31, 46, 160} }}, false, {})
            else
                RageUI.Button('Valider & Continuer', 'Encore une dernière petite étape et vous pourrez entrer dans notre ville. Vous devez maintenant choisir votre start.', {RightBadge = RageUI.BadgeStyle.Tick, Color = { HightLightColor = {39, 227, 45, 160}, BackgroundColor = {39, 227, 45, 160} }}, true, {
                    onSelected = function()
                        if _Config.StarterPack.enable then
                            Client:openStarterMenu()
                        else
                            Client:openSelectSpawnMenu()
                        end
                    end
                })
            end
        end)

        RageUI.IsVisible(characterMenu, function()
            FreezeEntityPosition(GetPlayerPed(-1), true)
            local Face = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46}
            local Skin = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31,32,33,34,35,36,37,38,39,40,41,42,43,44,45,46}

            

            RageUI.List('~c~→~s~ Sexe', {
                {Name = "Homme", Value = 0},
                {Name = "Femme", Value = 1},
            }, sexIndex, nil, {}, nil, {
                onListChange = function(Index, Item)
                    sexIndex = Index;
                end,
                onSelected = function(Index, Item)
                    TriggerEvent('skinchanger:change', 'sex', Item.Value)
                end,
            })

            RageUI.List('~c~→~s~ Visage', Face, iIndex.visage.iVisage, nil, {}, true, { onListChange = function(Index, Item) iIndex.visage.iVisage = Index TriggerEvent('skinchanger:change', 'face', iIndex.visage.iVisage - 1) end })
            RageUI.List('~c~→~s~ Peau', Skin, iIndex.visage.iSkin, nil, {}, true, { onListChange = function(Index, Item) iIndex.visage.iSkin = Index TriggerEvent('skinchanger:change', 'skin', iIndex.visage.iSkin - 1) end })

            RageUI.Button('~c~→~s~ Apparence', nil, {}, true, {}, appearanceMenu)
            RageUI.Button('~c~→~s~ Habits', nil, {}, true, {}, outfitMenu)
            RageUI.Button('~c~→~s~ Accessoires', nil, {}, true, {}, accessMenu)

            RageUI.Button('Valider le personnage', '~g~Cette action est irréversible.', {RightBadge = RageUI.BadgeStyle.Tick, Color = { HightLightColor = {39, 227, 45, 160}, BackgroundColor = {39, 227, 45, 160} }}, true, {
                onSelected = function()
                    characterValidate = true
                    ESX.ShowNotification('~b~Création perso~s~ \nVous avez validé l\'apparence de votre personnage.')
                    RageUI.GoBack()
                end
            })
        end)

        RageUI.IsVisible(appearanceMenu, function()
            FreezeEntityPosition(GetPlayerPed(-1), true)
            local Coiffure = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 2)-1, 1 do Coiffure[i] = i end
            local Barbes = {} for i = 0 , GetNumHeadOverlayValues(1)-1, 1 do Barbes[i] = i end
            local Sourcils = {} for i = 0 , GetNumHeadOverlayValues(2)-1, 1 do Sourcils[i] = i end
            local CouleurYeux = {1,2,3,4,5,6,7,8,9,10,11,12,13,14,15,16,17,18,19,20,21,22,23,24,25,26,27,28,29,30,31}
            local Rides = {} for i = 0, GetNumHeadOverlayValues(3)-1, 1 do Rides[i] = i end
            local Boutons = {} for i = 0, GetNumHeadOverlayValues(0)-1, 1 do Boutons[i] = i end

            RageUI.List('Cheveux :', Coiffure, iIndex.visage.iHair, nil, {}, true, { onListChange = function(Index, Item) iIndex.visage.iHair = Index TriggerEvent('skinchanger:change', 'hair_1', iIndex.visage.iHair - 1) end })
            RageUI.List('Barbe :', Barbes, iIndex.visage.iBeard, nil, {}, true, { onListChange = function(Index, Item) iIndex.visage.iBeard = Index TriggerEvent('skinchanger:change', 'beard_1', iIndex.visage.iBeard - 1) end })
            RageUI.List('Sourcils :', Sourcils, iIndex.visage.iSourcils, nil, {}, true, { onListChange = function(Index, Item) iIndex.visage.iSourcils = Index TriggerEvent('skinchanger:change', 'eyebrows_1', iIndex.visage.iSourcils - 1) end })
            RageUI.List('Yeux :', CouleurYeux, iIndex.visage.iEyeColor, nil, {}, true, { onListChange = function(Index, Item) iIndex.visage.iEyeColor = Index TriggerEvent('skinchanger:change', 'eye_color', iIndex.visage.iEyeColor - 1) end })

            -- Cheveux
            RageUI.ColourPanel("Couleur principale", RageUI.PanelColour.HairCut, settings.ColorCheveux.primary[1], settings.ColorCheveux.primary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    settings.ColorCheveux.primary[1] = MinimumIndex
                    settings.ColorCheveux.primary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "hair_color_1", settings.ColorCheveux.primary[2])
                end
            }, 1)
            RageUI.ColourPanel("Couleur secondaire", RageUI.PanelColour.HairCut, settings.ColorCheveux.secondary[1], settings.ColorCheveux.secondary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    settings.ColorCheveux.secondary[1] = MinimumIndex
                    settings.ColorCheveux.secondary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "hair_color_2", settings.ColorCheveux.secondary[2])
                end
            }, 1)

            -- barbes
            RageUI.PercentagePanel(settings.OpaPercentBarbe, 'Opacité', '0%', '100%', {
                onProgressChange = function(Percentage)
                    settings.OpaPercentBarbe = Percentage
                    TriggerEvent('skinchanger:change', 'beard_2',Percentage*10)
                end
            }, 2)
            RageUI.ColourPanel("Couleur de barbe", RageUI.PanelColour.HairCut, settings.ColorBarbes.primary[1], settings.ColorBarbes.primary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    settings.ColorBarbes.primary[1] = MinimumIndex
                    settings.ColorBarbes.primary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "beard_3", settings.ColorBarbes.primary[2])
                end
            }, 2)

            -- sourcils
            RageUI.PercentagePanel(settings.OpaPercentSourcil, 'Opacité', '0%', '100%', {
                onProgressChange = function(Percentage)
                    settings.OpaPercentSourcil = Percentage
                    TriggerEvent('skinchanger:change', 'eyebrows_2',Percentage*10)
                end
            }, 3)
            RageUI.ColourPanel("Couleur des sourcils", RageUI.PanelColour.HairCut, settings.ColorSourcils.primary[1], settings.ColorSourcils.primary[2], {
                onColorChange = function(MinimumIndex, CurrentIndex)
                    settings.ColorSourcils.primary[1] = MinimumIndex
                    settings.ColorSourcils.primary[2] = CurrentIndex
                    TriggerEvent("skinchanger:change", "eyebrows_3", settings.ColorSourcils.primary[2])
                end
            }, 3)
        end)


        RageUI.IsVisible(outfitMenu, function()
            FreezeEntityPosition(GetPlayerPed(-1), true)
            local Torso1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 11)-1, 1 do Torso1[i] = i end
            local Torso2 = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), 11, iIndex.tenues.Torso1) - 1, 1 do Torso2[i] = i end
            local TShirt1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 8) - 1, 1 do TShirt1[i] = i end
            local TShirt2 = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), 8, iIndex.tenues.TShirt1) - 1, 1 do TShirt2[i] = i end
            local Arms1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 3) - 1, 1 do Arms1[i] = i end
            local Pants1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 4) - 1, 1 do Pants1[i] = i end
            local Pants2 = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), 4, iIndex.tenues.Pants1) - 1, 1 do Pants2[i] = i end
            local Shoes1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 6) - 1, 1 do Shoes1[i] = i end
            local Shoes2 = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), 6, iIndex.tenues.Shoes1) - 1, 1 do Shoes2[i] = i end

            RageUI.List('Torse 1', Torso1, iIndex.tenues.Torso1, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Torso1 = Index iIndex.tenues.Torso2 = 1 TriggerEvent('skinchanger:change', 'torso_1', iIndex.tenues.Torso1 - 1) end, })
            RageUI.List('Torse 2', Torso2, iIndex.tenues.Torso2, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Torso2 = Index TriggerEvent('skinchanger:change', 'torso_2', iIndex.tenues.Torso2 - 1) end, })

            RageUI.List('T-Shirt 1', TShirt1, iIndex.tenues.TShirt1, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.TShirt1 = Index iIndex.tenues.TShirt2 = 1 TriggerEvent('skinchanger:change', 'tshirt_1', iIndex.tenues.TShirt1 - 1) end, })
            RageUI.List('T-Shirt 2', TShirt2, iIndex.tenues.TShirt2, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.TShirt2 = Index TriggerEvent('skinchanger:change', 'tshirt_2', iIndex.tenues.TShirt2 - 1) end, })

            RageUI.List('Bras 1', Arms1, iIndex.tenues.Arms1, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Arms1 = Index iIndex.tenues.Arms2 = 1 TriggerEvent('skinchanger:change', 'arms', iIndex.tenues.Arms1 - 1) end, })
            RageUI.List('Bras 2', {1,2,3,4,5,6,7,8,9,10}, iIndex.tenues.Arms2, nil, {}, true, { onSelected = function() Client:CreateArmsCam() end, onListChange = function(Index, Item) iIndex.tenues.Arms2 = Index TriggerEvent('skinchanger:change', 'arms_2', iIndex.tenues.Arms2 - 1) end, })

            RageUI.List('Pantalon 1', Pants1, iIndex.tenues.Pants1, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Pants1 = Index iIndex.tenues.Pants2 = 1 TriggerEvent('skinchanger:change', 'pants_1', iIndex.tenues.Pants1 - 1) end, })
            RageUI.List('Pantalon 2', Pants2, iIndex.tenues.Pants2, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Pants2 = Index TriggerEvent('skinchanger:change', 'pants_2', iIndex.tenues.Pants2 - 1) end, })

            RageUI.List('Chaussures 1', Shoes1, iIndex.tenues.Shoes1, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Shoes1 = Index iIndex.tenues.Shoes2 = 1 TriggerEvent('skinchanger:change', 'shoes_1', iIndex.tenues.Shoes1 - 1) end, })
            RageUI.List('Chaussures 2', Shoes2, iIndex.tenues.Shoes2, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Shoes2 = Index TriggerEvent('skinchanger:change', 'shoes_2', iIndex.tenues.Shoes2 - 1) end, })
        end)

        RageUI.IsVisible(accessMenu, function()
            FreezeEntityPosition(GetPlayerPed(-1), true)
            local Chaine1 = {} for i = 0 , GetNumberOfPedDrawableVariations(PlayerPedId(), 7) - 1, 1 do Chaine1[i] = i end
            local Chaine2 = {} for i = 0 , GetNumberOfPedTextureVariations(PlayerPedId(), 7, iIndex.tenues.Chaine1) - 1, 1 do Chaine2[i] = i end
            local Montre1 = {} for i = 0 , GetNumberOfPedPropDrawableVariations(PlayerPedId(), 6) - 1, 1 do Montre1[i] = i end
            local Montre2 = {} for i = 0 , GetNumberOfPedPropTextureVariations(PlayerPedId(), 6, iIndex.tenues.Montre1) - 1, 1 do Montre2[i] = i end
            local Bracelets1 = {} for i = 0 , GetNumberOfPedPropDrawableVariations(PlayerPedId(), 7) - 1, 1 do Bracelets1[i] = i end
            local Bracelets2 = {} for i = 0 , GetNumberOfPedPropTextureVariations(PlayerPedId(), 7, iIndex.tenues.Bracelets1) - 1, 1 do Bracelets2[i] = i end

            RageUI.List('Chaine 1', Chaine1, iIndex.tenues.Chaine1, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Chaine1 = Index iIndex.tenues.Chaine2 = 1 TriggerEvent('skinchanger:change', 'chain_1', iIndex.tenues.Chaine1 - 1) end, })
            RageUI.List('Chaine 2', Chaine2, iIndex.tenues.Chaine2, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Chaine2 = Index TriggerEvent('skinchanger:change', 'chain_2', iIndex.tenues.Chaine2 - 1) end, })

            RageUI.List('Montre 1', Montre1, iIndex.tenues.Montre1, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Montre1 = Index iIndex.tenues.Montre2 = 1 TriggerEvent('skinchanger:change', 'watches_1', iIndex.tenues.Montre1 - 1) end, })
            RageUI.List('Montre 2', Montre2, iIndex.tenues.Montre2, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Montre2 = Index TriggerEvent('skinchanger:change', 'watches_2', iIndex.tenues.Montre2 - 1) end, })

            RageUI.List('Bracelets 1', Bracelets1, iIndex.tenues.Bracelets1, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Bracelets1 = Index iIndex.tenues.Bracelets2 = 1 TriggerEvent('skinchanger:change', 'bracelets_1', iIndex.tenues.Bracelets1 - 1) end, })
            RageUI.List('Bracelets 2', Bracelets2, iIndex.tenues.Bracelets2, nil, {}, true, { onListChange = function(Index, Item) iIndex.tenues.Bracelets2 = Index TriggerEvent('skinchanger:change', 'bracelets_2', iIndex.tenues.Bracelets2 - 1) end, })
        end)


        if not RageUI.Visible(mainMenu) and not RageUI.Visible(characterMenu) and not RageUI.Visible(appearanceMenu) and not RageUI.Visible(outfitMenu) and not RageUI.Visible(accessMenu) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            FreezeEntityPosition(GetPlayerPed(-1), false)
            if not _Config.StarterPack.enable then
                Client:KillCam()
            end
        end
    end
end

function Client:openStarterMenu()
    local mainMenu = RageUI.CreateMenu('Starter Pack', 'Choisissez votre kit de départ')
    mainMenu.Closable = false

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        Wait(0)

        RageUI.IsVisible(mainMenu, function()
            FreezeEntityPosition(GetPlayerPed(-1), true)
            
            RageUI.Button('Starter Légal', (('Argent en cash : ~g~%s~s~\nArgent en banque : ~b~%s~s~'):format(_Config.StarterPack.Legal.cashMoney, _Config.StarterPack.Legal.bankMoney)), {}, true, {
                onSelected = function()
                    TriggerServerEvent(Prefix..':setToPlayer:legalstartpack')
                    Client:openSelectSpawnMenu()
                end
            })
            for k, v in pairs(_Config.StarterPack.Illegal.weapon) do
                RageUI.Button('Starter Illégal', (('Argent en sale : ~g~%s~s~\nArgent en banque : ~b~%s~s~\nArme : ~y~%s~s~'):format(_Config.StarterPack.Legal.cashMoney, _Config.StarterPack.Legal.bankMoney, v.label)), {}, true, {
                    onSelected = function()
                        TriggerServerEvent(Prefix..':setToPlayer:illegalstartpack')
                        Client:openSelectSpawnMenu()
                    end
                })
            end
        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
            FreezeEntityPosition(GetPlayerPed(-1), false)
            Client:KillCam()
        end
    end
end

function Client:openSelectSpawnMenu()
    local mainMenu = RageUI.CreateMenu('Spawn', 'Choisissez votre spawn')
    local index = 1
    mainMenu.Closable = false

    RageUI.Visible(mainMenu, not RageUI.Visible(mainMenu))

    while mainMenu do
        Wait(0)

        RageUI.IsVisible(mainMenu, function()
            
            RageUI.List('Choix de spawn :', {
                {Name = 'Centre ville', Position = _Config.Position.centralPoint, Heading = _Config.Position.centralHeading},
                {Name = 'Aéroport', Position = _Config.Position.airportPoint, Heading = _Config.Position.airportHeading},
            }, index, nil, {}, nil, {
                onListChange = function(Index, Item)
                    index = Index;
                end,
                onSelected = function(Index, Item)
                    currentName = Item.Name
                    currentPos = Item.Position
                    currentHeading = Item.Heading
                    Client.EndIdentity()
                end,
            })
            
        end)

        if not RageUI.Visible(mainMenu) then
            mainMenu = RMenu:DeleteType('mainMenu', true)
        end
    end
end