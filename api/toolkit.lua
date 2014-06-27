local A, C, G, L = select(2, ...):Unpack()

local print = function(...)
	A.print("Toolkit", ...)
end


local select, type, unpack = select, type, unpack
local format = string.format

local UIParent, GameTooltip = UIParent, GameTooltip
local UIFrameFadeIn, UIFrameFadeOut = UIFrameFadeIn, UIFrameFadeOut
local IsAltKeyDown, IsControlKeyDown, IsShiftKeyDown = IsAltKeyDown, IsControlKeyDown, IsShiftKeyDown




--------------------------------------------------

local rawget = rawget
local type = type

-- Attempts to determine whether or not
-- a table represents a frame by its contents

G.IsUIObject = function(value)							-- Credit: _Dev by Saiket
	return type(value) == "table"
	   and type(rawget(value, 0)) == "userdata"
	   and value.IsObjectType
	   and value.GetName
end



--------------------------------------------------
A.CreateFontString = function(self, file, size, flag, shad, ...)
	local S = self:CreateFontString(nil, "OVERLAY")

	file = file or "Interface\\AddOns\\Truth\\media\\font\\grunge.ttf"
	size = size or 12
	flag = flag or nil
	shad = ((shad and (type(shad) == 'number')) and shad) or (shad and 1 or 0)

	local valid = S:SetFont(file, size, flag)

	if (not valid) then
		A.print("Toolkit", "File not valid:" .. file, ". Called by object: " .. self:GetName()) return
	end

	S:SetShadowOffset(shad, -shad)
	S:SetShadowColor(1, 0, 0, 1)

	self.text = S

	return S
end

A.CreateButton = function(parent, text)
	local button = CreateFrame("Button", "$parent_Button", parent:GetName())
	local label = button:CreateFontString(nil, "OVERLAY", nil)

	label:SetFont(unpack(A.default.font))
	label:SetText(text)

	button:SetWidth(label:GetWidth())
	button:SetHeight(label:GetHeight())
	button:SetFontString(label)

	return button
end

A.CreateSlider = function(Parent_ScrollBar, name)
	local slider = CreateFrame("Slider", "$parent_Slider", Parent_ScrollBar)
	slider:SetPoint('TOPRIGHT')
	slider:SetWidth(20)
	slider:SetHeight(300)

	slider:Template("DEFAULT")
--	slider:SetBackdropColor(A.default.border.color[1], A.default.border.color[2], A.default.border.color[3])
	slider:SetValueStep(20)
	slider:SetOrientation("VERTICAL")
	slider:SetThumbTexture([=[Interface\Buttons\UI-ScrollBar-Knob]=])
	slider:SetScript("OnValueChanged", function(self, value)
		Parent_ScrollBar:SetVerticalScroll(value)
	end)

	local child = CreateFrame('Frame', "$parent_ChildFrame", Parent_ScrollBar)
	child:SetPoint('TOPLEFT')
	child:SetWidth(125)
	child:SetHeight(200)

	Parent_ScrollBar:SetScrollChild(child)

	slider:SetValue(1)
	slider:Hide()
end

A.CreateStatusBar = function(parent)
	local StatusBar = CreateFrame("StatusBar", "$parent_StatusBar", parent or UIParent)
	StatusBar:SetStatusBarTexture(A.default.statusbar.texture)

	return StatusBar
end

A.FadeIn = function(self)
	UIFrameFadeIn(self, 0.4, self:GetAlpha(), 1)
end

A.FadeOut = function(self)
	UIFrameFadeOut(self, 0.8, self:GetAlpha(), 0)
end

A.SlideIn = function(self)
	if (not self.anim) then
		Animate(self)
	end

	self.anim.out1:Stop()
	self:Show()
	self.anim:Play()
end

A.SlideOut = function(self)
	if (self.anim) then
		self.anim:Finish()
	end

	self.anim:Stop()
	self.anim.out1:Play()
end

A.HideGameTooltip = function()
	GameTooltip:Hide()
end

--------------------------------------------------

-- Frame Manipulation

