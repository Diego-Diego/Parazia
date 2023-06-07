

function math.round(num, numDecimalPlaces)
    return tonumber(string.format("%." .. (numDecimalPlaces or 0) .. "f", num))
end

function string.starts(String, Start)
    return string.sub(String, 1, string.len(Start)) == Start
end

---@class LaundererUIMenus
LaundererUI.Menus = setmetatable({}, LaundererUI.Menus)

---@type table
---@return boolean
LaundererUI.Menus.__call = function()
    return true
end

---@type table
LaundererUI.Menus.__index = LaundererUI.Menus

---@type table
LaundererUI.CurrentMenu = nil

---@type table
LaundererUI.NextMenu = nil

---@type number
LaundererUI.Options = 0

---@type number
LaundererUI.ItemOffset = 0

---@type number
LaundererUI.StatisticPanelCount = 0

---@class UISize
LaundererUI.UI = {
    Current = "NativeUI",
    Style = {
        LaundererUI = {
            Width = 0
        },
        NativeUI = {
            Width = 0
        }
    }
}

---@class Settings
LaundererUI.Settings = {
    Debug = false,
    Controls = {
        Up = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 172 },
                { 1, 172 },
                { 2, 172 },
                { 0, 241 },
                { 1, 241 },
                { 2, 241 },
            },
        },
        Down = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 173 },
                { 1, 173 },
                { 2, 173 },
                { 0, 242 },
                { 1, 242 },
                { 2, 242 },
            },
        },
        Left = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        Right = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        SliderLeft = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 174 },
                { 1, 174 },
                { 2, 174 },
            },
        },
        SliderRight = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 175 },
                { 1, 175 },
                { 2, 175 },
            },
        },
        Select = {
            Enabled = true,
            Pressed = false,
            Active = false,
            Keys = {
                { 0, 201 },
                { 1, 201 },
                { 2, 201 },
            },
        },
        Back = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 177 },
                { 1, 177 },
                { 2, 177 },
                { 0, 199 },
                { 1, 199 },
                { 2, 199 },
            },
        },
        Click = {
            Enabled = true,
            Active = false,
            Pressed = false,
            Keys = {
                { 0, 24 },
            },
        },
        Enabled = {
            Controller = {
                { 0, 2 }, -- Look Up and Down
                { 0, 1 }, -- Look Left and Right
                { 0, 25 }, -- Aim
                { 0, 24 }, -- Attack
            },
            Keyboard = {
                { 0, 201 }, -- Select
                { 0, 195 }, -- X axis
                { 0, 196 }, -- Y axis
                { 0, 187 }, -- Down
                { 0, 188 }, -- Up
                { 0, 189 }, -- Left
                { 0, 190 }, -- Right
                { 0, 202 }, -- Back
                { 0, 217 }, -- Select
                { 0, 242 }, -- Scroll down
                { 0, 241 }, -- Scroll up
                { 0, 239 }, -- Cursor X
                { 0, 240 }, -- Cursor Y
                { 0, 31 }, -- Move Up and Down
                { 0, 30 }, -- Move Left and Right
                { 0, 21 }, -- Sprint
                { 0, 22 }, -- Jump
                { 0, 23 }, -- Enter
                { 0, 75 }, -- Exit Vehicle
                { 0, 71 }, -- Accelerate Vehicle
                { 0, 72 }, -- Vehicle Brake
                { 0, 59 }, -- Move Vehicle Left and Right
                { 0, 89 }, -- Fly Yaw Left
                { 0, 9 }, -- Fly Left and Right
                { 0, 8 }, -- Fly Up and Down
                { 0, 90 }, -- Fly Yaw Right
                { 0, 76 }, -- Vehicle Handbrake
            },
        },
    },
    Audio = {
        Id = nil,
        Use = "NativeUI",
        LaundererUI = {
            UpDown = {
                audioName = "HUD_FREEMODE_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        },
        NativeUI = {
            UpDown = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_UP_DOWN",
            },
            LeftRight = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "NAV_LEFT_RIGHT",
            },
            Select = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "SELECT",
            },
            Back = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "BACK",
            },
            Error = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "ERROR",
            },
            Slider = {
                audioName = "HUD_FRONTEND_DEFAULT_SOUNDSET",
                audioRef = "CONTINUOUS_SLIDER",
                Id = nil
            },
        }
    },
    Items = {
        Title = {
            Background = { Width = 431, Height = 107 },
            Text = { X = 215, Y = 20, Scale = 1.15 },
        },
        Subtitle = {
            Background = { Width = 431, Height = 37 },
            Text = { X = 8, Y = 3, Scale = 0.35 },
            PreText = { X = 425, Y = 3, Scale = 0.35 },
        },
        Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 0, Width = 431 },
        Navigation = {
            Rectangle = { Width = 431, Height = 18 },
            Offset = 5,
            Arrows = { Dictionary = "commonmenu", Texture = "shop_arrows_upanddown", X = 190, Y = -6, Width = 50, Height = 50 },
        },
        Description = {
            Bar = { Y = 4, Width = 431, Height = 4 },
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 30 },
            Text = { X = 8, Y = 10, Scale = 0.35 },
        },
    },
    Panels = {
        Grid = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 275 },
            Grid = { Dictionary = "pause_menu_pages_char_mom_dad", Texture = "nose_grid", X = 115.5, Y = 47.5, Width = 200, Height = 200 },
            Circle = { Dictionary = "mpinventory", Texture = "in_world_circle", X = 115.5, Y = 47.5, Width = 20, Height = 20 },
            Text = {
                Top = { X = 215.5, Y = 15, Scale = 0.35 },
                Bottom = { X = 215.5, Y = 250, Scale = 0.35 },
                Left = { X = 57.75, Y = 130, Scale = 0.35 },
                Right = { X = 373.25, Y = 130, Scale = 0.35 },
            },
        },
        Percentage = {
            Background = { Dictionary = "commonmenu", Texture = "gradient_bgd", Y = 4, Width = 431, Height = 76 },
            Bar = { X = 9, Y = 50, Width = 413, Height = 10 },
            Text = {
                Left = { X = 25, Y = 15, Scale = 0.35 },
                Middle = { X = 215.5, Y = 15, Scale = 0.35 },
                Right = { X = 398, Y = 15, Scale = 0.35 },
            },
        },
    },
}

