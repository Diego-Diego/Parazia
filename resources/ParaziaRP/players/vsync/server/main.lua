
CurrenWeather = 'EXTRASUNNY'

RegisterCommand('WEATHER', function(source,args)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.getGroup() ~= 'user' then
        CurrenWeather = args[1]
        blackout = args[2]
        TriggerClientEvent('Meteo:updateWeather', -1, CurrenWeather)
    end
end)

RegisterNetEvent('Meteo:RetrieveCurrentWeather', function()
    TriggerClientEvent('Meteo:updateWeather', source, CurrenWeather)
end)