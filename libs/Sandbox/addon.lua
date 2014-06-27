local A, C, G, L = select(2, ...):Unpack()

if (not C["Addon"]["Enable"]) then return end






local f = CreateFrame("Frame")
f:RegisterEvent("ADDON_LOADED")
f:SetScript("OnEvent", function(self, event, addon)

	if (addon == "Blizzard_CombatLog") then

		self:UnregisterEvent("ADDON_LOADED")
	end

end)