function LaundererUI.SetScaleformParams(scaleform, data)
    data = data or {}
    for k, v in pairs(data) do
        PushScaleformMovieFunction(scaleform, v.name)
        if v.param then
            for _, par in pairs(v.param) do
                if math.type(par) == "integer" then
                    PushScaleformMovieFunctionParameterInt(par)
                elseif type(par) == "boolean" then
                    PushScaleformMovieFunctionParameterBool(par)
                elseif math.type(par) == "float" then
                    PushScaleformMovieFunctionParameterFloat(par)
                elseif type(par) == "string" then
                    PushScaleformMovieFunctionParameterString(par)
                end
            end
        end
        if v.func then
            v.func()
        end
        PopScaleformMovieFunctionVoid()
    end
end

function LaundererUI.IsMouseInBounds(X, Y, Width, Height)
    local MX, MY = math.round(GetControlNormal(2, 239) * 1920) / 1920, math.round(GetControlNormal(2, 240) * 1080) / 1080
    X, Y = X / 1920, Y / 1080
    Width, Height = Width / 1920, Height / 1080
    return (MX >= X and MX <= X + Width) and (MY > Y and MY < Y + Height)
end

function LaundererUI.GetSafeZoneBounds()
    local SafeSize = GetSafeZoneSize()
    SafeSize = math.round(SafeSize, 2)
    SafeSize = (SafeSize * 100) - 90
    SafeSize = 10 - SafeSize

    local W, H = 1920, 1080

    return { X = math.round(SafeSize * ((W / H) * 5.4)), Y = math.round(SafeSize * 5.4) }
end

