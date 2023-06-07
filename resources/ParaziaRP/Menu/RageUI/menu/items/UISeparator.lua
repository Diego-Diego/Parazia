---@type table
local SettingsButton = {
    Rectangle = { Y = 0, Width = 431, Height = 38 },
    Text = { X = 8, Y = 3, Scale = 0.33 },
}

function MowgliUI.Separator(Label)
    local CurrentMenu = MowgliUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            local Option = MowgliUI.Options + 1
            if CurrentMenu.Pagination.Minimum <= Option and CurrentMenu.Pagination.Maximum >= Option then
                if (Label ~= nil) then
                    RenderText(Label, CurrentMenu.X + SettingsButton.Text.X + (CurrentMenu.WidthOffset * 2.5 ~= 0 and CurrentMenu.WidthOffset * 2.5 or 200), CurrentMenu.Y + SettingsButton.Text.Y + CurrentMenu.SubtitleHeight + MowgliUI.ItemOffset, 0, SettingsButton.Text.Scale, 245, 245, 245, 255, 1)
                end
                MowgliUI.ItemOffset = MowgliUI.ItemOffset + SettingsButton.Rectangle.Height
                if (CurrentMenu.Index == Option) then
                    if (MowgliUI.LastControl) then
                        CurrentMenu.Index = Option - 1
                        if (CurrentMenu.Index < 1) then
                            CurrentMenu.Index = MowgliUI.CurrentMenu.Options
                        end
                    else
                        CurrentMenu.Index = Option + 1
                    end
                end
            end
            MowgliUI.Options = MowgliUI.Options + 1
        end
    end
end

