ESX = {}
ESX.DB = {}
ESX.Players = {}
ESX.Commands = {}
ESX.CommandsSuggestions = {}
ESX.Groups = {}
ESX.Jobs = {}
ESX.Items = {}
ESX.UsableItemsCallbacks = {}
ESX.ServerCallbacks = {}
ESX.TimeoutCount = -1
ESX.CancelledTimeouts = {}
ESX.Pickups = {}
ESX.PickupId = 0

AddEventHandler('sova:KraKss0TEX0', function(cb)
	cb(ESX)
end)

function getSharedObject()
	return ESX
end

MySQL.ready(function()
	MySQL.Async.execute('DELETE FROM addon_account_data WHERE `money` = 0', {})
	MySQL.Async.execute('DELETE FROM addon_inventory_items WHERE `count` = 0', {})
	MySQL.Async.execute('DELETE FROM datastore_data WHERE `data` = \'{}\'', {})

	MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
		for i = 1, #result, 1 do
			ESX.Items[result[i].name] = {
				label = result[i].label,
				weight = result[i].weight,
				canRemove = toboolean(result[i].can_remove),
				unique = toboolean(result[i].unique)
			}
		end
	end)

	MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(result)
		for i = 1, #result do
			ESX.Jobs[result[i].name] = result[i]
			ESX.Jobs[result[i].name].grades = {}
		end
	
		MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(result2)
			for i = 1, #result2 do
				if ESX.Jobs[result2[i].job_name] then
					ESX.Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
				else
					print(('[^3WARNING^7] Invalid job "%s" from table job_grades ignored'):format(result2[i].job_name))
				end
			end
		
			for k, v in pairs(ESX.Jobs) do
				if ESX.Table.SizeOf(v.grades) == 0 then
					ESX.Jobs[v.name] = nil
					print(('[^3WARNING^7] Ignoring job "%s" due to missing job grades'):format(v.name))
				end
			end
		end)
	end)
end)

RegisterServerEvent('esx:triggerServerCallback')
AddEventHandler('esx:triggerServerCallback', function(name, requestId, ...)
	local _source = source
	ESX.TriggerServerCallback(name, requestId, _source, function(...)
		TriggerClientEvent('esx:serverCallback', _source, requestId, ...)
	end, ...)
end)

RegisterCommand('refreshGlobalsInformations', function(source,args)
	if source == 0 then 
		ESX.Items = {}
		ESX.Jobs = {}
		MySQL.Async.fetchAll('SELECT * FROM items', {}, function(result)
			for i = 1, #result, 1 do
				ESX.Items[result[i].name] = {
					label = result[i].label,
					weight = result[i].weight,
					canRemove = toboolean(result[i].can_remove),
					unique = toboolean(result[i].unique)
				}
			end
		end)
	
		MySQL.Async.fetchAll('SELECT * FROM jobs', {}, function(result)
			for i = 1, #result do
				ESX.Jobs[result[i].name] = result[i]
				ESX.Jobs[result[i].name].grades = {}
			end
		
			MySQL.Async.fetchAll('SELECT * FROM job_grades', {}, function(result2)
				for i = 1, #result2 do
					if ESX.Jobs[result2[i].job_name] then
						ESX.Jobs[result2[i].job_name].grades[tostring(result2[i].grade)] = result2[i]
					else
						print(('[^3WARNING^7] Invalid job "%s" from table job_grades ignored'):format(result2[i].job_name))
					end
				end
			
				for k, v in pairs(ESX.Jobs) do
					if ESX.Table.SizeOf(v.grades) == 0 then
						ESX.Jobs[v.name] = nil
						print(('[^3WARNING^7] Ignoring job "%s" due to missing job grades'):format(v.name))
					end
				end
			end)
		end)
	end
end)

RegisterNetEvent('ewen:CreateNewItem')
AddEventHandler('ewen:CreateNewItem', function(value)
	local xPlayer = ESX.GetPlayerFromId(value.src)
	if xPlayer.getGroup() == '_dev' or xPlayer.getGroup() == 'responsable' then
		if ESX.Items[value.name] then
			xPlayer.showNotification('~q~ParaziaRP~w~L\'item existe déjà')
		else
			MySQL.Async.execute("INSERT INTO `items` (`name`, `label`, `weight`) VALUES (@name, @label, @weight) ", {
				['@name'] = value.name,
				['@label'] = value.label,
				['@weight'] = 0.5,
			})
		end
	end
end)

