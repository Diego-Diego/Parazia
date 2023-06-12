---@author Pablo Z.
---@version 1.0
--[[
  This file is part of ParaziaRP.
  
  File [jobsManager] created at [17/04/2021 21:15]

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRP.netRegisterAndHandle("openBossMenu", function(job)
    TriggerEvent('esx_society:openBossMenu', job, function(data, menu)
        menu.close()
    end, { wash = false })
end)