local A, C, G, L = select(2, ...):Unpack()
local P = A["PixelSizes"]
local X = A["PixelSize"]

local MARGIN, PAD = G.MARGIN, G.PAD




C["AOM"] = {								["Enable"] = true,		["Debug"] = false,
	["Width"] = 400,
	["Height"] = 800,
}

C["Announce"] = {							["Enable"] = true,		["Debug"] = false,
	["Interrupts"] = {						["Enable"] = false,		},
	["LowHealth"] = {						["Enable"] = false,
		["Font"] = {
			[1] = A.media.font.grunge,
			[2] = P[30],
			[3] = "THICKOUTLINE",
			[4] = 3,
			[5] = { 0.3, 0.3, 0.3, 1 },
		},
		["Message"] = "- LOW HEALTH -",
		["Sound"] = A.media.sound.warn,
		["Threshold"] = 50,
	},
	["Reputation"] = {						["Enable"] = false,
		["Announcements"] = true,
		["EventCounter"] = 0,
		["RunningTotal"] = 0,
		["Timestamp"] = "",
	},
	["Sap"] = {							["Enable"] = false,		},
	["Spells"] = {							["Enable"] = false,
		["AllSources"] = true,
		["MessageFormat"] = "%s used %s",
		["PlayerName"] = A.PLAYER_NAME,
		["SpellIDs"] = {
			34477,	-- Misdirection
			19801,	-- Tranquilizing Shot
			57934,	-- Tricks of the Trade
			633,		-- Lay on Hands
			20484,	-- Rebirth
			113269,	-- Rebirth (Symbiosis)
			61999,	-- Raise Ally
			20707,	-- Soulstone
			2908,	-- Soothe
			120668,	-- Stormlash Totem
			16190,	-- Mana Tide Totem
			64901,	-- Hymn of Hope
			108968,	-- Void Shift
		},
	},
}

C["Aura"] = {								["Enable"] = false,		["Debug"] = false,
	["Malystacks"] = {						["Enable"] = false,
		["Debuff"] = GetSpellInfo(56092),								-- "Engulf in Flames"
	},
	["StealthFX"] = {						["Enable"] = false,		},
}

C["Auto"] = {								["Enable"] = true,		["Debug"] = false,
	["Combatlog"] = {						["Enable"] = false,		},
	["Merchant"] = {						["Enable"] = true,		},
	["Release"] = {						["Enable"] = false,		},
}

C["Bar"] = {								["Enable"] = true,		["Debug"] = false,
	["Bags"] = {							["Enable"] = true,		},
	["Cooldown"] = {						["Enable"] = true,
		["Font"] = {
			[1] = A.media.font.pixel,
			[2] = 18,
			[3] = "OUTLINE",
			[4] = X,
			[5] = { 0, 0, 0, 1 },

		},
	},
	["Hotkeys"] = {						["Enable"] = true,
		["Font"] = {					--	[1] = A.media.font.continuum,
			[1] = A.media.font.pixel,
			[2] = 16,
			[3] = "MONOCHROME, OUTLINE",
			[4] = X,
			[5] = { 1, 1, 1, 1 },
		},
		["Text"] = {
			["Color"] = { 0, 0, 0, 0.8 },
		},
		["Point"] = {
			[1] = 'TOPRIGHT',
			[2] = 0,
			[3] = 0,
		},
	},
	["RangeColor"] = {						["Enable"] = true,		},
}

C["Character"] = {							["Enable"] = false,		["Debug"] = false,
	["ItemLevels"] = {						["Enable"] = false,
		["Font"] = {
			[1] = A.media.font.myriad,
			[2] = 16,
			[3] = "OUTLINE",
			[4] = 0,
			[5] = { 1, 1, 1, 0 },
		},
	},
	["Slots"] = {							["Enable"] = false,
		["iLvlFont"] = {
			[1] = A.media.font.myriad,
			[2] = 16,
			[3] = "OUTLINE",
		},
		["iDuraFont"] = {
			[1] = A.media.font.pixel,
			[2] = 12,
			[3] = "OUTLINE",
		},
	},
	["Stats"] = {							["Enable"] = false,		},
}

