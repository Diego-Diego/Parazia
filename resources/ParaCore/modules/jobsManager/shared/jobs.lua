---@author Pablo Z.
---@version 1.0
--[[
  This file is part of ParaziaRP.
  
  File [jobs] created at [17/04/2021 21:19]

  Copyright (c) ParaziaRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

ParaziaRPSharedCustomJobs = {
    ["ojap"] = {
        ---@param job Job
        onThisJobInit = function(job)
            local foodZone = ParaziaRPSZonesManager.createPrivate(vector3(-172.42, 295.07, 93.76), 22, {r = 118, g = 59, b = 245, a = 255}, function(source)
                ParaziaRPServerUtils.toClient("ojapOpenFrigo", source, ParaziaRPSCache.getCache("ojapfood"))
            end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le frigo", 20.0, 1.0, {})
            job:registerAdditionalZone(foodZone)
        end,

        inventory = vector3(-172.29, 293.83, 93.76),
        laundry = vector3(-175.75, 313.03, 97.09),
        -- Add garage

        clothes = {
            ["boss"] = {
                ["M"] = {
                    ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                    ['torso_1'] = 13,   ['torso_2'] = 0,
                    ['arms'] = 11,
                    ['pants_1'] = 24,   ['pants_2'] = 0,
                    ['shoes_1'] = 10,   ['shoes_2'] = 0,
                    ['helmet_1'] = 7,  ['helmet_2'] = 2,
                    ['chain_1'] = 10,    ['chain_2'] = 2,
                },

                ["F"] = {

                }
            },
            ["member"] = {
                ["M"] = {
                    ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                    ['torso_1'] = 13,   ['torso_2'] = 0,
                    ['arms'] = 11,
                    ['pants_1'] = 24,   ['pants_2'] = 0,
                    ['shoes_1'] = 10,   ['shoes_2'] = 0,
                    ['helmet_1'] = 7,  ['helmet_2'] = 2,
                    ['chain_1'] = 10,    ['chain_2'] = 2,
                },

                ["F"] = {

                }
            },
            ["recruit"] = {
                ["M"] = {
                    ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                    ['torso_1'] = 13,   ['torso_2'] = 0,
                    ['arms'] = 11,
                    ['pants_1'] = 24,   ['pants_2'] = 0,
                    ['shoes_1'] = 10,   ['shoes_2'] = 0,
                    ['helmet_1'] = 7,  ['helmet_2'] = 2,
                    ['chain_1'] = 10,    ['chain_2'] = 2,
                },

                ["F"] = {

                }
            }
        },
    },

    ["cockatoos"] = {
        ---@param job Job
        onThisJobInit = function(job)
            local foodZone = ParaziaRPSZonesManager.createPrivate(vector3(-437.21, -35.14, 40.17), 22, {r = 239, g = 236, b = 64, a = 255}, function(source)
                ParaziaRPServerUtils.toClient("cockatoosOpenFrigo", source, ParaziaRPSCache.getCache("cockatoosfood"))
            end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le frigo", 20.0, 1.0, {})
            job:registerAdditionalZone(foodZone)
        end,

        inventory = vector3(-437.21, -35.14, 40.17),
        laundry = vector3(-446.28, -24.79, 40.17),
        -- Add garage

        clothes = {
            ["boss"] = {
                ["M"] = {
                    ['tshirt_1'] = 72,  ['tshirt_2'] = 3,
                    ['torso_1'] = 31,   ['torso_2'] = 0,
                    ['arms'] = 17,
                    ['pants_1'] = 24,   ['pants_2'] = 0,
                    ['shoes_1'] = 10,   ['shoes_2'] = 0,
                    ['helmet_1'] = 7,  ['helmet_2'] = 0,
                    ['chain_1'] = 0,    ['chain_2'] = 0,
                },

                ["F"] = {
					['tshirt_1'] = 2,  ['tshirt_2'] = 0,
                    ['torso_1'] = 98,   ['torso_2'] = 0,
                    ['arms'] = 6,
                    ['pants_1'] = 6,   ['pants_2'] = 0,
                    ['shoes_1'] = 5,   ['shoes_2'] = 0,
                    ['helmet_1'] = 4,  ['helmet_2'] = 7,
                    ['chain_1'] = 0,    ['chain_2'] = 0
                }
            },
            ["member"] = {
                ["M"] = {
                    ['tshirt_1'] = 72,  ['tshirt_2'] = 3,
                    ['torso_1'] = 31,   ['torso_2'] = 0,
                    ['arms'] = 17,
                    ['pants_1'] = 24,   ['pants_2'] = 0,
                    ['shoes_1'] = 10,   ['shoes_2'] = 0,
                    ['helmet_1'] = 7,  ['helmet_2'] = 0,
                    ['chain_1'] = 0,    ['chain_2'] = 0,
                },

                ["F"] = {
					['tshirt_1'] = 2,  ['tshirt_2'] = 0,
                    ['torso_1'] = 98,   ['torso_2'] = 0,
                    ['arms'] = 6,
                    ['pants_1'] = 6,   ['pants_2'] = 0,
                    ['shoes_1'] = 5,   ['shoes_2'] = 0,
                    ['helmet_1'] = 4,  ['helmet_2'] = 7,
                    ['chain_1'] = 0,    ['chain_2'] = 0,

                }
            },
            ["recruit"] = {
                ["M"] = {
					['tshirt_1'] = 22,  ['tshirt_2'] = 0,
                    ['torso_1'] = 11,   ['torso_2'] = 1,
                    ['arms'] = 6,
                    ['pants_1'] = 24,   ['pants_2'] = 0,
                    ['shoes_1'] = 10,   ['shoes_2'] = 0,
                    ['helmet_1'] = 7,  ['helmet_2'] = 0,
                    ['chain_1'] = 0,    ['chain_2'] = 0,
                },

                ["F"] = {
					['tshirt_1'] = 2,  ['tshirt_2'] = 0,
                    ['torso_1'] = 98,   ['torso_2'] = 0,
                    ['arms'] = 6,
                    ['pants_1'] = 6,   ['pants_2'] = 0,
                    ['shoes_1'] = 5,   ['shoes_2'] = 0,
                    ['helmet_1'] = 4,  ['helmet_2'] = 7,
                    ['chain_1'] = 0,    ['chain_2'] = 0,

                }
            }
        },
    },

    ["plage"] = {
        ---@param job Job
        onThisJobInit = function(job)
            local foodZone = ParaziaRPSZonesManager.createPrivate(vector3(-172.42, 295.07, 93.76), 22, {r = 118, g = 59, b = 245, a = 255}, function(source)
                ParaziaRPServerUtils.toClient("plageOpenFrigo", source, ParaziaRPSCache.getCache("plage"))
            end, "Appuyez sur ~INPUT_CONTEXT~ pour ouvrir le frigo", 20.0, 1.0, {})
            job:registerAdditionalZone(foodZone)
        end,

        inventory = vector3(-1391.3155517578, -604.97479248047, 29.319574356079),
        laundry = vector3(-1389.5947265625, -591.4619140625, 29.319549560547),
        -- Add garage

        clothes = {
            ["boss"] = {
                ["M"] = {
                    ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                    ['torso_1'] = 13,   ['torso_2'] = 0,
                    ['arms'] = 11,
                    ['pants_1'] = 24,   ['pants_2'] = 0,
                    ['shoes_1'] = 10,   ['shoes_2'] = 0,
                    ['helmet_1'] = 7,  ['helmet_2'] = 2,
                    ['chain_1'] = 10,    ['chain_2'] = 2,
                },

                ["F"] = {

                }
            },
            ["member"] = {
                ["M"] = {
                    ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                    ['torso_1'] = 13,   ['torso_2'] = 0,
                    ['arms'] = 11,
                    ['pants_1'] = 24,   ['pants_2'] = 0,
                    ['shoes_1'] = 10,   ['shoes_2'] = 0,
                    ['helmet_1'] = 7,  ['helmet_2'] = 2,
                    ['chain_1'] = 10,    ['chain_2'] = 2,
                },

                ["F"] = {

                }
            },
            ["recruit"] = {
                ["M"] = {
                    ['tshirt_1'] = 15,  ['tshirt_2'] = 0,
                    ['torso_1'] = 13,   ['torso_2'] = 0,
                    ['arms'] = 11,
                    ['pants_1'] = 24,   ['pants_2'] = 0,
                    ['shoes_1'] = 10,   ['shoes_2'] = 0,
                    ['helmet_1'] = 7,  ['helmet_2'] = 2,
                    ['chain_1'] = 10,    ['chain_2'] = 2,
                },

                ["F"] = {

                }
            }
        },
    }
}