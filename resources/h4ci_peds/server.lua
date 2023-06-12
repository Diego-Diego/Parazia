ESX = nil

TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)


local admins = {
    'steam:11000014544390e', -- NoAIM : Lifetime
    'steam:1100001119f9930', -- Danny76#3742 : Lifetime
    'steam:11000014bbb3040', -- La R : Fonda
    'steam:11000014b04850c', -- Zeyroxx : Lifetime
    'steam:11000014bc5aca7',  -- Le S : Lifetime
    'steam:11000015882d156', -- .!VMr#1102 : Lifetime
    'steam:11000014c68809f', -- 2.0#5675 : Lifetime
    'steam:110000146021507', -- Azerko#8887 : Lifetime
    
}

function isAdmin(player)
    local allowed = false
    for i,id in ipairs(admins) do
        for x,pid in ipairs(GetPlayerIdentifiers(player)) do
            if string.lower(pid) == string.lower(id) then
                allowed = true
            end
        end
    end
    return allowed
end

RegisterServerEvent('checkadmin')
AddEventHandler('checkadmin', function()
	local id = source
	if isAdmin(id) then
		TriggerClientEvent("setgroup", source)
	end
end)

