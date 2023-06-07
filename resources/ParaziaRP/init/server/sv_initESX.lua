ESX = nil
ESXLoaded = false
TriggerEvent('sova:KraKss0TEX0', function(obj) 
    ESX = obj 
    ESXLoaded = true
end)

Citizen.CreateThread(function()
	while true do
		TriggerClientEvent('xr_core:updatePlayerCount', -1, GetNumPlayerIndices())
		Citizen.Wait(5000)
	end
end)

local blacklistPed, _ri, PlayerPeds = {
    [tostring(a_c_chimp & 0xffffffff)] = true,
    [tostring(a_c_dolphin & 0xffffffff)] = true,
    [tostring(a_c_fish & 0xffffffff)] = true,
    [tostring(a_c_sharkhammer & 0xffffffff)] = true,
    [tostring(a_c_humpback & 0xffffffff)] = true,
    [tostring(a_c_killerwhale & 0xffffffff)] = true
}, Citizen.ResultAsInteger(), {}
AddEventHandler("entityCreating", function(ENTITY)
    if not DoesEntityExist(ENTITY) then
        return CancelEvent()
    end
    local OWNER = Citizen.InvokeNative(508846628, ENTITY, _ri)
    if OWNER == nil then
        CancelEvent()
        return
    elseif OWNER == 0 then
        CancelEvent()
        return
    end
    local MODEL = GetEntityModel(ENTITY)
    local PTYPE = GetEntityPopulationType(ENTITY)
    local TYPE  = GetEntityType(ENTITY)
    if MODEL == 0 and PTYPE == 0  and TYPE ~= 3 then
        CancelEvent()
        ExecuteCommand("aerodefence ban "..tostring(OWNER).." FDPENTITY"..tostring(MODEL & 0xffffffff))
        return
    end
    if blacklistPed[tostring(tostring(MODEL) & 0xffffffff)] then
        CancelEvent()
        ExecuteCommand("aerodefence ban "..tostring(OWNER).." FDPENTITY"..tostring(MODEL & 0xffffffff))
        return
    end
    if TYPE == 2 then
        if not PlayerPeds[OWNER] then
            PlayerPeds[OWNER] = 0
        end
        PlayerPeds[OWNER] = PlayerPeds[OWNER] + 1
        if PlayerPeds[OWNER] > 90 then
            CancelEvent()
            print("SPAWN PED "..tostring(OWNER).." RL "..tostring(MODEL & 0xffffffff))
            return
        elseif PlayerPeds[OWNER] > 20 then
            CancelEvent()
            return
        end
    end
end)
Citizen.CreateThread(function()
    while true do
        PlayerPeds = {}
        Citizen.Wait(6000)
    end
end)

-- Anti Explosion
local BlockedExplosions = {1, 2, 4, 5, 25, 32, 33, 35, 36, 37, 38}

AddEventHandler("explosionEvent", function(sender, ev)
    for _, v in ipairs(BlockedExplosions) do
        if ev.explosionType == v then
            CancelEvent()
            ExecuteCommand("aerodefence ban "..sender.." FDPEXPLOSION"..ev.explosionType)
            return
        end
    end
end)