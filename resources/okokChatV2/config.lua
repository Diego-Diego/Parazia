Config = {}

--------------------------------
-- [Discord Logs]

Config.EnableDiscordLogs = true

Config.IconURL = "https://cdn.discordapp.com/attachments/1100193958929375455/1110957399679967232/logo.png"

Config.ServerName = "ParaziaRP"

-- To change a webhook color you need to set the decimal value of a color, you can use this website to do that - https://www.mathsisfun.com/hexadecimal-decimal-colors.html

Config.WebhookColor = "15188818"

--------------------------------
-- [Staff Groups]

Config.StaffGroups = { -- Groups that can access the different staff chats (/staff, /staffo, /sa)
	'_dev',
	'responsable',
	'gamemaster',
	'superadmin',
	'admin',
	'modo',
	'helper'
}

--------------------------------
-- [General]

Config.AllowPlayersToClearTheirChat = true

Config.ClearChatCommand = 'clear'

Config.EnableHideChat = true

Config.HideChatCommand = 'hide'

Config.ShowIDOnMessage = true -- Shows the player ID on every message that is sent

Config.ShowIDOnMessageForEveryone = false -- true: shows the player ID for everyone | false: shows it only for staffs

Config.ClearChatMessageTitle = 'SYSTEM'

Config.ClearChatMessage = 'The chat has been cleared!'

-- [Date Format]

Config.DateFormat = '%H:%M' -- To change the date format check this website - https://www.lua.org/pil/22.1.html

--------------------------------
-- [Time Out]

Config.TimeOutPlayers = true

Config.TimeOutCommand = "mute"

Config.RemoveTimeOutCommand = "unmute"

Config.ShowTimeOutMessageForEveryone = true

Config.TimeOutIcon = 'fas fa-gavel'

Config.MessageTitle = 'SERVER'

Config.TimeOutMessages = {
	['muted_for'] = '<b>{3}</b> has been muted for <b>{1}</b> minutes',
	['you_muted_for'] = 'You muted <b>{3}</b> for <b>{1}</b> minutes',
	['been_muted_for'] = 'You have been muted for <b>{0}</b> minutes',

	['you_unmuted'] = 'You unmuted <b>{2}</b>',
	['been_unmuted'] = 'You have been unmuted',

	['muted_message'] = 'You are muted for <b>{0}</b>',
	['seconds'] = ' seconds',
	['minutes'] = ' minutes',
	['hours'] = ' hours',
}

--------------------------------
-- [Job]

Config.JobChat = false

Config.JobCommand = 'jobc'

Config.JobIcon = 'fas fa-briefcase'

--------------------------------
-- [Private Message]

Config.EnablePM = true

Config.PMCommand = 'pm'

Config.PMIcon = 'fas fa-comment pm-icon'

Config.PMMessageTitle = "PM"

--------------------------------
-- [OOC/Me/Do/Try]

Config.Distance = 20.0

--------------------------------
-- [OOC]

Config.EnableOOC = false

Config.OOCCommand = 'ooc'

Config.OOCIcon = 'fas fa-door-open'

Config.OOCMessageTitle = 'OOC'

Config.OOCMessageWithoutCommand = true -- true: sends OOC message without command (/ooc) | false: doesn't send any message without it being a command

--------------------------------
-- [Me]

Config.EnableMeCommand = false

Config.MeCommand = 'me'

Config.MeIcon = 'fas fa-comment me-icon'

Config.MeMessageTitle = 'ME'

--------------------------------
-- [Do]

Config.EnableDoCommand = true

Config.DoCommand = 'do'

Config.DoIcon = 'fas fa-comment do-icon'

Config.DoMessageTitle = 'DO'

--------------------------------
-- [Try]

Config.EnableTryCommand = true

Config.TryCommand = 'try'

Config.TryIcon = 'fas fa-comment try-icon'

Config.TryMessageTitle = 'TRY'

--------------------------------
-- [Staff]

Config.EnableStaffCommand = false

Config.StaffCommand = 'staff'

Config.StaffMessageTitle = 'STAFF'

Config.StaffIcon = 'fas fa-shield-alt'

Config.AllowStaffsToClearEveryonesChat = true

Config.ClearEveryonesChatCommand = 'clearall'

Config.StaffSteamName = false

-- [Staff Only]

Config.EnableStaffOnlyCommand = true

Config.StaffOnlyCommand = 'staffo'

Config.StaffOnlyMessageTitle = 'STAFF ONLY'

Config.StaffOnlyIcon = 'fas fa-eye-slash'

Config.StaffOnlySteamName = false

-- [Server Announcement]

Config.EnableServerAnnouncement = true

Config.ServerAnnouncementCommand = 'sa'

Config.AnnouncementIcon = 'fas fa-exclamation-circle'

Config.AnnouncementMessageTitle = 'SERVER'

--------------------------------
-- [Advertisements]

Config.EnableAdvertisementCommand = false

Config.AdvertisementCommand = 'ad'

Config.AdvertisementPrice = 1000

Config.AdvertisementCooldown = 5 -- in minutes

