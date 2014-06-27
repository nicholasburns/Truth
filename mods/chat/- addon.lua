local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Enable"] or not C["Chat"]["Addon"]) then
	return
end




local Channelnames = {
	['Guild']				= 'G',
	['Party']				= 'P',
	['Raid']				= 'R',
	['Raid Leader']		= 'RL',
	['Raid Warning']		= 'RW',
	['Officer']			= 'O',
	['Battleground']		= 'B',
	['Battleground Leader']	= 'BL',
	['(%d+)%. .-']			= '%1',
}

local Hooks = {}

local F

--------------------------------------------------
do
	local tostring = tostring
	local gsub = string.gsub
	local date = date
	local pairs = pairs

	local AddMessage = function(F, text, r, g, b, id)
		text = tostring(text) or ""

		-- channels
		for k, v in pairs(Channelnames) do
			text = text:gsub("|h%[" .. k .. "%]|h", "|h" .. v .. "|h")
		end

		-- playera
		text = text:gsub("(|Hplayer.-|h)%[(.-)%]|h", "%1%2|h")

		-- says
		-- text = text:gsub(" says:", ":")

		-- whispers
		text = text:gsub(" whispers:", " <")
		text = text:gsub("To (|Hplayer.+|h):", "%1 >")

		-- achievements
		text = text:gsub("(|Hplayer.+|h) has earned the achievement (.+)!", "%1 ! %2")

		-- timestamp
		text = "|cff999999" .. date("[%H:%M]") .. "|r " .. text

		return Hooks[F](F, text, r, g, b, id)
	end

	-- local F
	for i = 1, (G.NUM_CHAT_FRAMES) do
		F = _G['ChatFrame' .. i]

		Hooks[F] = F.AddMessage
		F.AddMessage = AddMessage
	end
end



--------------------------------------------------
--	Credits
--------------------------------------------------
--	Copyright (c) 2009, Tom Wieland
--	All rights reserved.
--------------------------------------------------


