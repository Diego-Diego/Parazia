---@author Pablo Z.
---@version 1.0
--[[
  This file is part of ParaziaRP.
  
  File [jobsManager] created at [17/04/2021 21:15]

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local playersJobsCache = {}

ParaziaRPSJobsManager = {}
ParaziaRPSJobsManager.list = {}

---getJob
---@public
---@return Job
ParaziaRPSJobsManager.getJob = function(job)
    return ParaziaRPSJobsManager.list[job]
end

ParaziaRP.netHandleBasic("playerDropped", function(reason)
    playersJobsCache[source] = nil
end)

--[[ParaziaRP.netHandle("esxloaded", function()
    MySQL.Async.fetchAll("SELECT * FROM jobs WHERE usePabloSystem = 1", {}, function(result)
        for _,job in pairs(result) do
            if not ParaziaRPSharedCustomJobs[job.name] then
                print(ParaziaRP.prefix(ParaziaRPPrefixes.jobs,("Impossible de charger le job %s"):format(job.label)))
            else
                local society = ("society_%s"):format(job.name)
                TriggerEvent('esx_society:registerSociety', job.name, job.label, society, society, society, {type = 'private'})
                print(ParaziaRP.prefix(ParaziaRPPrefixes.jobs,("Chargement du job ^1%s ^7!"):format(job.name)))
                Job(job.name, job.label)
                ParaziaRPSharedCustomJobs[job.name].onThisJobInit(ParaziaRPSJobsManager.list[job.name])
            end
        end
    end)
end)]]

ParaziaRP.netRegisterAndHandle("jobInitiated", function(job)
    local source = source
    playersJobsCache[source] = {name = job.name, grade = job.grade_name, isCustom = ParaziaRPSJobsManager.getJob(job.name) ~= nil}
    if not ParaziaRPSJobsManager.getJob(job.name) then
        return
    end
    ---@type Job
    local ParaziaRPJob = ParaziaRPSJobsManager.getJob(job.name)
    ParaziaRPJob:subscribe(source, job.grade_name)
end)

ParaziaRP.netRegisterAndHandle("jobUpdated", function(newJob)
    local source = source
    local previousCache = playersJobsCache[source]
    local newCache = {name = newJob.name, grade = newJob.grade_name, isCustom = ParaziaRPSJobsManager.getJob(newJob.name) ~= nil}

    if previousCache.name ~= newJob.name then
        -- Changement de job
        ---@type Job
        if previousCache.isCustom then
            local previousJob = ParaziaRPSJobsManager.getJob(previousCache.name)
            previousJob:unsubscribe(source, previousCache.grade)
        end
        if newCache.isCustom then
            local newParaziaRPJob = ParaziaRPSJobsManager.getJob(newCache.name)
            newParaziaRPJob:subscribe(source, newCache.grade)
        end
    else
        if newCache.isCustom then
            if previousCache.grade ~= newCache.grade then
                local ParaziaRPJob = ParaziaRPSJobsManager.getJob(newCache.name)
                if previousCache.grade == "boss" then
                    ParaziaRPJob:alterBossAccess(source, false)
                elseif newCache.grade == "boss" then
                    ParaziaRPJob:alterBossAccess(source, true)
                end
            end
        end
    end

    playersJobsCache[source] = newCache
end)