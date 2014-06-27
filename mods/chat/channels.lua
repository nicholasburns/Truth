local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Enable"] or not C["Chat"]["Channels"]["Enable"]) then
	return
end




do
	local format = string.format
	local gsub = string.gsub
	local type = type


	local a = ".*%[(.*)%].*"
	local b = "%%[%1%%]"


	local ChannelFormats = {
		[1]  = {(CHAT_FLAG_AFK):gsub(a, b),			"[AFK]"},
		[2]  = {(CHAT_FLAG_DND):gsub(a, b),			"[DND]"},
		[3]  = {(CHAT_FLAG_GM ):gsub(a, b),			"[GMA]"},

		[4]  = {(CHAT_GUILD_GET):gsub(a, b), 		"[G]"  },
		[5]  = {(CHAT_OFFICER_GET):gsub(a, b), 		"[O]"  },

		[6]  = {(CHAT_PARTY_GET):gsub(a, b),		"[P]"  },
		[7]  = {(CHAT_PARTY_LEADER_GET):gsub(a, b), 	"[PL]" },
		[8]  = {(CHAT_PARTY_GUIDE_GET):gsub(a, b), 	"[PG]" },

		[9]  = {(CHAT_RAID_GET):gsub(a, b),			"[R]"  },
		[10] = {(CHAT_RAID_LEADER_GET):gsub(a, b),	"[RL]" },
		[11] = {(CHAT_RAID_WARNING_GET):gsub(a, b),	"[RW]" },
		[12] = {(CHAT_MONSTER_PARTY_GET):gsub(a, b),	"[RM]" },

		[13] = {(CHAT_INSTANCE_CHAT_GET):gsub(a, b),		"[I]" },
		[14] = {(CHAT_INSTANCE_CHAT_LEADER_GET):gsub(a, b),"[IL]"},

		[15] = {(CHAT_SAY_GET):gsub(a, b),				"[S]"  },
		[16] = {(CHAT_YELL_GET):gsub(a, b),				"[Y]"  },

		[17] = {(CHAT_BN_WHISPER_GET):gsub(a, b),		"[B <]"  }, -- L["B<"]
		[18] = {(CHAT_BN_WHISPER_INFORM_GET):gsub(a, b),	"[B >]"  }, -- L["B>"]

		[19] = {(CHAT_WHISPER_GET):gsub(a, b),			"[@]"    }, -- L["W<"]
		[20] = {(CHAT_WHISPER_INFORM_GET):gsub(a, b),		"[W >]"  }, -- L["W>"]
	}


	local AddMessage = ChatFrame1.AddMessage


	local FCF_AddMessage = function(self, text, ...)
		if (type(text) == "string") then
			text = gsub(text, "(|HBNplayer.-|h)%[(.-)%]|h", "%1%2|h")
			text = gsub(text, "(|Hplayer.-|h)%[(.-)%]|h", "%1%2|h")
			text = gsub(text, "%[(%d0?)%. (.-)%]", "(%1)")

			for i = 1, (#ChannelFormats) do
				text = gsub(text, ChannelFormats[i][1], ChannelFormats[i][2])
			end
		end

		return AddMessage(self, text, ...)
	end


	local Setup = function(self)
		local ChatFrame = self				-- _G[self]
		local ChatFrameID = ChatFrame:GetID()

		if (ChatFrameID ~= 2) then
			ChatFrame.AddMessage = FCF_AddMessage
		end
	end


	local Style = function()
		for id = 1, (G.NUM_CHAT_FRAMES) do
			local ChatFrame = _G[("ChatFrame%d"):format(id)]
			Setup(ChatFrame)
		end
	end

	hooksecurefunc("FCF_OpenTemporaryWindow", Style)

	Style()

end




----------------------------------------------------------------------------------------------------
--	Transitions
----------------------------------------------------------------------------------------------------
CHAT_YOU_CHANGED_NOTICE		= " # [%d]"  		-- 'Changed Channel: |Hchannel:%d|h[%s]|h'
CHAT_YOU_CHANGED_NOTICE_BN	= " # [%d]"  		-- 'Changed Channel: |Hchannel:CHANNEL:%d|h[%s]|h'

CHAT_YOU_JOINED_NOTICE		= " + [%d]"  		-- 'Joined Channel: |Hchannel:%d|h[%s]|h'
CHAT_YOU_JOINED_NOTICE_BN	= " + [%d]"  		-- 'Joined Channel: |Hchannel:CHANNEL:%d|h[%s]|h'

CHAT_YOU_LEFT_NOTICE		= " - [%d]"  		-- 'Left Channel: |Hchannel:%d|h[%s]|h'
CHAT_YOU_LEFT_NOTICE_BN		= " - [%d]"  		-- 'Left Channel: |Hchannel:CHANNEL:%d|h[%s]|h'

CHAT_SUSPENDED_NOTICE		= " - [%d]"  		-- 'Left Channel: |Hchannel:%d|h[%s]|h '
CHAT_SUSPENDED_NOTICE_BN		= " - [%d]"  		-- 'Left Channel: |Hchannel:CHANNEL:%d|h[%s]|h'


--------------------------------------------------
--	Reference
--------------------------------------------------
--[[	UTF-8 Character Codes

	----------------------------------------
	?  %s  \32  		WHITESPACE
	?  <	  \60		LESS-THAN SIGN
	?  >	  \62		GREATER-THAN SIGN
	?  @	  \64		COMMERCIAL AT
	?  [	  \91		LEFT SQUARE BRACKET
	?  ]	  \93		RIGHT SQUARE BRACKET
	?  ©	  \194 \169	COPYRIGHT SIGN
	----------------------------------------
	> utf8-chartable.de/unicode-utf8-table.pl?utf8=dec

--]]



--------------------------------------------------
--	Credits
--------------------------------------------------
--	rChat (Zork)
--------------------------------------------------
