local A, C, L = select(2, ...):Unpack()

if (not C["Bar"]["Enable"] or not C["Bar"]["Cooldown"]["Enable"]) then
	return
end

local print = function(...)
	A.print("Bar", "Cooldown", ...)
end

local M = C["Bar"]["Cooldown"]

if (IsAddOnLoaded("OmniCC") or IsAddOnLoaded("ncCooldown") or IsAddOnLoaded("tullaCC")) then		-- credit: ShestakUI by Shestak
	return
end


local GetFormattedTime
local Timer_Stop, Timer_ForceUpdate
local Timer_OnSizeChanged, Timer_OnUpdate
local Timer_Create, Timer_Start

do
	local format = string.format
	local floor = math.floor
	local unpack = unpack

	local UIParent = UIParent
	local GetTime = GetTime
	local CreateFrame = CreateFrame


	GetFormattedTime = function(s)
		if (s >= 86400) then return ("%dd"):format(floor(s / 86400 + 0.5)), s % 86400
		elseif (s >= 3600) then return ("%dh"):format(floor(s / 3600 + 0.5)), s % 3600
		elseif (s >= 60) then return ("%dm"):format(floor(s / 60 + 0.5)), s % 60 end
		return floor(s + 0.5), s - floor(s)
	end


	Timer_Stop = function(self)
		self.enabled = nil
		self:Hide()
	end

	Timer_ForceUpdate = function(self)
		self.nextUpdate = 0
		self:Show()
	end

	Timer_OnSizeChanged = function(self, width, height)
		local fontScale = A.Round(width) / 40
		if (fontScale == self.fontScale) then
			return
		end
		self.fontScale = fontScale
		self.text:SetFont(M["Font"][1], M["Font"][2], M["Font"][3])
		self.text:SetShadowOffset(M["Font"][4] or 0, -M["Font"][4] or 0)
		self.text:SetShadowColor(unpack(M["Font"][5]))
		if (self.enabled) then
			Timer_ForceUpdate(self)
		end
	end

	Timer_OnUpdate = function(self, elapsed)
		if (self.text:IsShown()) then
			if (self.nextUpdate > 0) then
				self.nextUpdate = self.nextUpdate - elapsed
			else
				if ((self:GetEffectiveScale() / UIParent:GetEffectiveScale()) < 0.5) then
					self.text:SetText("")
					self.nextUpdate = 1
				else
					local remain = self.duration - (GetTime() - self.start)
					if (floor(remain + 0.5) > 0) then
						local time, nextUpdate = GetFormattedTime(remain)
						self.text:SetText(time)
						self.nextUpdate = nextUpdate
						if (floor(remain + 0.5) > 5) then
							self.text:SetTextColor(1, 1, 1)
						else
							self.text:SetTextColor(1, 0.2, 0.2)
						end
					else
						Timer_Stop(self)
					end
				end
			end
		end
	end

	Timer_Create = function(self)
	--~  Watches OnSizeChanged events (this is needed since OnSizeChanged has buggy triggering if the frame with the handler is not shown)
		local scaler = CreateFrame('Frame', nil, self)
		scaler:SetAllPoints(self)

		local timer = CreateFrame('Frame', nil, scaler)
		timer:Hide()
		timer:SetAllPoints(scaler)
		timer:SetScript("OnUpdate", Timer_OnUpdate)

		local text = timer:CreateFontString(nil, "OVERLAY")
		text:SetPoint("CENTER", 1, 0)
		text:SetFont(M["Font"][1], M["Font"][2], M["Font"][3])
		timer.text = text

		Timer_OnSizeChanged(timer, scaler:GetSize())

		scaler:SetScript("OnSizeChanged", function(self, ...)
			Timer_OnSizeChanged(timer, ...)
		end)

		self.timer = timer

		return timer
	end

	Timer_Start = function(self, start, duration, charges, maxCharges)
		local remainingCharges = charges or 0

		if ((start > 0) and (duration > 2) and (remainingCharges == 0) and (not self.noOCC)) then
			local timer = self.timer or Timer_Create(self)
			timer.start = start
			timer.duration = duration
			timer.enabled = true
			timer.nextUpdate = 0
			timer:Show()
		else
			local timer = self.timer
			if (timer) then
				Timer_Stop(timer)
			end
		end
	end

	hooksecurefunc(getmetatable(_G["ActionButton1Cooldown"]).__index, "SetCooldown", Timer_Start)
end



----------------------------------------------------------------------------------------------------
if (not _G["ActionBarButtonEventsFrame"]) then
--	Escape
	return
end


-- Datatables
local active = {}
local hooked = {}


local cooldown_OnShow, cooldown_OnHide, cooldown_ShouldUpdateTimer, cooldown_Update
local actionButton_Register

do
	local pairs = pairs
	local GetActionCooldown = GetActionCooldown
	local GetActionCharges = GetActionCharges


	cooldown_OnShow = function(self)
		active[self] = true
	end

	cooldown_OnHide = function(self)
		active[self] = nil
	end

	cooldown_ShouldUpdateTimer = function(self, start, duration, charges, maxCharges)
		local timer = self.timer
		if (not timer) then
			return true
		end

		return not (timer.start == start or timer.charges == charges or timer.maxCharges == maxCharges)
	end

	cooldown_Update = function(self)
		local button = self:GetParent()
		local start, duration, enable = GetActionCooldown(button.action)
		local charges, maxCharges, chargeStart, chargeDuration = GetActionCharges(button.action)

		if (cooldown_ShouldUpdateTimer(self, start, duration, charges, maxCharges)) then
			Timer_Start(self, start, duration, charges, maxCharges)
		end
	end

	local EventWatcher = CreateFrame('Frame')												-- EventWatcher:Hide()
	EventWatcher:RegisterEvent("ACTIONBAR_UPDATE_COOLDOWN")
	EventWatcher:SetScript("OnEvent", function(self, event)
		for cd in pairs(active) do
			cooldown_Update(cd)
		end
	end)

	actionButton_Register = function(frame)
		local cd = frame.cooldown
		if (not hooked[cd]) then
			cd:HookScript("OnShow", cooldown_OnShow)
			cd:HookScript("OnHide", cooldown_OnHide)
			hooked[cd] = true
		end
	end

	if (_G["ActionBarButtonEventsFrame"].frames) then
		for i, frame in pairs(_G["ActionBarButtonEventsFrame"].frames) do
			actionButton_Register(frame)
		end
	end

	hooksecurefunc("ActionBarButtonEventsFrame_RegisterFrame", actionButton_Register)
end


-- A.print("Bar", "Cooldown", "Loaded")

