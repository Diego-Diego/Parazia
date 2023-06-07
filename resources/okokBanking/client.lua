ESX = nil

Citizen.CreateThread(function()
	while ESX == nil do
		TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
		Citizen.Wait(5000)
	end
end)

local PlayerData = {}
local trans = {}
local societyTrans = {}
local societyIdent, societyDays
local didAction = false
local isBankOpened = false
local canAccessSociety = false
local society = ''
local societyInfo
local closestATM, atmPos
local isDead = false
local playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney

Citizen.CreateThread(function()
	while ESX.GetPlayerData().job == nil do
		Citizen.Wait(10)
	end
	PlayerData = ESX.GetPlayerData()
end)

AddEventHandler('esx:onPlayerDeath', function()
	isDead = true
end)

AddEventHandler('playerSpawned', function(spawn)
	isDead = false
end)

Citizen.CreateThread(function()
	if Config.ShowBankBlips then
		Citizen.Wait(2000)
		for k,v in ipairs(Config.BankLocations)do
			local blip = AddBlipForCoord(v.x, v.y, v.z)
			SetBlipSprite(blip, v.blip)
			SetBlipDisplay(blip, 4)
			SetBlipScale(blip, v.blipScale)
			SetBlipColour(blip, v.blipColor)
			SetBlipAsShortRange(blip, true)
			BeginTextCommandSetBlipName("STRING")
			AddTextComponentString(v.blipText)
			EndTextCommandSetBlipName(blip)
		end
	end
end)

function NearATM()
	local ped = PlayerPedId()
	local pos = GetEntityCoords(ped)
	
	for i = 1, #Config.ATM do
		local atm = GetClosestObjectOfType(pos.x, pos.y, pos.z, Config.ATMDistance + 5, Config.ATM[i].model, false, false, false)
		if DoesEntityExist(atm) then
			if atm ~= closestATM then
				closestATM = atm
				atmPos = GetEntityCoords(atm)
			end
			local dist = #(pos - atmPos)
			
			if dist <= Config.ATMDistance then
				return true
			elseif dist <= Config.ATMDistance + 5 then
				return "update"
			end
		end
	end
end

function NearBank()
	local pos = GetEntityCoords(PlayerPedId())

	for k, v in pairs(Config.BankLocations) do
		local dist = #(vector3(v.x, v.y, v.z) - pos)

		if dist <= v.BankDistance then
			return true
		elseif dist <= v.BankDistance + 5 then
			return "update"
		end
	end
end

Citizen.CreateThread(function()
	local inRange = false
	local shown = false
	local notified = false

	while true do
		local playerped = PlayerPedId()
		inRange = false
		Citizen.Wait(0)
		if NearBank() and not isBankOpened and NearBank() ~= "update" then
			if not Config.okokTextUI then
				ESX.ShowHelpNotification("Appuyez sur ~INPUT_PICKUP~ pour accéder à la ~b~Banque~s~")
			else
				inRange = true
			end

			if IsControlJustReleased(0, 38) then

				if not isDead and not IsPedInAnyVehicle(playerped) then
					SetNuiFocus(true, true)
					SendNUIMessage({
						action = 'loading_data',
					})
					Citizen.Wait(500)
					openBank()
				else
					if not notified then
						exports['okokNotify']:Alert(_L('not_use_bank').title, _L('not_use_bank').text, _L('not_use_bank').time, _L('not_use_bank').type)
						notified = true
					end
				end
			end
		elseif NearBank() == "update" then
			Citizen.Wait(300)
		else
			Citizen.Wait(1000)
		end

		if inRange and not shown then
			shown = true
			exports['okokTextUI']:Open(_L('open_banking').text, _L('open_banking').color, _L('open_banking').side)
		elseif not inRange and shown then
			shown = false
			exports['okokTextUI']:Close()
		end
		notified = false
	end
end)

