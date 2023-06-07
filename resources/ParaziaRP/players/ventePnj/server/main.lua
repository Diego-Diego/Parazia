RegisterNetEvent('NPC:VenteDrugs', function(drugs)
    if drugs == 'Weed' then
        local xPlayer = ESX.GetPlayerFromId(source)
        local QuantityItem = xPlayer.getInventoryItem("weed_pooch").count
        local QuantityBuy = math.random(1,10)
        if QuantityItem >= QuantityBuy then
            local PrixWeed = math.random(250,300)
            local PrixWeedFinal = QuantityBuy * PrixWeed
            xPlayer.removeInventoryItem("weed_pooch", QuantityBuy)
            xPlayer.addAccountMoney('dirtycash', PrixWeedFinal)
            xPlayer.showNotification("Tu as vendu ~q~"..QuantityBuy.. " ~w~pochons de Weed pour ~q~"..PrixWeedFinal.."$")
        else
            xPlayer.showNotification("Le clients voulait plus de drogues que se que tu avais.")
        end
    elseif drugs == 'Coke' then
        local xPlayer = ESX.GetPlayerFromId(source)
        local QuantityItem = xPlayer.getInventoryItem("coke_pooch").count
        local QuantityBuy = math.random(1,10)
        if QuantityItem >= QuantityBuy then
            local PrixCoke = math.random(200,390)
            local PrixCokeFinal = QuantityBuy * PrixCoke
            xPlayer.removeInventoryItem("coke_pooch", QuantityBuy)
            xPlayer.addAccountMoney('dirtycash', PrixCokeFinal)
            xPlayer.showNotification("Tu as vendu ~q~"..QuantityBuy.. " ~w~pochons de Coke pour ~q~"..PrixCokeFinal.."$")
        else
            xPlayer.showNotification("Le clients voulait plus de drogues que se que tu avais.")
        end
    elseif drugs == 'Meth' then
        local xPlayer = ESX.GetPlayerFromId(source)
        local QuantityItem = xPlayer.getInventoryItem("meth_pooch").count
        local QuantityBuy = math.random(1,10)
        if QuantityItem >= QuantityBuy then
            local PrixMeth = math.random(250,450)
            local PrixMethFinal = QuantityBuy * PrixMeth
            xPlayer.removeInventoryItem("meth_pooch", QuantityBuy)
            xPlayer.addAccountMoney('dirtycash', PrixMethFinal)
            xPlayer.showNotification("Tu as vendu ~q~"..QuantityBuy.. " ~w~pochons de Meth pour ~q~"..PrixMethFinal.."$")
        else
            xPlayer.showNotification("Le clients voulait plus de drogues que se que tu avais.")
        end
    elseif drugs == 'Opium' then
        local xPlayer = ESX.GetPlayerFromId(source)
        local QuantityItem = xPlayer.getInventoryItem("opium_pooch").count
        local QuantityBuy = math.random(1,10)
        if QuantityItem >= QuantityBuy then
            local PrixMeth = math.random(300,600)
            local PrixMethFinal = QuantityBuy * PrixMeth
            xPlayer.removeInventoryItem("opium_pooch", QuantityBuy)
            xPlayer.addAccountMoney('dirtycash', PrixMethFinal)
            xPlayer.showNotification("Tu as vendu ~q~"..QuantityBuy.. " ~w~pochons d'opium pour ~q~"..PrixMethFinal.."$")
        else
            xPlayer.showNotification("Le clients voulait plus de drogues que se que tu avais.")
        end
    end
end)

-- Appel LSPD 
RegisterNetEvent("NPCVente:AppelLSPD", function(coords)
    local xPlayers	= ESX.GetPlayers()
    for i=1, #xPlayers, 1 do
        local xPlayer = ESX.GetPlayerFromId(xPlayers[i])
        if xPlayer.job.name == 'police' or xPlayer.job.name == 'sheriff' then
            TriggerClientEvent('NPCVente:AffichageAppel', xPlayers[i], coords)
        end
    end
end)