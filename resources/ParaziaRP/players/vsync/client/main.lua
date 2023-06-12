
local CurrenWeather = 'EXTRASUNNY'

RegisterNetEvent("Meteo:updateWeather", function(newWeather)
    LoadedMeteo = true
    CurrenWeather = newWeather
end)

lastWeather = 'EXTRASUNNY'

Citizen.CreateThread(function()
    Wait(2500)
    TriggerServerEvent('Meteo:RetrieveCurrentWeather')
    while true do
        Wait(250)
        if lastWeather ~= CurrenWeather then
            lastWeather = CurrenWeather
            SetWeatherTypeOverTime(CurrenWeather, 15.0)
            Citizen.Wait(15000)
        end
        ClearOverrideWeather()
        ClearWeatherTypePersist()
        SetWeatherTypePersist(CurrenWeather)
        SetWeatherTypeNow(CurrenWeather)
        SetWeatherTypeNowPersist(CurrenWeather)
    end
end)