function LaundererUI.Visible(Menu, Value)
    if Menu ~= nil and Menu() then
        if Value == true or Value == false then
            if Value then
                if LaundererUI.CurrentMenu ~= nil then
                    if LaundererUI.CurrentMenu.Closed ~= nil then
                        LaundererUI.CurrentMenu.Closed()
                    end
                    LaundererUI.CurrentMenu.Open = not Value
                    Menu:UpdateInstructionalButtons(Value);
                    Menu:UpdateCursorStyle();

                end
                LaundererUI.CurrentMenu = Menu
            else
                LaundererUI.CurrentMenu = nil
            end
            Menu.Open = Value
            LaundererUI.Options = 0
            LaundererUI.ItemOffset = 0
            LaundererUI.LastControl = false
        else
            return Menu.Open
        end
    end
end

function LaundererUI.CloseAll()
    if LaundererUI.CurrentMenu ~= nil then
        local parent = LaundererUI.CurrentMenu.Parent
        while parent ~= nil do
            parent.Index = 1
            parent.Pagination.Minimum = 1
            parent.Pagination.Maximum = parent.Pagination.Total
            parent = parent.Parent
        end
        LaundererUI.CurrentMenu.Index = 1
        LaundererUI.CurrentMenu.Pagination.Minimum = 1
        LaundererUI.CurrentMenu.Pagination.Maximum = LaundererUI.CurrentMenu.Pagination.Total
        LaundererUI.CurrentMenu.Open = false
        LaundererUI.CurrentMenu = nil
    end
    LaundererUI.Options = 0
    LaundererUI.ItemOffset = 0
    ResetScriptGfxAlign()
end

function LaundererUI.Banner()
    local CurrentMenu = LaundererUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Header) then
            LaundererUI.ItemsSafeZone(CurrentMenu)
            if CurrentMenu.Sprite ~= nil then
                if CurrentMenu.Sprite.Dictionary ~= nil then
                    if CurrentMenu.Sprite.Dictionary == "commonmenu" then
                        RenderSprite(CurrentMenu.Sprite.Dictionary, CurrentMenu.Sprite.Texture, CurrentMenu.X, CurrentMenu.Y, LaundererUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, LaundererUI.Settings.Items.Title.Background.Height, CurrentMenu.Sprite.Color.R,CurrentMenu.Sprite.Color.G,CurrentMenu.Sprite.Color.B,CurrentMenu.Sprite.Color.A)
                    else
                        RenderSprite(CurrentMenu.Sprite.Dictionary, CurrentMenu.Sprite.Texture, CurrentMenu.X, CurrentMenu.Y, LaundererUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, LaundererUI.Settings.Items.Title.Background.Height, nil)
                    end
                else
                    RenderRectangle(CurrentMenu.X, CurrentMenu.Y, LaundererUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, LaundererUI.Settings.Items.Title.Background.Height, CurrentMenu.Rectangle.R, CurrentMenu.Rectangle.G, CurrentMenu.Rectangle.B, CurrentMenu.Rectangle.A)
                end
            else
                RenderRectangle(CurrentMenu.X, CurrentMenu.Y, LaundererUI.Settings.Items.Title.Background.Width + CurrentMenu.WidthOffset, LaundererUI.Settings.Items.Title.Background.Height, CurrentMenu.Rectangle.R, CurrentMenu.Rectangle.G, CurrentMenu.Rectangle.B, CurrentMenu.Rectangle.A)
            end
            if (CurrentMenu.Display.Glare) then
                local ScaleformMovie = RequestScaleformMovie("MP_MENU_GLARE")
                ---@type number
                local Glarewidth = LaundererUI.Settings.Items.Title.Background.Width
                ---@type number
                local Glareheight = LaundererUI.Settings.Items.Title.Background.Height
                ---@type number
                local GlareX = CurrentMenu.X / 1920 + (CurrentMenu.SafeZoneSize.X / (64.399 - (CurrentMenu.WidthOffset * 0.065731)))
                ---@type number
                local GlareY = CurrentMenu.Y / 1080 + CurrentMenu.SafeZoneSize.Y / 33.195020746888
                LaundererUI.SetScaleformParams(ScaleformMovie, {
                    { name = "SET_DATA_SLOT", param = { GetGameplayCamRelativeHeading() } }
                })
                --DrawScaleformMovie(ScaleformMovie, GlareX, GlareY, Glarewidth / 430, Glareheight / 100, 255, 255, 255, 255, 0) (Petite Planète)
            end
            RenderText(CurrentMenu.Title, CurrentMenu.X + LaundererUI.Settings.Items.Title.Text.X + (CurrentMenu.WidthOffset / 2), CurrentMenu.Y + LaundererUI.Settings.Items.Title.Text.Y, CurrentMenu.TitleFont, CurrentMenu.TitleScale, 255, 255, 255, 255, 1)
            LaundererUI.ItemOffset = LaundererUI.ItemOffset + LaundererUI.Settings.Items.Title.Background.Height
        end
    end
