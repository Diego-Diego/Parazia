ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

ESX.RegisterUsableItem('zetony', function(source)
    local xPlayer  = ESX.GetPlayerFromId(source)
    local nitroquantity = xPlayer.getInventoryItem('zetony').count
    if nitroquantity > 0 then
        TriggerClientEvent('nitro:start', source)
    end
end)

RegisterServerEvent('nitro:removeInventoryItem')
AddEventHandler('nitro:removeInventoryItem', function(item, quantity)
    local xPlayer = ESX.GetPlayerFromId(source)
    xPlayer.removeInventoryItem(item, quantity)
end)
