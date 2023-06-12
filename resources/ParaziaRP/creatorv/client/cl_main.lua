ESX = nil

CreateThread(function()
    while ESX == nil do
        TriggerEvent(_Config.getESX, function(lib) ESX = lib end)
        Wait(10)
    end
end)

playerInfo = {
    surname = "",
    name = "",
    height = "",
    birthday = "",
    sex = "",
}

local FirstSpawn, PlayerLoaded = true, false

RegisterNetEvent('esx:playerLoaded')
AddEventHandler('esx:playerLoaded', function(xPlayer)
	PlayerLoaded = true
end)

AddEventHandler('playerSpawned', function()
	Citizen.CreateThread(function()
		while not PlayerLoaded do
			Citizen.Wait(10)
		end
		if FirstSpawn then
			ESX.TriggerServerCallback('esx_skin:getPlayerSkin', function(skin, jobSkin)
				if skin == nil then
                    TriggerEvent('instance:create', 'identity')
                    SetEntityCoords(PlayerPedId(), _Config.spawnPoint, false, false, false, false)
                    SetEntityHeading(PlayerPedId(), _Config.spawnHeading)
                    Client:SetPlayerBuckets(true)
                    Client:PlayAnimeCreator()
                    Client:CreatePlayerCam()
					Client:openIdentityMenu()
				else
                    TriggerEvent('skinchanger:loadSkin', skin)
				end
			end)
			FirstSpawn = false
		end
	end)
end)
