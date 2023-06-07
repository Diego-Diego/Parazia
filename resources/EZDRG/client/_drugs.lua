ESX = nil 

TriggerEvent("sova:KraKss0TEX0", function(obj) ESX = obj end)


local recolteEnCours = false
local traitementEnCours = false
local chargement = 0.0
local chargement1 = 0.0

RegisterNetEvent("::nDrugs::stopRecolte")
AddEventHandler("::nDrugs::stopRecolte", function()
    recolteEnCours = false
    chargement = 0.0
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
end)

RegisterNetEvent("::nDrugs::stopTraitement")
AddEventHandler("::nDrugs::stopTraitement", function()
    traitementEnCours = false
    chargement1 = 0.0
    ClearPedTasksImmediately(PlayerPedId())
    FreezeEntityPosition(PlayerPedId(), false)
end)

function RecolteMenu(v)
    local menu_recolte = RageUI.CreateMenu("RECOLTE", ("Récolte de : %s"):format(v.TypeDeLabo))
    menu_recolte.Closed = function()
        recolteEnCours = false
        chargement = 0.0
        FreezeEntityPosition(PlayerPedId(), false)
    end

    RageUI.Visible(menu_recolte, not RageUI.Visible(menu_recolte))

    while menu_recolte do
        RageUI.IsVisible(menu_recolte, function()
            RageUI.Button("Commencer à récolter", nil, {RightBadge = RageUI.BadgeStyle.GoldMedal}, not recolteEnCours, {
                onSelected = function()
                    FreezeEntityPosition(PlayerPedId(), true)
                    recolteEnCours = true
                    RequestAnimDict(v.AnimDict)
                    TaskPlayAnim(PlayerPedId(), v.AnimDict, v.PlayAnim, 1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
                end
            })
            RageUI.Line()
            RageUI.Button("Stopper la récolte", nil, {RightBadge = RageUI.BadgeStyle.Alert}, recolteEnCours, {
                onSelected = function()
                    FreezeEntityPosition(PlayerPedId(), false)
                    recolteEnCours = false
                    chargement = 0.0
                    ClearPedTasksImmediately(PlayerPedId())
                end
            })
            if recolteEnCours then
                RageUI.PercentagePanel(chargement, "Récolte de "..v.TypeDeLabo.." en cours : ~g~"..math.floor(chargement*100).."%", "", "", {})
              
                if chargement < 1.0 then
                    chargement = chargement + v.RecolteSpeed
                else 
                    chargement = 0
                end

                if chargement >= 1.0 then
                    TriggerServerEvent("::nDrugs::recolte", v)
                end
            end
        end)
        if not RageUI.Visible(menu_recolte) then
            menu_recolte = RMenu:DeleteType("menu_recolte", true)
        end
        Wait(1)
    end
end

function TraitementMenu(v)
    local menu_traitement = RageUI.CreateMenu("TRAITEMENT", ("Traitement de : %s"):format(v.TypeDeLabo))
    menu_traitement.Closed = function()
        traitementEnCours = false
        chargement1 = 0.0
    end
    RageUI.Visible(menu_traitement, not RageUI.Visible(menu_traitement))

    while menu_traitement do
        RageUI.IsVisible(menu_traitement, function()
            RageUI.Button("Commencer le traitement", nil, {RightBadge = RageUI.BadgeStyle.GoldMedal}, not traitementEnCours, {
                onSelected = function()
                    RequestAnimDict(v.AnimDictTrait)
                    TaskPlayAnim(PlayerPedId(), v.AnimDictTrait, v.PlayAnimTrait, 1.0, 1.0, -1, 9, 1.0, 0, 0, 0)
                    FreezeEntityPosition(PlayerPedId(), true)
                    traitementEnCours = true
                end
            })
            RageUI.Line()
            RageUI.Button("Stopper le traitement", nil, {RightBadge = RageUI.BadgeStyle.Alert}, traitementEnCours, {
                onSelected = function()
                    traitementEnCours = false
                    chargement1 = 0.0
                    FreezeEntityPosition(PlayerPedId(), false)
                    ClearPedTasksImmediately(PlayerPedId())
                end
            })
            if traitementEnCours then
                RageUI.PercentagePanel(chargement1, "Traitement de "..v.TypeDeLabo.." en cours : ~g~"..math.floor(chargement1*100).."%", "", "", {})
              
                if chargement1 < 1.0 then
                    chargement1 = chargement1 + v.TraitementSpeed
                else 
                    chargement1 = 0
                end

                if chargement1 >= 1.0 then
                    TriggerServerEvent("::nDrugs::traitement", v)
                end
            end
        end)
        if not RageUI.Visible(menu_traitement) then
            menu_traitement = RMenu:DeleteType("menu_traitement", true)
        end
        Wait(1)
    end
end

function VenteMenu(v)
    local nbSell = "~r~0"
    local sellOk = false
    local menu_vente = RageUI.CreateMenu("TRAITEMENT", ("Traitement de : %s"):format(v.TypeDeLabo))
    menu_vente.Closed = function()
        
    end
    RageUI.Visible(menu_vente, not RageUI.Visible(menu_vente))

    while menu_vente do
        RageUI.IsVisible(menu_vente, function()
            RageUI.Button("Pochon de ~g~"..v.TypeDeLabo.."~s~ à vendre :", nil, {RightLabel = nbSell}, true, {
                onSelected = function()
                    nb = DrugsInput("Pochon de ~g~"..v.TypeDeLabo.."~s~ que vous voulez vendre", "", 5, false)

                    if nb ~= nil and nb ~= "" then
                        nbSell = "~b~"..nb
                        sellOk = true
                    else
                        ESX.ShowNotification("Quantité invalide")
                    end
                end
            })
            RageUI.Line()
            RageUI.Button("Valider la vente", nil, {RightBadge = RageUI.BadgeStyle.Alert}, sellOk, {
                onSelected = function()
                    TriggerServerEvent("::nDrugs::sellDrugs", v, tonumber(nb))
                end
            })
        end)
        if not RageUI.Visible(menu_vente) then
            menu_vente = RMenu:DeleteType("menu_vente", true)
        end
        Wait(1)
    end
end

function DrugsInput(TextEntry, ExampleText, MaxStringLenght, isValueInt)
    AddTextEntry('FMMC_KEY_TIP1', TextEntry)
    DisplayOnscreenKeyboard(1, "FMMC_KEY_TIP1", "", ExampleText, "", "", "", MaxStringLenght)
    blockinput = true

    while UpdateOnscreenKeyboard() ~= 1 and UpdateOnscreenKeyboard() ~= 2 do
        Wait(0)
    end

    if UpdateOnscreenKeyboard() ~= 2 then
        local result = GetOnscreenKeyboardResult()
        Wait(500)
        blockinput = false
        if isValueInt then
            local isNumber = tonumber(result)
            if isNumber then
                return result
            else
                return nil
            end
        end

        return result
    else
        Wait(500)
        blockinput = false
        return nil
    end
end
