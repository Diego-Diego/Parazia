
--[[
  This file is part of ParaziaRP.

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local avaibleJobs = {
    "realestateagent",
    "ojap",
    "cockatoos"
}

for k,v in pairs(avaibleJobs) do
    Jobs.list[v] = {}
end


ParaziaRP.netHandle("esxloaded", function()
    Keys.Register('F6', 'F6_sovaCore', 'Menu Agent imo', function()
        if Jobs.list[Job.name] ~= nil and Jobs.list[Job.name].openMenu ~= nil then
            Jobs.list[Job.name].openMenu()
        end
    end)
end)