RegisterNetEvent("open:atm")
AddEventHandler("open:atm", function()
	local inRange = false
	local shown = false
	local notified = false

	local dict = 'anim@amb@prop_human_atm@interior@male@enter'
	local anim = 'enter'
	local ped = PlayerPedId()

	if NearATM() and not isBankOpened and NearATM() ~= "update" then
		if not isDead and not IsPedInAnyVehicle(ped) then
			ESX.TriggerServerCallback("okokBanking:HasCreditCard", function(hasItem)
				if not hasItem then
					exports['okokNotify']:Alert(_L('no_creditcard').title, _L('no_creditcard').text, _L('no_creditcard').time, _L('no_creditcard').type)
					return
				else
					ESX.TriggerServerCallback("okokBanking:GetPIN", function(pin)
						if pin then
							if not isBankOpened then
								isBankOpened = true
								RequestAnimDict(dict)

								while not HasAnimDictLoaded(dict) do
									Citizen.Wait(7)
								end

								TaskPlayAnim(ped, dict, anim, 8.0, 8.0, -1, 0, 0, 0, 0, 0)
								Citizen.Wait(Config.AnimTime*1000)
								ClearPedTasks(ped)

								TriggerEvent("okokBanking:OpenATM", pin)
								Citizen.Wait(3000)
								RemoveAnimDict(dict)
							end
						else
							exports['okokNotify']:Alert(_L('no_pin').title, _L('no_pin').text, _L('no_pin').time, _L('no_pin').type)
						end
					end)
				end
			end)
		else
			if not notified then
				exports['okokNotify']:Alert(_L('not_use_bank').title, _L('not_use_bank').text, _L('not_use_bank').time, _L('not_use_bank').type)
				notified = true
			end
		end
	elseif NearATM() == "update" then
		Citizen.Wait(100)
	else
		Citizen.Wait(1000)
	end
	notified = false
end)

RegisterCommand("trs", function()
	TriggerEvent("open:atm")
end)

RegisterNetEvent("okokBanking:OpenATM")
AddEventHandler("okokBanking:OpenATM", function(pin)
	SetNuiFocus(true, true)
	SendNUIMessage({
		action = 'atm',
		pin = pin,
	})
end)

function openBank()
	local hasJob = false
	local playeJob = ESX.GetPlayerData().job
	local playerJobName = ''
	local playerJobGrade = ''
	local jobLabel = ''
	isBankOpened = true

	canAccessSociety = false

	if playeJob ~= nil then
		hasJob = true
		playerJobName = playeJob.name
		playerJobGrade = playeJob.grade_name
		jobLabel = playeJob.name
		society = 'society_'..playerJobName
	end

	ESX.TriggerServerCallback("okokBanking:GetPlayerInfo", function(data)
		ESX.TriggerServerCallback("okokBanking:GetOverviewTransactions", function(cb, identifier, allDays)
			for k,v in pairs(Config.Societies) do
				if playerJobName == v then
					if json.encode(Config.SocietyAccessRanks) ~= '[]' then
						for k2,v2 in pairs(Config.SocietyAccessRanks) do
							if playerJobGrade == v2 then
								canAccessSociety = true
							end
						end
					else
						canAccessSociety = true
					end
				end
			end

			if canAccessSociety then
				ESX.TriggerServerCallback("okokBanking:SocietyInfo", function(cb)
					if cb ~= nil then
						societyInfo = cb
					else
						local societyIban = Config.IBANPrefix..jobLabel
						TriggerServerEvent("okokBanking:CreateSocietyAccount", society, jobLabel, 0, societyIban)
						Citizen.Wait(200)
						ESX.TriggerServerCallback("okokBanking:SocietyInfo", function(cb)
							societyInfo = cb
						end, society)
					end
				end, society)
			end

			isBankOpened = true
			trans = cb
			playerName, playerBankMoney, playerIBAN, trsIdentifier, allDaysValues, walletMoney = data.playerName, data.playerBankMoney, data.playerIBAN, identifier, allDays, data.walletMoney
			ESX.TriggerServerCallback("okokBanking:GetSocietyTransactions", function(societyTranscb, societyID, societyAllDays)
				societyIdent = societyID
				societyDays = societyAllDays
				societyTrans = societyTranscb
				if data.playerIBAN ~= nil then
					SetNuiFocus(true, true)
					if Config.RequireCreditCardForATM then
						SendNUIMessage({
							action = 'bankmenu',
							playerName = data.playerName,
							playerSex = data.sex,
							playerBankMoney = data.playerBankMoney,
							walletMoney = walletMoney,
							playerIBAN = data.playerIBAN,
							db = trans,
							identifier = trsIdentifier,
							graphDays = allDaysValues,
							isInSociety = canAccessSociety,
							RequireCC = true,
						})
					else
						SendNUIMessage({
							action = 'bankmenu',
							playerName = data.playerName,
							playerSex = data.sex,
							playerBankMoney = data.playerBankMoney,
							walletMoney = walletMoney,
							playerIBAN = data.playerIBAN,
							db = trans,
							identifier = trsIdentifier,
							graphDays = allDaysValues,
							isInSociety = canAccessSociety,
							RequireCC = false,
						})
					end
				else
					GenerateIBAN()
					Citizen.Wait(1000)
					ESX.TriggerServerCallback("okokBanking:GetPlayerInfo", function(data)
						SetNuiFocus(true, true)
						if Config.RequireCreditCardForATM then
							SendNUIMessage({
								action = 'bankmenu',
								playerName = data.playerName,
								playerSex = data.sex,
								playerBankMoney = data.playerBankMoney,
								walletMoney = walletMoney,
								playerIBAN = data.playerIBAN,
								db = trans,
								identifier = trsIdentifier,
								graphDays = allDaysValues,
								isInSociety = canAccessSociety,
								RequireCC = true,
							})
						else
							SendNUIMessage({
								action = 'bankmenu',
								playerName = data.playerName,
								playerSex = data.sex,
								playerBankMoney = data.playerBankMoney,
								walletMoney = walletMoney,
								playerIBAN = data.playerIBAN,
								db = trans,
								identifier = trsIdentifier,
								graphDays = allDaysValues,
								isInSociety = canAccessSociety,
								RequireCC = false,
							})
						end
					end)
				end
			end, society)
		end)
	end)
