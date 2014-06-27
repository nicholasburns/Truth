local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Enable"] or not C["Chat"]["AddMessage"]["Enable"]) then
	return
end


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ C.chat_channel_aliases = {
	--   [pattern to look for] 			= '[what to replace it with]',
		[CHAT_MSG_GUILD]				= '[G]',
		[CHAT_MSG_PARTY]				= '[P]',
		[CHAT_MSG_PARTY_LEADER]			= '[PL]',
		[CHAT_MSG_RAID]				= '[R]',
		[CHAT_MSG_RAID_LEADER]			= '[RL]',
		[CHAT_MSG_RAID_WARNING]			= '[RW]',
		[CHAT_MSG_OFFICER]				= '[O]',
		[INSTANCE_CHAT]				= '[I]',
		[INSTANCE_CHAT_LEADER]			= '[IL]',
	}

	C.chat_channel_global_aliases = {
	  -- General						[1. General - Orgrimar]
		['(%d+)%. ' .. GENERAL]			= '%[%1%]',		-- [1]	<working>
	  -- Trade 						[2. Trade - City]
		['(%d+)%. ' .. TRADE]			= '%[%1%]',		-- [2]	<working>
	  -- LocalDefense 					[3. LocalDefense - Orgrimar]
		['(%d+)%. LocalDefense']			= '%[%1%]',		-- [3]
	  -- LookingForGroup 				[4. LookingForGroup]
		['(%d+)%. ' .. LOOKING]			= '%[%1%]',		-- [4]
	  -- WorldDefense 					[5. WorldDefense]
	  -- ['(%d+)%. WorldDefense']			= '%[%1%]',		-- [5]	<working>
	  -- GuildRecruitment 				[5. GuildRecruitment]
	  -- ['(%d+)%. GuildRecruitment']		= '%[%1%.GR%]',	-- [GR]
	  -- Custom Channels 				[6. iKorgath]
	  -- ['(%d+)%. .-']					= '%[%1%.%]',
	}
--]]


----------------------------------------------------------------------------------------------------
if (C["Chat"]["AddMessage"]["Enable1"]) then

	local Channelnames, AddMessage


	local Hooks = {}
	local F

	do
		local date = date
		local pairs = pairs
		local gsub, tostring = string.gsub, tostring


		ChannelNames = {
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


		AddMessage = function(F, text, r, g, b, id)
			text = tostring(text) or ""

			-- channels
			for k, v in pairs(ChannelNames) do
				text = text:gsub("|h%[" .. k .. "%]|h", "|h" .. v .. "|h")
			end

			-- player
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


		for i = 1, (G.NUM_CHAT_FRAMES) do
			local ChatFrame = _G[("ChatFrame%d"):format(i)]

			Hooks[ChatFrame] = ChatFrame.AddMessage

			ChatFrame.AddMessage = AddMessage
		end
	end

-- end	-- Enable1


----------------------------------------------------------------------------------------------------
else										-- elseif (C["Chat"]["AddMessage"]["Enable2"]) then

	local OldAddMessages = {}

	do
		local pairs = pairs
		local format, gsub, match, sub, tostring = string.format, string.gsub, string.match, string.sub, tostring


		local whisperfrom = sub(CHAT_WHISPER_GET, 4) --isolate the localized bit from the %s
		local says = sub(CHAT_SAY_GET, 4)


		local StandardChannels = {						-- Regular Channels
			[CHAT_MSG_GUILD] = "[G]",
			[CHAT_MSG_PARTY] = "[P]",
			[CHAT_MSG_PARTY_LEADER] = "[PL]",
			[CHAT_MSG_RAID] = "[R]",
			[CHAT_MSG_RAID_LEADER] = "[RL]",
			[CHAT_MSG_RAID_WARNING] = "[RW]",
			[CHAT_MSG_OFFICER] = "[O]",
			[INSTANCE_CHAT] = "[I]",
			[INSTANCE_CHAT_LEADER] = "[IL]",
		}

		local CustomChannels = {
			["(%d+)%. " .. TRADE] = "%[%1%.Tr%]",
			["(%d+)%. " .. GENERAL] = "%[%1%.Gen%]",
			["(%d+)%. " .. LOOKING] = "%[%1%.LFG%]",
			["(%d+)%. WorldDefense"] = "%[%1%.WD%]",
			["(%d+)%. LocalDefense"] = "%[%1%.LD%]",
			["(%d+)%. GuildRecruitment"] = "%[%1%.GR%]",
			["(%d+)%. .-"] = "%[%1%.%]",				--All other numbered and custom channels
		}


		local AddMessage = function(F, text, ...)
			text = tostring(text) or ""

			-- channels
			if (match(text, "%d+%. .-|h")) then
				for k, v in pairs(CustomChannels) do
					text = text:gsub("|h%[" .. k .. "%]|h", "|h" .. v .. "|h", 1)
				end
			else
				for k, v in pairs(StandardChannels) do
					text = text:gsub("|h%[" .. k .. "]|h", "|h" .. v .. "|h", 1)
				end
			end

			-- normal say messages
			text = text:gsub("]|h " .. says, "]|h: ", 1)

			-- player names (remove brackets)
			text = text:gsub("(|Hplayer.-|h)%[(.-)%](|h)", "%1%2%3", 1)

			-- new Away and Busy tags - revert to AFK and DND
			text = text:gsub(CHAT_FLAG_DND, "<DND>", 1)
			text = text:gsub(CHAT_FLAG_AFK, "<AFK>", 1)

			-- whispers	(BNet whispers aren't covered atm)
			text = text:gsub("|h "  ..  whisperfrom, "|h: ", 1)


			return OldAddMessages[F](F, text, ...)
		end


		local f = CreateFrame('Frame')
		f:RegisterEvent('PLAYER_ENTERING_WORLD')
		f:SetScript('OnEvent', function(self, event, addon)

			for i = 1, (G.NUM_CHAT_FRAMES) do
				local ChatFrame = _G[("ChatFrame%d"):format(i)]

				OldAddMessages[ChatFrame] = ChatFrame.AddMessage
				ChatFrame.AddMessage = AddMessage
			end

			self:UnregisterEvent('PLAYER_ENTERING_WORLD')
		end)

	end

end	-- Enable2


--------------------------------------------------
--	Credits
--------------------------------------------------
--	Copyright (c) 2009, Tom Wieland
--	All rights reserved.
--------------------------------------------------


