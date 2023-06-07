---@type table
local Heritage = {
    Background = { Dictionary = "loc1", Texture = "loc1", Width = 431, Height = 228 },
    Background2 = { Dictionary = "loc2", Texture = "loc2", Width = 431, Height = 228 },
    Background3 = { Dictionary = "loc3", Texture = "loc3", Width = 431, Height = 228 },
    Background4 = { Dictionary = "backgroundd", Texture = "backgroundd", Width = 431, Height = 228 },
    Background5 = { Dictionary = "tp1", Texture = "tp1", Width = 431, Height = 228 },
    Background6 = { Dictionary = "tp2", Texture = "tp2", Width = 431, Height = 228 },
    Background7 = { Dictionary = "tp3", Texture = "tp3", Width = 431, Height = 228 },
    Background8 = { Dictionary = "jobs", Texture = "jobs1", Width = 431, Height = 228 },
    Background9 = { Dictionary = "jobs", Texture = "jobs2", Width = 431, Height = 228 },
    Background10 = { Dictionary = "jobs", Texture = "jobs3", Width = 431, Height = 228 },
    Background11 = { Dictionary = "boutique", Texture = "a45amg", Width = 431, Height = 228 },
    Background12 = { Dictionary = "boutique", Texture = "bmwi8", Width = 431, Height = 228 },
    Background13 = { Dictionary = "boutique", Texture = "bmwx6", Width = 431, Height = 228 },
    Background14 = { Dictionary = "boutique", Texture = "brabus", Width = 431, Height = 228 },
    Background15 = { Dictionary = "boutique", Texture = "c63", Width = 431, Height = 228 },
    Background16 = { Dictionary = "boutique", Texture = "c63amg", Width = 431, Height = 228 },
    Background17 = { Dictionary = "boutique", Texture = "cls53", Width = 431, Height = 228 },
    Background18 = { Dictionary = "boutique", Texture = "dodgecharger", Width = 431, Height = 228 },
    Background19 = { Dictionary = "boutique", Texture = "ferrari", Width = 431, Height = 228 },
    Background20 = { Dictionary = "boutique", Texture = "g65", Width = 431, Height = 228 },
    Background21 = { Dictionary = "boutique", Texture = "huracan", Width = 431, Height = 228 },
    Background22 = { Dictionary = "boutique", Texture = "levante", Width = 431, Height = 228 },
    Background23 = { Dictionary = "boutique", Texture = "panamera", Width = 431, Height = 228 },
    Background24 = { Dictionary = "boutique", Texture = "porsche918", Width = 431, Height = 228 },
    Background25 = { Dictionary = "boutique", Texture = "porschecayman", Width = 431, Height = 228 },
    Background26 = { Dictionary = "boutique", Texture = "rs3", Width = 431, Height = 228 },
    Background27 = { Dictionary = "boutique", Texture = "rs6sedan", Width = 431, Height = 228 },
    Background28 = { Dictionary = "boutique", Texture = "rs7", Width = 431, Height = 228 },
    Background29 = { Dictionary = "boutique", Texture = "rs62020", Width = 431, Height = 228 },
    Background30 = { Dictionary = "boutique", Texture = "sq8", Width = 431, Height = 228 },
    Background31 = { Dictionary = "boutique", Texture = "urus", Width = 431, Height = 228 },
}

function RageUI.VehPreview()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background11.Dictionary, Heritage.Background11.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background11.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background11.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview2()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background12.Dictionary, Heritage.Background12.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background12.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background12.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview3()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background13.Dictionary, Heritage.Background13.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background13.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background13.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview4()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background14.Dictionary, Heritage.Background14.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background14.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background14.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview5()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background15.Dictionary, Heritage.Background15.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background15.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background15.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview6()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background16.Dictionary, Heritage.Background16.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background16.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background16.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview7()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background17.Dictionary, Heritage.Background17.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background17.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background17.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview8()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background18.Dictionary, Heritage.Background18.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background18.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background18.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview9()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background19.Dictionary, Heritage.Background19.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background19.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background19.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview10()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background20.Dictionary, Heritage.Background20.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background20.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background20.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview11()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background21.Dictionary, Heritage.Background21.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background21.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background21.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview12()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background22.Dictionary, Heritage.Background22.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background22.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background22.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview13()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background23.Dictionary, Heritage.Background23.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background23.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background23.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview14()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background24.Dictionary, Heritage.Background24.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background24.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background24.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview15()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background25.Dictionary, Heritage.Background25.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background25.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background25.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview16()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background26.Dictionary, Heritage.Background26.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background26.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background26.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview17()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background27.Dictionary, Heritage.Background27.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background27.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background27.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview18()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background28.Dictionary, Heritage.Background28.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background28.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background28.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview19()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background29.Dictionary, Heritage.Background29.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background29.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background29.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview20()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background30.Dictionary, Heritage.Background30.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background30.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background30.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.VehPreview21()
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background31.Dictionary, Heritage.Background31.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background31.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background31.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end


---HeritageWindow
---@return nil
---@public
function RageUI.HeritageWindow(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background.Dictionary, Heritage.Background.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.HeritageWindow2(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background2.Dictionary, Heritage.Background2.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background2.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background2.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.HeritageWindow3(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background3.Dictionary, Heritage.Background3.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background3.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background3.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.HeritageWindow4(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background4.Dictionary, Heritage.Background4.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background4.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background4.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.HeritageWindow5(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background5.Dictionary, Heritage.Background5.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background5.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background5.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.HeritageWindow6(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background6.Dictionary, Heritage.Background6.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background6.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background6.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.HeritageWindow7(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background7.Dictionary, Heritage.Background7.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background7.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background7.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.HeritageWindow8(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background8.Dictionary, Heritage.Background8.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background8.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background8.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.HeritageWindow9(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background9.Dictionary, Heritage.Background9.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background9.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background9.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end

function RageUI.HeritageWindow10(Mum, Dad)
    ---@type table
    local CurrentMenu = RageUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            RenderSprite(Heritage.Background10.Dictionary, Heritage.Background10.Texture, CurrentMenu.X, CurrentMenu.Y + CurrentMenu.SubtitleHeight + RageUI.ItemOffset, Heritage.Background10.Width + (CurrentMenu.WidthOffset / 1), Heritage.Background10.Height)
            RageUI.ItemOffset = RageUI.ItemOffset + Heritage.Background.Height
        end
    end
end