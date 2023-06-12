---@class Server
Server = {} or {};

function Server:getIdentity(source, cb)
	local identifier = ESX.GetIdentifierFromId(source)

	MySQL.Async.fetchAll('SELECT identifier, firstname, lastname, dateofbirth, sex, height FROM `users` WHERE `identifier` = @identifier', {
		['@identifier'] = identifier
	}, function(result)
		local data = {}

		data.identifier = identiier

		if result[1] then
			data.firstname = result[1].firstname
			data.lastname = result[1].lastname
			data.dateofbirth = result[1].dateofbirth
			data.sex = result[1].sex
			data.height = result[1].height
		end

		cb(data)
	end)
end

function Server:ToDiscord(name, message, color)
    date_local1 = os.date('%H:%M:%S', os.time())
    local date_local = date_local1
    local DiscordWebHook = _ServerConfig.discordWehbook

    local embeds = {
        {
            ["title"]= message,
            ["type"]="rich",
            ["color"] =color,
            ["footer"]=  {
                ["text"]= "Heure : " ..date_local.. "",
            },
        }
    }

    if message == nil or message == '' then return FALSE end
    PerformHttpRequest(DiscordWebHook, function(err, text, headers) end, 'POST', json.encode({ username = name,embeds = embeds}), { ['Content-Type'] = 'application/json' })
end

function Server:SetFirstName(identifier, firstname)
	MySQL.Async.execute('UPDATE `users` SET `firstname` = @firstname WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@firstname']		= firstname
	})
end

function Server:SetLastName(identifier, lastname)
	MySQL.Async.execute('UPDATE `users` SET `lastname` = @lastname WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@lastname']		= lastname
	})
end

function Server:SetDOB(identifier, dateofbirth, callback)
	MySQL.Async.execute('UPDATE `users` SET `dateofbirth` = @dateofbirth WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@dateofbirth']	= dateofbirth
	})
end

function Server:SetSex(identifier, sex)
	MySQL.Async.execute('UPDATE `users` SET `sex` = @sex WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@sex']		    = sex
	})
end

function Server:SetSex2(identifier, sex2)
	MySQL.Async.execute('UPDATE `users` SET `sex` = @sex WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@sex']		    = sex2
	})
end

function Server:SetHeight(identifier, height)
	MySQL.Async.execute('UPDATE `users` SET `height` = @height WHERE identifier = @identifier', {
		['@identifier']		= identifier,
		['@height']		    = height
	})
end