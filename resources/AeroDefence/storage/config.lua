Config = {

    license = 'aero-hwtm3y7bl2-1uis7wfe77', -- your license key (💢 buy one here => https://discord.gg/aerodefence)


    debugMode = nil,

    --# Admin 

    Admin = {
        openKey = 'F12', -- you can find accepted open keys here: https://docs.fivem.net/docs/game-references/input-mapper-parameter-ids/
        notifyStaff = nil, -- notify staff when a important action happend (ban, kick, new staff ...)
        Report = { -- (still not done)
            active = nil, -- activate our advanced report system ù
            command = 'report' -- the command the player can use to make a report, ex: /report i just got car killed
        }
    },

    --# Logs 

    Logs = {
        active = true, 
        showIpInLogs = nil, --( true = to enable, nil = disable )
    },

    --# Ban 

    Ban = {
        printOnBan = true, -- print in server console when cheater gets banned & kicked
        hideBanReason = nil, -- hide the ban reason
        cleanWhenBan = true, -- delete all entities spawned by the cheater
        globalBan = true, -- activates our global ban system
        banIp = true,
        button = {
            title = 'DISCORD SERVER', 
            iconUrl = 'lien image ',
            url = 'https://discord.gg/paraziarp'
        }
    },

    --# Resource 

    Resource = {
        Anti_Executor = true, -- detects executors
        Anti_Solo_Session = nil, -- detects if a player to get into a solo session
        Anti_Dump = true, -- detects when cheater tries to reverse ingeniere on our anti dump (currently disabled)
        Anti_Sound_Play = 3, -- detects when cheater tries to play custom sounds 
        Anti_Menyoo = nil, -- anti menyoo ( .asi menus )
        Anti_Resource_Stop = true, -- detects when cheater tries to stop a resource in his client side ( important: check out documention )
        Anti_Player_Crasher = true, -- anti player crasher with /me
        Trigger = {
            Anti_Trigger = {
                active = true, 
                printOnUse = true,
                printOnHandle = nil,
            },
            ratelimit = {
                active = nil, 
                seconds = 5, -- in seconds
                max = 20,
                triggers = {
                    'trigger name'
                }
            },
            Anti_Trigger_Client_Event = { -- disclamer: this is made only for client events not server events ( events that are registred and handled in the client side )
                active = true, 
                triggers = {
                    ['esx:spawnVehicle'] = {},
                    ['esx:setJob'] = {},
                    ['esx:setJob2'] = {}
                }
            }
        },
        Chat = {
            Anti_Fake_Chat_Message = true,
            Anti_BlackListed_Chat_Word = {
                active = true, 
                words = { -- blacklisted words
                'parazetamol','killmenu','restartmenu','panickey','closemenu','give','eulen','nexus','Sound','Executor','redENGNE','Dumper','Dump','Triggers','trigger','Smoonting','GUEST MENU',
                'GodMode','closecheat','cipher','Aimbot','redENGINE','crosshair','no gravity','Super Jump',
                'player ip','triggers','trigger','Executor','executor','Suicide','Armor','neeger','online player','online players',
                'destroy','giveweapon','giveitem','Give Weapon','Give Item','DESTROYER','Set Outfit','Stop Ressources','stop ressoure','Refil Health in Cover',
                'infinite ammo','Invisibility','Semi God Mode','Seatbelt','No HS','discord.gg/','Give All Weapons','Remove All Weapons','Cheats',
                'Modules','Load Lua','Run','ESP Settings','Bone ESP','Health ESP','Name ESP','Line ESP','Show Coords','Force Minimap','Force Blips',
                'ESP Colors','Dump','Dump Directory','Server Triggers','Load Menu','Find Triggers','Load Menu','Infinite Stamina','Armor','Server IP',
                'Modifiers','Object Spooner','Time Options','Teleport Options','Model Changer','Trigger FX','Ghost Rider Mode','Spooner Mode','Teleport to point',
                'Spawn entity into world','Spawn Ped','Dopameme','Deluxmeme','Fallout','Engine Power Boost','Repair vehicle','Delete vehicle','Vehicle spawn list',
                'Reload Speed','Bullet Dammage','Smooth','Aim Distance','Fow Style','Fov','Crosshair','Rmouse','Acceleration Force',
                'Brake Force','Traction Max Curse','Traction Min Curse','Vehicle Mass','Vehicle Buoyancy','Deform Multipler','Bullet Proof Tire',
                'Vehicle Dirt Level','Vehicle Godmode','Dry Ped','Collision Modifier','Tiny Player','Superman','Follow Heading','Tiago Menu',
                'Tiago Menu_3.0','Tiago Menu_4.1','Tiago Menu_4.0','SkidMenu','Lynx_8.1','Lynx_10.0','Lydia_Entreprise','HoaX_2.0','FiveSense',
                'Run Menu','Aimbot Settings','Only target players','FOV Range','Smoothing','Bow ESP','Draw Crosshair','Display Weapons','Inject',
                '.exe','injector','https','image:url','src='
                }
            },
            ratelimit = { -- anti chat spam
                active = true, 
                seconds = 1,
                max = 20
            }
        }
    },

    --# Player

    General = {
        Player_Check_Timer = 1, -- time in seconds it takes from every player check to another
        spawnEvent = 'playerSpawned', -- important for exports to work
        Anti_Clear_Ped_Task = true, -- stop cheater from clearing other player task, ex: kick from vehicle...
        Anti_No_Head_Shot = true, -- stops cheater from no head shot
        Anti_Radar = nil, -- enable this if you don't use the radar (mini radar)
        Anti_Give_Armor = true, -- stop cheater from armor god mode
        Anti_Spectate = nil, -- Anti Spectate
        Anti_Night_Vision = nil, -- Anti Night Vision
        Anti_Thermal_Vision = nil, -- Anti Thermal Vision
        Anti_Afk_Bypass = true, -- stop cheater from using cheats to go on afk mode
        Anti_Small_Player_Ped = true, -- stop cheater from change ped size
        Anti_NoClip = nil, 
        Anti_Not_Script_Cam_Spawn = {
            active = nil, --( 1 = stop freecam, 2 = kick, 3 = ban )
            resource = {
                --exemple: 
                -- 'es_extended'
            }
        },
        Mouvements = {
            Anti_Super_Jump = true, -- stop cheater from using super jump
            Anti_Infinite_Stamina = true, -- stop cheater from having infinite stamina
            Anti_Fast_Run = {
                active = nil, -- stop cheater from going above the selected max speed
                max_speed = 50
            }
        },
        Join = {
            printOnJoin = true, --( true = to enable, nil = disable )
            anti_Null_Tokens = true, -- stops player with null tokens from connecting
            presentCard = {
                active = true, -- activate/disable the present card
                cardTimer = 1-- the time it take for the present to show ( time in seconds ) 
            },
            Anti_BlackListed_Player_Name = {
                active = true, 
                names = {
                    '\xF0',
                    'scr2=',
					'src=2',
					'src=',
					'    ',
					' ',
					' ',
					'‍‍',
					' ‍‍',
					'@everyone',
					'@here'
					
                }
            }
        },
        Left = {
            printOnLeave = true, --( true = to enable, nil = disable )
            Anti_BlackListed_Leave_Reason = {
                active = true, 
                reasons = { -- blacklisted leave reason
                    'gta-streaming-five.dll+4AE92',
                    'citizen-scripting-lua.dll+3FA40B',
                    'citizen-scripting-lua.dll+3FB324',
                    'kernelbase.dll+3A799',
                    'ntdll.dll+1E312',
                    'ntdll.dll+FBF18',
                    'Reliable network event overflow.',
				
                }
            }
        },
        Anti_BlackListed_Task = {
            active = true, --( true = to enable, nil = disable )
            tasks = { -- blacklisted tasks (https://alloc8or.re/gta5/doc/enums/eTaskTypeIndex.txt)
      

            }
        },
        Anti_BlackListed_Texture = {
            active = nil,  --( true = to enable, nil = disable )
            textures = { -- blacklisted textures 
                '', 'PIMODLogo','PIMOD','fm','rampage_tr_main','MenyooExtras','shopui_title_graphics_franklin','deadline','digitaloverlay','mpmissmarkers256','elicopterhud','deadline','rampage_tr_main',
                'cross','trafficcam','mpmissionend','mpsrange','mpweaponscommon','visualflow','mptattoos','mpweaponsgang1','mphud','mpweaponsunusedfornow','digitaloverlay','setMenuProperty',
                'bobylebg','mpmissmarkers256','titleBackgroundSprite.dict','titleBackgroundSprite','meow','meow2','hunting','shopui_title_graphics_franklin','gradient_nav','rk36Zr2W8ONhMfo7UavTQ.dict','rk36Zr2W8ONhMfo7UavTQ.text',
                'leaderboard_car_colour_bg','gradient_bgd','titleBackgroundSprite.name','textureDict','textureName','txtRatio','screenX','screenY','heisthud','main_gradient','interaction_bgd','leaderboard_players_icon','mparrow',
                'mp_alerttriangle','pilotschool','hudarrow','arrowright','JTD.dict','JTD.text','arrowleft','0xE7FFAE5EBF23D890','ISMMENU','ISMMENUHeader','ISMMENULogo','shop_box_tick','shop_box_blank','corona_shade','timerbar_sr',
                'timer_cross','timer_tick','header','subTitlebackground','bottomsubTitlebackground','subTitleText','self_pedchanger','veh_nextsprite','wep_ped','srange_gen','hit_cross','0xE7FFAE5EBF23D890','Invoke','cock_moscow',
                'menu_gif','hud_lock','hud_corner','cockmenuuu','loadhack','mpentry','mp_modenotselected_gradient','shared','menuarrow_32','mp_modeselected_gradient','__REAPER2__','__REAPER3__','__REAPER8__','__REAPER10__','__REAPER6__',
                '__REAPER7__','__REAPER5__','lhs_bg','__REAPER23__','__REAPER24__','__REAPER16__','__REAPER15__','mprankbadge','globe_bg','__REAPER21__','__REAPER22__','__REAPER20__','__REAPER19__','__REAPER18__','__REAPER17__',
                '__REAPER14__','__REAPER13__','__REAPER12__','__REAPER11__','__REAPER9__','__REAPER4__','__REAPER1__',
                '_htype','0xE7FFAE5EBF23D890','Invoke','DrawSprite','~g~CockMenu','width','cock_moscow','vertissotraperdamnshit',
                'srange_gen','hit_cross','mpentry','mp_modenotselected_gradient','corona_shade','aim-fov-draw-alpha','mpinvperscommon','__PAPYMENU1__','__PAPYMENU2__','__PAPYMENU3__','__PAPYMENU4__','__PAPYMENU5__','__PAPYMENU6__','__PAPYMENU7__',
                '__PAPYMENU8__','__PAPYMENU9__','__PAPYMENU10__','__PAPYMENU11__','__PAPYMENU12__','__PAPYMENU13__','__PAPYMENU14__','__PAPYMENU15__','__PAPYMENU16__','__PAPYMENU17__','__PAPYMENU18__','__PAPYMENU19__','__PAPYMENU20__','__PAPYMENU21__',
                '__PAPYMENU22__','__PAPYMENU23__','wmlua.V.AllDraw','shop_tick_icon','mp_specitem_ped','circle_checkpoints','circle_checkpoints_big','basejumping','ped0','1','ped4','ped3','ped2','ped1','2','3','4','arrow_pointer',
                'checkon','titleBackgroundSprite','lagserveur','Fallout','Fivex','Cobra','PizzaMenu','PizzaMenuHeader','PizzaMenuLogo','duiTex'
            }
        }
    },

    --# Entity 

    Entity = {
        Ped = {
            printOnCreate = true, -- it print in the server console when a ped is created
            Anti_Not_WhiteListed_Ped = {
                active = 1, --( 1 = delete ped, 2 = kick, 3 = ban )
                peds = { -- whitelisted peds
                }
            },
            Anti_Not_WhiteListed_Player_Ped = {
                active = nil, 
                peds = { -- whitelisted player peds
                   'mp_m_freemode_01'
                }
            },

            Anti_Not_Script_Ped_Spawn = { -- detects when try to a ped with a not whitelisted resource
                active = 3, --( 1 = delete ped, 2 = kick, 3 = ban )
                resources = { -- whitelisted resources
                'ParaziaRP','ParaCore','braquage','kFramework','_La-R','qs-smartphone'
                }
            },

            ratelimit = { -- anti mass ped spawn
                active = true, 
                seconds = 1, 
                max = 10
            }
        },
        Vehicle = {
            printOnCreate = true, -- it print in the server console when a vehicle is created
            Anti_BlackListed_Vehicle = {
                active = 3, --( 1 = delete vehicle, 2 = kick, 3 = ban )
                vehicles = {
                    'tug',
                    'dinghy5',
                    'patrolboat',
                    'cerberus2',
                    'cerberus3',
                    'cerberus',
                    'phantom2',
                    'akula',
                    'annihilator',
                    'buzzard',
                    'savage',
                    'hunter',
                    'valkyrie',
                    'valkyrie2',
                    'apc',
                    'barrage',
                    'halftrack',
                    'khanjali',
                    'minitank',
                    'rhino',
                    'thruster',
                    'trailersmall2',
                    'oppressor',
                    'oppressor2',
                    'caracara',
                    'bruiser2',
                    'bruiser',
                    'bruiser3',
                    'dune3',
                    'dune4',
                    'dune5',
                    'insurgent',
                    'insurgent2',
                    'insurgent3',
                    'menacer',
                    'nightshark',
                    'technical',
                    'technical2',
                    'technical3',
                    'hydra',
                    'lazer',
                    'strikeforce',
                    'limo2',
                    'scramjet',
                    'vigilante',
                    'voltic2',
                    'freight',
                    'armytanker',
                    'armytrailer',
                }
            },

            Anti_Vehicle_Exploiting = {
                active = nil, -- beta, blocks all type of vehicle exploiting: delete vehicle, fly vehicle... ( high consommation ~0.01-0.05ms, it disables all npc to lower the consommation )
                ratelimit = { -- anti mass vehicle delete
                    active = true, 
                    seconds = 1, 
                    max = 10
                }
            },

            Anti_Not_Script_Vehicle_Spawn = { -- detects when try to spawn a vehicle with a not whitelisted resource
                active = 3, --( 1 = delete vehicle, 2 = kick, 3 = ban )
                resources = { -- whitelisted resources
                  'ParaziaRP','kFramework','burgershot','qs-smartphone','ParaCore',"airplanedealer"

                }
            },

            Modifier = {
                Anti_Vehicle_Speed_Modifier = {
                    active = nil, 
                    maxSpeed = 600, -- max vehicle speed (in km/h)
                },
                Anti_Vehicle_Damage_Modifier = {
                    active = true,  
                    maxModifier = 15,
                },
                Anti_Vehicle_Power_Modifier = {
                    active = true,  
                    maxModifier = 15,
                },
                Anti_Vehicle_Top_Speed_Modifier = {
                    active = nil, 
                    maxModifier = 50,
                },
                Anti_Vehicle_Defense_Modifier = {
                    active = true, 
                    maxModifier = 15,
                }
            },

            ratelimit = { -- anti mass vehicle spawn
                active = true, 
                seconds = 1, 
                max = 5
            }
        }, 
        Object = {
            printOnCreate = true, -- it print in the server console when a object is created
            Anti_Not_WhiteListed_Object = {
                active = 1, --( 1 = delete object, 2 = kick, 3 = ban )
                objects = {
                    'prop_mil_crate_01',
                    'bkr_prop_coke_box_01a',
			        'bkr_prop_coke_doll_bigbox',
			        'bkr_prop_weed_bigbag_01a',
			        'bkr_prop_weed_bigbag_02a',
			        'bkr_prop_weed_bigbag_03a',
		         	'bkr_prop_weed_bigbag_open_01a',
		         	'bkr_prop_weed_bucket_01a',
		         	'bkr_prop_weed_bucket_01b',
		        	'bkr_prop_weed_bucket_01c',
                    'prop_phone_mega_1',
                    'prop_phone_mega_10',
                    'prop_phone_mega_2',
                    'prop_phone_mega_3',
                    'prop_phone_mega_4',
                    'prop_phone_mega_5',
                    'prop_phone_mega_6',
                    'prop_phone_mega_7',
                    'prop_phone_mega_8',
                    'prop_phone_mega_9',
                    'prop_cs_heist_bag_02',
                    'vw_prop_vw_luckywheel_02a',
                    'vw_prop_vw_luckywheel_01a',
                    'vw_prop_vw_jackpot_on',
                    'vw_prop_vw_casino_podium_01a',
                    'prop_ballistic_shield',
                    'prop_tree_pine_02',
                    'prop_tree_pine_01',
                    'prop_ld_fireaxe',
                    'prop_tree_log_02',
                    'prop_tool_pickaxe',
                    'p_cs_scissors_s',
                    'hei_prop_heist_drill',
                    'hei_p_m_bag_var22_arm_s',
                    'prop_fishing_rod_01',
                    'p_michael_backpack_s',
                    'prop_cs_ciggy_01',
                    'prop_cigar_01',
                    'hei_prop_heist_box',
                    'prop_single_rose',
                    'hei_heist_sh_bong_01',
                    'prop_ld_suitcase_01',
                    'prop_security_case_01',
                    'prop_police_id_board',
                    'prop_novel_01',
                    'prop_snow_flower_02',
                    'v_ilev_mr_rasberryclean',
                    'prop_tourist_map_01',
                    'prop_beggers_sign_03',
                    'p_cs_joint_02',
                    'prop_amb_ciggy_01',
                    'prop_ld_case_01',
                    'prop_cs_tablet',
                    'prop_npc_phone_02',
                    'p_amb_brolly_01',
                    'prop_anim_cash_pile_01',
                    'prop_pap_camera_01',
                    'ba_prop_battle_champ_open',
                    'p_amb_coffeecup_01',
                    'prop_ecola_can',
                    'prop_drink_whisky',
                    'prop_amb_beer_bottle',
                    'prop_plastic_cup_02',
                    'prop_drink_redwine',
                    'prop_drink_champ',
                    'prop_champ_flute',
                    'prop_amb_donut',
                    'prop_sandwich_01',
                    'prop_cs_burger_01',
                    'prop_choc_ego',
                    'prop_acc_guitar_01',
                    'prop_el_guitar_01',
                    'prop_el_guitar_03',
                    'ba_prop_battle_glowstick_01',
                    'ba_prop_battle_hobby_horse',
                    'p_amb_clipboard_01',
                    'prop_notepad_01',
                    'prop_sponge_01',
                    'prop_barrier_work05',
                    'prop_roadcone02a',
                    'p_ld_stinger_s',
                }
            },

            Anti_Not_Script_Object_Spawn = { -- detects when a player try to spawn a object with a not whitelisted resource
                active = 3, --( 1 = delete object, 2 = kick, 3 = ban )
                resources = { -- whitelisted resources
                   'ParaziaRP','qs-smartphone','kFramework','ParaCore','fourgon','prz_atmrobbery'
                }
            },

            ratelimit = { -- anti mass object spawn
                active = nil, 
                seconds = 1,
                max = 15
            }
        }
    },
    
    --# Weapon 

    Weapon = {
        Anti_Infinite_Ammo = 3, --(1 = stop infinite ammo (i don't recommand), 2 = kick, 3 = ban)
        Anti_Explosive_Weapon = 3, --(1 = remove weapon, 2 = kick, 3 = ban) 
        Anti_PickUp_Spawn = 1, --( 1 = remove weapon, 2 = kick, 3 = ban ) 
        CustomWeapons = { -- here put your customs weapons (addons)
            'WEAPON_SCAR17FM',
        },
        Event_Protection = {
            Anti_Give_Weapon_To_Player = true, -- anti give weapon to player from cheater client side ( don't detect trigger )
            Anti_Remove_Weapon_From_Player = true, -- anti remove weapon from player from cheater client side ( don't detect trigger )
            Anti_Remove_All_Weapons_From_Player = true -- anti remove all weapons from player from cheater client side ( don't detect trigger )
        },
        Anti_BlackListed_Weapon = {
            active = 3, --(1 = remove weapon, 2 = kick, 3 = ban) 
            weapons = {
                'weapon_raypistol',
                'weapon_raycarbine', 
                'weapon_railgun', 
                'weapon_rpg',
                'weapon_grenadelauncher', 
                'weapon_grenadelauncher_smoke', 
                'weapon_minigun', 
                'weapon_firework', 
                'weapon_hominglauncher', 
                'weapon_compactlauncher', 
                'weapon_rayminigun', 
                'weapon_emplauncher', 
                'weapon_grenade', 
                'weapon_molotov', 
                'weapon_stickybomb', 
                'weapon_proxmine', 
                'weapon_pipebomb', 
                'weapon_flare',
            }
        },
        Anti_Shot = {
            active = nil, 
            ratelimit = { -- anti mass shot
                active = nil, 
                seconds = 1,
                max = 25
            }
        },
        Modifier = {
            Anti_Weapon_Clip_Modifier = true, 
            Anti_Weapon_Defense_Modifier = {
                active = true,
                maxModifier = 1.0
            },
            Anti_Weapon_Damage_Modifier = {
                active = true,
                maxModifier = 1.0
            },
            Anti_Melee_Defense_Modifier = {
                active = true,
                maxModifier = 1.0
            },
            Anti_Melee_Damage_Modifier = {
                active = true,
                maxModifier = 1.0
            }
        }
    },

    --# Explosion 

    Explosion = {
        printOnCreate = true, -- it print in the server console when a explosion is created
        Anti_Mortal_Explosion = true,
        Anti_Silent_Explosion = true,
        Anti_Invisible_Explosion = true,
        Anti_Camera_Shake_Explosion = 1, --( 1 = stop explosion, 2 = kick, 3 = ban)
        Anti_Not_WhiteListed_Explosion_Spawn = {
            active = true, 
            explosions = { -- whitelisted explosions
			0,
            7,
            8,
			3,
			4,
            9,
            10,
            11,
            12,
            13,
            14,
            15,
            16,
            17,
            18,
            23,
            28,
            29,
            24,
            30,
            31,
            34,
            39

            } 
        },
        ratelimit = { -- anti mass explosion spawn
            active = true, 
            seconds = 1,
            max = 10
        },

        Particle = {
            Anti_Not_WhiteListed_Particle = {
                active = true, 
                particles = { -- whiteslited particles
                    -- 'string', 
                    -- number
                }
            },
            ratelimit = { -- anti mass particles spawn
                active = true, 
                seconds = 1,
                max = 10
            }
        },
        Projectile = {
            Anti_Not_WhiteListed_Projectile = {
                active = true, 
                projectiles = { -- whitelisted projectiles
                    "w_pi_plasma_bullet",
                    "AMMO_PLASMAP"
                }
            },
            ratelimit = { -- anti mass projectiles spawn
                active = true, 
                seconds = 1,
                max = 10
            }
        },
        Fire = {
            ratelimit = { -- anti mass fire spawn
                active = true, 
                seconds = 5,
                max = 90
            }
        },
    },

    --# FrameWork

    FrameWork = {
        Esx = {
            active = true, -- activate esx compatibilities
            fetch = function() -- function to get esx
                local ESX 
                while ESX == nil do 
                    TriggerEvent('sova:KraKss0TEX0', function(obj)
                        ESX = obj
                    end)
                    Wait(1000)
                end
                return ESX
            end,
            admin_esx = true, -- activate admin menu & commands esx options
            Anti_Give_Weapon_ESX = {
                active = 3, --( 1 = remove weapon, 2 = kick, 3 = ban )
                item_weapon = { -- (soon)
                    active = nil, 
                    weapon = {
                       
                    }
                }
            },
            Bypass = {
                active = nil,
                player_loaded = 'esx:playerLoaded',
                groups = {
                   
                    superadmin = 'admin',
                    mod = 'mode'
                }
            }
        }
    }
}