end

RegisterNUICallback("action", function(data, cb)
	if data.action == "close" then
		isBankOpened = false
		SetNuiFocus(false, false)
	elseif data.action == "deposit" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				if data.window == 'bankmenu' then
					TriggerServerEvent('okokBanking:DepositMoney', tonumber(data.value))
				elseif data.window == 'societies' then
					TriggerServerEvent('okokBanking:DepositMoneyToSociety', tonumber(data.value), societyInfo.society, societyInfo.society_name)
				end
			else
				exports['okokNotify']:Alert(_L('invalid_amount').title, _L('invalid_amount').text, _L('invalid_amount').time, _L('invalid_amount').type)
			end
		else
			exports['okokNotify']:Alert(_L('invalid_amount').title, _L('invalid_amount').text, _L('invalid_amount').time, _L('invalid_amount').type)
		end
	elseif data.action == "withdraw" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				if data.window == 'bankmenu' then
					TriggerServerEvent('okokBanking:WithdrawMoney', tonumber(data.value))
				elseif data.window == 'societies' then
					TriggerServerEvent('okokBanking:WithdrawMoneyToSociety', tonumber(data.value), societyInfo.society, societyInfo.society_name, societyInfo.value)
				end
			else
				exports['okokNotify']:Alert(_L('invalid_amount').title, _L('invalid_amount').text, _L('invalid_amount').time, _L('invalid_amount').type)
			end
		else
			exports['okokNotify']:Alert(_L('invalid_input').title, _L('invalid_input').text, _L('invalid_input').time, _L('invalid_input').type)
		end
	elseif data.action == "transfer" then
		if tonumber(data.value) ~= nil then
			if tonumber(data.value) > 0 then
				ESX.TriggerServerCallback("okokBanking:IsIBanUsed", function(isUsed, isPlayer)
					if isUsed ~= nil then
						if data.window == 'bankmenu' then
							if isPlayer then
								TriggerServerEvent('okokBanking:TransferMoney', tonumber(data.value), data.iban:upper(), isUsed.identifier, isUsed.accounts, isUsed.name)
							elseif not isPlayer then
								TriggerServerEvent('okokBanking:TransferMoneyToSociety', tonumber(data.value), isUsed.iban:upper(), isUsed.society_name, isUsed.society)
							end
						elseif data.window == 'societies' then
							local toMyself = false
							if data.iban:upper() == playerIBAN then
								toMyself = true
							end

							if isPlayer then
								TriggerServerEvent('okokBanking:TransferMoneyToPlayerFromSociety', tonumber(data.value), data.iban:upper(), isUsed.identifier, isUsed.accounts, isUsed.name, societyInfo.society, societyInfo.society_name, societyInfo.value, toMyself)
							elseif not isPlayer then
								TriggerServerEvent('okokBanking:TransferMoneyToSocietyFromSociety', tonumber(data.value), isUsed.iban:upper(), isUsed.society_name, isUsed.society, societyInfo.society, societyInfo.society_name, societyInfo.value)
							end
						end
					elseif isUsed == nil then
						exports['okokNotify']:Alert(_L('iban_not_exist').title, _L('iban_not_exist').text, _L('iban_not_exist').time, _L('iban_not_exist').type)
					end
				end, data.iban:upper())
			else
				exports['okokNotify']:Alert(_L('invalid_amount').title, _L('invalid_amount').text, _L('invalid_amount').time, _L('invalid_amount').type)
			end
		else
			exports['okokNotify']:Alert(_L('invalid_input').title, _L('invalid_input').text, _L('invalid_input').time, _L('invalid_input').type)
		end
	elseif data.action == "overview_page" then
		SetNuiFocus(true, true)
		if Config.RequireCreditCardForATM then
			SendNUIMessage({
				action = 'overview_page',
				playerBankMoney = playerBankMoney,
				walletMoney = walletMoney,
				playerIBAN = playerIBAN,
				db = trans,
				identifier = trsIdentifier,
				graphDays = allDaysValues,
				isInSociety = canAccessSociety,
				RequireCC = true,
			})
		else
			SendNUIMessage({
				action = 'overview_page',
				playerBankMoney = playerBankMoney,
				walletMoney = walletMoney,
				playerIBAN = playerIBAN,
				db = trans,
				identifier = trsIdentifier,
				graphDays = allDaysValues,
				isInSociety = canAccessSociety,
				RequireCC = false,
			})
		end
	elseif data.action == "transactions_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'transactions_page',
			db = trans,
			identifier = trsIdentifier,
			graph_values = allDaysValues,
			isInSociety = canAccessSociety,
		})
	elseif data.action == "society_transactions" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'society_transactions',
			db = societyTrans,
			identifier = societyIdent,
			graph_values = societyDays,
			isInSociety = canAccessSociety,
			societyInfo = societyInfo,
		})
	elseif data.action == "society_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'society_page',
			playerBankMoney = playerBankMoney,
			walletMoney = walletMoney,
			playerIBAN = playerIBAN,
			db = societyTrans,
			identifier = societyIdent,
			graphDays = societyDays,
			isInSociety = canAccessSociety,
			societyInfo = societyInfo,
		})
	elseif data.action == "settings_page" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'settings_page',
			isInSociety = canAccessSociety,
			ibanCost = Config.IBANChangeCost,
			ibanPrefix = Config.IBANPrefix,
			ibanCharNum = Config.CustomIBANMaxChars,
			pinCost = Config.PINChangeCost,
			pinCharNum = 4,
		})
	elseif data.action == "atm" then
		SetNuiFocus(true, true)
		SendNUIMessage({
			action = 'loading_data',
		})
		Citizen.Wait(500)
		openBank()
	elseif data.action == "change_iban" then
		if Config.CustomIBANAllowLetters then
			local iban = Config.IBANPrefix..data.iban:upper()
			
			ESX.TriggerServerCallback("okokBanking:IsIBanUsed", function(isUsed, isPlayer)

				if isUsed == nil then
					TriggerServerEvent('okokBanking:UpdateIbanDB', iban, Config.IBANChangeCost)
				elseif isUsed ~= nil then
					exports['okokNotify']:Alert(_L('iban_in_use').title, _L('iban_in_use').text, _L('iban_in_use').time, _L('iban_in_use').type)
				end
			end, iban)
		elseif not Config.CustomIBANAllowLetters then
			if tonumber(data.iban) ~= nil then
				local iban = Config.IBANPrefix..data.iban:upper()
				
				ESX.TriggerServerCallback("okokBanking:IsIBanUsed", function(isUsed, isPlayer)

					if isUsed == nil then
						TriggerServerEvent('okokBanking:UpdateIbanDB', iban, Config.IBANChangeCost)
					elseif isUsed ~= nil then
						exports['okokNotify']:Alert(_L('iban_in_use').title, _L('iban_in_use').text, _L('iban_in_use').time, _L('iban_in_use').type)
					end
				end, iban)
			else
				exports['okokNotify']:Alert(_L('iban_only_numbers').title, _L('iban_only_numbers').text, _L('iban_only_numbers').time, _L('iban_only_numbers').type)
			end
		end
	elseif data.action == "change_pin" then
		if tonumber(data.pin) ~= nil then
			if string.len(data.pin) == 4 then
				ESX.TriggerServerCallback("okokBanking:GetPIN", function(pin)
					if pin then
						TriggerServerEvent('okokBanking:UpdatePINDB', data.pin, Config.PINChangeCost)
					else
						TriggerServerEvent('okokBanking:UpdatePINDB', data.pin, 0)
					end
				end)
			else
				exports['okokNotify']:Alert(_L('pin_digits').title, _L('pin_digits').text, _L('pin_digits').time, _L('pin_digits').type)
			end
		else
			exports['okokNotify']:Alert(_L('pin_only_numbers').title, _L('pin_only_numbers').text, _L('pin_only_numbers').time, _L('pin_only_numbers').type)
		end
	elseif data.action == "buy_new_cc" then
		TriggerServerEvent('okokBanking:GiveCC')
	end
