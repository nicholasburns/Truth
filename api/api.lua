local A, C, G, L = select(2, ...):Unpack()
local print = function(...) A.print("API", ...) end
local X = A["PixelSize"]
local P = A["PixelSizes"]
G.Panels = {}


local error = error
local assert = assert
local getmetatable = getmetatable
local select, type, unpack, pairs, ipairs = select, type, unpack, pairs, ipairs
local math, ceil, floor, max, min = math, math.ceil, math.floor, math.max, math.min
local string, find, format, upper = string, string.find, string.format, string.upper
local table, tinsert = table, table.insert

local CreateFrame = CreateFrame
local SetDesaturation = SetDesaturation
local SquareButton_SetIcon = SquareButton_SetIcon
local UnitClass = UnitClass


-- Constant
local PLAYER_COLOR = A.PLAYER_COLOR

local BACKDROP_COLOR = {
	r = A.default.backdrop.color[1],
	g = A.default.backdrop.color[2],
	b = A.default.backdrop.color[3],
	a = A.default.backdrop.alpha,
}
local BORDER_COLOR = {
	r = A.default.border.color[1],
	g = A.default.border.color[2],
	b = A.default.border.color[3],
	a = A.default.border.alpha,
}

local TEMPLATE_ALPHA = A.default.backdrop.alpha
local TEMPLATE_STYLE = "DEFAULT"


local MARGIN, PAD = G.MARGIN, G.PAD			-- 10, 5

local BUTTON_WIDTH, BUTTON_HEIGHT = G.BUTTON_WIDTH or 80, G.BUTTON_HEIGHT or 22
local CHECKBUTTON_SIZE = G.CHECKBUTTON_SIZE or 20
local SCROLLBAR_WIDTH = G.SCROLLBAR_WIDTH or 28
local SCROLLBAR_BUTTON_SIZE = G.SCROLLBAR_BUTTON_SIZE or 16
local SCROLLBAR_THUMB_TEXTURE = G.SCROLLBAR_THUMB_TEXTURE or [=[Interface\Buttons\UI-ScrollBar-Knob]=]



-- API
local isNil, isFrame, isFont, isNumber, isString, isTable, isTexture
local Kill, Strip, Scale, Size, Width, Height, Point, GetPoints, SetInside, SetOutside
local SetHighlightBackdrop, SetClassBackdrop, SetDefaultBackdrop, SetHoverScripts
local Template, Border, Shadow, Backdrop, Panel
local StyleButton, StyleItemButton
local SkinButton, SkinCheckButton, SkinCloseButton, SkinSlider, SkinTab, SkinResizeButton
local SkinIcon, SkinDropDownButton, SkinDropDownBox, SkinEditBox, SkinRotateButton, SkinScrollBar
local SkinPageButton, SkinNextPrevButton
local SkinNormalTexture, SkinTexture


----------------------------------------------------------------------------------------------------
isNil = function(value)
	return (value == nil) or nil
end
isFrame = function(frame)
	return (frame and frame.IsObjectType and frame:IsObjectType("frame")) and frame or nil
end
isFont = function(font)
	return (font and font.IsObjectType and font:IsObjectType("fontstring")) and font or nil
end
isNumber = function(number)
	return (number and type(number) == "number") and number or nil
end
isString = function(string)
	return (string and type(string) == "string") and string or nil
end
isTable = function(table)
	return (table and type(table) == "table") and table or nil
end
isTexture = function(self)
	return (self and self.IsObjectType and self:IsObjectType("texture")) and self or nil
end

----------------------------------------------------------------------------------------------------
Kill = function(self)
	if (not self) then
		return
	end

	if (self.IsProtected) then
		if (self:IsProtected()) then
			error(("Attempted to kill a protected object: < %s >"):format(self:GetName()))									-- error("Attempted to kill a protected object: <" .. Object:GetName() .. ">")
		end
	end

	if (self.UnregisterAllEvents) then
		self:SetParent(A["HiddenFrame"])
		self:UnregisterAllEvents()
	else
		self.Show = self.Hide
	end

	self:Hide()
end
Strip = function(self, kill)
	for i = 1, (self:GetNumRegions()) do
		local region = select(i, self:GetRegions())
		if (region and region:GetObjectType() == "Texture") then
			if (kill and type(kill) == "boolean") then
				region:Kill()
			else
				region:SetTexture(nil)
			end
		end
	end
end
Scale = function(size)
	return X * floor(size / X + 0.5)
--	return X * floor(size / X + 0.5)
end
Size = function(self, width, height)
	self:SetSize(Scale(width), Scale(height or width))
end
Width = function(self, width)
	self:SetWidth(Scale(width))
end
Height = function(self, height)
	self:SetHeight(Scale(height))
end
Point = function(self, a1, a2, a3, a4, a5)
	self.points = self.points and self.points or 0
	if (self.points == 0) then
		self:ClearAllPoints()
	end

	a2 = isNumber(a2) and Scale(a2) or a2		-- a2 = (type(a2) == 'number') and Scale(a2) or a2
	a3 = isNumber(a3) and Scale(a3) or a3        -- a3 = (type(a3) == 'number') and Scale(a3) or a3
	a4 = isNumber(a4) and Scale(a4) or a4        -- a4 = (type(a4) == 'number') and Scale(a4) or a4
	a5 = isNumber(a5) and Scale(a5) or a5        -- a5 = (type(a5) == 'number') and Scale(a5) or a5

	self:SetPoint(a1, a2, a3, a4, a5)

	self.points = self.points + 1
end
SetInside = function(self, anchor, x, y)
	anchor = not isNumber(anchor) and anchor or nil

	if (self:GetPoint()) then
		self:ClearAllPoints()
	end

	x = isNumber(x) and Scale(x) or A["PixelSizes"][2]
	y = isNumber(y) and Scale(y) or A["PixelSizes"][2]

	if (not anchor) then
		self:SetPoint("TOPLEFT", x, -y)
		self:SetPoint("BOTTOMRIGHT", -x, y)
	else
		self:SetPoint("TOPLEFT", anchor, x, -y)
		self:SetPoint("BOTTOMRIGHT", anchor, -x, y)
	end
end
SetOutside = function(self, anchor, x, y)
	anchor = not isNumber(anchor) and anchor or nil

	x = isNumber(x) and Scale(x) or A["PixelSizes"][2]
	y = isNumber(y) and Scale(y) or A["PixelSizes"][2]

	if (self:GetPoint()) then
		self:ClearAllPoints()
	end

	if (not anchor) then
		self:SetPoint("TOPLEFT", -x, y)
		self:SetPoint("BOTTOMRIGHT", x, -y)
	else
		self:SetPoint("TOPLEFT", anchor, -x, y)
		self:SetPoint("BOTTOMRIGHT", anchor, x, -y)
	end
end
SkinNormalTexture = function(self)
end

--------------------------------------------------
SetHighlightBackdrop = function(self)
	self:SetBackdropColor(1, 1, 1, 0.3)
	self:SetBackdropBorderColor(1, 1, 1)
end
SetClassBackdrop = function(self)
--	self:SetBackdropColor(PLAYER_COLOR.r/3, PLAYER_COLOR.g/3, PLAYER_COLOR.b/3)
	self:SetBackdropBorderColor(PLAYER_COLOR.r, PLAYER_COLOR.g, PLAYER_COLOR.b)
end
SetDefaultBackdrop = function(self)
--	self:SetBackdropColor(BACKDROP_COLOR.r, BACKDROP_COLOR.g, BACKDROP_COLOR.b)
	self:SetBackdropBorderColor(BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b)
end
SetHoverScripts = function(self)
	self.bcolor = self.bcolor or { self:GetBackdropColor() }
	self.ecolor = self.ecolor or { self:GetBackdropBorderColor() }

	self:HookScript("OnEnter", function(self)
		self:SetBackdropColor(PLAYER_COLOR.r / 3, PLAYER_COLOR.g / 3, PLAYER_COLOR.b / 3)
		self:SetBackdropBorderColor(PLAYER_COLOR.r, PLAYER_COLOR.g, PLAYER_COLOR.b)
	end)

	self:HookScript("OnLeave", function(self)
		self:SetBackdropColor(unpack(self.bcolor))
		self:SetBackdropBorderColor(unpack(self.ecolor))
	end)
