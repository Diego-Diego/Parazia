
Config = {}
Config.Locale = 'fr'

Config.DefaultGroup = 'user'
Config.DefaultLevel = '0'
Config.CommandPrefix = '/'
Config.DefaultPosition = vector3(-822.91, -123.28, 28.18)

Config.Accounts = {
	['cash'] = {
		label = _U('cash'),
		starting = 50000,
		priority = 1
	},
	['dirtycash'] = {
		label = _U('dirtycash'),
		starting = 0,
		priority = 2
	},
	['bank'] = {
		label = _U('bank'),
		starting = 50000,
		priority = 3
	},
	['chip'] = {
		label = 'Jetons Casino',
		starting = 0,
		priority = 4
	}
}

Config.EnableSocietyPayouts = false
Config.PaycheckInterval = 30 * 60 * 1000
Config.MaxWeight = 24

Config.ContribWeapon = {
	['WEAPON_HATCHET'] = true,
    ['WEAPON_BAT'] = true,
    ['WEAPON_DOUBLEACTION'] = true,
    ['WEAPON_NAVYREVOLVER'] = true,
    ['WEAPON_ASSAULTRIFLE'] = true,
    ['WEAPON_SPECIALCARBINE'] = true,
    ['WEAPON_COMBATPDW'] = true,
    ['WEAPON_KATANA'] = true,
    ['WEAPON_GADGETPISTOL'] = true,
    ['WEAPON_CASABLANCA'] = true,
    ['WEAPON_PISTOL_MK2'] = true,
    ['WEAPON_MACHINEPISTOL'] = true,
    ['GADGET_PARACHUTE'] = true,
    ['WEAPON_STONE_HATCHET'] = true,
    ['WEAPON_PUMPSHOTGUN'] = true,
    ['WEAPON_HEAVYSHOTGUN'] = true,
    ['WEAPON_APPISTOL'] = true,
    ['WEAPON_COMBATMG_MK2'] = true,
    ['WEAPON_MG'] = true,
    ['WEAPON_COMBATMG'] = true,
    ['WEAPON_MARKSMANRIFLE_MK2'] = true,
    ['WEAPON_HEAVYSNIPER_MK2'] = true,
    ['WEAPON_ASSAULTSMG'] = true,
    ['WEAPON_BULLPUPSHOTGUN'] = true,
    ['WEAPON_ASSAULTSHOTGUN'] = true,
}