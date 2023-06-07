Citizen.CreateThread(function()
    while true do
        TriggerServerEvent('ParaziaRP:GetVIP')
        Wait(5000)
    end
end)

IsVip = false

function GetVIP()
    return IsVip
end

RegisterNetEvent('ewen:updateVIP')
AddEventHandler('ewen:updateVIP',function(vip)
    IsVip = vip
end)