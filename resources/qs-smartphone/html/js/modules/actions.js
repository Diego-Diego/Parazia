$(document).ready(function () {
	$("input,textarea,.emojionearea-editor").keypress(function () {
		$.post('https://qs-smartphone/disableControls')
	});

	$("input,textarea,.emojionearea-editor").focus(function () {
		$.post('https://qs-smartphone/disableControls')
	});
	window.addEventListener('message', function (event) {
			if (event.data.action == "open"){
				QS.Phone.Data.QSMeta = event.data.QSMeta;
				customPhoneCoords = QS.Phone.Data.QSMeta.phoneCoords;
				QS.Phone.Functions.Open(event.data);
				QS.Phone.Functions.SetupCurrentCall(event.data.CallData);
				$('.phone-frame').attr('src', './img/' + event.data.phoneType)
				QS.Phone.Functions.LoadBackground(event.data.background, QS.Phone.Data.customWalls[event.data.phoneType])
				QS.Phone.Data.IsOpen = true;
				QS.Phone.Data.PlayerData = event.data.PlayerData;
				QS.Phone.Data.QSMeta = event.data.QSMeta;
				QS.Phone.Data.Webhook = event.data.webhook;
				StartDrag()
			}
			if (event.data.action == "updateConnection"){
				$(".signal").removeClass('low')
				$("#phone-notConnection").fadeOut(0)
				if (event.data.inMountain) {
					$(".signal").addClass('low')
					if (!isBypassedApp(QS.Phone.Data.currentApplication)) $("#phone-notConnection").fadeIn(0);
				}
				notSignal = event.data.inMountain;
			}
			if (event.data.action == "youtubeNearbySongAdd"){
				let {
					url, volume, time, playerid
				} = event.data
				Players[playerid] = {
					url,
					volume,
					time
				}
				PlayForPlayer(playerid)
			}
			if (event.data.action == "updateTime"){
				$('.current-time').html(formatTime(event.data.timeStamp ?? 0))
                const percent = (event.data.timeStamp / event.data.maxDuration) * 100
                $('.spotify-progress').css('width', percent + '%')
                $('.timeline .total-time').html(formatTime(event.data.maxDuration))
			}
			if (event.data.action == "removeMusicInWater"){
				QS.Phone.Animations.BottomSlideDown('.container', 400, -700);
				stopMusicInWater()
			}
			if (event.data.action == "spotifyNearbySongAdd"){
				spotifyPlayers[event.data.playerid] = {
					url: event.data.url,
					volume: event.data.volume,
					time: event.data.time
				}
				spotifyPlayForPlayer(event.data.playerid)
			}
			if (event.data.action == "youtubeNearbySongUpdateVolume"){
				Players[event.data.playerid].volume = event.data.volume;
				Players[event.data.playerid].Player.setVolume?.(Players[event.data.playerid].volume)
			}
			if (event.data.action == "spotifyNearbySongUpdateVolume"){
				spotifyPlayers[event.data.playerid].paused = event.data.paused;
				const state = spotifyPlayers[event.data.playerid].Player?.getPlayerState?.()
				if (event.data.paused) {
					if (state == 1) {
						spotifyPlayers[event.data.playerid].Player.pauseVideo()
					}
				} else {
					if (state == 2) {
						spotifyPlayers[event.data.playerid].Player.playVideo()
					}
				}
				spotifyPlayers[event.data.playerid].volume = event.data.volume;
				spotifyPlayers[event.data.playerid].Player.setVolume?.(spotifyPlayers[event.data.playerid].volume)
			}
			if (event.data.action == "youtubeNearbySongRemove"){
				StopForPlayer(event.data.playerid)
			}
			if (event.data.action == "spotifyNearbySongRemove"){
				spotifyStopForPlayer(event.data.playerid)
			}
			if (event.data.action == "inCharging"){
				if (event.data.charging) {
					$("#charging").fadeIn(0)
					document.documentElement.style.setProperty('--battery', '#00ff00');
				} else {
					$("#charging").fadeOut(0)
					document.documentElement.style.setProperty('--battery', '#fff');
				}
				charging = event.data.charging;
			}
			if (event.data.action == "updateBattery"){
				document.documentElement.style.setProperty('--batteryPercentage', event.data.battery + '%');
				changeBatteryColor(event.data.battery)
				if (event.data.battery <= 0) {
					if (QS.Phone.Data.currentApplication) uygulama_kapat();
					$("#close-screen").fadeIn(0)
					$(".phone-header").fadeOut(0)
					$("#date").fadeOut(0)
					$(".interactionDiv").fadeOut(0)
					$(".decorate-keys").fadeOut(0)
					$('#lock-screen').addClass('hidden')
					$('.menu-draggable').hide();
					notSignal = true
					notBattery = true;
				} else {
					$(".phone-header").fadeIn(0)
					$("#close-screen").fadeOut(0)
					$("#date").fadeIn(0)
					$(".decorate-keys").fadeIn(0)
					$(".interactionDiv").fadeIn(0)
					notBattery = false;
				}
			}
			if (event.data.action == "close"){
				QS.Phone.Functions.CloseGeneral()
			}
			if (event.data.action == "tiktokChoiceVideo"){
				ChoiceVideo(event.data.url)
			}
			if (event.data.action == "DosyaAl"){
				$(".bluetooth-panel-received").css("display", "block");
				$(".QSSharedtext").html(`<strong>${event.data.veri.firstname} ${event.data.veri.lastname}</strong> ` + QS.Phone.Functions.Lang("BLUETOOTH_SUCCESS") + ``);

				QS.Phone.Notifications.Add("./img/apps/settings.png", QS.Phone.Functions.Lang("BLUETOOTH_TITLE"), QS.Phone.Functions.Lang("BLUETOOTH_RECEIVED"))
			}
			if (event.data.action == "Purchased"){
				inUber = false
				$('#uber_active').html(QS.Phone.Functions.Lang("UBER_ACTIVE"))
				$('#uber_active').css('background-color', '#ac0b0b')
			}
			if (event.data.action == "darkwebForceClose"){
				$('.phone-application-container').css('transform', 'scale(0)')
				QS.Phone.Animations.TopSlideUp('.' + QS.Phone.Data.currentApplication + "-app", 400, -160);
				CanOpenApp = false;
				setTimeout(function () {
					QS.Phone.Functions.ToggleApp(QS.Phone.Data.currentApplication, "none");
					CanOpenApp = true;
				}, 400)
				ChangeHeaderColor("white", 300);
				QS.Phone.Data.currentApplication = null;
			}
			if (event.data.action == "updateNotifies"){
				LockScreen_Notifies = event.data.notifies
				LoadLockScreenNotifies()
			}
			if (event.data.action == "UpdateNotes"){
				$.post('https://qs-smartphone/BringNotes', JSON.stringify({}), function (Notes) {
					SetupNotes(Notes);
				})
			}
			if (event.data.action == "LoadPhoneData"){
				QS.Phone.Functions.LoadBackground(event.data.background, QS.Phone.Data.customWalls[event.data.phoneType])
				QS.Phone.Functions.LoadPhoneData(event.data);
			}
			if (event.data.action == "CheckLoad"){ // Chequeo para ver si nui termino de cargar
				$.post('https://qs-smartphone/checked', function () {});
			}
			if (event.data.action == "TamEkranKapat"){
				ekran(0);
			}
			if (event.data.action == "RefreshGroupWhatsApp"){
				QS.Phone.Functions.RefreshGroupWhatsApp();
			}
			if (event.data.action == "RefreshPostsInstagram"){
				QS.Phone.Functions.RefreshPostsInstagram();

			}
			if (event.data.action == "RefreshStoriesInstagram"){
				QS.Phone.Functions.RefreshStoriesInstagram();

			}
			if (event.data.action == "TamEkranGecis"){
				ekran(1);
			}
			if (event.data.action == "BildirimManager"){
				BildirimManager(event.data.bildirim);
			}
			if (event.data.action == "AddPoliceAlert"){
				AddPoliceAlert(event.data);
			}
			if (event.data.action == "ResetPhonePos"){
				localStorage.setItem("zoom-phone", 100)
				$("body").css("zoom", `100%`)
			}
			if (event.data.action == "AddNewCryptoTransfer"){
				AddNewCryptoTransfer(event.data.data);
			}
			if (event.data.action == "UpdateTransactions"){
				RefreshCryptoTransactions(event.data);
			}
			if (event.data.action == "Notification"){
				QS.Phone.Notifications.Add(event.data.PhoneNotify.icon, event.data.PhoneNotify.title, event.data.PhoneNotify.text, event.data.PhoneNotify.color, event.data.PhoneNotify.timeout);
			}
			if (event.data.action == "tiktokNotify"){
				QS.Phone.Notifications.Add("./img/apps/tiktok.png", "Tiktok", event.data.msg)
			}
			if (event.data.action == "PhoneNotification"){
				QS.Phone.Notifications.Add(event.data.PhoneNotify.icon, event.data.PhoneNotify.title, event.data.PhoneNotify.text, event.data.PhoneNotify.color, event.data.PhoneNotify.timeout);
			}
			if (event.data.action == "RefreshAppAlerts"){
				QS.Phone.Functions.SetupAppWarnings(event.data.AppData);
			}
			if (event.data.action == "UpdateMentionedTweets"){
				QS.Phone.Notifications.LoadMentionedTweets(event.data.Tweets);
			}
			if (event.data.action == "UpdateBank"){
				$(".bank-app-account-balance").html(QS.Phone.Functions.Lang("CURRENCY_SYMBOL") + event.data.NewBalance);
				$(".bank-app-account-balance").data('balance', event.data.NewBalance);
			}
			if (event.data.action == "UpdateMessageChat"){
				if (QS.Phone.Data.currentApplication != "messages") {
					if (messages_notifications) {
						QS.Phone.Notifications.Add("./img/apps/messages.png", QS.Phone.Functions.Lang("MESSAGE_TITLE"), QS.Phone.Functions.Lang("MESSAGE_NEW"));
					}
				}
				if (QS.Phone.Data.currentApplication == "messages") {
					if (QUASAR.currentNumber !== null && QUASAR.currentNumber == event.data.chatNumber) {
						GetMessagesFromPhone(QUASAR.currentNumber);
					}
				}
			}
			if (event.data.action == "UpdateMessageChatEmergency"){
				if (QS.Phone.Data.currentApplication == "messages") {
					if (QUASAR.currentNumber !== null && QUASAR.currentNumber == event.data.chatNumber) {
						GetMessagesFromPhone(QUASAR.currentNumber);
					}
				}
			}
			if (event.data.action == "UpdateChat"){
				if (QS.Phone.Data.currentApplication == "whatsapp") {
					if (OpenedChatData.phone !== null && OpenedChatData.phone == event.data.chatNumber) {
						$.post('https://qs-smartphone/GetWhatsappChat', JSON.stringify({
							phone: OpenedChatData.phone
						}), function (chat) {
							GlobalChatData.messages = JSON.parse(chat.messages);
							SetupChatMessages(GlobalChatData);
						});
					} else {
						var opentabmessages = $('.whatsapp-tabs #messages').is(':visible');

						if (opentabmessages) {
							$.post('https://qs-smartphone/GetWhatsappChats', JSON.stringify({}), function (chats) {
								LoadWhatsappChats(chats);
							});
						}
						if (whatsapp_notifications) {
							QS.Phone.Notifications.Add("./img/apps/whatsapp.png", QS.Phone.Functions.Lang("WHATSAPP_TITLE"), QS.Phone.Functions.Lang("MESSAGE_NEW"));
						}
					}
				} else {
					$.post('https://qs-smartphone/UpdateChat:NotifyLockScreen:App', JSON.stringify({}), function () {});
					if (whatsapp_notifications) {
						QS.Phone.Notifications.Add("./img/apps/whatsapp.png", QS.Phone.Functions.Lang("WHATSAPP_TITLE"), QS.Phone.Functions.Lang("MESSAGE_NEW"));
					}
				}
			}
			if (event.data.action == "UpdateTinderMessages"){
				if (QS.Phone.Data.currentApplication != "tinder") {
					if (tinder_notifications) {
						QS.Phone.Notifications.Add("./img/apps/tinder.png", QS.Phone.Functions.Lang("TINDER_TITLE"), QS.Phone.Functions.Lang("TINDER_NEW"));
					}
				}
				if (QS.Phone.Data.currentApplication == "tinder") {
					if (openedPhone !== null && openedPhone == event.data.chatNumber) {
						$.post('https://qs-smartphone/GetTinderMessages', JSON.stringify({}), function (chat) {
							messages = chat;
							GetTinderMessagesFromPhone(messages[GetOpenedChatId(openedPhone)]);
						});
					}
				} else {
					if (whatsapp_notifications) {
						QS.Phone.Notifications.Add("./img/apps/whatsapp.png", QS.Phone.Functions.Lang("WHATSAPP_TITLE"), QS.Phone.Functions.Lang("WHATSAPP_NEW"));
					}
				}
			}
			if (event.data.action == "UpdateGroupChat"){

				if (QS.Phone.Data.currentApplication == "whatsapp") {

					if (OpenedChatData.group !== null && OpenedChatData.group == event.data.chatNumber) {

						$.post('https://qs-smartphone/GetWhatsappGroupMessages', JSON.stringify({
							number: OpenedChatData.group
						}), function (messages) {
							if (messages) {
								LoadMessagesGroup(messages);
								$('.whatsapp-openedgroup-messages').animate({
									scrollTop: 9999
								}, 1);
							}
						});
					} else {
						var opentabgroups = $('.whatsapp-tabs #groups').is(':visible');

						if (opentabgroups) {
							$.post('https://qs-smartphone/GetWhatsappChats', JSON.stringify({}), function (chats) {
								LoadWhatsappChats(chats);
							});
						}
						if (whatsapp_notifications) {
							QS.Phone.Notifications.Add("./img/apps/whatsapp.png", QS.Phone.Functions.Lang("WHATSAPP_GROUP_TITLE"), QS.Phone.Functions.Lang("MESSAGE_NEW"));
						}
					}
				} else {
					$.post('https://qs-smartphone/Update:NotifyLockScreen:App', JSON.stringify({}), function () {});

					$.post('https://qs-smartphone/NewNotifies', JSON.stringify({
						msg: QS.Phone.Functions.Lang("MESSAGE_NEW"),
						app: 'WHATSAPP',
						time: new Date(),
						head: QS.Phone.Functions.Lang("WHATSAPP_GROUP_TITLE"),
						phone: QS.Phone.Data.PlayerData.charinfo.phone,
					}));

					if (whatsapp_notifications) {
						QS.Phone.Notifications.Add("./img/apps/whatsapp.png", QS.Phone.Functions.Lang("WHATSAPP_GROUP_TITLE"), QS.Phone.Functions.Lang("MESSAGE_NEW"));
					}
				}
			}
			if (event.data.action == "UpdateHashtags"){
				QS.Phone.Notifications.LoadHashtags(event.data.Hashtags);
			}
			if (event.data.action == "RefreshWhatsappAlerts"){
				QS.Phone.Functions.ReloadWhatsappAlerts(event.data.Chats);
			}
			if (event.data.action == "CancelOutgoingCall"){
				CallingSound.pause();
				CallingSound.currentTime = 0;
				QS.Phone.Data.CallActive = false;
				QS.Phone.Functions.CloseGeneral();
				CallOngoingDisappear(100)
				CallAlertDisappear(50)
				CancelOutgoingCall();
			}
			if (event.data.action == "IncomingCallAlert"){
				$.post('https://qs-smartphone/HasPhone', JSON.stringify({}), function (HasPhone) {
					if (HasPhone) {
						IncomingCallAlert(event.data.CallData, event.data.Canceled, event.data.AnonymousCall);
						if (QS.Phone.Data.CallActive) {
							if (!QS.Phone.Data.IsOpen) {
								QS.Phone.Animations.BottomSlideUp('.container', 400, -580)
							}
						}
					}
				});
			}
			if (event.data.action == "SetupHomeCall"){
				QS.Phone.Data.CallActive = true
				QS.Phone.Functions.SetupCurrentCall(event.data.CallData);
			}
			if (event.data.action == "CallAlertAppear"){
				CallAlertAppear(50)
			}
			if (event.data.action == "AnswerCall"){
				CallingSound.pause();
				CallingSound.currentTime = 0;
				QS.Phone.Data.CallActive = true
				QS.Phone.Functions.AnswerCall(event.data.CallData);
				if (!QS.Phone.Data.IsOpen) {
					QS.Phone.Animations.BottomSlideUp('.container', 400, -580)
				}
			}
			if (event.data.action == "UpdateCallTime"){
				var CallTime = event.data.Time;
				var date = new Date(null);
				date.setSeconds(CallTime);
				var timeString = date.toISOString().substr(14, 5);
				
				$(".phone-currentcall-timer").html(timeString);
				$(".phone-call-ongoing-time").html(timeString);
				if (notSignal) {
					$.post('https://qs-smartphone/CancelOngoingCall');
					$('.phone-application-container').css('transform', 'scale(0)')
					setTimeout(function () {
						QS.Phone.Functions.ToggleApp("phone-call", "none");
					}, 400)
					ChangeHeaderColor("white", 300);
					QS.Phone.Data.CallActive = false;
					QS.Phone.Data.currentApplication = null;
				}
			}
			if (event.data.action == "CancelOngoingCall"){
				CallingSound.pause();
				CallingSound.currentTime = 0;
				$('.phone-application-container').css('transform', 'scale(0)')
				setTimeout(function () {
					QS.Phone.Functions.ToggleApp("phone-call", "none");

				}, 400)
				ChangeHeaderColor("white", 300);

				QS.Phone.Data.CallActive = false;
				QS.Phone.Data.currentApplication = null;
			}
			if (event.data.action == "RefreshContacts"){
				QS.Phone.Functions.LoadContacts(event.data.Contacts);
			}
			if (event.data.action == "UpdateMails"){
				QS.Phone.Functions.SetupMails(event.data.Mails);
			}
			if (event.data.action == "RefreshMyStorieInsta"){
				QS.Phone.Functions.ReceiveMyStorie(event.data.stories);
			}
			if (event.data.action == "RefreshAdverts"){
				if (QS.Phone.Data.currentApplication == "advert") {
					QS.Phone.Functions.RefreshAdverts(event.data.Adverts);
				}
			}
			if (event.data.action == "UpdateApplications"){
				QS.Phone.Data.PlayerJob = event.data.JobData;
				QS.Phone.Functions.SetupApplications(event.data);
			}
			if (event.data.action == "RefreshGroupChat"){
				QS.Phone.Functions.RefreshGroupChat(event.data.messageData)
			}
		
	})
});