end

--------------------------------------------------
Template = function(self, template)
	local T = template and upper(template) or TEMPLATE_STYLE
	local alpha = TEMPLATE_ALPHA

	if (T == "TRANSPARENT" or T == "T") then
		alpha = 0.7
	elseif (T == "CLASSCOLOR" or T == "C") then
		alpha = 0.3
	elseif (T == "CLEAR") then
		alpha = 0.0
		self:SetBackdrop(nil)
		--	 self.SetBackdropColor = noop
		--	 self.SetBackdropBorderColor = noop

		return
	end

	self:SetBackdrop(A.template.backdrop)

	if (T == "CLASSCOLOR" or T == "C") then
		self:SetBackdropColor(PLAYER_COLOR.r/3, PLAYER_COLOR.g/3, PLAYER_COLOR.b/3, alpha)
		self:SetBackdropBorderColor(PLAYER_COLOR.r, PLAYER_COLOR.g, PLAYER_COLOR.b)
	else
		self:SetBackdropColor(BACKDROP_COLOR.r, BACKDROP_COLOR.g, BACKDROP_COLOR.b, alpha)
		self:SetBackdropBorderColor(BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b)
	end
end
Border = function(self, template)
	if (template == "TOP") then															-- print("border", name)
		_G[("%sLeft"):format(self:GetName())]:Kill()
		_G[("%sMiddle"):format(self:GetName())]:Kill()
		_G[("%sRight"):format(self:GetName())]:Kill()

		self.border = self:CreateTexture(nil, 'BORDER')
		self.border:SetPoint('TOPLEFT', 0, 1)
		self.border:SetPoint('TOPRIGHT', 0, 1)
		self.border:SetHeight(1)
		self.border:SetTexture(BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b)
	else
		self.border = CreateFrame("Frame", "$parent_Border", self)
		self.border:SetFrameLevel(self:GetFrameLevel() + 1)
		self.border:SetAllPoints()
		self.border:SetBackdrop({
			edgeFile = A.default.border.texture,
			edgeSize = X,
			insets   = {left = 0, right = 0, top = 0, bottom = 0}})						-- insets = {left = X, right = X, top = X, bottom = X}})
		self.border:SetBackdropBorderColor(BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b)
	end
end
Shadow = function(self)
	self.shadow = CreateFrame('Frame', "$parent_Shadow", self)
	self.shadow:SetOutside(self, 3, 3)
	self.shadow:SetFrameStrata(self:GetFrameStrata())
	self.shadow:SetFrameLevel((self:GetFrameLevel() > 0) and (self:GetFrameLevel() - 1) or 0)
	self.shadow:SetBackdrop({
		edgeFile = A.media.border.glow,
		edgeSize = Scale(3),
		insets   = {left = Scale(5), right = Scale(5), top = Scale(5), bottom = Scale(5)}})
	self.shadow:SetBackdropBorderColor(0, 0, 0, 0.8)
end
Backdrop = function(self)
	self.backdrop = CreateFrame('Frame', "$parent_Backdrop", self)
	self.backdrop:SetFrameLevel((self:GetFrameLevel() > 0) and (self:GetFrameLevel() - 1) or 0)
	self.backdrop:SetAllPoints(self)
	self.backdrop:SetBackdrop(A.template.background)
	self.backdrop:SetBackdropColor(BACKDROP_COLOR.r, BACKDROP_COLOR.g, BACKDROP_COLOR.b, BACKDROP_COLOR.a)
end
Panel = function(self, template)
--	count:  Handles multiple panels placed on a single frame (AuctionFrame uses 2 background panels)
	local count = self.panel_count or 1

	local panel

	if (count == 1) then
		panel = CreateFrame('Frame', "$parent_Panel", self)
		self.panel = panel
	else
		panel = CreateFrame('Frame', "$parent_Panel_" .. count, self)
	end

	panel:Template(template)
	panel:SetFrameLevel((self:GetFrameLevel() > 0) and (self:GetFrameLevel() - 1) or 0)
