local ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

CreateThread(function()
    while true do 
        Wait(impots.time)
        local xPlayers = ESX.GetPlayers()    
        for i = 1, #xPlayers do
            local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
            if (not xPlayer) then return end
            if (xPlayer.job.name == "unemployed") and (xPlayer.job2.name == "unemployed2") then
                if xPlayer.getAccount('bank').money >= impots["unemployed"] then
                    xPlayer.removeAccountMoney('bank', impots["unemployed"])
                    TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "IMPOTS", "ParaziaRP", ("Taxes payées :  %i ~g~$"):format(impots["unemployed"]), "BILLING")                                                         
                end
            end
    
            if (xPlayer.job.name ~= "unemployed") and (xPlayer.job2.name ~= "unemployed2") then
                if xPlayer.getAccount('bank').money >= impots["doubleJob"] then
                    xPlayer.removeAccountMoney('bank', impots["doubleJob"])
                    TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "IMPOTS", "ParaziaRP", ("Taxes payées :  %i ~g~$"):format(impots["doubleJob"]), "BILLING")  
                    return 
                end
            end
    
            if (xPlayer.job.name == "unemployed") and (xPlayer.job2.name ~= "unemployed2") then
                if xPlayer.getAccount('bank').money >= impots["job1"] then
                    xPlayer.removeAccountMoney('bank', impots["job1"])
                    TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "IMPOTS", "ParaziaRP", ("Taxes payées :  %i ~g~$"):format(impots["job1"]), "BILLING")
                    return
                end
            end
    
            if (xPlayer.job.name ~= "unemployed") and (xPlayer.job2.name == "unemployed2") then
                if xPlayer.getAccount('bank').money >= impots["job2"] then
                    xPlayer.removeAccountMoney('bank', impots["job2"])
                    TriggerClientEvent("esx:showAdvancedNotification", xPlayers[i], "IMPOTS", "ParaziaRP", ("Taxes payées :  %i ~g~$"):format(impots["job2"]), "BILLING")  
                    return
                end
            end
        end
        print("^7[KraKss] ^6Impots Payés^7")        
    end
end)

-- local function getItemsFromCfg(name)
--     local isBreaking, isGood, Name, Price
--     for k,v in pairs(Config.Products) do
--         if (name == v.label) then
--             isBreaking ,isGood, Name, Price = true, true, v.name, v.price
--         end
--         if (isBreaking) then break end
--     end
--     return isGood, Name, Price
-- end

-- RegisterNetEvent('ashop:buyProducts', function(label)
--     local xPlayer = ESX.GetPlayerFromId(source)
--     local playerMoney = xPlayer.getMoney()
--     local checkItem, nameItem, priceItem = getItemsFromCfg(label)

--     if (checkItem) then
--         if (playerMoney >= priceItem) then
--             xPlayer.removeMoney(priceItem)
--             xPlayer.addInventoryItem(nameItem)
--         else
--             print('u don\'t have enough money')
--         end
--     else
--         print('item doesn\'t exist')
--     end
-- end)