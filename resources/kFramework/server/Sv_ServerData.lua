local Server = GetConvar('sv_type', 'FA')
local Servers = {
	['FA'] = {
		drugs = {
			WeedField = vector3(2432.08, 4970.43, 42.35),
			WeedProcessing = vector3(2434.13, 4964.28, 42.35),
			CokeField = vector3(1014.47, -2892.66, 15.22),
			CokeProcessing = vector3(1090.84, -3194.55, -38.99),
			MethField = vector3(1391.94, 3606.08, 38.94),
			MethProcessing = vector3(-19.65, 3029.21, 41.65),
			OpiumField = vector3(3817.2, 4483.08, 6.37),
			OpiumProcessing = vector3(3807.83, 4478.6, 6.37),
			FlakkaField = vector3(1925.03, 5100.78, 41.92),
			FlakkaProcessing = vector3(92.75, 3753.34, 40.77)

		}
	}
}

exports('GetData', function(key)
	return Servers[Server][key]
end)