--	panel:SetFrameLevel(self:GetFrameLevel() - 1)

	self.panel[count] = panel

	G.Panels[#G.Panels + 1] = panel

	self.panel_count = count + 1

--	DEBUG
--	print("G.Panels", #G.Panels)						-- print total # of panels created
--	print(self.panel[count]:GetName(), self.panel_count)	-- print current panel name & its panel count
end

--------------------------------------------------
do
	local OnEnter, OnLeave
	local OnMouseUp, OnMouseDown
	local OnDisable, OnEnable


	OnEnter = function(self)
		self:SetBackdropBorderColor(PLAYER_COLOR.r, PLAYER_COLOR.g, PLAYER_COLOR.b)
	end

	OnLeave = function(self)
		self:SetBackdropBorderColor(BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b)
	end

	SkinButton = function(self, StripTextures)												-- if (self:GetName()) then local name = self:GetName() -- if (_G[("%sLeft"):format(name)]) then _G[("%sLeft"):format(name)]:SetAlpha(0) end -- if (_G[("%sMiddle"):format(name)]) then _G[("%sMiddle"):format(name)]:SetAlpha(0) end -- if (_G[("%sRight"):format(name)]) then _G[("%sRight"):format(name)]:SetAlpha(0) end end
		if (self.Left) then self.Left:SetAlpha(0) end
		if (self.Right) then self.Right:SetAlpha(0) end
		if (self.Middle) then self.Middle:SetAlpha(0) end
		if (self.SetNormalTexture) then self:SetNormalTexture('') end
		if (self.SetPushedTexture) then self:SetPushedTexture('') end
		if (self.SetDisabledTexture) then self:SetDisabledTexture('') end
		if (self.SetHighlightTexture) then self:SetHighlightTexture('') end

		if (StripTextures) then
			Strip(self)
		end

		self:Template("DEFAULT")

		self:HookScript("OnEnter", SetClassBackdrop)
		self:HookScript("OnLeave", SetDefaultBackdrop)
	end


	OnMouseUp = function(self)
		self.icon:SetPoint('CENTER')
	end

	OnMouseDown = function(self)
		if (self:IsEnabled()) then
			self.icon:SetPoint('CENTER', -1, -1)
		end
	end

	OnDisable = function(self)
		SetDesaturation(self.icon, true)
		self.icon:SetAlpha(0.5)
	end

	OnEnable = function(self)
		SetDesaturation(self.icon, false)
		self.icon:SetAlpha(1)
	end


	SkinIcon = function(self, Direction)
		assert(self, "does not exist")

		self:SkinButton(true)
		self:SetSize(self:GetWidth() - 10, self:GetHeight() - 10)

		if (not self.icon) then
			self.icon = self:CreateTexture(nil, "ARTWORK")
		end

		local icon = self.icon
		icon:SetSize(14, 14)
		icon:SetPoint("CENTER")
		icon:SetTexture([=[Interface\Buttons\SquareButtonTextures]=])
		icon:SetTexCoord(0.01562500, 0.20312500, 0.01562500, 0.20312500)

		self:SetScript("OnMouseUp", OnMouseUp)
		self:SetScript("OnMouseDown", OnMouseDown)
		self:SetScript("OnDisable", OnDisable)
		self:SetScript("OnEnable",  OnEnable)
		if (not self:IsEnabled()) then
			self:GetScript("OnDisable")(self)
		end

		if (Direction) then
			SquareButton_SetIcon(self, Direction)
		end
	end


	SkinNextPrevButton = function(self, Direction)
		SkinIcon(self, Direction)
	end
end

SkinDropDownBox = function(self, width)
	local Button = _G[self:GetName() .. "Button"]
	local Text   = _G[self:GetName() .. "Text"]

	Strip(self)

	width = isNumber(width) or 150
	self:SetWidth(width)

	Text:Point("RIGHT", Button, "LEFT", -2, 0)


	-- Button
	Button:Template("DEFAULT")
	Button:Size(Button:GetWidth() - 7, Button:GetHeight() - 7)
	Button:Point("RIGHT", self, -10, 3)		-- Button:SkinDropDownButton() SkinNextPrevButton(Button)

	local normal = Button.GetNormalTexture and Button:GetNormalTexture() or nil
	local pushed = Button.GetPushedTexture and Button:GetPushedTexture() or nil
	local disabled = Button.GetDisabledTexture and Button:GetDisabledTexture() or nil
	local highlight = Button.GetHighlightTexture and Button:GetHighlightTexture() or nil

	if (normal) then
		normal:SetInside()
		normal:SetTexCoord(0.25, 0.3, 0.25, 0.7,  0.7, 0.3,  0.7, 0.7)				-- {ULx,  ULy,  LLx, LLy,  URx, URy,  LRx, LRy}
	end
	if (pushed) then
		pushed:SetTexCoord(0.25, 0.3, 0.25, 0.7,  0.7, 0.3,  0.7, 0.7)
		pushed:SetAllPoints(normal)
	end
	if (disabled) then
		disabled:SetTexCoord(0.25, 0.3, 0.25, 0.7,  0.7, 0.3,  0.7, 0.7)
		disabled:SetAllPoints(normal)
	end
	if (highlight) then
		highlight:SetTexture(1, 1, 1, 0.3)
		highlight:SetAllPoints(normal)
	end


	-- Backdrop
	Backdrop(self)
	self.backdrop:Template("CLASSCOLOR")
	self.backdrop:SetHeight(20)
	self.backdrop:Point("TOPLEFT", 20, -2)
	self.backdrop:Point("BOTTOMRIGHT", Button, 2, -2)

	return Button
end
SkinEditBox = function(self, height)
	local name = self:GetName()

	if (_G[("%sMid"):format(name)]) then _G[("%sMid"):format(name)]:Kill() end
	if (_G[("%sLeft"):format(name)]) then _G[("%sLeft"):format(name)]:Kill() end
	if (_G[("%sRight"):format(name)]) then _G[("%sRight"):format(name)]:Kill() end
	if (_G[("%sMiddle"):format(name)])	then _G[("%sMiddle"):format(name)]:Kill() end

	self:Height(height or 20)

	self:SetTextInsets(2, 1, 1, 1)			-- {L, R, T, B}

	-- Backdrop
	self.backdrop = CreateFrame('Frame', "$parent_Backdrop", self)
	self.backdrop:SetFrameLevel((self:GetFrameLevel() > 0) and (self:GetFrameLevel() - 1) or 0)
	self.backdrop:SetAllPoints(self)
	self.backdrop:SetBackdrop({bgFile = A.default.backdrop.texture})
	self.backdrop:SetBackdropColor(0.5, 0.5, 0.5, 0.9)

	-- Currency
	if (name:find("Silver") or name:find("Copper")) then									-- Currency (the tiny boxes)
	--	self.backdrop:Point('TOPLEFT', self, 0, 0)
		self.backdrop:SetPoint('BOTTOMRIGHT', self, -12, 0)
	end
end
SkinScrollBar = function(self)
	local ScrollBarName	= self.GetName and self:GetName()
	local UpButton		= _G[("%sScrollUpButton"):format(ScrollBarName)]
	local DownButton	= _G[("%sScrollDownButton"):format(ScrollBarName)]

	self:Strip(true)

	UpButton:SkinIcon("UP")
	UpButton:SetSize(18, 16)

	DownButton:SkinIcon("DOWN")
	DownButton:SetSize(18, 16)

	local Track = self.Track or CreateFrame('Frame', "$parent_TrackBackdrop", self)
	Track:SetPoint('TOPLEFT', UpButton, 'BOTTOMLEFT', 0, -1)
	Track:SetPoint('BOTTOMRIGHT', DownButton, 'TOPRIGHT', 0, 1)
	Track:Template("TRANSPARENT")
	Track:SetBackdropColor(0.5, 0.5, 0.5, 0.3)

	if (self:GetThumbTexture()) then			-- self:GetThumbTexture():SetTexture(nil)
		local Thumb = self.Thumb or CreateFrame('Frame', "$parent_ThumbBackdrop", self)
		Thumb:Strip(true)
		Thumb:Template("DEFAULT")
		Thumb:SetInside(self:GetThumbTexture())
	end
end
SkinTab = function(self)
	assert(self, "does not exist")

	self:Strip(true)

	-- Backdrop
	self.backdrop = CreateFrame('Frame', "$parent_Backdrop", self)
	self.backdrop:Template("DEFAULT")
	self.backdrop:SetFrameLevel((self:GetFrameLevel() > 0) and (self:GetFrameLevel() - 1) or 0)
	self.backdrop:Point('TOPLEFT', 10, -3)
	self.backdrop:Point('BOTTOMRIGHT', -10, 3)
end
SkinTexture = function(self)
	local Texture = self.GetNormalTexture and self:GetNormalTexture()

	if (Texture) then
		Texture:GetNormalTexture():SetTexCoord(0.08, 0.92, 0.08, 0.92)								-- self:GetNormalTexture():SetTexCoord(G.TexCoords:Unpack())
		Texture:GetNormalTexture():SetInside()
	end
end


--------------------------------------------------
StyleButton = function(self)														-- Styles actionbar & bag buttons
	self:Strip()

	if (self.SetPushedTexture and not self.pushed) then
		self.pushed = self:CreateTexture("Frame", nil, self)
		self.pushed:SetTexture(1, 1, 0, 0.35)	-- (0.9, 0.8, 0.1, 0.4)
		self.pushed:SetInside()
		self:SetPushedTexture(self.pushed)
	end
	if (self.SetCheckedTexture and not self.checked) then
		self.checked = self:CreateTexture("Frame", nil, self)
		self.checked:SetTexture(0, 1, 0, 0.35)
		self.checked:SetInside()
		self:SetCheckedTexture(self.checked)
	end
	if (self.SetHighlightTexture and not self.highlight) then
		self.highlight = self:CreateTexture("Frame", nil, self)
		self.highlight:SetTexture(1, 1, 1, 0.35)
		self.highlight:SetInside()
		self:SetHighlightTexture(self.highlight)
	end
--	local cooldown = self:GetName() and _G[self:GetName() .. 'Cooldown']
	local cooldown = self.GetName and _G[self:GetName() .. 'Cooldown']
	if (cooldown) then cooldown:SetInside() end

	-- MONITOR THIS !
--	self:Template("TRANSPARENT")

	-- Coords
--	self:GetNormalTexture():SetTexCoord(0.08, 0.92, 0.08, 0.92)
--	self:GetNormalTexture():SetInside()
end

StyleItemButton = function(self)
	self:StyleButton()
	self:Template("DEFAULT")

	if (not self:GetNormalTexture()) then
		return
	end

	self:GetNormalTexture():SetTexCoord(0.08, 0.92, 0.08, 0.92)
	self:GetNormalTexture():SetInside()
end

SkinCheckButton = function(self, size)
	self:Strip()
	self:Template("DEFAULT")

	if (size) then
		self:SetSize(size, size)
	end

	if (self.SetHighlightTexture) then
		self.highlight = self:CreateTexture(nil, nil, self)
		self.highlight:SetTexture(PLAYER_COLOR.r, PLAYER_COLOR.g, PLAYER_COLOR.b, 0.5)
		self.highlight:SetInside()
		self:SetHighlightTexture(self.highlight)
	end
	if (self.SetCheckedTexture) then
		self.checked = self:CreateTexture(nil, nil, self)
		self.checked:SetTexture(PLAYER_COLOR.r, PLAYER_COLOR.g, PLAYER_COLOR.b)
		self.checked:SetInside()
		self:SetCheckedTexture(self.checked)
	end
	if (self.SetDisabledCheckedTexture) then
		self.disabled = self:CreateTexture(nil, nil, self)
		self.disabled:SetTexture(0.6, 0.6, 0.6, 0.75)
		self.disabled:SetInside()
		self:SetDisabledCheckedTexture(self.disabled)
	end
end
SkinCloseButton = function(self, anchor, text)
	self:Strip(true)
	self:Template("DEFAULT")

	self:SetSize(20, 20)

	if (anchor) then
		self:ClearAllPoints()
		self:SetPoint('TOPRIGHT', anchor or nil, -PAD, -PAD)
	else
		self:SetPoint('TOPRIGHT', -PAD, -PAD)
	end

	if (self.SetNormalTexture) then self:SetNormalTexture('') end
	if (self.SetPushedTexture) then self:SetPushedTexture('') end

	self:HookScript("OnEnter", SetClassBackdrop)
	self:HookScript("OnLeave", SetDefaultBackdrop)

	self.text = self:CreateFontString(nil, "OVERLAY")
	self.text:SetFont(A.media.font.continuum, 16, "OUTLINE")				-- A.media.font.pt
	self.text:SetTextColor(1, 1, 1, 1)
	self.text:SetJustifyH("CENTER")
	self.text:SetPoint("CENTER", 1, 0)
	self.text:SetText(text or "x")
end
SkinResizeButton = function(self)
	self:SetSize(18, 18)					--[[ Default Size: 16 ]]
	self:ClearAllPoints()
	self:SetPoint('BOTTOMRIGHT')

	self:SetNormalTexture([=[Interface\CHATFRAME\UI-ChatIM-SizeGrabber-Up]=])
	self:SetPushedTexture([=[Interface\CHATFRAME\UI-ChatIM-SizeGrabber-Down]=])
	self:SetHighlightTexture([=[Interface\CHATFRAME\UI-ChatIM-SizeGrabber-Highlight]=])

	self:SetScript("OnMouseDown", function(self) self:GetParent():StartSizing() end)
	self:SetScript("OnMouseUp", function(self) self:GetParent():StopMovingOrSizing() end)
end
SkinRotateButton = function(self)
	self:Template("DEFAULT")
	self:Size(18)

	local normal = self.GetNormalTexture and self:GetNormalTexture() or nil
	local pushed = self.GetPushedTexture and self:GetPushedTexture() or nil
	local highlight = self.GetHighlightTexture and self:GetHighlightTexture() or nil

	if (normal) then
		normal:SetInside()
		normal:SetTexCoord(0.3, 0.3, 0.3, 0.65, 0.7, 0.3, 0.7, 0.65)				-- {ULx,  ULy,  LLx, LLy,  URx, URy,  LRx, LRy}
	end

	if (pushed) then
		pushed:SetTexCoord(0.3, 0.3, 0.3, 0.65, 0.7, 0.3, 0.7, 0.65)
		pushed:SetAllPoints(normal)
	end

	if (highlight) then
		highlight:SetTexture(1, 1, 1, 0.3)
		highlight:SetAllPoints(normal)
	end
end
SkinSlider = function(self)
	if (self.slider) then
		return
	end

	self:SetBackdrop(nil)

	local backdrop = CreateFrame("Frame", "$parent_Backdrop", self)
	backdrop:Template("DEFAULT")
	backdrop:Point("TOPLEFT", 14, -2)
	backdrop:Point("BOTTOMRIGHT", -15, 3)
	backdrop:SetFrameLevel(self:GetFrameLevel() - 1)

	local slider = select(4, self:GetRegions())
	slider:SetTexture("Interface\\CastingBar\\UI-CastingBar-Spark")
	slider:SetBlendMode("ADD")

	self.slider = true
end


--------------------------------------------------
--[[ SetTexCoord  { ULx, ULy, LLx, LLy, URx, URy, LRx, LRy }


	ULx - X position : as a fraction of the img WIDTH  : from the LEFT
	ULy - Y position : as a fraction of the img HEIGHT : from the TOP
	LLx - X position : as a fraction of the img WIDTH  : from the LEFT
	LLy - Y position : as a fraction of the img HEIGHT : from the TOP
	URx - X position : as a fraction of the img WIDTH  : from the LEFT
	URy - Y position : as a fraction of the img HEIGHT : from the TOP
	LRx - X position : as a fraction of the img WIDTH  : from the LEFT
	LRy - Y position : as a fraction of the img HEIGHT : from the TOP


	- top left corner of the image is (0, 0)
	- bottom right corner is (1, 1)

	---------------------------------------------
	Example  |  Displays the bottom-left quarter of the image

	Texture:SetTexCoord(0, 0.5, 0.5, 1)		-- { LEFT, RIGHT, TOP, BOTTOM }

	left   - Left edge   : as a fraction of the img WIDTH  : from the LEFT
	right  - Right edge  : as a fraction of the img WIDTH  : from the LEFT
	top    - Top edge    : as a fraction of the img HEIGHT : from the TOP
	bottom - Bottom edge : as a fraction of the img HEIGHT : from the TOP
--]]

--[[ Working_SkinNextPrevButton = function(self, horizonal)
	self:Template("DEFAULT")
	self:Size(self:GetWidth() - 7, self:GetHeight() - 7)

	if (horizonal) then
		self:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.72, 0.65, 0.29, 0.65, 0.72)
		self:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.8, 0.65, 0.35, 0.65, 0.8)
		self:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
	else
		self:GetNormalTexture():SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)

		if (self:GetPushedTexture()) then
			self:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)
		end

		if (self:GetDisabledTexture()) then
			self:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)
		end
	end

	self:GetNormalTexture():Point("TOPLEFT", 2, -2)						--	self:GetNormalTexture():ClearAllPoints()
	self:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)

	if (self:GetDisabledTexture()) then
		self:GetDisabledTexture():SetAllPoints(self:GetNormalTexture())
	end

	if (self:GetPushedTexture()) then
		self:GetPushedTexture():SetAllPoints(self:GetNormalTexture())
	end

	self:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
	self:GetHighlightTexture():SetAllPoints(self:GetNormalTexture())
