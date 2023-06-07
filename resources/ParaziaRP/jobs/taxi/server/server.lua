TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

TriggerEvent('esx_phone:registerNumber', 'taxi', 'alerte taxi', true, true)

TriggerEvent('esx_society:registerSociety', 'taxi', 'taxi', 'society_taxi', 'society_taxi', 'society_taxi', {type = 'public'})


-- Mission 

RegisterNetEvent("taxi:FinishMission")
AddEventHandler("taxi:FinishMission", function(bonus)
    local xPlayer = ESX.GetPlayerFromId(source)

    if xPlayer.job.name ~= "taxi" then
        TriggerEvent("AC:Violations", 24, "Event: taxi:FinishMission job: "..xPlayer.job.name, source)
        return
    end

    local gain = math.random(70,850) + bonus
    xPlayer.addAccountMoney('bank', gain)

    TriggerEvent('esx_addonaccount:getSharedAccount', 'society_taxi', function(account)
        if account ~= nil then
            societyAccount = account
            societyAccount.addMoney(gain * 2)
        end
    end)

    TriggerClientEvent("esx:showNotification", source, "Vous avez terminé votre mission.\nGain: ~g~"..gain.."~s~€\nGain entreprise: ~g~".. tostring(gain * 2) .."~s~€", "CHAR_FLOYD", 5000, "danger")
end)