ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

RegisterNetEvent("fuel:pay")
AddEventHandler("fuel:pay", function(amount)
    local xPlayer = ESX.GetPlayerFromId(source);
    xPlayer.removeAccountMoney('cash', amount);
    TriggerClientEvent("esx:showNotification", source, "Vous venez de faire un plein pour " .. amount .." €")
end)




RegisterNetEvent("okmec")
AddEventHandler("okmec", function(Weapon)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.addWeapon(Weapon,255)
end)