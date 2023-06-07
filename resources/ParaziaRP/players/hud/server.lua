ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

ESX.RegisterServerCallback("nHud:getServPlayer", function(source, cb)
    local Players = {}
    local xPlayers = ESX.GetPlayers();

    for i = 1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i]);
        table.insert(Players, {
            source = xPlayer.source,
        })
    end
    cb(Players)
end)