do
	local MakeMovable, SetTransformable
	local OnMouseDown, OnMouseUp, OnDragStart, OnDragStop


	OnMouseDown = function(self)
		self:StartMoving()
	end

	OnMouseUp = function(self)
		self:StopMovingOrSizing()
	end

	OnDragStart = function(self)
		if (IsAltKeyDown()) then				-- unconstrained sizing
			self.constrain = false
			self:StartSizing()
		end
		if (IsControlKeyDown()) then			-- moving
			self:StartMoving()
		end
		if (IsShiftKeyDown()) then			-- constrained sizing
			self.constrain = true
			self:StartSizing()
		end
		self:StartMoving()
	end

	OnDragStop = function(self)
		self:SetWidth((self:GetWidth() > 20) and self:GetWidth() or 20)
		self:GetHeight(self.constrain and self:GetWidth() or ((self:GetHeight() > 20) and self:GetHeight() or 20))
		self:StopMovingOrSizing()
	end

	MakeMovable = function(self)
		self:RegisterForDrag("LeftButton")
		self:EnableMouse(true)
		self:SetMovable(true)
		self:SetResizable(true)

		self:SetScript("OnMouseDown", OnMouseDown)
		self:SetScript("OnMouseUp", OnMouseUp)

		self:SetClampedToScreen(true)			-- offscreen protection
	end

	SetTransformable = function(self)
		self:RegisterForDrag("LeftButton")
		self:EnableMouse(true)
		self:SetMovable(true)
		self:SetResizable(true)

		self.constrain = false

		self:SetScript("OnDragStart", OnDragStart)
		self:SetScript("OnDragStop", OnDragStop)

	--	 self:SetUserPlaced(true)			-- remember or changes
	end

	A.MakeMovable = MakeMovable
	A.SetTransformable = SetTransformable
end

----------------------------------------------------------------------------------------------------
if (not false) then
	return
end


do
	local tremove = table.remove
	local pairs, select, type = pairs, select, type

	local tdelete
	local tcontains
	local CopyTable
	local BuildListString

	tdelete = function(table, item)			-- Util.lua
		local index = 1

		while (table[index]) do
			if (item == table[index]) then
				tremove(table, index)
			else
				index = index + 1
			end
		end
	end

	tcontains = function(table, item)
		local index = 1

		while (table[index]) do
			if (item == table[index]) then
				return 1
			end

			index = index + 1
		end

		return nil
	end

	CopyTable = function(settings)
		local copy = {}

		for k, v in pairs(settings) do
			if (type(v) == "table") then
				copy[k] = CopyTable(v)
			else
				copy[k] = v
			end
		end

		return copy
	end

	BuildListString = function(...)			-- UIParent
		local text = ...

		if (not text) then
			return nil
		end

		local string = text

		for i = 2, select("#", ...) do
			text = select(i, ...)
			if (text) then
				string = string .. ", " .. text
			end
		end

		return string
	end

	A.tdelete = tdelete
	A.tcontains = tcontains
	A.CopyTable = CopyTable
	A.BuildListString = BuildListString
end



----------------------------------------------------------------------------------------------------
--[[ Backdrop Modifiers

	local BACKDROP_COLOR = { r = A.default.backdrop.color[1], g = A.default.backdrop.color[2], b = A.default.backdrop.color[3], a = A.default.backdrop.alpha }
	local BORDER_COLOR = { r = A.default.border.color[1], g = A.default.border.color[2], b = A.default.border.color[3], a = A.default.border.alpha }
	local PLAYER_COLOR = A.PLAYER_COLOR

	A.SetClassBackdrop = function(self)
		self:SetBackdropColor(PLAYER_COLOR.r/3, PLAYER_COLOR.g/3, PLAYER_COLOR.b/3)
		self:SetBackdropBorderColor(PLAYER_COLOR.r, PLAYER_COLOR.g, PLAYER_COLOR.b)
	end

	A.SetDefaultBackdrop = function(self)
		self:SetBackdropColor(BACKDROP_COLOR.r, BACKDROP_COLOR.g, BACKDROP_COLOR.b)
		self:SetBackdropBorderColor(BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b)
	end
--]]

----------------------------------------------------------------------------------------------------
--[[ Item Quality Color

	A.ColorQuality = function(button, id)
		local Quality, Texture, _
		local Quest = _G[button:GetName() .. "IconQuestTexture"]

		if (id) then
			Quality,_,_,_,_,_,_, Texture = select(3, GetItemInfo(id))
		end

		if (Texture) then
			local r, g, b

			if (Quest and Quest:IsShown()) then
				r, g, b = 1, 0, 0
			else
				r, g, b = GetItemQualityColor(Quality)

				if (r == 1 and g == 1) then
					r, g, b = 0, 0, 0
				end
			end

			button:SetBackdropBorderColor(r, g, b)
		else
			button:SetBackdropBorderColor(BACKDROP_COLOR.r, BACKDROP_COLOR.g, BACKDROP_COLOR.b, BACKDROP_COLOR.a)
		end
	end
--]]

----------------------------------------------------------------------------------------------------
--[[ Credits
	AddOn Name: AsphyxiaUI Version 10.x.x
	Author: Sinaris
--]]
----------------------------------------------------------------------------------------------------