Config.AdvertisementIcon = 'fas fa-ad'

--------------------------------
-- [Anonymous/Dark]

Config.EnableAnonymousCommand = false

Config.AnonymousCommand = 'anon'

Config.AnonymousPrice = 1000

Config.AnonymousCooldown = 5 -- in minutes

Config.WhatJobsCantSeeAnonymousChat = {
	'police',
	'ambulance',
}

Config.AnonymousIcon = 'fas fa-mask'

--------------------------------
-- [Twitch]

Config.EnableTwitchCommand = false

Config.TwitchCommand = 'twitch'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.TwitchList = {
	'steam:110000118a12j8a', -- Example, change this
}

Config.TwitchIcon = 'fab fa-twitch'

--------------------------------
-- [Youtube]

Config.EnableYoutubeCommand = false

Config.YoutubeCommand = 'youtube'

-- Types of identifiers: steam: | license: | xbl: | live: | discord: | fivem: | ip:
Config.YoutubeList = {
	'steam:110000118a12j8a', -- Example, change this
}

Config.YoutubeIcon = 'fab fa-youtube'

--------------------------------
-- [Twitter]

Config.EnableTwitterCommand = false

Config.TwitterCommand = 'twitter'

Config.TwitterIcon = 'fab fa-twitter'

--------------------------------
-- [Police]

Config.EnablePoliceCommand = false

Config.PoliceCommand = 'police'

Config.PoliceJobName = 'police'

Config.PoliceIcon = 'fas fa-bullhorn'

--------------------------------
-- [Ambulance]

Config.EnableAmbulanceCommand = false

Config.AmbulanceCommand = 'ambulance'

Config.AmbulanceJobName = 'ambulance'

Config.AmbulanceIcon = 'fas fa-ambulance'

--------------------------------
-- [Notifications]

Config.NotificationsText = {
	['disable_chat'] = { title = 'SYSTEM', message = 'Vous avez désactivé le chat', time = 5000, type = 'info'},
	['enable_chat'] = { title = 'SYSTEM', message = 'Vous avez activé le chat', time = 5000, type = 'info'},
	['ad_success'] = { title = 'ADVERTISEMENT', message = 'Publicité réalisée avec succès pour ${price}€', time = 5000, type = 'success'},
	['ad_no_money'] = { title = 'ADVERTISEMENT', message = "Vous n'avez pas assez d'argent pour faire une publicité", time = 5000, type = 'error'},
	['ad_too_quick'] = { title = 'ADVERTISEMENT', message = "Vous ne pouvez pas faire de publicité si rapidement", time = 5000, type = 'info'},
	['mute_not_adm'] = { title = 'SYSTEM', message = "Vous n'êtes pas administrateur", time = 5000, type = 'error'},
	['mute_id_inv'] = { title = 'SYSTEM', message = "L'identifiant est invalide", time = 5000, type = 'error'},
	['mute_time_inv'] = { title = 'SYSTEM', message = 'Le temps de silence est invalide', time = 5000, type = 'error'},
	['alr_muted'] = { title = 'SYSTEM', message = 'Cette personne est déjà masquée', time = 5000, type = 'error'},
	['alr_unmuted'] = { title = 'SYSTEM', message = 'Cette personne est déjà désactivée', time = 5000, type = 'error'},
	['an_success'] = { title = 'ANONYMOUS', message = 'Annonce faite avec succès pour le prix€', time = 5000, type = 'success'},
	['an_no_money'] = { title = 'ANONYMOUS', message = "Vous n'avez pas assez d'argent pour faire une publicité", time = 5000, type = 'error'},
	['an_too_quick'] = { title = 'ANONYMOUS', message = "Vous ne pouvez pas faire de publicité si rapidement", time = 5000, type = 'error'},
	['an_not_allowed'] = { title = 'ANONYMOUS', message = "Vous n'êtes pas autorisé à envoyer des messages dans le chat anonyme", time = 5000, type = 'error'},
	['is_muted'] = { title = 'ANONYMOUS', message = "Ce joueur est muet", time = 5000, type = 'error'},
}

Config.WebhookText = {
	['clear_all'] = 'Effacé toutes les discussions',
	['staff_msg'] = 'Staff message',
	['staff_chat_msg'] = 'Staff chat message',
	['sv_an'] = 'Annonce du serveur',
	['ad'] = 'Publicité',
	['twitch'] = 'Twitch',
	['youtube'] = 'Youtube',
	['twitter'] = 'Twitter',
	['police'] = 'Police',
	['ambulance'] = 'Ambulance',
	['job_chat'] = 'Chat Métier [${job}]',
	['pm_chat'] = 'Message privé à ${name} [${id}]',
	['ooc'] = 'OOC',
	['me'] = 'ME',
	['do'] = 'FAIRE',
	['try'] = 'ESSAYER',
	['muted'] = 'En sourdine [${id}]',
	['muted_for'] = 'Pour ${muteTime} minutes',
	['unmuted'] = 'Réactivé [${id}]',
	['p_unmuted'] = 'Le son du joueur a été réactivé',
	['anon'] = 'Anonymous',
}