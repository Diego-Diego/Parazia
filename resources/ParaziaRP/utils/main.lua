

nbPlayerTotal = 0
RegisterNetEvent('xr_core:updatePlayerCount')
AddEventHandler('xr_core:updatePlayerCount', function(nbPlayer)
    nbPlayerTotal = nbPlayer
end)

-- Rich presence ↓
Citizen.CreateThread(function()
	while true do
		SetDiscordAppId(1088861126709743786)
		SetDiscordRichPresenceAsset('paraziarp')
		SetRichPresence(GetPlayerName(PlayerId()) .." ID : ["..GetPlayerServerId(PlayerId()).."] "  .. nbPlayerTotal .. "/512 Joueurs")

		SetDiscordRichPresenceAction(0, "・Rejoindre le discord", "https://discord.gg/paraziarp")
		Citizen.Wait(5000)
	end
end)

-- Pause menu ↓
Citizen.CreateThread(function()
    while true do
        AddTextEntry('PM_SCR_MAP', '~g~Carte de Los Santos')
        AddTextEntry('PM_SCR_GAM', '~g~Prendre l\'avion')
        AddTextEntry('PM_SCR_INF', '~g~Logs')
        AddTextEntry('PM_SCR_SET', '~g~Configuration')
        AddTextEntry('PM_SCR_STA', '~g~Statistiques')
        AddTextEntry('PM_SCR_GAL', '~g~Galerie')
        AddTextEntry('PM_SCR_RPL', '~g~Éditeur ∑')
        AddTextEntry('PM_PANE_CFX', '~g~ParaziaRP')
        AddTextEntry('FE_THDR_GTAO', "~g~ParaziaRP~w~ | ~g~discord.gg/paraziarp~w~ | ~g~ID : ~w~".. GetPlayerServerId(PlayerId()) .." | ~g~".. nbPlayerTotal .. "~w~/~g~2048 ~w~joueurs ~g~en ligne")
        AddTextEntry('PM_PANE_LEAVE', '~g~Se déconnecter de ParaziaRP')
        AddTextEntry('PM_PANE_QUIT', '~g~Quitter FiveM')
        Citizen.Wait(5000)
    end
end)