end
--]]

--[[	EditBox - Texture Nuke

	if (self.LeftTex) then self.LeftTex:Kill() end
	if (self.RightTex) then self.RightTex:Kill() end
	if (self.MiddleTex) then self.MiddleTex:Kill() end
	if (self.TopTex) then self.TopTex:Kill() end
	if (self.TopLeftTex) then self.TopLeftTex:Kill() end
	if (self.TopRightTex) then self.TopRightTex:Kill() end
	if (self.BottomTex) then self.BottomTex:Kill() end
	if (self.BottomLeftTex) then self.BottomLeftTex:Kill() end
	if (self.BottomRightTex) then self.BottomRightTex:Kill() end
--]]

----------------------------------------------------------------------------------------------------
local function addapi(O)
	local mt = getmetatable(O).__index

	if (not O.isNil) then mt.isNil = isNil end
	if (not O.isFrame) then mt.isFrame = isFrame end
	if (not O.isFont) then mt.isFont = isFont end
	if (not O.isNumber) then mt.isNumber = isNumber end
	if (not O.isString) then mt.isString = isString end
	if (not O.isTable) then mt.isTable = isTable end
	if (not O.isTexture) then mt.isTexture = isTexture end

	if (not O.Kill) then mt.Kill = Kill end
	if (not O.Strip) then mt.Strip = Strip end

--	Pixel API
	if (not O.Scale) then mt.Scale = Scale end
	if (not O.Size) then mt.Size = Size end
	if (not O.Width) then mt.Width = Width end
	if (not O.Height) then mt.Height = Height end
	if (not O.Point) then mt.Point = Point end
	if (not O.GetPoints) then mt.GetPoints = GetPoints end
	if (not O.SetInside) then  mt.SetInside = SetInside end
	if (not O.SetOutside) then  mt.SetOutside = SetOutside end

--	Utilities
	if (not O.SetHighlightBackdrop) then mt.SetHighlightBackdrop = SetHighlightBackdrop end
	if (not O.SetClassBackdrop) then mt.SetClassBackdrop = SetClassBackdrop end
	if (not O.SetDefaultBackdrop) then mt.SetDefaultBackdrop = SetDefaultBackdrop end
	if (not O.SetHoverScripts) then mt.SetHoverScripts = SetHoverScripts end
