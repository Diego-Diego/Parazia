local ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj)
    ESX = obj
end)

Citizen.CreateThread(function()
    while true do
        TriggerClientEvent("esx:showAdvancedNotification", -1, "DISCORD", "ParaziaRP", utils.messageDiscord , "CHAR_SOVALIFE")
        Citizen.Wait(utils.notifTime * 60000)
        TriggerClientEvent("esx:showAdvancedNotification", -1, "BOUTIQUE", "ParaziaRP", utils.messageBoutique , "CHAR_SOVALIFE")
        Citizen.Wait(utils.notifTime * 60000)
    end
end)

RegisterNetEvent("KraKss:ReviveDeadPlayer")
AddEventHandler("KraKss:ReviveDeadPlayer", function()
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)    
    local xMoney = xPlayer.getAccount("cash").money
    local xBank = xPlayer.getAccount("bank").money
    if xPlayer then
        if xMoney >= utils.healCost then
            xPlayer.removeAccountMoney("cash", utils.reaCost)
            ExecuteCommand("revive ".._src)
            MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = 'society_ambulance'", {}, function(result)
                if result[1] then
                    print("[KRAKSS] "..result[1].money)
                    MySQL.Async.execute("UPDATE addon_account_data SET money = @a WHERE account_name = 'society_ambulance'", {
                        ['a'] = result[1].money + utils.reaCost
                    })
                end
            end)
            TriggerClientEvent("KraKss:updateDeathStatut", _src) 
            TriggerClientEvent("esx:showAdvancedNotification", _src, "ParaziaRP", "MÉDECIN", "Vous avez été réanimé et vous avez payé ~g~"..utils.healCost.."$", "CHAR_EMS")
        elseif xBank >= utils.healCost then
            xPlayer.removeAccountMoney("bank", utils.reaCost) 
            ExecuteCommand("revive ".._src)
            MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = 'society_ambulance'", {}, function(result)
                if result[1] then
                    print("[KRAKSS] "..result[1].money)
                    MySQL.Async.execute("UPDATE addon_account_data SET money = @a WHERE account_name = 'society_ambulance'", {
                        ['a'] = result[1].money + utils.reaCost
                    })
                end
            end)
            TriggerClientEvent("KraKss:updateDeathStatut", _src) 
            TriggerClientEvent("esx:showAdvancedNotification", _src, "ParaziaRP", "MÉDECIN", "Vous avez été réanimé et vous avez payé ~g~"..utils.healCost.."$", "CHAR_EMS")
        else
            TriggerClientEvent("esx:showNotification", _src, "~g~Vous n'avez pas assez d'argent")
        end
    else
        DropPlayer("[KRAKSS] Cheat | discord.gg/ParaziaRP si vous pensez que c'est une erreur")
        return
    end
end)

ESX.RegisterServerCallback("KraKss:healPlayer", function(source, cb)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)    
    local xMoney = xPlayer.getAccount("cash").money
    local xBank = xPlayer.getAccount("bank").money
    local canBeHealed = false
    if xPlayer then
        if xMoney >= utils.healCost then
            xPlayer.removeAccountMoney("cash", utils.healCost)
            TriggerClientEvent("esx:showAdvancedNotification", _src, "ParaziaRP", "MÉDECIN", "Vous avez été soigné et vous avez payé ~g~"..utils.healCost.."$", "CHAR_EMS")
            MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = 'society_ambulance'", {}, function(result)
                if result[1] then
                    print("[KRAKSS] "..result[1].money)
                    MySQL.Async.execute("UPDATE addon_account_data SET money = @a WHERE account_name = 'society_ambulance'", {
                        ['a'] = result[1].money + utils.healCost
                    })
                end
            end)
            canBeHealed = true
        elseif xBank >= utils.healCost then 
            xPlayer.removeAccountMoney("bank", utils.healCost)
            TriggerClientEvent("esx:showAdvancedNotification", _src, "ParaziaRP", "MÉDECIN", "Vous avez été soigné et vous avez payé ~g~"..utils.healCost.."$", "CHAR_EMS")
            MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = 'society_ambulance'", {}, function(result)
                if result[1] then
                    print("[KRAKSS] "..result[1].money)
                    MySQL.Async.execute("UPDATE addon_account_data SET money = @a WHERE account_name = 'society_ambulance'", {
                        ['a'] = result[1].money + utils.healCost
                    })
                end
            end)
            canBeHealed = true
        else
            TriggerClientEvent("esx:showNotification", _src, "~g~Vous n'avez pas assez d'argent")
        end
    else
        return
    end
    cb(canBeHealed)
end)

-- RegisterCommand("modifyVehicleSQL", function() -- commande pour baisser/augmenter le prix des véhicules
--     MySQL.Async.fetchAll("SELECT * FROM vehicles", {}, function(result)
--         for i = 1, #result do
--             if result[i].category ~= "import" then
--                 MySQL.Async.execute("UPDATE vehicles SET price = @a WHERE model = @b", {
--                     ['a'] = 1000000,
--                     ['b'] = result[i].model
--                 })
--             end
--         end
--     end)
-- end)

print("^4KraKss^0 - [^1kCore^0] utils initialized")