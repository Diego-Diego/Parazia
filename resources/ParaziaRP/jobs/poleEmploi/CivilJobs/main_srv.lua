TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

local cl = {}

local function IseventCl(_src)
    for _ , id in pairs(cl) do
        if (_src == id) then
            return true
        end
    end 
    return false
end

local function adCl(_src)
    table.insert(cl, _src)
end

local function removeCl(_src)
    for idx, id in pairs(cl) do
        if (_src == id) then
            cl[idx] = nil
        end
    end 
end

local function lanexevent(eventname, func)
    RegisterServerEvent(eventname)
    AddEventHandler(eventname, function(...)
        _src = source
        if (IseventCl(_src)) then

            DropPlayer(_src, "Tu fais quoi la mdr")  
            return
        end
        adCl(_src)
        SetTimeout(1500, function()
            removeCl(_src)
        end)
        func(...)
    end)
end

lanexevent("ori_jobs:pay", function(money)
    local _source = source
    if money < 200 then
        local xPlayer = ESX.GetPlayerFromId(_source)
        xPlayer.addAccountMoney('cash', money)
    else
        DropPlayer(source, "Pourquoi Cheat ?")  
    end
end)