end)

RegisterNetEvent("okokBanking:updateTransactions")
AddEventHandler("okokBanking:updateTransactions", function(money, wallet)
	Citizen.Wait(100)
	if isBankOpened then
		ESX.TriggerServerCallback("okokBanking:GetOverviewTransactions", function(cb, id, allDays)
			trans = cb
			allDaysValues = allDays
			SetNuiFocus(true, true)
			if Config.RequireCreditCardForATM then
				SendNUIMessage({
					action = 'overview_page',
					playerBankMoney = playerBankMoney,
					walletMoney = walletMoney,
					playerIBAN = playerIBAN,
					db = trans,
					identifier = trsIdentifier,
					graphDays = allDaysValues,
					isInSociety = canAccessSociety,
					isUpdate = true,
					RequireCC = true,
				})
			else
				SendNUIMessage({
					action = 'overview_page',
					playerBankMoney = playerBankMoney,
					walletMoney = walletMoney,
					playerIBAN = playerIBAN,
					db = trans,
					identifier = trsIdentifier,
					graphDays = allDaysValues,
					isInSociety = canAccessSociety,
					isUpdate = true,
					RequireCC = false,
				})
			end
			TriggerEvent('okokBanking:updateMoney', money, wallet)
		end)
	end
end)

RegisterNetEvent("okokBanking:updateMoney")
AddEventHandler("okokBanking:updateMoney", function(money, wallet)
	if isBankOpened then
		playerBankMoney = money
		walletMoney = wallet
		SendNUIMessage({
			action = 'updatevalue',
			playerBankMoney = money,
			walletMoney = wallet,
		})
	end
end)

