local A, C, G, L = select(2, ...):Unpack()

if (not C["Skin"]["Enable"] or not C["Skin"]["Recount"]["Enable"]) then
	return
end

if (not IsAddOnLoaded("Recount")) then
	return
end

local Recount = _G.Recount
local pairs = pairs


-- Constants
local MyName = A.PLAYER_NAME
local MyProfileName = MyName .. " - " .. GetRealmName()
-- local class = select(2, UnitClass("player"))
-- local classcolor = (CUSTOM_CLASS_COLORS or RAID_CLASS_COLORS)[class]



--------------------------------------------------
local function SkinFrame(f)
--	Skin Recount Frame

	f.bgMain = CreateFrame("Frame", "$parent_MainBackdrop", f)

	if (f ~= Recount.MainWindow) then
	  -- f.bgMain:Template("DEFAULT")
		f.bgMain:Template("TRANSPARENT")

		f.CloseButton:SkinCloseButton()
		f.CloseButton:ClearAllPoints()
		f.CloseButton:SetPoint("TOPRIGHT", f, -4, -11)
	end

	if (f == Recount.MainWindow) then
		f.Title:SetPoint("TOPLEFT", f, 3, -15)
		f.Title:SetFont(A.default.font[1], A.default.font[2], A.default.font[3])
		f.Title:SetShadowColor(0, 0, 0, A.default.font[4] and 1 or 0)
		f.CloseButton:SetPoint("TOPRIGHT", f, 3, -9)
	end

	f.bgMain:SetPoint("BOTTOMLEFT", f)
	f.bgMain:SetPoint("BOTTOMRIGHT", f)
	f.bgMain:SetPoint("TOP", f, 0, -7)
	f.bgMain:SetFrameLevel(f:GetFrameLevel())

	f:SetBackdrop(nil)
end

local function SkinButton(b, text)
	if (b.SetNormalTexture)    then b:SetNormalTexture("") end
	if (b.SetPushedTexture)    then b:SetPushedTexture("") end
	if (b.SetHighlightTexture) then b:SetHighlightTexture("") end

	if (not b.text) then
		b:FontString("text", A.default.font[1], A.default.font[2], A.default.font[3])
		b.text:SetPoint("CENTER")
		b.text:SetText(text)
	end

	b:HookScript("OnEnter", function(self) self.text:SetTextColor(A.GetPlayerColor()) end)				-- b:HookScript("OnEnter", function(self) self.text:SetTextColor(classcolor.r, classcolor.g, classcolor.b) end)
	b:HookScript("OnLeave", function(self) self.text:SetTextColor(1, 1, 1) end)
end


--------------------------------------------------
-- Override bar textures
Recount.UpdateBarTextures = function(self)
	for k, v in pairs(Recount.MainWindow.Rows) do
		v.StatusBar:SetStatusBarTexture(A.default.statusbar.texture)
		v.StatusBar:GetStatusBarTexture():SetHorizTile(false)
		v.StatusBar:GetStatusBarTexture():SetVertTile(false)

		v.background = v.StatusBar:CreateTexture(nil, "BACKGROUND")
		v.background:SetAllPoints(v.StatusBar)
		v.background:SetTexture(A.default.backdrop.texture)
		v.background:SetVertexColor(0.15, 0.15, 0.15, 0.8)

		v.overlay = CreateFrame("Frame", nil, v.StatusBar)
		v.overlay:Template("DEFAULT")
		v.overlay:SetFrameStrata("BACKGROUND")
		v.overlay:SetPoint("TOPLEFT", -2, 2)
		v.overlay:SetPoint("BOTTOMRIGHT", 2, -2)

		v.LeftText:ClearAllPoints()
		v.LeftText:SetPoint("LEFT", v.StatusBar, 2, 0)
		v.LeftText:SetFont(A.default.font[1], A.default.font[2], A.default.font[3])
		v.LeftText:SetShadowOffset(A.default.font[4] and 1 or 0, A.default.font[4] and -1 or 0)

		v.RightText:SetFont(A.default.font[1], A.default.font[2], A.default.font[3])
		v.RightText:SetShadowOffset(A.default.font[4] and 1 or 0, A.default.font[4] and -1 or 0)
	end
end
Recount.SetBarTextures = Recount.UpdateBarTextures


--------------------------------------------------
-- Fix bar textures as they are created
Recount.SetupBar_ = Recount.SetupBar
Recount.SetupBar = function(self, bar)
	self:SetupBar_(bar)
	bar.StatusBar:SetStatusBarTexture(A.default.statusbar.texture)
end


--------------------------------------------------
-- Skin frames when they're created
Recount.CreateFrame_ = Recount.CreateFrame
Recount.CreateFrame = function(self, Name, Title, Height, Width, ShowFunc, HideFunc)

	local frame = self:CreateFrame_(Name, Title, Height, Width, ShowFunc, HideFunc)
	SkinFrame(frame)

	return frame
end


--------------------------------------------------
-- Skin some others frame, not available outside Recount
Recount.AddWindow_ = Recount.AddWindow
Recount.AddWindow = function(self, frame)
	Recount:AddWindow_(frame)

	if (frame.YesButton) then
		frame:Template("TRANSPARENT")
		frame.YesButton:SkinButton()
		frame.NoButton:SkinButton()
	end

	if (frame.ReportButton) then
		frame.ReportButton:SkinButton()
	end
