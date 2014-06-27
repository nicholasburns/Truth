local A, C, G, L = select(2, ...):Unpack()

local P = A["PixelSizes"]
local X = A["PixelSize"]









C["AOM"] = {								["Enable"] = true,
	["Enable"] = true,
	["Width"] = 400,
	["Height"] = 800,
}

C["Announce"] = {
	["Enable"] = true,
	["Experience"] = {
		["Enable"] = false,
		["Announcements"] = true,
		["EventCounter"] = 0,
		["RunningTotal"] = 0,
		["Timestamp"] = "",
	},
	["Interrupts"] = {
		["Enable"] = false,
	},
	["Lowhealth"] = {
		["Enable"] = false,
		["Threshold"] = 50,
		["Message"] = '- LOW HEALTH -',
		["Sound"] = A.media.sound.warn,
		["Font"] = {A.media.font.grunge, P[30], 'THICKOUTLINE'},
	},
	["Reputation"] = {
		["Enable"] = false,
		["Announcements"] = true,
		["EventCounter"] = 0,
		["RunningTotal"] = 0,
		["Timestamp"] = "",
	},
	["Spells"] = {
		["Enable"] = false,
		["AllSources"] = true,
		["MessageFormat"] = "%s used %s",
		["Playername"] = A["PlayerName"],
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

C["Aura"] = {								["Enable"] = true,
	["CP"] = {
		["Enable"] = true,
	  -- ["Debuff"] = GetSpellInfo(56092),								-- "Engulf in Flames"
	},
	["Malystacks"] = {
		["Enable"] = true,
		["Debuff"] = GetSpellInfo(56092),								-- "Engulf in Flames"
	},
	['Textures'] = {
		['Question']	= [=[Interface\Icons\INV_Misc_QuestionMark]=],
		['Sword']		= [=[Interface\BUTTONS\Spell-Reset]=],				-- sword
		['DuelWield']	= [=[Interface\Icons\ABILITY_DUALWIELD]=],			-- dualwield
	},
}

C["Automation"] = {							-- *
	["Merchant"] = true,			--[[*]]
	["Release"] = false,				--[[*]]
}

C["Bar"] = {								["Enable"] = true,
	["Bags"] = true,
	["Cooldown"] = {
		["Enable"] = false,
		["Font"] = {A.media.font.pixel, P[18], "OUTLINE", true, {0, 0, 0, 0.8}},
	},
	["Hotkeys"] = {
		["Enable"] = true,
		["Font"] = {A.media.font.pixel, P[16], "MONOCHROME, OUTLINE", {1, 1, 1, 1}},
		["Shadow"] = {X, {0, 0, 0, 1}},
	},
	["RangeColor"] = {
		["Enable"] = true,
	},
}

C["Character"] = {							-- *
	["ItemLevels"] = {
		["Enable"] = false,			--[[*]]
		["Font"] = {A.media.font.myriad, P[16], "OUTLINE"},
	},
	["Slots"] = {
		["Enable"] = false,			--[[*]]
		["iLvlFont"] = {A.media.font.myriad, P[16], "OUTLINE"},
		["iDuraFont"] = {A.media.font.pixel, P[12], "OUTLINE"},
	},
	["Stats"] = {
		["Enable"] = false,			--[[*]]
	},
}

C["Chat"] = {								["Enable"] = true,
	["AddMessage"] = {
		["Enable"] = true,
		["Enable1"] = true,
		["Enable2"] = true,
	},
	["Channels"] = false,
	["Copy"] = {			["Enable"] = true,
		["Font"]  = {A.media.font.myriad, P["Normal"], nil},
		["FontColor"] = {1, 1, 1, 1},
		["Width"]  = 700, --450,
		["Height"] = 400, --250,
		["Point"]  = {'TOPLEFT', UIParent, 'TOPLEFT', G.MARGIN, -120},				-- ["Point"]  = {'BOTTOM', ChatFrame1EditBox, 'TOP', 0, G.MARGIN},
		["TitleHeight"] = 30,
		["ButtonNormal"] = [=[Interface\BUTTONS\UI-GuildButton-PublicNote-Disabled]=],
		["ButtonHighlight"] = [=[Interface\BUTTONS\UI-GuildButton-PublicNote-Up]=],
	},
	["Tab"] = {
		["Enable"] = true,
		["Font"] = {A.media.font.continuum, P["Huge"], "OUTLINE", nil},
	},
	["Timestamp"] = {
		["Enable"] = false,
		["Color"] = {0.5, 0.5, 0.5, 1},
		["ColorFormat"] = "|cff888888%s|r",
		["Format"] = "%H:%M",
		["Lootstamps"] = true,
	},
	["Armory"] = false,
	["Bubbles"] = false,
	["Icons"] = false,
	["Neon"] = false,
	["Scroll"] = {["Enable"] = false, ["NumLines"] = 4,},
	["Sounds"] = false,

	["Urls"] = false,
	['Font'] = {A.media.font.myriad, P["Normal"], nil},
	['Width'] = 450,
	['Height'] = 250,
	['Point'] = {'BOTTOMLEFT', UIParent, G.MARGIN, G.MARGIN},
	['Windows'] = 4,
	["EditBox"] = {
		["Font"] = {A.media.font.ptsn, P["Huge"], nil, true},
	},
}

C["Dev"] = {								["Enable"] = true,
	["Copy"] = true,
	["Debug"] = true,						-- A.FormatString(data, functionLookup)
	["Dump"] = true,						-- Truth.ListTextures(O)  |  Truth.ListChildren(O)
}

C["Map"] = {								["Enable"] = false,
	["Minimap"] = {
		["Enable"] = false,
	},
	["Worldmap"] = {
		["Enable"] = false,
		["Scale"] = 0.8,
		["Font"] = {A.default.font.file, P[20], 'OUTLINE', P[2]},
	},
}

C["Quest"] = {								["Enable"] = false,
	["QM"] = false,
	["Wowhead"] = false,
}

C["Skin"] = {								["Enable"] = true,
	["Auction"] = false,
	["Bags"] = false,
	["Debug"] = false,
	["Macros"] = false,
	["Others"] = false,
	["System"] = false,
	 --
	["BugSack"] = false,
	["Recount"] = false,
}

C["Tooltip"] = {							["Enable"] = true,
	["Anchor"] = {
		["Enable"] = true,
		["Cursor"] = true, 					-- Anchor to cursor
		["None"] = false,					-- Default anchor ( bottom-right )
		["Point"] = {"BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -27.35, 27.35},
	  -- ["Smart"] = false,
	},
	["Aura"] = {
		["Enable"] = false,
		["SpellID"] = true,
		["AppliedBy"] = true,
	},
	["Icons"] = {							--[[  OnTooltipSetItem  ]]
		["Enable"] = false,
		["Size"] = 24,
	},
	["InsantFade"] = true,
	["ItemBorder"] = {						--[[  OnTooltipSetItem  ]]
		["Enable"] = false,
		["BackdropColor"] = A.default.backdrop.color,					-- {r = A.default.backdrop.color[1], g = A.default.backdrop.color[2], b = A.default.backdrop.color[3]},
		["BackdropAlpha"] = A.default.backdrop.alpha,
	},
	["Macros"] = {
		["Enable"] = false,
	},
	["Mono"] = {							--[[  OnTooltipSetItem  ]]
		["Enable"] = false,
	},
	["Offset"] = {
		["Enable"] = false,
	},

	["ToT"] = {
		["Enable"] = false,
	},
}

C["Tooltip"]['Font'] = {A.media.font.myriad, P["Normal"], nil, X}
C["Tooltip"]['Color'] = {
	['Backdrop'] = {A.default.backdrop.color[1], A.default.backdrop.color[2], A.default.backdrop.color[3], A.default.backdrop.alpha},	-- {0, 0, 0, 0.6},
	['Border']   = {A.default.border.color[1], A.default.border.color[2], A.default.border.color[3], A.default.border.alpha},			-- {0, 0, 0, 1.0},
}
C["Tooltip"]['StatusBar'] = {
	['Font'] = {A.media.font.continuum, P["Large"], nil, X},			-- ["Font"] = {GameFontNormal:GetFont(), 11, "OUTLINE"}
	['Height'] = 15,
	['Point'] = {
		[1] = {'BOTTOMLEFT', GameTooltip, 'TOPLEFT', 0, G.PAD},
		[2] = {'BOTTOMRIGHT', GameTooltip, 'TOPRIGHT', 0, G.PAD},
	},
	['Color'] = {
		['Backdrop'] = {A.default.statusbar.backdrop.color[1], A.default.statusbar.backdrop.color[2], A.default.statusbar.backdrop.color[3], A.default.statusbar.backdrop.alpha},
		['Border'] = {A.default.statusbar.border.color[1], A.default.statusbar.border.color[2], A.default.statusbar.border.color[3], A.default.statusbar.border.alpha},
	},
	['Texture'] = A.default.statusbar.texture,
}


  --[[ DEBUG ]]-----------------------------------

if (A.DEBUGMODE) then
	C["Chat"]['Width']  = 700
	C["Chat"]['Height'] = 1000
	C["Chat"]['Point']  = {'TOPLEFT',  UIParent,  5, -100}
	C["Chat"]["Copy"]["Width"]  = 700
	C["Chat"]["Copy"]["Height"] = 800
	C["Chat"]["Copy"]["Point"]  = {'TOPLEFT', DEFAULT_CHAT_FRAME, 'TOPRIGHT', G.PAD, 0}
	C["Chat"]["Copy"]["Point2"] = {'BOTTOMLEFT', DEFAULT_CHAT_FRAME, 'BOTTOMRIGHT', G.PAD, 0}
end


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ C["Tooltip"]["Text"] = {
		["Enable"] = false,
		["Character"] = {
			["Enable"] = false,
			["ShowClass"] = false,
			["ShowFaction"] = false,
			["ShowGender"] = false,
			["ShowLevel"] = false,
			["ShowRace"] = false,
			["ShowRealm"] = false,
		},
		["Guild"] = {
			["Enable"] = false,
			["ShowName"] = false,
			["ShowRank"] = false,
			["ShowRealm"] = false,
		},
		["PVP"] = {
			["Enable"] = false,
			["ShowFlag"] = false,
			["ShowTitle"] = false,
		},
		["Player"] = {
			["Enable"] = false,
			["ShowTitle"] = false,
			["ShowRealm"] = false,
		},
	},
--]]


--------------------------------------------------

C["Unit"] = {								["Enable"] = false,
	["QuickLinks"] = {
		["Enable"] = false,
		["ArmoryID"] = 1,
		["ChatFrame"] = DEFAULT_CHAT_FRAME,
	},
}

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

--------------------------------------------------
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

