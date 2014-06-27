local A, C, G, L = select(2, ...):Unpack()











--------------------------------------------------
--	Mis-clicks
--------------------------------------------------
do
	StaticPopupDialogs.RESURRECT.hideOnEscape = nil
	StaticPopupDialogs.PARTY_INVITE.hideOnEscape = nil
	StaticPopupDialogs.PARTY_INVITE_XREALM.hideOnEscape = nil
	StaticPopupDialogs.CONFIRM_SUMMON.hideOnEscape = nil
	StaticPopupDialogs.ADDON_ACTION_FORBIDDEN.button1 = nil
	StaticPopupDialogs.TOO_MANY_LUA_ERRORS.button1 = nil

	PetBattleQueueReadyFrame.hideOnEscape = nil

	PVPReadyDialog.leaveButton:Hide()
	PVPReadyDialog.enterButton:Point('BOTTOM', PVPReadyDialog, 0, 25)
end


--------------------------------------------------
--	PlayerPowerBarAlt
--------------------------------------------------
--[[
-- credit: Sinaris, Azilroka
-- AsphyxiaUI\Elements\Miscellaneous\Elements\AltPowerBar.lua
local A, C, L, U, M, P = select(2, ...):Unpack()
local Layouts = A["Layouts"]
local DataTextLeft = Layouts["DataTextLeft"]


local TimeSinceLastUpdate = 1

local function OnUpdate(self, elapsed)
	if(not self:IsShown()) then return end

	TimeSinceLastUpdate = TimeSinceLastUpdate + elapsed

	if(TimeSinceLastUpdate >= 1) then
		local Power = UnitPower("player", ALTERNATE_POWER_INDEX)
		local MaxPower = UnitPowerMax("player", ALTERNATE_POWER_INDEX)
		local R, G, B = A.ColorGradient(Power, MaxPower, 0, 0.8, 0, 0.8, 0.8, 0, 0.8, 0, 0)

		self.Text:SetText(Power .. " / " .. MaxPower)
		self.Status:SetMinMaxValues(0, UnitPowerMax("player", ALTERNATE_POWER_INDEX))
		self.Status:SetValue(Power)
		self.Status:SetStatusBarColor(R, G, B)

		TimeSinceLastUpdate = 0
	end
end


local function OnEvent(self)
	self:UnregisterEvent("PLAYER_ENTERING_WORLD")

	if(UnitAlternatePowerInfo("player")) then
		self:Show()
		self:SetScript("OnUpdate", OnUpdate)
	else
		self:Hide()
		self:SetScript("OnUpdate", nil)
	end
end


PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_SHOW")
PlayerPowerBarAlt:UnregisterEvent("UNIT_POWER_BAR_HIDE")
PlayerPowerBarAlt:UnregisterEvent("PLAYER_ENTERING_WORLD")


local AltPowerBar = CreateFrame("Frame", nil, DataTextLeft)
AltPowerBar:SetAllPoints()
AltPowerBar:SetFrameStrata("HIGH")
AltPowerBar:SetFrameLevel(DataTextLeft:GetFrameLevel() + 1)
AltPowerBar:SetTemplate("DO")
AltPowerBar:RegisterEvent("UNIT_POWER")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_SHOW")
AltPowerBar:RegisterEvent("UNIT_POWER_BAR_HIDE")
AltPowerBar:RegisterEvent("PLAYER_ENTERING_WORLD")
AltPowerBar:SetScript("OnEvent", OnEvent)


AltPowerBar.Status = A.CreateStatusBar(nil, AltPowerBar)
AltPowerBar.Status:SetFrameLevel(AltPowerBar:GetFrameLevel() + 1)
AltPowerBar.Status:SetMinMaxValues(0, 100)
AltPowerBar.Status:SetInside()


AltPowerBar.Text = AltPowerBar.Status:CreateFontString(nil, "OVERLAY")
AltPowerBar.Text:SetFont(unpack(A["FontTemplate"]["AltPowerBar"]["BuildFont"]))
AltPowerBar.Text:Point("CENTER", AltPowerBar, "CENTER", 0, 1)
AltPowerBar.Text:SetShadowColor(0, 0, 0)
AltPowerBar.Text:SetShadowOffset(1.25, -1.25)

--]]


