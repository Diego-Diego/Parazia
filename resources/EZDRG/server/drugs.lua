ESX = nil 

TriggerEvent("sova:KraKss0TEX0", function(obj) ESX = obj end)

RegisterNetEvent("::nDrugs::recolte")
AddEventHandler("::nDrugs::recolte", function(data)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local nbItems = xPlayer.getInventoryItem(data.NomItem).count

    if nbItems >= data.MaxRecolteItem then
        TriggerClientEvent("esx:showNotification", _src, "Tu n'as plus de place dans ton inventaire")
        TriggerClientEvent("::nDrugs::stopRecolte", _src)
    else
        xPlayer.addInventoryItem(data.NomItem, 1)
    end
end)

RegisterNetEvent("::nDrugs::traitement")
AddEventHandler("::nDrugs::traitement", function(data)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local item1 = xPlayer.getInventoryItem(data.NomItem).count
    local item2 = xPlayer.getInventoryItem(data.ItemTraitement).count

    if item2 > data.MaxTraitementItem then
        TriggerClientEvent("esx:showNotification", _src, "Tu n'as plus de place dans ton inventaire")
        TriggerClientEvent("::nDrugs::stopTraitement", _src)
    elseif item1 < data.NbItemTraitement then
        TriggerClientEvent("esx:showNotification", _src, ("Tu n'as pas asser de %s"):format(data.TypeDeLabo))
        TriggerClientEvent("::nDrugs::stopTraitement", _src)
    else
        xPlayer.removeInventoryItem(data.NomItem, data.NbItemTraitement)
        xPlayer.addInventoryItem(data.ItemTraitement, 1)
    end
end)

RegisterNetEvent("::nDrugs::sellDrugs")
AddEventHandler("::nDrugs::sellDrugs", function(data, amount)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local nbItems = xPlayer.getInventoryItem(data.ItemTraitement).count

    if nbItems >= amount then
        xPlayer.removeInventoryItem(data.ItemTraitement, amount)
        xPlayer.addAccountMoney("dirtycash", data.PrixVente*amount)
        TriggerClientEvent("esx:showNotification", _src, "Tu à vendu ~b~"..amount.."~s~ "..data.TypeDeLabo.." pour ~g~"..data.PrixVente*amount.."$")
    else
        TriggerClientEvent("esx:showNotification", _src, "Tu n'as pas asser de ~g~"..data.TypeDeLabo)
    end
end)