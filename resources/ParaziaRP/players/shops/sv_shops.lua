local listeItem = {
    ['weapon_bat'] = {name = 'weapon_bat', label = 'Batte de Baseball', price = 15000, category = 'Ammu-Nation'},
    ['weapon_nightstick'] = {name = 'weapon_nightstick', label = 'Matraque', price = 15000, category = 'Ammu-Nation'},
    ['weapon_knuckle'] = {name = 'weapon_knuckle', label = 'Poing Américain', price = 15000, category = 'Ammu-Nation'},
    ['weapon_knife'] = {name = 'weapon_knife', label = 'Couteau', price = 15000, category = 'Ammu-Nation'},
    ['weapon_battleaxe'] = {name = 'weapon_battleaxe', label = 'Hache de Combat', price = 15000, category = 'Ammu-Nation'},
    ['weapon_poolcue'] = {name = 'weapon_poolcue', label = 'Queue de billard', price = 15000, category = 'Ammu-Nation'},
    ['weapon_snspistol'] = {name = 'weapon_snspistol', label = 'Pistolet SNS - ~q~Vip', price = 50000, category = 'Ammu-Nation'},
    ['weapon_pistol'] = {name = 'weapon_pistol', label = 'Berreta - ~q~Vip', price = 75000, category = 'Ammu-Nation'},
    ['weapon_pistol50'] = {name = 'weapon_pistol50', label = 'Pistolet 50mm - ~q~Vip', price = 50000, category = 'Ammu-Nation'},
    ['weapon_revolver'] = {name = 'weapon_revolver', label = 'Rvolver - ~q~Vip', price = 75000, category = 'Ammu-Nation'},

    ['clip'] = {name = 'clip', label = 'Chargeur', price = 180, category = 'Munitions'},
    ['pistol_ammo_box'] = {name = 'pistol_ammo_box', label = 'Boite de munitions pistoler', price = 180, category = 'Munitions'},
    ['smg_ammo_box'] = {name = 'smg_ammo_box', label = 'Boite de munitions mitraliette', price = 180, category = 'Munitions'},
    ['rifle_ammo_box'] = {name = 'rifle_ammo_box', label = 'Boite de munitions fusil d\'assault', price = 180, category = 'Munitions'},
    ['shotgun_ammo_box'] = {name = 'shotgun_ammo_box', label = 'Boite de munitions fusil a pompe', price = 180, category = 'Munitions'},

    ['phone'] = {name = 'phone', label = 'Téléphone', price = 150, category = 'Superette'},
    ['burger'] = {name = 'burger', label = 'Hamburger', price = 50, category = 'Superette'},
    ['water'] = {name = 'water', label = 'Eau de source', price = 50, category = 'Superette'},
    ['radio'] = {name = 'radio', label = 'Radio', price = 75, category = 'Superette'},
    ['fishingrod'] = {name = 'fishingrod', label = 'Canne à pêche', price = 25, category = 'Superette'},
    ['fishbait'] = {name = 'fishbait', label = 'Appât de poisson', price = 5, category = 'Superette'},
    ['cafe'] = {name = 'cafe', label = 'Café - VIP ~y~Gold', price = 50, category = 'Superette'},
    ['donut'] = {name = 'donut', label = 'Donut - VIP ~y~Gold', price = 50, category = 'Superette'},
    ['jusleechi'] = {name = 'jusleechi', label = 'Jus de Leechi - VIP ~y~Diamond', price = 50, category = 'Superette'},
    ['hotdog'] = {name = 'hotdog', label = 'Hot-dog - VIP ~y~Diamond', price = 50, category = 'Superette'},
    ['pomme'] = {name = 'pomme', label = 'Pomme', price = 70, category = 'Superette'},
    ['poulet'] = {name = 'poulet', label = 'Poulet', price = 85, category = 'Superette'},
    ['7up'] = {name = '7up', label = '7up', price = 85, category = 'Superette'},
}

RegisterServerEvent('core:achat')
AddEventHandler('core:achat', function(item, price, type)
    local xPlayer = ESX.GetPlayerFromId(source)

    -- if listeItem[item] == nil then
    --     DropPlayer(source, 'Utilisation d\'un Trigger ( LTD )'.. item, price, type)
    -- else
        --if listeItem[item].name == item and listeItem[item].price == tonumber(price) then
    if not xPlayer then
        return
    else
        if type == 1 then
            if xPlayer.getAccount('cash').money >= listeItem[item].price then
                xPlayer.removeAccountMoney('cash', price)
                if listeItem[item].category == "Ammu-Nation" then
                    xPlayer.addWeapon(listeItem[item].name, 25)
                    --xPlayer.addInventoryItem(listeItem[item].name, 1)
                else
                    xPlayer.addInventoryItem(listeItem[item].name, 1)
                end
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~'.. listeItem[item].category.. '~n~~w~Vous avez acheté ~q~'.. listeItem[item].label .. '~w~ pour : '.. listeItem[item].price .. '$')
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~q~Type de paiement : ~w~Liquide') 
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~'.. listeItem[item].category ..'~n~~w~Vous n\'avez pas l\'argent nécéssaire')
            end
        elseif type == 2 then
            if tonumber(xPlayer.getAccount('bank').money) >= price then
                xPlayer.removeAccountMoney('bank', price)
                if listeItem[item].category == "Ammu-Nation" then
                    xPlayer.addWeapon(listeItem[item].name, 25)
                    --xPlayer.addInventoryItem(listeItem[item].name, 1)
                else
                    xPlayer.addInventoryItem(listeItem[item].name, 1)
                end
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~'.. listeItem[item].category.. ' ~n~~w~Vous avez acheté ~q~'.. listeItem[item].label .. '~w~ pour : '.. listeItem[item].price .. '$')
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~q~Type de paiement : ~w~Carte Bancaire')
            else
                TriggerClientEvent('esx:showNotification', xPlayer.source, '~g~'.. listeItem[item].category ..'~n~~w~Vous n\'avez pas l\'argent nécéssaire')
            end
        end
    --  else 
    --     DropPlayer(source, 'Utilisation d\'un Trigger ( LTD )'.. item, price, type)
    -- end
    end
   -- 
end)

RegisterServerEvent('esx_clip:remove')
AddEventHandler('esx_clip:remove', function()
	local xPlayer = ESX.GetPlayerFromId(source)
	xPlayer.removeInventoryItem('clip', 1)
end)

ESX.RegisterUsableItem('clip', function(source)
	TriggerClientEvent('esx_clip:clipcli', source)
end)