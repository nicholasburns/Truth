local A, C, G, L = select(2, ...):Unpack()

if (not C["Aura"]["Enable"] or not C["Aura"]["Malystacks"]["Enable"]) then
	return
end

local format = string.format
local min, max = math.min, math.max
local pairs = pairs
local sub = string.sub
local time = time
local tonumber = tonumber

local GetComboPoints = GetComboPoints
local GetTime = GetTime
local IsLoggedIn = IsLoggedIn
local UnitGUID = UnitGUID
local UnitInVehicle = UnitInVehicle
local UnitDebuff = UnitDebuff
local UnitPower = UnitPower

local DEBUFF_NAME = C["Aura"]["Malystacks"]["Debuff"]
local DEFAULT_ICON_TEXTURE = [=[Interface\Icons\Spell_Nature_WispSplode]=]
local DEFAULT_COMBO_POINT_TEXTURE = [=[Interface\ComboFrame\ComboPoint]=]
local DEFAULT_COMBO_POINT_COORDS = {0, 0.375, 0, 1}


--------------------------------------------------
--	Event Handlers
--------------------------------------------------
local OnUpdate = function(self, elapsed)
	local power = UnitPower("vehicle")
	if (power >= 50) then
		self.background:SetVertexColor(1, 1, 1, 1)
	else
		self.background:SetVertexColor(1, 1, 1, max(0.3, (power - 15) * 2 / 100))			-- Ramp up alpha wrt energy from 30 to 50, providing a visual jump (.68 -> 1) at 50
	end

	local _,_,_, count, _,_, expires = UnitDebuff("target", DEBUFF_NAME, nil, "PLAYER")

	if (expires) then
		local remaining = expires - GetTime()
		self.time:SetFormattedText("|cff%s%0.1f s|r", A.TimeRemainingToColor(remaining / 15), remaining)
		self.time:Show()
	else
		self.time:Hide()
	end

	self.count:SetFormattedText("|cffFFFFFF%d|r", count or 0)
end

local OnDragStop = function(self)
	self:StopMovingOrSizing()

	local point, _, _, x, y = self:GetPoint(1)

	TruthDB["Malystacks"]["Point"] = point
	TruthDB["Malystacks"]["X"] = x
	TruthDB["Malystacks"]["Y"] = y

--[[ My current cp addon is slightly different

	local pt, _, xoff, yoff = self:GetPoint(1)
	TruthCPDB["Point"] = { pt, xoff, yoff }
--]]
end



local function SetupFrame(addonframe)
	local p = TruthDB["Malystacks"]["Point"] or "CENTER"					-- local p2 = TruthDB["Malystacks"]["Anchor"] or UIParent
	local x = TruthDB["Malystacks"]["X"] or 0
	local y = TruthDB["Malystacks"]["Y"] or 0

	local F = addonframe
	F:Size(64)
	F:Point(p, x, y)
	F:EnableMouse(true)
	F:SetMovable(true)
	F:SetClampedToScreen(true)
	F:RegisterForDrag("LeftButton")
	F:SetScript("OnDragStart", F.StartMoving)
	F:SetScript("OnDragStop", OnDragStop)


	local backdrop = F:CreateTexture(nil, "BACKGROUND")
	backdrop:SetAllPoints(F)
	backdrop:SetTexture(DEFAULT_ICON_TEXTURE)
  -- backdrop:SetTexture([=[Interface\Icons\Spell_Fire_Burnout]=])				-- "Interface\\Icons\\Spell_Fire_Burnout")
	F.backdrop = backdrop


	local time = F:CreateFontString(nil, "OVERLAY")
	time:ClearAllPoints()
	time:SetPoint("TOP", F, "BOTTOM", 0, 0)
	time:SetJustifyH("CENTER")
	time:SetFont("Fonts\\FRIZQT__.TTF", 12, "OUTLINE")
	F.time = time


	local count = F:CreateFontString(nil, "OVERLAY")
	count:Size(64)
	count:Point("TOPLEFT", F, "TOPLEFT", 0, 0)
	count:SetJustifyH("CENTER")
	count:SetJustifyV("MIDDLE")
	count:SetFont("Fonts\\FRIZQT__.TTF", 36, "OUTLINE")
	count:SetText("|cFFFFFFFF0|r")
	F.count = count


	---------------------------------------------
	local ComboPoints = {}

	local DEFAULT_COMBO_POINT_TEXTURE = [=[Interface\ComboFrame\ComboPoint]=]
	local DEFAULT_COMBO_POINT_COORDS = {0, 0.375, 0, 1}

	for i = 1, 5 do
		local cp = F:CreateTexture(nil, "OVERLAY")
		cp:SetTexture([=[Interface\ComboFrame\ComboPoint]=])				-- DEFAULT_COMBO_POINT_TEXTURE
		cp:SetTexCoord(0, 0.375, 0, 1)								-- DEFAULT_COMBO_POINT_COORDS
	  -- cp:SetTexture([=[Interface\AddOns\MalygosStacks\cp]=])
		cp:Size(12)

		if (i == 1) then
			cp:SetPoint("BOTTOMRIGHT", F, "BOTTOMRIGHT", -2, 0)
		else
			cp:SetPoint("RIGHT", ComboPoints[i - 1], "LEFT")
		end

		cp:Hide()

		ComboPoints[i] = cp
	end

	F.ComboPoints = ComboPoints

	F:SetScript("OnUpdate", OnUpdate)
