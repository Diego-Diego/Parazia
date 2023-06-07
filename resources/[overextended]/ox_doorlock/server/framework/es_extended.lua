local resourceName = 'kFramework'

if not GetResourceState(resourceName):find('start') then return end

SetTimeout(0, function()
    TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)

    GetPlayer = ESX.GetPlayerFromId

    function RemoveItem(playerId, item)
        local player = GetPlayer(playerId)

        if player then player.removeInventoryItem(item, 1) end
    end

    function DoesPlayerHaveItem(player, items)
        for i = 1, #items do
            local item = items[i]
            local data = player.getInventoryItem(item.name)

            if data?.count > 0 then
                if item.remove then
                    player.removeInventoryItem(item.name, 1)
                end

                return item.name
            end
        end

        return false
    end
end)

function GetCharacterId(player)
    return player.identifier
end

local groups = {"job", "job2"}

function IsPlayerInGroup(player, filter)
    local type = type(filter)

    if type == 'string' then
        for i = 1, #groups do
			local data = player[groups[i]]

			if data.name == filter then
				return data.name, data.grade
			end
		end
    else
        local tabletype = table.type(filter)

        if tabletype == 'hash' then
            for i = 1, #groups do
                local data = player[groups[i]]
                local grade = filter[data.name]

                if grade and grade <= data.grade then
                    return data.name, data.grade
                end
            end
        elseif tabletype == 'array' then
            for i = 1, #filter do
                local group = filter[i]

                for j = 1, #groups do
                    local data = player[groups[j]]

                    if data.name == group then
                        return data.name, data.grade
                    end
                end
            end
        end
    end
end