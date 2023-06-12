SouthZones = {
    [1] = vector3(794.49, 3413.99, 62.68),
}

local ZoneInfoSud = SouthZones[1]

RegisterNetEvent('illegalshop:GetPoints')
AddEventHandler('illegalshop:GetPoints', function()
    TriggerClientEvent('illegalshop:ReceivePoints', source, ZoneInfoSud)
end)

RegisterNetEvent('IllegalShop:buyItem')
AddEventHandler('IllegalShop:buyItem', function(item, type)
    if BlackMarket.ListObjetsSecurity[item] == nil then return end
    local xPlayer = ESX.GetPlayerFromId(source)
    if BlackMarket.ListObjetsSecurity[item].type == 'item' then
        if xPlayer.canCarryItem(item, 1) then
            if xPlayer.getAccount('cash').money >= BlackMarket.ListObjetsSecurity[item].price then
                xPlayer.removeAccountMoney('cash', BlackMarket.ListObjetsSecurity[item].price)
                xPlayer.addInventoryItem(item, 1)
                xPlayer.showNotification('Vous avez acheté '..BlackMarket.ListObjetsSecurity[item].label.. ' pour '.. BlackMarket.ListObjetsSecurity[item].price.. '$')
            else
                xPlayer.showNotification('Vous n\'avez pas l\'argent nécéssaire')
            end
        else
            xPlayer.showNotification('Vous avez trop d\'objets sur vous.')
        end
    elseif BlackMarket.ListObjetsSecurity[item].type == 'weapon' then 
        if xPlayer.getAccount('cash').money >= BlackMarket.ListObjetsSecurity[item].price then
            xPlayer.removeAccountMoney('cash', BlackMarket.ListObjetsSecurity[item].price)
            xPlayer.addWeapon(item, 250)
            xPlayer.showNotification('Vous avez acheté '..BlackMarket.ListObjetsSecurity[item].label.. ' pour '.. BlackMarket.ListObjetsSecurity[item].price.. '$')
        else
            xPlayer.showNotification('Vous n\'avez pas l\'argent nécéssaire')
        end
    end
end)

Citizen.CreateThread(function()
    Wait(2000)
    print('POSITION BLACKMARKET SUD : '..ZoneInfoSud)
end)