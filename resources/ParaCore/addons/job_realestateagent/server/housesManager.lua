--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRPSHousesManager = {}

ParaziaRPSHousesManager.instanceRange = 1000
ParaziaRPSHousesManager.list = {}

local function addHouse(info, needDecode)
    ---@type House
    local house
    if needDecode then
        house = House(info.id, info.owner, json.decode(info.infos), info.ownerInfo, json.decode(info.inventory), info.street)
    else
        house = House(info.id, info.owner, info.infos, info.ownerInfo, info.inventory, info.street)
    end
    house:initMarker()
    house:initBlips()
    ParaziaRPSHousesManager.list[house.houseId] = house
end

local function loadHouses()
    MySQL.Async.fetchAll("SELECT * FROM paraziarp_houses", {}, function(houses)
        local tot = 0
        for id, info in pairs(houses) do
            tot = tot + 1
            addHouse(info, true)
        end
        print(ParaziaRP.prefix(ParaziaRPPrefixes.house, ("%i maisons importées depuis la db"):format(tot)))
    end)
end

local function createHouse(data, author, street, announce)
    MySQL.Async.insert("INSERT INTO paraziarp_houses (owner, ownerInfo, infos, inventory, createdAt, createdBy, street) VALUES(@a, @b, @c, @d, @e, @f, @g)", {
        ['a'] = "none",
        ['b'] = "none",
        ['c'] = json.encode(data),
        ['d'] = json.encode({}),
        ['e'] = os.time(),
        ['f'] = ParaziaRPServerUtils.getLicense(author),
        ['g'] = street
    }, function(insertId)
        addHouse({ id = insertId, owner = "none", infos = data, ownerInfo = "none", inventory = {}, street }, false)
        ParaziaRPServerUtils.toClient("addAvailableHouse", -1, { id = insertId, coords = data.entry })
        TriggerClientEvent("esx:showNotification", author, "~g~Création de la propriétée effectuée !")
        if announce then ParaziaRPServerUtils.toAll("advancedNotif", "~y~Agence immobilière", "~q~Nouvelle propriétée", ("Une nouvelle propriétée ~s~(~o~%s~s~) est disponible à ~q~%s ~s~pour la somme de ~g~%s$"):format(ParaziaRPInteriors[data.selectedInterior].label, street, ESX.Math.GroupDigits(tonumber(data.price))), "CHAR_MINOTAUR", 1) end
    end)
end

ParaziaRP.netHandle("esxloaded", function()
    loadHouses()
end)

ParaziaRP.netHandle("openPropertyMenu", function(source, propertyID)
    -- TODO -> (AntiCheat) Check la distance
    ---@type House
    local identifier = ESX.GetIdentifierFromId(source)
    local isAllowed = false
    local house = ParaziaRPSHousesManager.list[propertyID]
    for _,v in pairs(house.allowedPlayers) do 
        if v == identifier then
            isAllowed = true
        end
    end
    ParaziaRPServerUtils.toClient("openClientPropertyMenu", source, house.ownerLicense, { house.info.selectedInterior, house.info.price, propertyID, house.ownerInfo }, ParaziaRPServerUtils.getLicense(source), isAllowed, house.public)
end)

ParaziaRP.netRegisterAndHandle("saveProperty", function(info, street, announce)
    -- TODO -> (AntiCheat) Check le job de la source
    local source = source
    createHouse(info, source, street, announce)
end)

