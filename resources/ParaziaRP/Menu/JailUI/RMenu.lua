
---
--- Generated by EmmyLua(https://github.com/EmmyLua)
--- Created by Dylan Malandain.
--- DateTime: 29/10/2019 02:40
---

---@class JailUI
JailUI = {}

---@class Item
JailUI.Item = {}

---@class Panel
JailUI.Panel = {}

---@class Window
JailUI.Window = {}

---@class RMenuv2
RMenuv2 = setmetatable({}, RMenuv2)

---@type table
local TotalMenus = {}

---Add
---@param Type string
---@param Name string
---@param Menu table
---@return RMenuv2
---@public
function RMenuv2.Add(Type, Name, Menu)
    if RMenuv2[Type] ~= nil then
        RMenuv2[Type][Name] = {
            Menu = Menu
        }
    else
        RMenuv2[Type] = {}
        RMenuv2[Type][Name] = {
            Menu = Menu
        }
    end
    return table.insert(TotalMenus, Menu)
end

---Get
---@param Type string
---@param Name string
---@return table
---@public
function RMenuv2:Get(Type, Name)
    if self[Type] ~= nil and self[Type][Name] ~= nil then
        return self[Type][Name].Menu
    end
end

---GetType
---@param Type string
---@return table
---@public
function RMenuv2:GetType(Type)
    if self[Type] ~= nil then
        return self[Type]
    end
end

---Settings
---@param Type string
---@param Name string
---@param Settings string
---@param Value any optional
---@return void
---@public
function RMenuv2:Settings(Type, Name, Settings, Value)
    if Value ~= nil then
        self[Type][Name][Settings] = Value
    else
        return self[Type][Name][Settings]
    end
end

---Delete
---@param Type string
---@param Name string
---@return void
---@public
function RMenuv2:Delete(Type, Name)
    self[Type][Name] = nil
    collectgarbage()
end

---DeleteType
---@param Type string
---@return void
---@public
function RMenuv2:DeleteType(Type)
    self[Type] = nil
    collectgarbage()
end
