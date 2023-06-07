local ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

RegisterNetEvent('kWhiten') 
AddEventHandler('kWhiten', function(Money, BlackMoney)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    local GetBlackMoney = xPlayer.getAccount('dirtycash').money
    if not xPlayer then
        return
    end
    if Money <= GetBlackMoney then
        xPlayer.removeAccountMoney('dirtycash', BlackMoney)
        xPlayer.addAccountMoney('cash', Money)
        TriggerClientEvent('esx:showNotification', source, "J'ai blanchi ~g~"..BlackMoney.."$~s~ prends ~g~"..Money.."$ propre~s~ et balance pas au flics !")
    end
end)

print("^4KraKss ^7Le blanchisseur à spawn au coordonnées suivantes ^1"..LaundererPos[1].."^7 !")