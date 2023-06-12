local HashATM = nil

local ESX = nil
Citizen.CreateThread(function()
    while ESX == nil do
        TriggerEvent('sova:KraKss0TEX0', function(obj) ESX = obj end)
        Citizen.Wait(5000)
    end
end)

exports.ox_target:addModel(ATM.Props, {
    {
        icon = "fas fa-credit-card",
        label = "Accéder à l'atm",
        event = "open:atm",
        distance = 1.5,
        canInteract = function(entity, coords, distance)
            HashATM = entity
            return true
        end,
    },
    {
        icon = "fas fa-credit-card",
        label = "Braquer l'ATM",
        event = "robberyAtm",
        distance = 1.5,
        canInteract = function(entity, coords, distance)
            HashATM = entity
            return true
        end,
    },
})

RegisterNetEvent("robberyAtm")
AddEventHandler("robberyAtm", function()
    ESX.TriggerServerCallback('prz_atmrobbery:getRobbery', function(cb)
        if cb then
            AnimHack()
            TriggerEvent("mhacking:show")
            TriggerEvent("mhacking:start", 4, 30, AtmHackFirstSuccess)
            TriggerServerEvent("prz_atmrobbery:robberyAlert", GetEntityCoords(HashATM))
        end
    end, HashATM)
end)

function AtmHackFirstSuccess(success)
    FreezeEntityPosition(GetPlayerPed(-1),false)
    TriggerEvent('mhacking:hide')
    if success then
        TriggerServerEvent("prz_atmrobbery:stopAtm", HashATM)
        ESX.ShowNotification("Tu as Réussi a  ~y~hacker~s~ le ~b~NetWork~s~, la police a été prévenu !")
        ClearPedTasks(PlayerPedId())
        Wait(2500)
        AnimCash()
    else
		ESX.ShowNotification("Tu as ~r~Raté~s~ le Hack du ~y~NetWork~s~, la police a été prévenu !")
		ClearPedTasks(PlayerPedId())
        FreezeEntityPosition(PlayerPedId(), false)
	end
end

function AnimCash()
	local animDict = "anim@heists@ornate_bank@grab_cash"
	local animName = "grab"

	RequestAnimDict(animDict)
    while not HasAnimDictLoaded(animDict) do
        Citizen.Wait(10)
    end

	SetEntityHeading(PlayerPedId(), GetEntityHeading(HashATM))

	local model = GetHashKey('prop_cs_heist_bag_02')
	RequestModel(model)
	while not HasModelLoaded(model) do
        RequestModel(model)
        Wait(10)
    end

	local object = CreateObject(model, GetEntityCoords(PlayerPedId()), true, true, true)
	AttachEntityToEntity(object, PlayerPedId(), GetPedBoneIndex(PlayerPedId(), 57005), 0.0, 0.0, -0.16, 250.0, -30.0, 0.0, false, false, false, false, 0, true)

	TaskPlayAnim(PlayerPedId(), animDict, animName, 1.0, -1.0, -1, 2, 0, 0, 0, 0)
    if lib.progressCircle({
        duration = ATM.GrapTime,
        position = 'bottom',
        useWhileDead = false,
        canCancel = false,
        disable = {
            car = true,
        },
    }) then
        DeleteEntity(object)
        ClearPedTasks(PlayerPedId())
        TriggerServerEvent('prz_atmrobbery:giveCash')
    end
end

function AnimHack()
    SetCurrentPedWeapon(PlayerPedId(), GetHashKey("WEAPON_UNARMED"),true)
	Citizen.Wait(250)
	FreezeEntityPosition(PlayerPedId(), true)
	TaskStartScenarioInPlace(PlayerPedId(), 'WORLD_HUMAN_STAND_MOBILE', -1, true)
	Citizen.Wait(2000)
end

local blipAtm = nil
RegisterNetEvent('prz_atmrobbery:setBlip')
AddEventHandler('prz_atmrobbery:setBlip', function(position)
	blipAtm = AddBlipForCoord(position.x, position.y, position.z)

	SetBlipSprite(blipAtm, 161)
	SetBlipScale(blipAtm, 1.5)
	SetBlipColour(blipAtm, 1)
    
	PulseBlip(blipAtm)

    BeginTextCommandSetBlipName("STRING")
    AddTextComponentString("Braquage d'atm")
    EndTextCommandSetBlipName(blip)
end)

RegisterNetEvent('prz_atmrobbery:killBlip')
AddEventHandler('prz_atmrobbery:killBlip', function()
	RemoveBlip(blipAtm)
end)