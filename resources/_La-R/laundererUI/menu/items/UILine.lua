---
--- @author Dylan MALANDAIN
--- @version 2.0.0
--- @since 2020
---
--- LaundererUI Is Advanced UI Libs in LUA for make beautiful interface like RockStar GAME.
---
---
--- Commercial Info.
--- Any use for commercial purposes is strictly prohibited and will be punished.
---
--- @see LaundererUI
---

---@type table

local SettingsButton = {
    Text = { X = 13, Y = 10, Scale = 0.32 },
    Rectangle = { Y = 1, Width = 1, Height = 10 },
}




function LaundererUI.Line(R,G,B,O)
    local CurrentMenu = LaundererUI.CurrentMenu
    local Description = LaundererUI.Settings.Items.Description;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = LaundererUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                RenderRectangle(CurrentMenu.X + Description.Bar.Y + 60 + CurrentMenu.SubtitleHeight , CurrentMenu.Y + Description.Bar.Y + 1.9 + CurrentMenu.SubtitleHeight + LaundererUI.ItemOffset, Description.Bar.Width - 120 + CurrentMenu.WidthOffset, Description.Bar.Height - 0.7, R, G, B, O)
                LaundererUI.ItemOffset = LaundererUI.ItemOffset + SettingsButton.Rectangle.Height + Description.Bar.Height 
                if (CurrentMenu.Index == Option) then
                    if (LaundererUI.LastControl) then
                        CurrentMenu.Index = Option - 0
                        if (CurrentMenu.Index < 0) then
                            CurrentMenu.Index = LaundererUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 0
                    end
                end
            end
            LaundererUI.Options = LaundererUI.Options + 0
        end
    end
end