--	if (not O.ClassBackdrop) then mt.ClassBackdrop = ClassBackdrop end
--	if (not O.DefaultBackdrop) then mt.DefaultBackdrop = DefaultBackdrop end
--	if (not O.NewBackdrop) then mt.NewBackdrop = NewBackdrop end
--	if (not O.OldBackdrop) then mt.OldBackdrop = OldBackdrop end
--	if (not O.MakeMovable) then mt.MakeMovable = MakeMovable end

--	Frame API
	if (not O.Template) then mt.Template = Template end
	if (not O.Border) then mt.Border = Border end
	if (not O.Backdrop) then mt.Backdrop = Backdrop end
	if (not O.Shadow) then mt.Shadow = Shadow end
--	if (not O.Overlay) then mt.Overlay = Overlay end
	if (not O.Panel) then mt.Panel = Panel end

--	Skin API
	if (not O.StyleButton) then mt.StyleButton = StyleButton end
	if (not O.StyleItemButton) then mt.StyleItemButton = StyleItemButton end
	if (not O.SkinButton) then mt.SkinButton = SkinButton end
--	if (not O.SkinCheckBox) then mt.SkinCheckBox = SkinCheckBox end
	if (not O.SkinCheckButton) then mt.SkinCheckButton = SkinCheckButton end
	if (not O.SkinCloseButton) then mt.SkinCloseButton = SkinCloseButton end
	if (not O.SkinDropDownButton) then mt.SkinDropDownButton = SkinDropDownButton end
	if (not O.SkinDropDownBox) then mt.SkinDropDownBox = SkinDropDownBox end
	if (not O.SkinEditBox) then mt.SkinEditBox = SkinEditBox end
	if (not O.SkinIcon) then mt.SkinIcon = SkinIcon end
	if (not O.SkinNextPrevButton) then mt.SkinNextPrevButton = SkinNextPrevButton end
	if (not O.SkinPageButton) then mt.SkinPageButton = SkinPageButton end
	if (not O.SkinRotateButton) then mt.SkinRotateButton = SkinRotateButton end
	if (not O.SkinScrollBar) then mt.SkinScrollBar = SkinScrollBar end
	if (not O.SkinSlider) then mt.SkinSlider = SkinSlider end
	if (not O.SkinTab) then mt.SkinTab = SkinTab end
	if (not O.SkinResizeButton) then mt.SkinResizeButton = SkinResizeButton end

	if (not O.SkinTexture) then mt.SkinTexture = SkinTexture end
	if (not O.SkinNormalTexture) then mt.SkinNormalTexture = SkinNormalTexture end

	---------------------------------------------

--	if (not O.FadeIn) then mt.FadeIn = FadeIn end
--	if (not O.FadeOut) then mt.FadeOut = FadeOut end
--	if (not O.Font) then mt.Font = Font end
--	if (not O.FontTemplate) then mt.FontTemplate = FontTemplate end
--	if (not O.FontString) then mt.FontString = FontString end
end

local handled = {['Frame'] = true}
local Object = CreateFrame('Frame')
addapi(Object)
addapi(Object:CreateTexture())
addapi(Object:CreateFontString())
Object = EnumerateFrames()
while (Object) do
	if (not handled[Object:GetObjectType()]) then
		addapi(Object)
		handled[Object:GetObjectType()] = true
	end
	Object = EnumerateFrames(Object)
end



-- Blizzard Panels
--	local ToggleFrame = ToggleFrame
--	local ShowUIPanel = ShowUIPanel
--	local HideUIPanel = HideUIPanel
--	local HideParentPanel = HideParentPanel
--	local LowerFrameLevel = LowerFrameLevel
--	local RaiseFrameLevel = RaiseFrameLevel
--	local RaiseFrameLevelByTwo = RaiseFrameLevelByTwo




--[[	Blizzard Panel Functions

	-- Panel Functions						--@ UIParent

	local LowerFrameLevel = LowerFrameLevel
	local RaiseFrameLevel = RaiseFrameLevel
	local RaiseFrameLevelByTwo = RaiseFrameLevelByTwo

	local LowerFrameLevel = function(f)
		f:SetFrameLevel(f:GetFrameLevel() - 1)
	end

	local RaiseFrameLevel = function(f)
		f:SetFrameLevel(f:GetFrameLevel() + 1)
	end

	local RaiseFrameLevelByTwo = function(f)
		f:SetFrameLevel(f:GetFrameLevel() + 2)
	end

	local ToggleFrame = function(f)
		if (f:IsShown()) then
			HideUIPanel(f)
		else
			ShowUIPanel(f)
		end
	end

	local ShowUIPanel = function(frame, force)
		if (not frame or frame:IsShown()) then return end
		if (not GetUIPanelWindowInfo(frame, "area")) then
			frame:Show() return
		end
		FramePositionDelegate:SetAttribute("panel-force", force)
		FramePositionDelegate:SetAttribute("panel-frame", frame)
		FramePositionDelegate:SetAttribute("panel-show", true)
	end

	local HideUIPanel = function(f, skipSetPoint)
		if (not f or not f:IsShown()) then return end
		if (not GetUIPanelWindowInfo(f, "area")) then
			f:Hide() return
		end
		FramePositionDelegate:SetAttribute("panel-frame", f)
		FramePositionDelegate:SetAttribute("panel-skipSetPoint", skipSetPoint)
		FramePositionDelegate:SetAttribute("panel-hide", true)
	end

	local HideParentPanel = function(self)
		HideUIPanel(self:GetParent())
	end
--]]

----------------------------------------------------------------------------------------------------
--	ShestakUI / Tukui Media Config
----------------------------------------------------------------------------------------------------
--[[ C['media'] = {
		['blank']			= [=[~\Media\white]=],		-- texture for borders
		['hlite']			= [=[~\Media\highlight]=],	-- texture for debuffs highlight
		['tex']			= [=[~\Media\texture]=],		-- texture for status bars
		 --
		['border_color']	= {0.37, 0.3, 0.3, 1},		-- color for borders
		['backdrop_color']	= {0, 0, 0, 1},			-- color for borders backdrop
		['overlay_color']	= {0, 0, 0, 0.7},			-- color for action bars overlay
	}
--]]
----------------------------------------------------------------------------------------------------


--------------------------------------------------
--	Util
--------------------------------------------------
--[[ local ClassBackdrop = function(self)
		self:SetBackdropColor(PLAYER_COLOR.r/3, PLAYER_COLOR.g/3, PLAYER_COLOR.b/3)
		self:SetBackdropBorderColor(PLAYER_COLOR.r, PLAYER_COLOR.g, PLAYER_COLOR.b)
	end
--]]

--[[ local GetClassColors = function(class)
	-- Exampple Usage:
	-- local r, g, b = GetClassColors(A["PlayerClass"])

	class = class and class:upper()

	if (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class]) then
		return CUSTOM_CLASS_COLORS[class].r, CUSTOM_CLASS_COLORS[class].g, CUSTOM_CLASS_COLORS[class].b
	end

	if (RAID_CLASS_COLORS and RAID_CLASS_COLORS[class]) then
		return RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
	end

	return 0.63, 0.63, 0.63
end
local ClassColors = GetClassColors
--]]

--[[ local FontString = function(parent, name, file, size, flag, ...)
		local fs = parent:CreateFontString(nil, "OVERLAY")
		fs:SetFont(file, size, flag)
		fs:SetShadowColor(0, 0, 0, 1)
		fs:SetShadowOffset(1, -1)

		if (not name) then
			parent.text = fs
		else
			parent[name] = fs
		end

		return fs
	end
--]]


--[[	local TopBorder = function(self)				-- (Button)
		local Button = self:GetName()

		_G[Button .. "Left"]:Kill()
		_G[Button .. "Middle"]:Kill()
		_G[Button .. "Right"]:Kill()

		local f = _G[Button]

		f.topborder = f:CreateTexture(nil, 'BORDER')
		f.topborder:Point('TOPLEFT', f, -1, 1)
		f.topborder:Point('TOPRIGHT', f, 1, -1)
		f.topborder:SetHeight(1)
		f.topborder:SetTexture(0.5, 0.5, 0.5)
		f.topborder:SetDrawLayer('BORDER', -7)
	end
--]]