C["Chat"] = {								["Enable"] = false,		["Debug"] = false,
	["AddMessage"] = {						["Enable"] = true,
		["Enable1"] = true,
		["Enable2"] = false,
	},
	["Armory"] = {							["Enable"] = false,		},
	["Bubbles"] = {						["Enable"] = false,		},
	["Channels"] = {						["Enable"] = false,		},
	["Copy"] = {							["Enable"] = true,
		["Width"]  = 700,															-- 450,
		["Height"] = 400, 															-- 250,
		["Point"]  = {																-- {'BOTTOM',ChatFrame1EditBox,'TOP',0,10},
			[1] = 'TOPLEFT',
			[2] =  UIParent,
			[3] = 'TOPLEFT',
			[4] =  MARGIN,
			[5] = -120,
		},
		["Font"]  = {																-- {GameFontNormal:GetFont(), 11, "OUTLINE"}
			[1] = A.media.font.myriad,
			[2] = P["Normal"],
			[3] = "NONE",
			[4] = 0,
			[5] = { 1, 0, 0, 1 },
		},
		["FontColor"] = { 1, 1, 1, 1 },
		["TitleHeight"] = 30,
		["ButtonNormal"] = [=[Interface\BUTTONS\UI-GuildButton-PublicNote-Disabled]=],
		["ButtonHighlight"] = [=[Interface\BUTTONS\UI-GuildButton-PublicNote-Up]=],
	},
	['EditBox'] = {
		['Font'] = {
			[1] = A.media.font.ptbold,
			[2] = P["Huge"],
			[3] = "",
			[4] = 0,
			[5] = { 1, 0, 0, 0 },
		},
	},
	["Icons"] = {							["Enable"] = false,		},
	["Neon"] = {							["Enable"] = false,		},
	["Scroll"] = {							["Enable"] = true,
		["NumLines"] = 4,
		["ShowBottomBotton"] = true,
	},
	["Tab"] = {							["Enable"] = true,
		["Font"] = {
			[1] = A.media.font.continuum,
			[2] = P["Huge"],
			[3] = "OUTLINE",
			[4] = 0,
			[5] = { 1, 1, 1, 0 },
		},
	},
	["Timestamp"] = {						["Enable"] = false,
		["Color"] = { 0.5, 0.5, 0.5, 1 },
		["ColorFormat"] = "|cff888888%s|r",
		["Format"] = "%H:%M",
		["Lootstamps"] = true,
	},
	["Sounds"] = {							["Enable"] = false,		},
	["URL"] = {							["Enable"] = false,		},
	['Font'] = {
		[1] = A.media.font.myriad,
		[2] = P["Normal"],
		[3] = "",
		[4] = 0,
		[5] = { 1, 1, 1, 0 },
	},
	['Width'] = 450,
	['Height'] = 250,
	['Point'] = {
		[1] = 'BOTTOMLEFT',
		[2] = UIParent,
		[3] = 'BOTTOMLEFT',
		[4] = MARGIN,
		[5] = MARGIN,
	},
	['Windows'] = 4,
}

C["Dev"] = {								["Enable"] = true,		["Debug"] = false,
	["Copy"] = {							["Enable"] = true,		},
	["Debug"] = {							["Enable"] = false,		},
	["Dump"] = {							["Enable"] = true,		},
}

C["Map"] = {								["Enable"] = false,		["Debug"] = false,
	["Minimap"] = {						["Enable"] = false,
		["Coords"] = false,
	},
	["Worldmap"] = {						["Enable"] = false,
		["Scale"] = 0.8,
		["Font"] = {
			[1] = A.media.font.myriad,
			[2] = 20,
			[3] = "OUTLINE",
			[4] = 2,
			[5] = { 1, 1, 1, 0 },
		},
	},
}

C["Quest"] = {								["Enable"] = true,		["Debug"] = false,
	["QM"] = {							["Enable"] = false,		},
	["Quest"] = {							["Enable"] = false,		},
	["Wowhead"] = {						["Enable"] = true,		},
}

C["Skin"] = {								["Enable"] = true,		["Debug"] = false,
	["Auction"] = {						["Enable"] = true,		},
	["BlackMarket"] = {						["Enable"] = false,		},
	["Bags"] = {							["Enable"] = true,		},
	["Debug"] = {							["Enable"] = false,		},
	["Macros"] = {							["Enable"] = true,		},
	["Others"] = {							["Enable"] = false,		},
	["System"] = {							["Enable"] = false,		},
	["BugSack"] = {						["Enable"] = false,		},
	["Recount"] = {						["Enable"] = false,		},
}

C["Tooltip"] = {							["Enable"] = true,		["Debug"] = false,
	["Anchor"] = {							["Enable"] = true,
		["Cursor"] = true,
		["None"] = false,
		["Point"] = {
			[1] = 'RIGHT',
			[2] =  UIParent,
			[3] = 'RIGHT',
			[4] = -100,
			[5] =  0,
		},
	},
	["Aura"] = {							["Enable"] = false,
		["SpellID"] = true,
		["AppliedBy"] = true,
	},
	["Icons"] = {							["Enable"] = false,		["Size"] = 24,	},
	["InsantFade"] = {						["Enable"] = false,		},
	["ItemBorder"] = {						["Enable"] = false,		},
	["Macros"] = {							["Enable"] = false,		},
	["Mono"] = {							["Enable"] = false,		},
	["Offset"] = {							["Enable"] = false,		},
	["Text"] = {							["Enable"] = false,		},
	["ToT"] = {							["Enable"] = false,		},
	["ShowGuildRank"] = {					["Enable"] = false,		},
	---------------------------------------------
	['Font'] = {
		[1] = A.media.font.myriad,
		[2] = P["Normal"],
		[3] = "",
		[4] = X,
		[5] = { 1, 1, 1, 1 },
	},
	['Color'] = {
		['Backdrop'] = {
			[1] = A.default.backdrop.color.r,
			[2] = A.default.backdrop.color.g,
			[3] = A.default.backdrop.color.b,
			[4] = A.default.backdrop.color.a,
		},
		['Border'] = {
			[1] = A.default.border.color.r,
			[2] = A.default.border.color.g,
			[3] = A.default.border.color.b,
			[4] = A.default.border.color.a,
		},			--
	},
	['StatusBar'] = {
		['Font'] = {
			[1] = A.media.font.continuum,
			[2] = P["Large"],
			[3] = "",
			[4] = X,
			[5] = { 1, 1, 1, 1 },
		},
		['Height'] = 15,
		['Point'] = {
			[1] = 'BOTTOMLEFT',
			[2] =  GameTooltip,
			[3] = 'TOPLEFT',
			[4] =  0,
			[5] =  PAD,
		},
		['Point2'] = {
			[1] = 'BOTTOMRIGHT',
			[2] =  GameTooltip,
			[3] = 'TOPRIGHT',
			[4] =  0,
			[5] =  PAD,
		},
		['Texture'] = A.default.statusbar.texture,
	},
}

