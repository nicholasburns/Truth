local A, C, G, L = select(2, ...):Unpack()

if (not C["Tooltip"]["Enable"] or not C["Tooltip"]["ShowGuildRank"]["Enable"]) then
	return
end




do
	local GameTooltip = GameTooltip
	local CreateFrame = CreateFrame
	local GetGuildInfo = GetGuildInfo


	local OnEvent = function()
		local _, rank = GetGuildInfo("mouseover")
		if (rank) then
			GameTooltip:AddDoubleLine("Guild rank:", rank, 1, 0.82, 0, 1, 1, 1)
			GameTooltip:Show()
		end
	end


	local f = CreateFrame('Frame')
	f:SetScript("OnEvent", OnEvent)
	f:RegisterEvent("UPDATE_MOUSEOVER_UNIT")
end


A.print("Tooltip", "GuildRank", "Loaded")


--------------------------------------------------
--	Guildranks
--------------------------------------------------
--[[ ## Interface: 40200
	## Title: Guildranks
	## Author: Fñx

	Guildranks.lua
--]]
--------------------------------------------------