--[[ API.Button = function(parent, text)
	local button = CreateFrame('Button', '$parent'..text..'Button', parent, 'UIPanelButtonTemplate')
	button:SetText(text)
	return button
end
--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ SkinScrollFrame  (unused blocks)

	---------------------------------------------
  --[=[	Blizzard_Calandar.lua
		Modify the size of the scrollbar & the position of the UpButton/DownButton buttons
		in order to get the thumb texture to stop closer to the up and down buttons
  --]=]

	-- STEP 1: resize the scrollbar
	local scrollBar = self

	scrollBar:Point('TOPLEFT', "$parent", 'TOPRIGHT', 0, -10)
	scrollBar:Point('BOTTOMLEFT', "$parent", 'BOTTOMRIGHT', 0, 10)

	-- STEP 2: Reposition the UpButton/DownButton buttons
	local upButton   = _G[self:GetName() .. "ScrollUpButton"]
	local downButton = _G[self:GetName() .. "ScrollDownButton"]

	upButton:Point('BOTTOM', scrollBar, 'TOP', 0, -4)
	downButton:Point('TOP', scrollBar, 'BOTTOM', 0, 4)

	-- STEP 3: Save the scrollbar
	self.scrollBar = scrollBar

	---------------------------------------------
	if (_G[name .. "BG"]) then _G[name .. "BG"]:SetTexture(nil) end
	if (_G[name .. "Track"]) then _G[name .. "Track"]:SetTexture(nil) end
	if (_G[name .. "Top"]) then _G[name .. "Top"]:SetTexture(nil) end
	if (_G[name .. "Bottom"]) then _G[name .. "Bottom"]:SetTexture(nil) end
	if (_G[name .. "Middle"]) then _G[name .. "Middle"]:SetTexture(nil) end

--]]

--[[ Frameless Border

	self:SetBackdrop({bgFile = texture})
  -- edgeFile = A.default.border.texture, edgeSize = X})
  -- insets = {left = -X, right = -X, top = -X, bottom = -X}})

	self.bordertop = self:CreateTexture(nil, 'BORDER')
	self.bordertop:Point('TOPLEFT', -1, 1)
	self.bordertop:Point('TOPRIGHT', 1, -1)
	self.bordertop:Height(1)
	self.bordertop:SetTexture(0.5, 0.5, 0.5)

	self.borderbottom = self:CreateTexture(nil, 'BORDER')
	self.borderbottom:Point('BOTTOMLEFT', -1, -1)
	self.borderbottom:Point('BOTTOMRIGHT', 1, -1)
	self.borderbottom:Height(1)
	self.borderbottom:SetTexture(0.5, 0.5, 0.5)

	self.borderleft = self:CreateTexture(nil, 'BORDER')
	self.borderleft:Point('TOPLEFT', -1, 1)
	self.borderleft:Point('BOTTOMLEFT', 1, -1)
	self.borderleft:Width(1)
	self.borderleft:SetTexture(0.5, 0.5, 0.5)

	self.borderright = self:CreateTexture(nil, 'BORDER')
	self.borderright:Point('TOPRIGHT', 1, 1)
	self.borderright:Point('BOTTOMRIGHT', -1, -1)
	self.borderright:Width(1)
	self.borderright:SetTexture(0.5, 0.5, 0.5)

	-- self.borderinsidetop = self:CreateTexture(nil, 'BORDER')
	-- self.borderinsidetop:Point('TOPLEFT', 1, -1)
	-- self.borderinsidetop:Point('TOPRIGHT', -1, 1)
	-- self.borderinsidetop:Height(1)
	-- self.borderinsidetop:SetTexture(0.5, 0.5, 0.5)

	-- self.borderinsidebottom = self:CreateTexture(nil, 'BORDER')
	-- self.borderinsidebottom:Point('BOTTOMLEFT', 1, 1)
	-- self.borderinsidebottom:Point('BOTTOMRIGHT', -1, 1)
	-- self.borderinsidebottom:Height(1)
	-- self.borderinsidebottom:SetTexture(0.5, 0.5, 0.5)

	-- self.borderinsideleft = self:CreateTexture(nil, 'BORDER')
	-- self.borderinsideleft:Point('TOPLEFT', 1, -1)
	-- self.borderinsideleft:Point('BOTTOMLEFT', -1, 1)
	-- self.borderinsideleft:Width(1)
	-- self.borderinsideleft:SetTexture(0.5, 0.5, 0.5)

	-- self.borderinsideright = self:CreateTexture(nil, 'BORDER')
	-- self.borderinsideright:Point('TOPRIGHT', -1, -1)
	-- self.borderinsideright:Point('BOTTOMRIGHT', 1, 1)
	-- self.borderinsideright:Width(1)
	-- self.borderinsideright:SetTexture(0.5, 0.5, 0.5)
--]]

--[[ local SkinScrollBar = function(self, thumbtrim)
	local name = self:GetName()										-- print("SkinScrollBar()", name)
	local scroll = _G[name]											-- BrowseScrollFrameScrollBar

	local up   = _G[name .. "ScrollUpButton"]
	local down = _G[name .. "ScrollDownButton"]

	if (_G[name .. 'BG'])     then _G[name .. 'BG']:SetTexture(nil) end
	if (_G[name .. 'Track'])  then _G[name .. 'Track']:SetTexture(nil) end
	if (_G[name .. 'Top'])    then _G[name .. 'Top']:SetTexture(nil) end
	if (_G[name .. 'Bottom']) then _G[name .. 'Bottom']:SetTexture(nil) end
	if (_G[name .. 'Middle']) then _G[name .. 'Middle']:SetTexture(nil) end

	-- ScrollBar

	self:Point("TOPRIGHT", -5, -(up:GetHeight() + 5))
	self:Point("BOTTOMRIGHT", -5, (up:GetHeight() + 5))

	if (up and down) then

		-- Down Button
		up:Strip()

		if (not up.texture) then
			up:SkinPageButton()
			up:SetSize(up:GetWidth() + 7, up:GetHeight() + 7)
			-- up:SkinPrevNextButton()
			-- up.texture = up:CreateTexture(nil, 'OVERLAY')
			-- up.texture:SetInside()
			-- up.texture:SetVertexColor(BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b)
		end

		-- Down Button
		down:Strip()

		if (not down.texture) then
			down:SkinPageButton()
			down:SetSize(down:GetWidth() + 7, down:GetHeight() + 7)
			-- down:SkinPrevNextButton()
			-- down.texture = down:CreateTexture(nil, 'OVERLAY')
			-- down.texture:SetInside()
			-- down.texture:SetVertexColor(BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b)
		end

		-- Track Background
		if (not self.trackbackdrop) then
			self.trackbackdrop = CreateFrame('Frame', "$parent_TrackBackdrop", self)
			self.trackbackdrop:Point('TOPLEFT', up, 'BOTTOMLEFT', 0, -1)
			self.trackbackdrop:Point('BOTTOMRIGHT', down, 'TOPRIGHT', 0, 1)
			self.trackbackdrop:Template("TRANSPARENT")

			self.trackbackdrop:SetBackdropColor(PLAYER_COLOR.r/3/2, PLAYER_COLOR.g/3/2, PLAYER_COLOR.b/3/2)
			self.trackbackdrop:SetBackdropBorderColor(PLAYER_COLOR.r, PLAYER_COLOR.g, PLAYER_COLOR.b)
		end

		-- Thumb Texture
		if (self:GetThumbTexture()) then
			self:GetThumbTexture():SetTexture(nil)

			if (not self.thumbbg) then
				self.thumbbg = CreateFrame('Frame', "$parent_ThumbBackground", self)
				self.thumbbg:Point('TOPLEFT', self:GetThumbTexture(), 2, -(thumbtrim or 3))
				self.thumbbg:Point('BOTTOMRIGHT', self:GetThumbTexture(), -2, (thumbtrim or 3))
				self.thumbbg:SetFrameLevel(self.trackbackdrop:GetFrameLevel())
				self.thumbbg:Template("DEFAULT")

				self.thumbbg:SetBackdropColor(PLAYER_COLOR.r/3, PLAYER_COLOR.g/3, PLAYER_COLOR.b/3)
				self.thumbbg:SetBackdropBorderColor(PLAYER_COLOR.r, PLAYER_COLOR.g, PLAYER_COLOR.b)
			end
		end
	end
end
--]]

