ESX = nil
TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
print("Chargement du ^4Pôle Emploi^0 ...")
ESX.RegisterServerCallback('kTeste:getJobs', function(source, cb)
     MySQL.Async.fetchAll('SELECT * FROM jobs ORDER BY label ASC', {}, function(result)
         cb(result)
     end)
 end)
RegisterServerEvent('blowJobs:changeJob')
AddEventHandler('blowJobs:changeJob', function(job, jobLabel, grade)
     local xPlayer = ESX.GetPlayerFromId(source)
     if xPlayer.job.name == job then
          TriggerClientEvent("sound:Error", source)
          TriggerClientEvent("esx:showNotification", source, "~q~Pôle Emploi~s~\nVous êtes déjà dans cette entreprise .")
     else
          if job == "unemployed" then
               TriggerClientEvent("sound:Nice", source)
               xPlayer.setJob(job, grade)
               TriggerClientEvent("esx:showNotification", source, "~q~Pôle Emploi~s~\nVous venez de quitter votre ~o~métier~s~ .")     
          else
               TriggerClientEvent("sound:Nice", source)
               xPlayer.setJob(job, grade)
               TriggerClientEvent("esx:showNotification", source, "~q~Pôle Emploi~s~\nVous avez été embauché en tant que ~y~"..jobLabel)     
          end
     end
end)

--[[RegisterServerEvent('powx_joblisting:setJobVigneron')
AddEventHandler('powx_joblisting:setJobVigneron', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("vigne", 0)
end)

RegisterServerEvent('powx_joblisting:setJobTabac')
AddEventHandler('powx_joblisting:setJobTabac', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("tabac", 0)
end)

RegisterServerEvent('powx_joblisting:setJobBrasseur')
AddEventHandler('powx_joblisting:setJobBrasseur', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("brasseur", 0)
end)

RegisterServerEvent('powx_joblisting:setJobBle')
AddEventHandler('powx_joblisting:setJobBle', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("ble", 0)
end)

RegisterServerEvent('powx_joblisting:setJobAbatteur')
AddEventHandler('powx_joblisting:setJobAbatteur', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("abateur", 0)
end)

RegisterServerEvent('powx_joblisting:setJobChômeur')
AddEventHandler('powx_joblisting:setJobChômeur', function(job)
    local _source = source
    local xPlayer = ESX.GetPlayerFromId(_source)
    xPlayer.setJob("unemployed", 0)
end)]]