ParaziaRP.netRegisterAndHandle("enterHouse", function(houseId, isGuest, from)
    if not ParaziaRPSHousesManager.list[houseId] then
        return
    end
    local source = source
    local identifier = ESX.GetIdentifierFromId(source)
    ---@type House
    local house = ParaziaRPSHousesManager.list[houseId]
    -- TODO -> Faire le système de clés (autoriser d'autres joueurs)
    if not house.public then
        if not isGuest then
            if identifier ~= house.ownerLicense then
                return
            end
        else
            local isAllowed = false
            for _,v in pairs(house.allowedPlayers) do
                if v == identifier then
                    isAllowed = true
                end
            end 
            if not isAllowed then
                return
            end
        end
    end
    house:enter(source, identifier ~= house.ownerLicense, from)
end)

ParaziaRP.netRegisterAndHandle("buyProperty", function(houseId)
    if not ParaziaRPSHousesManager.list[houseId] then
        return
    end
    local source = source
    local xPlayer = ESX.GetPlayerFromId(source)
    local bank = xPlayer.getAccount("bank").money
    ---@type House
    local house = ParaziaRPSHousesManager.list[houseId]
    if house.ownerLicense ~= "none" then
        TriggerClientEvent("esx:showNotification", source, "~q~Cette maison a déjà été achetée !")
        return
    end
    local price = tonumber(house.info.price)
    if bank >= price then
        xPlayer.removeAccountMoney("bank", price)
        --local license = ParaziaRPServerUtils.getLicense(source)
        local identifier = ESX.GetIdentifierFromId(source)
        MySQL.Async.fetchAll("SELECT * FROM users WHERE identifier = @a", {
            ['a'] = identifier
        }, function(res)
            if res[1] then
                MySQL.Async.execute("UPDATE paraziarp_houses SET owner = @a, ownerInfo = @b WHERE id = @c", {
                    ['a'] = identifier,
                    ['b'] = res[1].firstname.." "..res[1].lastname,
                    ['c'] = houseId
                }, function(done)
                    ParaziaRPSHousesManager.list[houseId].ownerLicense = identifier
                    ParaziaRPSHousesManager.list[houseId].ownerInfo = res[1].firstname.." "..res[1].lastname
                    ParaziaRPServerUtils.toClient("addOwnedHouse", source, {id = houseId, coords = house.info.entry})
                    ParaziaRPServerUtils.toClient("advancedNotif", source, "~y~Agence immobilière", "~q~Achat de propriétée", "~g~Félicitations ~s~! Cette propriétée est désormais la votre ! Profitez-en bien.", "CHAR_MINOTAUR", 1)
                    ParaziaRPServerUtils.toAll("houseNoLongerAvailable", houseId)
                end)
                MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = 'society_realestateagent'", {}, function(result)
                    if result[1] then
                        MySQL.Async.execute("UPDATE addon_account_data SET money = @a WHERE account_name = 'society_realestateagent'", {
                            ['a'] = result[1].money + (price / 2)
                        })
                    end
                end)
            end
        end)
        
    else
        ParaziaRPServerUtils.toClient("advancedNotif", source, "~y~Agence immobilière", "~q~Achat de propriétée", "Vous n'avez pas assez d'argent en banque pour acheter cette propriétée !", "CHAR_MINOTAUR", 1)
    end
end)

RegisterCommand("immoMoney", function(source)
    local _src = source
    local xPlayer = ESX.GetPlayerFromId(_src)
    local job = xPlayer.getJob()
    if job.name == "realestateagent" then 
        MySQL.Async.fetchAll("SELECT money FROM addon_account_data WHERE account_name = 'society_realestateagent'", {}, function(result)
            if result[1] then
                TriggerClientEvent("esx:showNotification", _src, "Vous avez ~g~"..ESX.Math.GroupDigits(result[1].money).."$ ~s~dans votre société !")
            else
                TriggerClientEvent("esx:showNotification", _src, "Vous n'avez pas de compte !")            
            end
        end)
    else
        TriggerClientEvent("esx:showNotification", _src, "~p~Vous n'avez pas les droits de regarder l'argent de l'agence immo!")
    end
end)

ParaziaRP.netRegisterAndHandle("requestAvailableHouses", function()
    local source = source
    local identifier = ParaziaRPServerUtils.getLicense(source)
    local allowed = {}
    local available = {}
    local owned = {}
    ---@param house House
    for houseID, house in pairs(ParaziaRPSHousesManager.list) do
        if house.ownerLicense == "none" then
            available[houseID] = house.info.entry
        else
            if house.ownerLicense == identifier then
                owned[houseID] = house.info.entry
            else
                for _,allowedLicense in pairs(house.allowedPlayers) do
                    if identifier == allowedLicense then
                        allowed[houseID] = {coords = house.info.entry, name = house.ownerInfo}
                    end
                end
            end
        end
    end
    ParaziaRPServerUtils.toClient("cbAvailableHouses", source, available, owned, allowed)
end)

ParaziaRP.netRegisterAndHandle("setHouseAlloweds", function(houseId, allowedTable, isPublic)
    if not ParaziaRPSHousesManager.list[houseId] then
        return
    end
    local newHouseAllowedTable = {}
    local source = source
    local license = ParaziaRPServerUtils.getLicense(source)
    ---@type House
    local house = ParaziaRPSHousesManager.list[houseId]
    if not house:isOwner(source) then 
        return
    end
    house.allowedPlayers = {}
    for k,v in pairs(allowedTable) do
        if v.can == true then
            table.insert(newHouseAllowedTable, k)
        end
    end
    house.public = isPublic
    house.allowedPlayers = newHouseAllowedTable
    ParaziaRPSHousesManager.list[houseId] = house
    TriggerClientEvent("esx:showNotification", source, "~g~Modification appliquées")
end)

ParaziaRP.netRegisterAndHandle("ParaziaRP:Ouvert", function()
    TriggerClientEvent("esx:showNotification", -1, "~q~L'agence immo ~s~est désormais ~g~ouvert ~s~!")
end)

ParaziaRP.netRegisterAndHandle("ParaziaRP:Fermée", function()
    TriggerClientEvent("esx:showNotification", -1, "~q~L'agence immo ~s~est désormais ~q~fermé ~s~!")
end)