--[[ local SkinPrevNextButton = function(b)
		local name = b:GetName()
		local BackButton = name and (find(name, "Left") or find(name, "Prev") or find(name, "Decrement") or find(name, "Back"))

		local NORMAL_TEXTURE_PREV	= "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up"		-- Normal
		local NORMAL_TEXTURE_NEXT	= "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up"
		local PUSHED_TEXTURE_PREV	= "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down"		-- Pushed
		local PUSHED_TEXTURE_NEXT	= "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down"
		local DISABLED_TEXTURE_PREV	= "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled"	-- Disabled
		local DISABLED_TEXTURE_NEXT	= "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled"

		local Normal_BLP, Pushed_BLP, Disabled_BLP
		if (b:GetNormalTexture()) then Normal_BLP = b:GetNormalTexture():GetTexture() end
		if (b:GetPushedTexture()) then Pushed_BLP = b:GetPushedTexture():GetTexture() end
		if (b:GetDisabledTexture()) then Disabled_BLP = b:GetDisabledTexture():GetTexture() end

		b:Strip()

		if (not Normal_BLP and BackButton) then Normal_BLP = NORMAL_TEXTURE_PREV elseif (not Normal_BLP) then Normal_BLP = NORMAL_TEXTURE_NEXT end
		if (not Pushed_BLP and BackButton) then Pushed_BLP = PUSHED_TEXTURE_PREV elseif (not Pushed_BLP) then Pushed_BLP = PUSHED_TEXTURE_NEXT end
		if (not Disabled_BLP and BackButton) then Disabled_BLP = DISABLED_TEXTURE_PREV elseif (not Disabled_BLP) then Disabled_BLP = DISABLED_TEXTURE_NEXT end

		b:SetNormalTexture(Normal_BLP)
		b:SetPushedTexture(Pushed_BLP)
		b:SetDisabledTexture(Disabled_BLP)


		b:SetSize(b:GetWidth() - 7, b:GetHeight() - 7)


		if (Normal_BLP and Pushed_BLP and Disabled_BLP) then
			b:GetNormalTexture():SetTexCoord(0.3, 0.3, 0.3, 0.8, 0.6, 0.3, 0.6, 0.8)
			b:GetPushedTexture():SetTexCoord(0.3, 0.3, 0.3, 0.8, 0.6, 0.3, 0.6, 0.8)				-- if (b:GetPushedTexture()) then b:GetPushedTexture():SetTexCoord(0.3, 0.3, 0.3, 0.8, 0.6, 0.3, 0.6, 0.8) end
			b:GetDisabledTexture():SetTexCoord(0.3, 0.3, 0.3, 0.7, 0.6, 0.3, 0.6, 0.7)				-- if (b:GetDisabledTexture()) then b:GetDisabledTexture():SetTexCoord(0.3, 0.3, 0.3, 0.7, 0.6, 0.3, 0.6, 0.7) end
		 -- b:GetNormalTexture():ClearAllPoints()
		 -- b:GetNormalTexture():SetPoint("TOPLEFT", 2, -2)
		 -- b:GetNormalTexture():SetPoint("BOTTOMRIGHT", -2, 2)
			b:GetNormalTexture():SetInside()
			b:GetPushedTexture():SetAllPoints(b:GetNormalTexture())							-- if (b:GetPushedTexture()) then b:GetPushedTexture():SetAllPoints(b:GetNormalTexture()) end
			b:GetDisabledTexture():SetAllPoints(b:GetNormalTexture())							-- if (b:GetDisabledTexture()) then b:GetDisabledTexture():SetAllPoints(b:GetNormalTexture()) end
			b:GetHighlightTexture():SetAllPoints(b:GetNormalTexture())

			b:GetHighlightTexture():SetTexture(1, 1, 1, 0.3)
		end
	end
--]]

--[[ local SkinPageButton = function(b, ButtonIsHorizontal)
	local NORMAL_TEXTURE_PREV	= "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Up"		-- Normal
	local NORMAL_TEXTURE_NEXT	= "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Up"
	local PUSHED_TEXTURE_PREV	= "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Down"		-- Pushed
	local PUSHED_TEXTURE_NEXT	= "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Down"
	local DISABLED_TEXTURE_PREV	= "Interface\\Buttons\\UI-SpellbookIcon-PrevPage-Disabled"	-- Disabled
	local DISABLED_TEXTURE_NEXT	= "Interface\\Buttons\\UI-SpellbookIcon-NextPage-Disabled"
	local name = b:GetName()
	local BackButton = name and (find(name, "Left") or find(name, "Prev") or find(name, "Decrement") or find(name, "Back"))

	local Normal_BLP, Pushed_BLP, Disabled_BLP

	local Normal = b:GetNormalTexture()
	local Pushed = b:GetPushedTexture()
	local Disabled = b:GetDisabledTexture()
	local Highlight = b:GetHighlightTexture()

	b:Strip()

	Normal_BLP = (Normal and not Normal:GetTexture() and BackButton and NORMAL_TEXTURE_PREV) or (Normal and not Normal:GetTexture() and NORMAL_TEXTURE_NEXT) or nil
	Pushed_BLP = (Pushed and (not Pushed:GetTexture() and BackButton) and PUSHED_TEXTURE_PREV) or ((not Pushed:GetTexture()) and PUSHED_TEXTURE_NEXT) or nil
	Disabled_BLP = (Disabled and (not Disabled:GetTexture() and BackButton) and DISABLED_TEXTURE_PREV) or ((not Disabled:GetTexture()) and DISABLED_TEXTURE_NEXT) or nil

	b:SetNormalTexture(Normal_BLP)
	b:SetPushedTexture(Pushed_BLP)
	b:SetDisabledTexture(Disabled_BLP)

	b:Template("DEFAULT")
	b:Size(b:GetWidth() - 7, b:GetHeight() - 7)
	-- b:SetInside()

	if (Normal_BLP and Pushed_BLP and Disabled_BLP) then

		if (ButtonIsHorizontal) then
			b:SetNormalTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Up")
			b:SetPushedTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Down")
			b:SetDisabledTexture("Interface\\ChatFrame\\UI-ChatIcon-ScrollDown-Disabled")
			 --
			Normal:SetTexCoord(0.3, 0.29, 0.3, 0.72, 0.65, 0.29, 0.65, 0.72)
			Pushed:SetTexCoord(0.3, 0.35, 0.3, 0.8, 0.65, 0.35, 0.65, 0.8)				-- if (b:GetPushedTexture()) then b:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.8, 0.65, 0.35, 0.65, 0.8) end
			Disabled:SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)			-- if (b:GetDisabledTexture()) then b:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75) end
		else
			Normal:SetTexCoord(0.3, 0.29, 0.3, 0.81, 0.65, 0.29, 0.65, 0.81)
			Pushed:SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81)				-- if (b:GetPushedTexture()) then b:GetPushedTexture():SetTexCoord(0.3, 0.35, 0.3, 0.81, 0.65, 0.35, 0.65, 0.81) end
			Disabled:SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75)			-- if (b:GetDisabledTexture()) then b:GetDisabledTexture():SetTexCoord(0.3, 0.29, 0.3, 0.75, 0.65, 0.29, 0.65, 0.75) end
		end

		Normal:SetInside()

		Pushed:SetAllPoints(Normal)									-- if (b:GetPushedTexture()) then b:GetPushedTexture():SetAllPoints(b:GetNormalTexture()) end
		Disabled:SetAllPoints(Normal)									-- if (b:GetDisabledTexture()) then b:GetDisabledTexture():SetAllPoints(b:GetNormalTexture()) end
		Highlight:SetAllPoints(Normal)
		Highlight:SetTexture(1, 1, 1, 0.3)

	end