function ESX.DeletGrade(job, index) 
	if ESX.Jobs[job].grades[tostring(index)] then 
		ESX.Jobs[job].grades[tostring(index)] = nil
		MySQL.Async.execute('DELETE FROM job_grades WHERE job_name = @job_name and grade = @grade', {
			['@job_name'] = job,
			['@grade'] = tostring(index),
		})
		print(json.encode(ESX.Jobs[job].grades))
		return ESX.Jobs[job].grades
	end
end

function ESX.AddGrade(job, gradeInfo) 
	if ESX.Jobs[job] then 
		local NumberGrade = "0"
		local NumberGradeMake = false
		if not ESX.Jobs[job].grades["0"] and not NumberGradeMake then 
			NumberGrade = "0"
			NumberGradeMake = true
		end
		if not ESX.Jobs[job].grades["1"] and not NumberGradeMake then 
			NumberGrade = "1"
			NumberGradeMake = true
		end
		if not ESX.Jobs[job].grades["2"] and not NumberGradeMake then 
			NumberGrade = "2"
			NumberGradeMake = true
		end
		if not ESX.Jobs[job].grades["3"] and not NumberGradeMake then 
			NumberGrade = "3"
			NumberGradeMake = true
		end
		if not ESX.Jobs[job].grades["4"] and not NumberGradeMake then 
			NumberGrade = "4"
			NumberGradeMake = true
		end
		if not ESX.Jobs[job].grades["5"] and not NumberGradeMake then 
			NumberGrade = "5"
			NumberGradeMake = true
		end
		if not ESX.Jobs[job].grades["6"] and not NumberGradeMake then 
			NumberGrade = "6"
			NumberGradeMake = true
		end
		if not ESX.Jobs[job].grades["7"] and not NumberGradeMake then 
			NumberGrade = "7"
			NumberGradeMake = true
		end
		ESX.Jobs[job].grades[NumberGrade] = {}
		ESX.Jobs[job].grades[NumberGrade].job_name = gradeInfo.job_name
		ESX.Jobs[job].grades[NumberGrade].grade = NumberGrade
		ESX.Jobs[job].grades[NumberGrade].name = gradeInfo.name
		ESX.Jobs[job].grades[NumberGrade].label = gradeInfo.label
		ESX.Jobs[job].grades[NumberGrade].salary = gradeInfo.salary
		ESX.Jobs[job].grades[NumberGrade].skin_mal = gradeInfo.skin_mal
		ESX.Jobs[job].grades[NumberGrade].skin_female = gradeInfo.skin_female
		MySQL.Async.execute('INSERT INTO job_grades (job_name, grade, name, label, salary, skin_male, skin_female) VALUES (@job_name, @grade, @name, @label, @salary, @skin_male, @skin_female)', {
			['@job_name'] = gradeInfo.job_name,
			['@grade'] = NumberGrade,
			['@name'] = gradeInfo.name,
			['@label'] = gradeInfo.label,
			['@salary'] = gradeInfo.salary,
			['@skin_male'] = json.encode(gradeInfo.skin_mal),
			['@skin_female'] = json.encode(gradeInfo.skin_female)
		})
		return ESX.Jobs[job].grades
	end
end

function ESX.EditGrade(editType, job, args) 
	if ESX.Jobs[job] then 
		if editType == "salary" then 
			if ESX.Jobs[job].grades[tostring(args.grade)] then
				ESX.Jobs[job].grades[tostring(args.grade)].salary = args.amount
				MySQL.Sync.execute("UPDATE job_grades SET salary=@salary WHERE name=@name and job_name=@job_name", {
					["@salary"] = args.amount,
					["@job_name"] = ESX.Jobs[job].name,
					["@name"] = ESX.Jobs[job].grades[tostring(args.grade)].name
				})
				return ESX.Jobs[job].grades
			end
		end
	end
end