end


--------------------------------------------------
--	Events
--------------------------------------------------
local AddonFrame = CreateFrame('Frame', nil, UIParent)
AddonFrame:RegisterEvent("ADDON_LOADED")
AddonFrame:SetScript("OnEvent", function(self, event, ...)
	if (self[event]) then self[event](self, ...) end
end)


function AddonFrame:UNIT_ENTERED_VEHICLE(unit)
	if (unit == "player") then
		local guid = tonumber(sub(UnitGUID("vehicle") or "", 7, 10), 16)

		if (guid == 30161 or guid == 32535) then
			if (SetupFrame) then
				SetupFrame(self)
			  -- SetupFrame()
				SetupFrame = nil
			end

			self:RegisterEvent("PLAYER_TARGET_CHANGED")
			self:RegisterEvent("UNIT_COMBO_POINTS")
			self:RegisterEvent("UNIT_EXITED_VEHICLE")

			self:Show()
		end
	end
end

function AddonFrame:UNIT_EXITED_VEHICLE(unit)
	if (unit == "player" and self:IsShown()) then
		self:UnregisterEvent("PLAYER_TARGET_CHANGED")
		self:UnregisterEvent("UNIT_COMBO_POINTS")
		self:UnregisterEvent("UNIT_EXITED_VEHICLE")

		self:Hide()
	end
end

function AddonFrame:UNIT_COMBO_POINTS()
	if (not UnitInVehicle("player")) then
		self:UNIT_EXITED_VEHICLE("player")
		return
	end

	local ComboPoints = GetComboPoints("vehicle", "target")

	for i = 1, 5 do
		if (ComboPoints >= i) then
			self.ComboPoints[i]:Show()
		else
			self.ComboPoints[i]:Hide()
		end
	end
end

AddonFrame.PLAYER_TARGET_CHANGED = AddonFrame.UNIT_COMBO_POINTS


function AddonFrame:ADDON_LOADED(addon)
	if (addon ~= AddOn) then return end

	local defaults = {
		["scale"] = 1,
		["size"] = 64,
		["point"] = { "CENTER", 0, 0 },
		["padding"] = G.PAD,
	}

	TruthDB["Malystacks"] = TruthDB["Malystacks"] or {}

	for k, v in pairs(defaults) do
		if (TruthDB["Malystacks"][k] == nil) then
			TruthDB["Malystacks"][k] = v
		end
	end


	self:RegisterEvent("UNIT_ENTERED_VEHICLE")

	if (IsLoggedIn()) then
		self:UNIT_ENTERED_VEHICLE("player")
	end

	self:UnregisterEvent("ADDON_LOADED")
	self.ADDON_LOADED = nil
end


-- Slash
SLASH_TRUTH_MALYSTACKS1 = "/maly"
SlashCmdList["TRUTH_MALYSTACKS"] = function()
	AddonFrame:UNIT_ENTERED_VEHICLE("player")
end


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ TimeRemainingToColor

	local function TimeRemainingToColor(ratio)
		ratio = min(1, ratio)
		return format("%02x%02x00", (1 - ratio) * 255, ratio * 255)
	end

--]]

--------------------------------------------------
--	Toc File: For credit and future reference
--------------------------------------------------
--[[ ## Interface: 50400
	## Title: MalygosStacks
	## Notes: Shows a frame to track your debuff on Malygos in phase three.
	## Author: Nebula
	## Version: 1.4
	## SavedVariables: TruthDB["Malystacks"]
	## X-Category: Raid
	## LoadManagers: AddonLoader
	## X-LoadOn-Zone: The Nexus, The Eye of Eternity
	## X-LoadOn-Slash: /malygosstacks
	## X-Curse-Packaged-Version: 1.4
	## X-Curse-Project-Name: MalygosStacks
	## X-Curse-Project-ID: malygosstacks
	## X-Curse-Repository-ID: wow/malygosstacks/mainline

	MalygosStacks.lua

--]]