RegisterNetEvent("okokBanking:updateIban")
AddEventHandler("okokBanking:updateIban", function(iban)
	playerIBAN = iban
	SendNUIMessage({
		action = 'updateiban',
		iban = playerIBAN,
	})
end)

RegisterNetEvent("okokBanking:updateIbanPinChange")
AddEventHandler("okokBanking:updateIbanPinChange", function()
	Citizen.Wait(100)
	ESX.TriggerServerCallback("okokBanking:GetOverviewTransactions", function(cbs, ids, allDays)
		trans = cbs
	end)
end)

RegisterNetEvent("okokBanking:updateTransactionsSociety")
AddEventHandler("okokBanking:updateTransactionsSociety", function(wallet)
	Citizen.Wait(100)
	ESX.TriggerServerCallback("okokBanking:SocietyInfo", function(cb)
		ESX.TriggerServerCallback("okokBanking:GetSocietyTransactions", function(societyTranscb, societyID, societyAllDays)
			ESX.TriggerServerCallback("okokBanking:GetOverviewTransactions", function(cbs, ids, allDays)
				trans = cbs
				walletMoney = wallet
				societyDays = societyAllDays
				societyIdent = societyID
				societyTrans = societyTranscb
				societyInfo = cb
				if cb ~= nil then
					SetNuiFocus(true, true)
					SendNUIMessage({
						action = 'society_page',
						walletMoney = wallet,
						db = societyTrans,
						graphDays = societyDays,
						isInSociety = canAccessSociety,
						societyInfo = societyInfo,
						identifier = societyIdent,
						isUpdate = true,
					})
				end
			end)
		end, society)
	end, society)
end)

function GenerateIBAN()
	math.randomseed(GetGameTimer())
	local stringFormat = "%0"..Config.IBANNumbers.."d"
	local number = math.random(0, 10^Config.IBANNumbers-1)
	number = string.format(stringFormat, number)
	local iban = Config.IBANPrefix..number:upper()
	local isIBanUsed = true
	local hasChecked = false

	while true do
		Citizen.Wait(10)
		if isIBanUsed and not hasChecked then
			isIBanUsed = false
			ESX.TriggerServerCallback("okokBanking:IsIBanUsed", function(isUsed)
				if isUsed ~= nil then
					isIBanUsed = true
					number = math.random(0, 10^Config.IBANNumbers-1)
					number = string.format("%03d", number)
					iban = Config.IBANPrefix..number:upper()
				elseif isUsed == nil then
					hasChecked = true
					isIBanUsed = false
				end
				canLoop = true
			end, iban)
		elseif not isIBanUsed and hasChecked then
			break
		end
	end
	TriggerServerEvent('okokBanking:SetIBAN', iban)
end