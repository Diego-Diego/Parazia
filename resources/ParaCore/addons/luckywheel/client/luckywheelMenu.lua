---@author Pablo Z.
---@version 1.0
--[[
  This file is part of VisionRP.
  
  File [luckywheelMenu] created at [22/04/2021 06:57]

  Copyright (c) VisionRP - All Rights Reserved

  Unauthorized using, copying, modifying and/or distributing of this file,
  via any medium is strictly prohibited. This code is confidential.
--]]

local cat, desc = "luckywheel", "~q~Roue - VisionRP"
local isWaitingServerResponse = false
local sub = function(str)
    return cat .. "_" .. str
end

RegisterNetEvent("luckywheelCbTurn")
AddEventHandler("luckywheelCbTurn", function()
    VisionRPGameUtils.advancedNotification("~q~VisionRP", "~y~Roue de la chance","Vous pouvez désormais vous rendre vers la roue et la tourner ! Bonne chance !", "CHAR_SEALIFE", 1)
    isWaitingServerResponse = false
end)

RegisterNetEvent("luckywheelPaidNotCbTurn")
AddEventHandler("luckywheelPaidNotCbTurn", function()
    isWaitingServerResponse = false
end)

RegisterNetEvent("luckywheelPaidCbTurn")
AddEventHandler("luckywheelPaidCbTurn", function()
    VisionRPGameUtils.advancedNotification("Roue de la fortune", "~q~VisionRP", "Vous avez reçus un tour de roue payant, merci c'est lors de votre prochaine reconnexion qu'il sera présent !", "CHAR_SEALIFE", 1)
    isWaitingServerResponse = false
end)

RegisterNetEvent("luckywheelOpenMenu")
AddEventHandler("luckywheelOpenMenu", function(canDoFreeTurn, paidTurnsCount)
    if menuIsOpened then
        return
    end

    if currentTurn then
        ESX.ShowNotification("~q~Vous avez un tour de roue en cours")
        return
    end

    if isWaitingServerResponse then
        ESX.ShowNotification("~q~Une transaction est encore en cours avec le serveur...")
        return
    end

    FreezeEntityPosition(PlayerPedId(), true)
    menuIsOpened = true

    RMenu.Add(cat, sub("main"), RageUI.CreateMenu(nil, desc, nil, nil, "casinoui_lucky_wheel", "casinoui_lucky_wheel"))
    RMenu:Get(cat, sub("main")).Closed = function()
    end

    RageUI.Visible(RMenu:Get(cat, sub("main")), true)

    VisionRP.newThread(function()
        while menuIsOpened do
            local shouldStayOpened = false
            local function tick()
                shouldStayOpened = true
            end

            RageUI.IsVisible(RMenu:Get(cat, sub("main")), true, true, true, function()
                tick()
                RageUI.Separator("↓ ~o~Tour gratuit ~s~↓")
                if canDoFreeTurn then
                    RageUI.ButtonWithStyle("~g~Obtenir mon tour gratuit", nil, {}, true, function(_,_,s)
                        if s then
                            shouldStayOpened = false
                            isWaitingServerResponse = true
                            VisionRPClientUtils.toServer("luckywheelRequestFreeTurn")
                        end
                    end)
                else
                    RageUI.ButtonWithStyle("~q~Revenez plus tard", nil, {}, false, function()  end)
                end
                --[[RageUI.Separator("↓ ~q~Tours payants ~s~↓")
                if paidTurnsCount <= 0 then
                    RageUI.ButtonWithStyle(("Acheter un tour payant ~s~(~g~500 VisionRPCoins~s~)"), nil, {}, true, function(_,_,s)
                        if s then
                            shouldStayOpened = false
                            isWaitingServerResponse = true
                            VisionRPClientUtils.toServer("luckywheelPaidTurn")
                        end
                    end)
                else
                    RageUI.ButtonWithStyle(("~g~Utiliser un tour payant ~s~(~g~x%s~s~)"):format(paidTurnsCount), nil, {}, true, function(_,_,s)
                        if s then
                            shouldStayOpened = false
                            isWaitingServerResponse = true
                            VisionRPClientUtils.toServer("luckywheelRequestPaidTurn")
                        end
                    end)
                end]]

            end, function()
            end)

            if not shouldStayOpened and menuIsOpened then
                menuIsOpened = false
            end
            Wait(0)
        end
        FreezeEntityPosition(PlayerPedId(), false)
        RMenu:Delete(cat, sub("main"))
    end)
end)