--[[
  This file is part of Ronflex Shop.

  Copyright (c) Ronflex Shop - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

Jail = {}
Jail.ESX = "" --A laisser vide de base

Jail.PointSortie = vector3(1847.2439, 2586.4255, 45.6721) -- Position de sortie du jouer
Jail.PointEntrer = vector3(1766.12, 2488.0, 46.74) -- Position de spawn 

Jail.WebhookJail = "https://discord.com/api/webhooks/1090020024577691648/xU95E7rnK6htoq8Ucx3JwSrT14hC7ItixWVXYWYltyM15mVUTOj1s4ZKGNkxkUCckRbK" -- Logs lorsqu'il est jail
Jail.WebhookUnJail = "https://discord.com/api/webhooks/1090020133013029064/ADMRCSCIjcmRr_cMZ7ifz8XakWO3GAiTN8qsgvhnHX1aWEwp9J2ydCiqdPbDaWLl8TZm" -- Logs lorsqu'il est unjail
Jail.WebhookJailOffline = "https://discord.com/api/webhooks/1090020200201597008/r4uZmGkFzXpXp2wHFenEg0YSJ-P4l_8AdFhiE3h4cxkFz6XSoGkYS3vPJ1U6ZEJBJWKP"-- Logs lorsqu'il est jailoffline
Jail.StaffOnlyUnjailPlayerJail = true -- Vous permet de choisir si UNIQUEMENT le staff qui à jail la personne peut le unajil
Jail.TimerJailMortDeco = 10 -- Temps que la personne sera en jail si elle déco
Jail.JailPlayerDead = false -- Jailurer si la perosnne est jail quand elle déco en étant morte


--[[

Pour retirer le joueur de la table afin que quand il est revive il ne soit plus dans la table
pour le jail mettez de trigger:

TriggerServerEvent("ronflex:updatejailplayerider", true)

--]]