C["Unit"] = {								["Enable"] = true,		["Debug"] = false,
	["RaidIcons"] = {						["Enable"] = true,		},
}

----------------------------------------------------------------------------------------------------

-- Debug Mode

do
	A["DEBUGMODE"] = false
	if ( A["DEBUGMODE"] == true) then
		A["DEBUGMODE_CHAT_REMINDER"] = ("|cffC79C6E%s|r"):format("[DEBUGMODE]")
		print("|cffC79C6E [DEBUGMODE] |r", " A.DEBUGMODE: ", " true ")
	end

	if ( A.DEBUGMODE) then
		C["Chat"]['Width']  = 700
		C["Chat"]['Height'] = 1000
		C["Chat"]['Point']  = {'TOPLEFT',  UIParent,  5, -100}
		C["Chat"]["Copy"]["Width"]  = 700
		C["Chat"]["Copy"]["Height"] = 800
		C["Chat"]["Copy"]["Point"]  = {'TOPLEFT', DEFAULT_CHAT_FRAME, 'TOPRIGHT', PAD, 0}
		C["Chat"]["Copy"]["Point2"] = {'BOTTOMLEFT', DEFAULT_CHAT_FRAME, 'BOTTOMRIGHT', PAD, 0}
	end
end

--------------------------------------------------
--[[	Pixel Map

	P = {
		[1]  = 1*X,						-- 0.83
		[2]  = 2*X,						-- 1.66
		[3]  = 3*X,						-- 2.50
		[4]  = 4*X,						-- 3.33
		[5]  = 5*X,						-- 4.16
		[6]  = 6*X,						-- 5.00
		[7]  = 7*X,						-- 5.83
		[8]  = 8*X,						-- 6.66	(tiny)
		[9]  = 9*X,						-- 7.5
		[10] = 10*X,						-- 8.33	(small)
		[11] = 11*X,						-- 9.16
		[12] = 12*X,						-- 10	(medium) / (normal)
		[13] = 13*X,						-- 10.83
		[14] = 14*X,						-- 11.66
		[15] = 15*X,						-- 12.45
		[16] = 16*X,						-- 13.33	(large)
		[18] = 18*X,						-- 15
		[20] = 20*X,						-- 16.66	(huge) / (huge1)
		[22] = 22*X,						-- 18.33
		[24] = 24*X,						-- 20	(superhuge)
		[30] = 30*X,						-- 25
		[32] = 32*X,						-- 26.66	(gigantic)
		[48] = 48*X,						-- 40
		----------------------
		["Pixel"]		= 1*X,
		["Pad"]		= 2*X,
		----------------------
		["Tiny"]		= 10*X,				-- 8.33

		["Small"]		= 12*X,				-- 10
		["Normal"]	= 14*X,				-- 11.66
		["Large"]		= 16*X,				-- 13.33

		["Huge"] 		= 20*X,				-- 16.66
		["Superhuge"]	= 24*X,				-- 20	(superhuge)
		["Gigantic"]	= 32*X,				-- 26.66	(gigantic)

		["Biggest"]	= 48*X,				-- 40
	}

--]]


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Unit

	C["Unit"] = {								["Enable"] = false,
		["ArmoryLink"] = {						["Enable"] = false,
			["ArmoryID"] = 1,
			["ChatFrame"] = DEFAULT_CHAT_FRAME,
		},
		["QuickLinks"] = {						["Enable"] = false,
			["ArmoryID"] = 1,
			["ChatFrame"] = DEFAULT_CHAT_FRAME,
		},
	}
--]]

--[[ C["Tooltip].["Statusbar"] = {
			["Enable"] = true,
			["Font"] = {A.media.font.continuum, 12},	-- P[12]},
			["Statusbar"] = {
				["Enable"] = true,
				["Texture"] = A.media.statusbar.flat,
				["Width"] = 200,
				["Height"] = 6,
				["Inset"] = 2,
			},
		},
	}
--]]