end
--]]

--[[ local Overlay = function(self)
	if (self.overlay) then return end

	self.overlay = self:CreateTexture("$parent_Overlay", "BORDER", self)								-- self.overlay = self:CreateTexture(self:GetName() and self:GetName() .. "_Overlay" or nil, "BORDER", self)
	self.overlay:SetInside()
	self.overlay:SetTexture(A.default.border.texture)
	self.overlay:SetVertexColor(0.5, 0.5, 0.5)

end
--]]

--[[ local Border = function(self, iborder, oborder)
		if (iborder) then
			if (self.iborder) then return end
			self.iborder = CreateFrame("Frame", "$parent_InnerBorder", self)
			self.iborder:SetPoint('TOPLEFT', X, -X)
			self.iborder:SetPoint('BOTTOMRIGHT', -X, X)
			self.iborder:SetBackdrop({
				edgeFile = A.default.border.texture,
				edgeSize = X,
				insets   = {left = X, right = X, top = X, bottom = X}})
			self.iborder:SetBackdropBorderColor(BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b)
		end
		if (oborder) then
			if (self.oborder) then return end
			self.oborder = CreateFrame('Frame', "$parent_OuterBorder", self)
			self.oborder:SetPoint('TOPLEFT', -X, X)
			self.oborder:SetPoint('BOTTOMRIGHT', X, -X)
			self.oborder:SetFrameLevel(self:GetFrameLevel() + 1)
			self.oborder:SetBackdrop({
				edgeFile = A.default.border.texture,
				edgeSize = X,
				insets   = {left = X, right = X, top = X, bottom = X}})
			self.oborder:SetBackdropBorderColor(BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b)
		end
	end
--]]

--------------------------------------------------

--[[ local MakeMovableIcon = function(f)
		f:SetMovable(true)
		f:EnableMouse(true)

		f:RegisterForDrag("LeftButton")
		f:SetScript("OnDragStart", function(self)
			if (IsControlKeyDown() or IsAltKeyDown()) then
				self:StartSizing()

			elseif (IsShiftKeyDown()) then
				self:StartMoving()

			else
				self:StartMoving()
			end
		end)
		f:SetScript("OnDragStop", function(self)
			if (self.t) then
				self:SetHeight(self:GetWidth())	-- Make it a square
			end

			self:StopMovingOrSizing()
		end)
	end
--]]

--------------------------------------------------

--[[ Arrows Textures

	local DownArrowNormal	= [=[Interface\ChatFrame\UI-MicroStream-Green]=]
	local DownArrowPushed	= [=[Interface\ChatFrame\UI-MicroStream-Yellow]=]
	local DownArrowDisabled	= [=[Interface\ChatFrame\UI-MicroStream-Red]=]

	Toggling Textures

	local NormalDownArrow	= [=[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Up]=]
	local PushedDownArrow	= [=[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Down]=]
	local DisabledDownArrow	= [=[Interface\ChatFrame\UI-ChatIcon-ScrollDown-Disabled]=]

	Paging Textures

	local PrevPageNormal	= [=[Interface\Buttons\UI-SpellbookIcon-PrevPage-Up]=]			-- Normal
	local NextPageNormal	= [=[Interface\Buttons\UI-SpellbookIcon-NextPage-Up]=]
	local PrevPagePushed	= [=[Interface\Buttons\UI-SpellbookIcon-PrevPage-Down]=]		-- Pushed
	local NextPagePushed	= [=[Interface\Buttons\UI-SpellbookIcon-NextPage-Down]=]
	local PrevPageDisabled	= [=[Interface\Buttons\UI-SpellbookIcon-PrevPage-Disabled]=]	-- Disabled
	local NextPageDisabled	= [=[Interface\Buttons\UI-SpellbookIcon-NextPage-Disabled]=]

	local NormalPrev		= [=[Interface\Buttons\UI-SpellbookIcon-PrevPage-Up]=]			-- Normal
	local NormalNext		= [=[Interface\Buttons\UI-SpellbookIcon-NextPage-Up]=]
	local PushedLeft		= [=[Interface\Buttons\UI-SpellbookIcon-PrevPage-Down]=]		-- Pushed
	local PushedRight		= [=[Interface\Buttons\UI-SpellbookIcon-NextPage-Down]=]
	local DisabledLeft		= [=[Interface\Buttons\UI-SpellbookIcon-PrevPage-Disabled]=]	-- Disabled
	local DisabledRight		= [=[Interface\Buttons\UI-SpellbookIcon-NextPage-Disabled]=]
---]]

--------------------------------------------------

--[[ SetPoint()



	X-Offset:		+ POS + values move obj RIGHT
				- NEG - values move obj LEFT
	Y-Offset:		+ POS + values move obj UpButton
				- NEG - values move obj DownButton
--]]
--[[ Layers

	HIGHLIGHT		Level 4. Place your text, objects, and buttons in this level
	OVERLAY		Level 3. Place your text, objects, and buttons in this level
	ARTWORK		Level 2. Place the artwork of your self here - Default for regions when layer is not specified
	BORDER 		Level 1. Place the artwork of your self here
	BACKGROUND	Level 0. Place the background of your self here

--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ local Colorize = function(t)
		if (t == 'CLASSCOLOR') then
			local Class = select(2, UnitClass('player'))
			local color = A.color.class[Class]

			bR, bG, bB = BACKDROP_COLOR.r, BACKDROP_COLOR.g, BACKDROP_COLOR.b
			eR, eG, eB = color[1], color[2], color[3]										-- eR, eG, eB = A["PlayerColors"]["r"], A["PlayerColors"]["g"], A["PlayerColors"]["b"]
		else
			bR, bG, bB = BACKDROP_COLOR.r, BACKDROP_COLOR.g, BACKDROP_COLOR.b
			eR, eG, eB = BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b
		end
	end
--]]

--[[ local Skin = function(f)
		f:SetBackdrop({
			bgFile	= [=[Interface\Tooltips\UI-Tooltip-Background]=],
			edgeFile	= [=[Interface\BUTTONS\WHITE8X8]=],
			edgeSize	= 1,
			insets	= {left = 1, right = 1, top = 1, bottom = 1}})
	 -- f:SetBackdropColor(.1, .1, .1, 1)
	 -- f:SetBackdropBorderColor(.6, .6, .6, 1)
	end
--]]

--------------------------------------------------

--[[ Strip Textures (simpler version)

	local StripTextures = function(obj, kill)
		for i = 1, ( obj:GetNumRegions() ) do
			local region = select(i, obj:GetRegions())

			if (region:GetObjectType() == 'Texture') then
				if (kill) then
					region:Kill()
				else
					region:SetTexture(nil)
				end
			end
		end
	end
--]]

--------------------------------------------------

--[[ local function SkinSlider_WORKING_VERSION(f, height, movetext)
	local name = f:GetName()

	f:Template("DEFAULT")
	f:SetBackdropColor(0, 0, 0, .8)

	if (not height) then
		height = f:GetHeight()
	end

	if (movetext) then
		if(_G[name .. 'Low'])  then _G[name .. 'Low']:SetPoint('BOTTOM', 0, -18) end
		if(_G[name .. 'High']) then _G[name .. 'High']:SetPoint('BOTTOM', 0, -18) end
		if(_G[name .. 'Text']) then _G[name .. 'Text']:SetPoint('TOP', 0, 19) end
	end

	f:SetThumbTexture(A.default.backdrop.texture)
	f:GetThumbTexture():SetVertexColor(BORDER_COLOR.r, BORDER_COLOR.g, BORDER_COLOR.b)

	if (f:GetWidth() < f:GetHeight()) then
		f:SetWidth(height)
		f:GetThumbTexture():Size(f:GetWidth(), f:GetWidth() + 4)
	else
		f:SetHeight(height)
		f:GetThumbTexture():Size(height + 4, height)
	end
end
--]]

