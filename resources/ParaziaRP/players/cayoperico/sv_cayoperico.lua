RegisterServerEvent('cayoperico:buy')
AddEventHandler('cayoperico:buy', function(count, price, name)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    if xPlayer.getAccount('cash').money >= 100 then 
        xPlayer.removeAccountMoney('cash', 100)
        TriggerClientEvent('esx:showNotification', source, "Vous avez acheté un ~q~billet d'avion.")
        TriggerClientEvent('tpisland', source)
    else
        TriggerClientEvent('esx:showNotification', source, "~g~Vous n'avez pas assez d'argent.")
    end
end)