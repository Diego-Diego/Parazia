ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

ESX.RegisterServerCallback("barber:getmoney", function(source, cb)
    local xPlayer = ESX.GetPlayerFromId(source)
    if xPlayer.getAccount('cash').money >= 300 then 
        xPlayer.removeAccountMoney('cash', 300)
        cb(true)
    else
        cb(false)
    end
end)