end

function LaundererUI.Subtitle()
    local CurrentMenu = LaundererUI.CurrentMenu
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Subtitle) then
            LaundererUI.ItemsSafeZone(CurrentMenu)
            if CurrentMenu.Subtitle ~= "" then
                RenderRectangle(CurrentMenu.X, CurrentMenu.Y + LaundererUI.ItemOffset, LaundererUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset, LaundererUI.Settings.Items.Subtitle.Background.Height + CurrentMenu.SubtitleHeight, 0, 0, 0, 200)
                RenderText(CurrentMenu.PageCounterColour .. CurrentMenu.Subtitle, CurrentMenu.X + LaundererUI.Settings.Items.Subtitle.Text.X, CurrentMenu.Y + LaundererUI.Settings.Items.Subtitle.Text.Y + LaundererUI.ItemOffset, 0, LaundererUI.Settings.Items.Subtitle.Text.Scale, 245, 245, 245, 255, nil, false, false, LaundererUI.Settings.Items.Subtitle.Background.Width + CurrentMenu.WidthOffset)
                if CurrentMenu.Index > CurrentMenu.Options or CurrentMenu.Index < 0 then
                    CurrentMenu.Index = 1
                end
                if (CurrentMenu ~= nil) then
                    if (CurrentMenu.Index > CurrentMenu.Pagination.Total) then
                        local offset = CurrentMenu.Index - CurrentMenu.Pagination.Total
                        CurrentMenu.Pagination.Minimum = 1 + offset
                        CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total + offset
                    else
                        CurrentMenu.Pagination.Minimum = 1
                        CurrentMenu.Pagination.Maximum = CurrentMenu.Pagination.Total
                    end
                end
                
                if CurrentMenu.Display.PageCounter then
                    if CurrentMenu.PageCounter == nil then
                        RenderText(CurrentMenu.PageCounterColour .. CurrentMenu.Index .. " / " .. CurrentMenu.Options, CurrentMenu.X + LaundererUI.Settings.Items.Subtitle.PreText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + LaundererUI.Settings.Items.Subtitle.PreText.Y + LaundererUI.ItemOffset, 0, LaundererUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                    else
                        RenderText(CurrentMenu.PageCounter, CurrentMenu.X + LaundererUI.Settings.Items.Subtitle.PreText.X + CurrentMenu.WidthOffset, CurrentMenu.Y + LaundererUI.Settings.Items.Subtitle.PreText.Y + LaundererUI.ItemOffset, 0, LaundererUI.Settings.Items.Subtitle.PreText.Scale, 245, 245, 245, 255, 2)
                    end
                end
                LaundererUI.ItemOffset = LaundererUI.ItemOffset + LaundererUI.Settings.Items.Subtitle.Background.Height
            end
        end
    end
end

function LaundererUI.Background()
    local CurrentMenu = LaundererUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() and (CurrentMenu.Display.Background) then
            LaundererUI.ItemsSafeZone(CurrentMenu)
            SetScriptGfxDrawOrder(0)
            RenderSprite(LaundererUI.Settings.Items.Background.Dictionary, LaundererUI.Settings.Items.Background.Texture, CurrentMenu.X, CurrentMenu.Y + LaundererUI.Settings.Items.Background.Y + CurrentMenu.SubtitleHeight, LaundererUI.Settings.Items.Background.Width + CurrentMenu.WidthOffset, LaundererUI.ItemOffset, 0, 0, 0, 0, 150)
            SetScriptGfxDrawOrder(1)
        end
    end
end

function LaundererUI.Description()
    local CurrentMenu = LaundererUI.CurrentMenu;
    local Description = LaundererUI.Settings.Items.Description;
    if CurrentMenu ~= nil and CurrentMenu.Description ~= nil then
        if CurrentMenu() then
            LaundererUI.ItemsSafeZone(CurrentMenu)
            RenderRectangle(CurrentMenu.X, CurrentMenu.Y + Description.Bar.Y + CurrentMenu.SubtitleHeight + LaundererUI.ItemOffset, Description.Bar.Width + CurrentMenu.WidthOffset, Description.Bar.Height, 0, 0, 0, 255)
            RenderSprite(Description.Background.Dictionary, Description.Background.Texture, CurrentMenu.X, CurrentMenu.Y + Description.Background.Y + CurrentMenu.SubtitleHeight + LaundererUI.ItemOffset, Description.Background.Width + CurrentMenu.WidthOffset, CurrentMenu.DescriptionHeight, 0, 0, 0, 255)
            RenderText(CurrentMenu.Description, CurrentMenu.X + Description.Text.X, CurrentMenu.Y + Description.Text.Y + CurrentMenu.SubtitleHeight + LaundererUI.ItemOffset, 0, Description.Text.Scale, 255, 255, 255, 255, nil, false, false, Description.Background.Width + CurrentMenu.WidthOffset - 8.0)
            LaundererUI.ItemOffset = LaundererUI.ItemOffset + CurrentMenu.DescriptionHeight + Description.Bar.Y
        end
    end
end

function LaundererUI.Render()
    local CurrentMenu = LaundererUI.CurrentMenu;
    if CurrentMenu ~= nil then
        if CurrentMenu() then
            if CurrentMenu.Safezone then
                ResetScriptGfxAlign()
            end

            if (CurrentMenu.Display.InstructionalButton) then
                if not CurrentMenu.InitScaleform then
                    CurrentMenu:UpdateInstructionalButtons(true)
                    CurrentMenu.InitScaleform = true
                end
                DrawScaleformMovieFullscreen(CurrentMenu.InstructionalScaleform, 255, 255, 255, 255, 0)
            end
            CurrentMenu.Options = LaundererUI.Options
            CurrentMenu.SafeZoneSize = nil
            LaundererUI.Controls()
            LaundererUI.Options = 0
            LaundererUI.StatisticPanelCount = 0
            LaundererUI.ItemOffset = 0
            if CurrentMenu.Controls.Back.Enabled then
                if CurrentMenu.Controls.Back.Pressed and CurrentMenu.Closable then
                    CurrentMenu.Controls.Back.Pressed = false
                    local Audio = LaundererUI.Settings.Audio
                    LaundererUI.PlaySound(Audio[Audio.Use].Back.audioName, Audio[Audio.Use].Back.audioRef)

                    if CurrentMenu.Closed ~= nil then
                        collectgarbage()
                        CurrentMenu.Closed()
                    end

                    if CurrentMenu.Parent ~= nil then
                        if CurrentMenu.Parent() then
                            LaundererUI.NextMenu = CurrentMenu.Parent
                            CurrentMenu:UpdateCursorStyle()
                        else
                            LaundererUI.NextMenu = nil
                            LaundererUI.Visible(CurrentMenu, false)
                        end
                    else
                        LaundererUI.NextMenu = nil
                        LaundererUI.Visible(CurrentMenu, false)
                    end
                elseif CurrentMenu.Controls.Back.Pressed and not CurrentMenu.Closable then
                    CurrentMenu.Controls.Back.Pressed = false
                end
            end
            if LaundererUI.NextMenu ~= nil then
                if LaundererUI.NextMenu() then
                    LaundererUI.Visible(CurrentMenu, false)
                    LaundererUI.Visible(LaundererUI.NextMenu, true)
                    CurrentMenu.Controls.Select.Active = false
                    LaundererUI.NextMenu = nil
                    LaundererUI.LastControl = false
                end
            end
        end
    end
end

function LaundererUI.ItemsDescription(CurrentMenu, Description, Selected)
    ---@type table
    if Description ~= "" or Description ~= nil then
        local SettingsDescription = LaundererUI.Settings.Items.Description;
        if Selected and CurrentMenu.Description ~= Description then
            CurrentMenu.Description = Description or nil
            ---@type number
            local DescriptionLineCount = GetLineCount(CurrentMenu.Description, CurrentMenu.X + SettingsDescription.Text.X, CurrentMenu.Y + SettingsDescription.Text.Y + CurrentMenu.SubtitleHeight + LaundererUI.ItemOffset, 0, SettingsDescription.Text.Scale, 255, 255, 255, 255, nil, false, false, SettingsDescription.Background.Width + (CurrentMenu.WidthOffset - 5.0))
            if DescriptionLineCount > 1 then
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height * DescriptionLineCount
            else
                CurrentMenu.DescriptionHeight = SettingsDescription.Background.Height + 7
            end
        end
    end
end

function LaundererUI.ItemsMouseBounds(CurrentMenu, Selected, Option, SettingsButton)
    ---@type boolean
    local Hovered = false
    Hovered = LaundererUI.IsMouseInBounds(CurrentMenu.X + CurrentMenu.SafeZoneSize.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SafeZoneSize.Y + CurrentMenu.SubtitleHeight + LaundererUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height)
    if Hovered and not Selected then
        RenderRectangle(CurrentMenu.X, CurrentMenu.Y + SettingsButton.Rectangle.Y + CurrentMenu.SubtitleHeight + LaundererUI.ItemOffset, SettingsButton.Rectangle.Width + CurrentMenu.WidthOffset, SettingsButton.Rectangle.Height, 255, 255, 255, 20)
        if CurrentMenu.Controls.Click.Active then
            CurrentMenu.Index = Option
            local Audio = LaundererUI.Settings.Audio
            LaundererUI.PlaySound(Audio[Audio.Use].UpDown.audioName, Audio[Audio.Use].UpDown.audioRef)
        end
    end
    return Hovered;
end

function LaundererUI.ItemsSafeZone(CurrentMenu)
    if not CurrentMenu.SafeZoneSize then
        CurrentMenu.SafeZoneSize = { X = 0, Y = 0 }
        if CurrentMenu.Safezone then
            CurrentMenu.SafeZoneSize = LaundererUI.GetSafeZoneBounds()
            SetScriptGfxAlign(76, 84)
            SetScriptGfxAlignParams(0, 0, 0, 0)
        end
    end
end

function LaundererUI.CurrentIsEqualTo(Current, To, Style, DefaultStyle)
    return Current == To and Style or DefaultStyle or {};
end

function LaundererUI.IsVisible(Menu, Items, Panels)
    if (LaundererUI.Visible(Menu)) and (UpdateOnscreenKeyboard() ~= 0) and (UpdateOnscreenKeyboard() ~= 3) then
        LaundererUI.Banner()
        LaundererUI.Subtitle()
        if (Items ~= nil) then
            Items()
        end
        LaundererUI.Background();
        LaundererUI.Navigation();
        LaundererUI.Description();
        if (Panels ~= nil) then
            Panels()
        end
        LaundererUI.Render()
    end
end

---SetStyleAudio
---@param StyleAudio string
---@return void
---@public
function LaundererUI.SetStyleAudio(StyleAudio)
    LaundererUI.Settings.Audio.Use = StyleAudio or "LaundererUI"
end

function LaundererUI.GetStyleAudio()
    return LaundererUI.Settings.Audio.Use or "LaundererUI"
end

