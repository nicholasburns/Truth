local A, C, G, L = select(2, ...):Unpack()

if (not C["Tooltip"]["Enable"] or not C["Tooltip"]["InsantFade"]["Enable"]) then
	return
end




do
	local WorldFrame = WorldFrame
	local GetMouseFocus = GetMouseFocus
	local UnitExists = UnitExists
	local TOOLTIP_UPDATE_TIME = TOOLTIP_UPDATE_TIME


	local OnUpdate = function(self, elapsed, ...)
		self.UpdateTime = self.UpdateTime + elapsed

		if (self.UpdateTime > TOOLTIP_UPDATE_TIME) then
			self.UpdateTime = 0

			if (GetMouseFocus() == WorldFrame and (not UnitExists("mouseover"))) then
				self:Hide()
			end
		end
	end


	GameTooltip.UpdateTime = 0
	GameTooltip:HookScript("OnUpdate", OnUpdate)
end


-- A.print("Tooltip", "Fade", "Loaded")



--------------------------------------------------
--	Credit
--------------------------------------------------
--	Neav_UI Compilation
--	fade.lua
--------------------------------------------------

