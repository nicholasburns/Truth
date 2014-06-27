local A, C, G, L = select(2, ...):Unpack()

if (not C["Announce"]["Enable"] or not C["Announce"]["Sap"]["Enable"]) then
	return
end




local OnEvent
local PLAYER_NAME = A.PLAYER_NAME

do
	local select = select
	local SendChatMessage = SendChatMessage
	local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME


	OnEvent = function(...)
		if ((select(14, ...) == 6770)
		and (select(11, ...) == PLAYER_NAME)
		and (select(4,  ...) == "SPELL_AURA_APPLIED" or
			select(4, ...) == "SPELL_AURA_REFRESH")) then

			SendChatMessage("Sapped", "SAY")

			DEFAULT_CHAT_FRAME:AddMessage("Sapped by: " .. (select(7, ...) or "(unknown)"))

		end
	end


	local f = CreateFrame('Frame')
	f:RegisterEvent("COMBAT_LOG_EVENT_UNFILTERED")
	f:SetScript('OnEvent', OnEvent)
end


-- A.print("Announce", "Sap", "Loaded")


--------------------------------------------------
--	Credits
--------------------------------------------------
--[[ Addon: SaySapped
--]]
--------------------------------------------------