end


--------------------------------------------------
-- Skin existing frames
if (Recount.MainWindow)   then SkinFrame(Recount.MainWindow) end
if (Recount.ResetFrame)   then SkinFrame(Recount.ResetFrame) end
if (Recount.GraphWindow)  then SkinFrame(Recount.GraphWindow) end
if (Recount.ConfigWindow) then SkinFrame(Recount.ConfigWindow) end
if (Recount.DetailWindow) then SkinFrame(Recount.DetailWindow) end

if (_G["Recount_Realtime_FPS_FPS"]) then SkinFrame(_G["Recount_Realtime_FPS_FPS"].Window) end
if (_G["Recount_Realtime_Latency_LAG"]) then SkinFrame(_G["Recount_Realtime_Latency_LAG"].Window) end
if (_G["Recount_Realtime_!RAID_DAMAGE"]) then SkinFrame(_G["Recount_Realtime_!RAID_DAMAGE"].Window) end
if (_G["Recount_Realtime_!RAID_HEALING"]) then SkinFrame(_G["Recount_Realtime_!RAID_HEALING"].Window) end
if (_G["Recount_Realtime_!RAID_DAMAGETAKEN"]) then SkinFrame(_G["Recount_Realtime_!RAID_DAMAGETAKEN"].Window) end
if (_G["Recount_Realtime_!RAID_HEALINGTAKEN"]) then SkinFrame(_G["Recount_Realtime_!RAID_HEALINGTAKEN"].Window) end
if (_G["Recount_Realtime_Upstream Traffic_UP_TRAFFIC"]) then SkinFrame(_G["Recount_Realtime_Upstream Traffic_UP_TRAFFIC"].Window) end
if (_G["Recount_Realtime_Downstream Traffic_DOWN_TRAFFIC"]) then SkinFrame(_G["Recount_Realtime_Downstream Traffic_DOWN_TRAFFIC"].Window) end
if (_G["Recount_Realtime_Bandwidth Available_AVAILABLE_BANDWIDTH"]) then SkinFrame(_G["Recount_Realtime_Bandwidth Available_AVAILABLE_BANDWIDTH"].Window) end

--------------------------------------------------
-- Update Textures
Recount:UpdateBarTextures()
Recount.MainWindow.ConfigButton:HookScript("OnClick", function(self)
	Recount:UpdateBarTextures()
end)


--------------------------------------------------
-- Reskin Dropdown
Recount.MainWindow.FileButton:HookScript("OnClick", function(self)
	if (LibDropdownFrame0) then
		LibDropdownFrame0:Template("TRANSPARENT")
	end
end)


--------------------------------------------------
-- Reskin Buttons
SkinButton(Recount.MainWindow.CloseButton,  "X")
SkinButton(Recount.MainWindow.RightButton,  ">")
SkinButton(Recount.MainWindow.LeftButton,   "<")
SkinButton(Recount.MainWindow.ResetButton,  "R")
SkinButton(Recount.MainWindow.FileButton,   "F")
SkinButton(Recount.MainWindow.ConfigButton, "C")
SkinButton(Recount.MainWindow.ReportButton, "S")


--------------------------------------------------
-- Force some default profile options
if (not RecountDB) then RecountDB = {} end
if (not RecountDB["profiles"]) then RecountDB["profiles"] = {} end
if (not RecountDB["profiles"][MyName .. " - " .. GetRealmName()]) then RecountDB["profiles"][MyProfileName] = {} end
if (not RecountDB["profiles"][MyName .. " - " .. GetRealmName()]["MainWindow"]) then RecountDB["profiles"][MyProfileName]["MainWindow"] = {} end

RecountDB["profiles"][MyProfileName]["Locked"] = true
RecountDB["profiles"][MyProfileName]["Scaling"] = 1
RecountDB["profiles"][MyProfileName]["MainWindow"]["RowHeight"] = 12
RecountDB["profiles"][MyProfileName]["MainWindow"]["RowSpacing"] = 7
RecountDB["profiles"][MyProfileName]["MainWindow"]["ShowScrollbar"] = false
RecountDB["profiles"][MyProfileName]["MainWindow"]["HideTotalBar"]  = true
-- RecountDB["profiles"][MyProfileName]["MainWindow"]["Position"]["x"] = 284
-- RecountDB["profiles"][MyProfileName]["MainWindow"]["Position"]["y"] = -281
-- RecountDB["profiles"][MyProfileName]["MainWindow"]["Position"]["w"] = 221

-- RecountDB["profiles"][MyProfileName]["MainWindow"]["BarText"]["NumFormat"] = 3
-- RecountDB["profiles"][MyProfileName]["MainWindowWidth"] = 221
-- RecountDB["profiles"][MyProfileName]["ClampToScreen"] = true
-- RecountDB["profiles"][MyProfileName]["Font"] = "Calibri"

--[[
RecountDB["profiles"][MyProfileName]["MainWindow"]["Position"]["h"] = 158
RecountDB["profiles"][MyProfileName]["MainWindowHeight"] = 158    ]]

