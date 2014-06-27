local A, C, G, L = select(2, ...):Unpack()



local media = {}
local default = {}
local template = {}

do
	local X = A["PixelSize"] or 1
	local P = A["PixelSizes"]

	local bgFile, tile, tileSize, edgeFile, edgeSize, insets


	media = {
		backdrop = {		  --[[					   A.media.backdrop													]]
			['normal'] 	= "Interface\\AddOns\\Truth\\media\\background\\normal",			-- A.media.backdrop.normal
			['tooltip']	= "Interface\\AddOns\\Truth\\media\\background\\tooltip",			-- A.media.backdrop.tooltip
		},
		border = {		  --[[					   A.media.border													]]
			['normal']	= "Interface\\AddOns\\Truth\\media\\border\\normal",				-- A.media.border.normal
			['tooltip']	= "Interface\\AddOns\\Truth\\media\\border\\tooltip",				-- A.media.border.tooltip
			['glow']		= "Interface\\AddOns\\Truth\\media\\border\\glow",				-- A.media.border.glow
			['iglow']		= "Interface\\AddOns\\Truth\\media\\border\\iglow",				-- A.media.border.iglow
		},
		font = {			  --[[					   A.media.font													]]
			['continuum']	= "Interface\\AddOns\\Truth\\media\\font\\continuum.ttf",			-- A.media.font.continuum
			['grunge']	= "Interface\\AddOns\\Truth\\media\\font\\grunge.ttf",				-- A.media.font.grunge
			['myriad']	= "Interface\\AddOns\\Truth\\media\\font\\myriad.ttf",				-- A.media.font.myriad
			['visitor']	= "Interface\\AddOns\\Truth\\media\\font\\visitor.ttf",			-- A.media.font.visitor
			["pixel"]		= "Interface\\AddOns\\Truth\\media\\font\\visitor.ttf",
			['pt']		= "Interface\\AddOns\\Truth\\media\\font\\paratype.ttf",			-- A.media.font.ptsn
			['ptbold']	= "Interface\\AddOns\\Truth\\media\\font\\paratype_bold.ttf",		-- A.media.font.ptsn_bold
		},
		statusbar = {		  --[[					   A.media.statusbar												]]
			['flat'] 		= "Interface\\AddOns\\Truth\\media\\statusbar\\flat.tga",			-- A.media.statusbar.flat
			['minimal'] 	= "Interface\\AddOns\\Truth\\media\\statusbar\\minimal.tga",		-- A.media.statusbar.minimal
		},
		sound = {			  --[[					   A.media.sound													]]
			['error']		= "Interface\\AddOns\\Truth\\media\\sound\\error.mp3",				-- A.media.sound.error
			['femalewarn']	= "Interface\\AddOns\\Truth\\media\\sound\\femalewarn.mp3",			-- A.media.sound.femalewarn
			['whisper']	= "Interface\\AddOns\\Truth\\media\\sound\\whisper.mp3",			-- A.media.sound.whisper
			['warn']		= "Interface\\AddOns\\Truth\\media\\sound\\warn.ogg",				-- A.media.sound.warn
		},
		icon = {
			['duelwield']	= 'Interface\\Icons\\ABILITY_DUALWIELD',
			['question']	= 'Interface\\Icons\\INV_Misc_QuestionMark',
			['sword']		= 'Interface\\BUTTONS\\Spell-Reset',
		},
	}


	default = {
		font = { --[[								   A.default.font					]]
			[1] = media.font.myriad,
			[2] = P["Normal"],
			[3] = "OUTLINE",
			[4] = 0,
			[5] = { 0, 0, 0, 0 },

			["file"] = media.font.myriad,
			["size"] = P["Normal"],
			["flag"] = "OUTLINE",
			["shadow"] = 0,
			["shadowcolor"] = { 0, 0, 0, 0 },

			[ [=[pixel]=] ] = {
				[1] = media.font.pixel,
				[2] = 12,
				[3] = "MONOCHROME, OUTLINE",
				[4] = X,
				[5] = { 0, 0, 0, 1 },

				['file'] = media.font.pixel,
				['size'] = 12,
				['flag'] = "MONOCHROME, OUTLINE",
				['shadow'] = X,
				['shadowcolor'] = { 0, 0, 0, 1 },
			},
		},
		backdrop = { --[[							   A.default.backdrop				]]
			['alpha'] = 0.7,						-- A.default.backdrop.alpha
			['color'] = {							-- A.default.backdrop.color
				[1] = 0.1,
				[2] = 0.1,
				[3] = 0.1,
				[4] = 0.7,
				["r"] = 0.1,
				["g"] = 0.1,
				["b"] = 0.1,
				["a"] = 0.7,
			},
			['texture'] = media.backdrop.normal,		-- A.default.backdrop.texture
		},
		border = { --[[							   A.default.border					]]
			['alpha'] = 1,							-- A.default.border.alpha
			['color'] = {							-- A.default.border.color
				[1] = 0.6,
				[2] = 0.6,
				[3] = 0.6,
				[4] = 1,
				["r"] = 0.6,
				["g"] = 0.6,
				["b"] = 0.6,
				["a"] = 1,
			},
			['texture'] = media.border.normal,
		},
		statusbar = { --[[							   A.default.statusbar				]]
			['alpha'] = 0.5,						-- A.default.statusbar.alpha
			['color'] = {							-- A.default.statusbar.color
				[1] = 0,
				[2] = 0,
				[3] = 0,
				[4] = 0.5,
				["r"] = 0,
				["g"] = 0,
				["b"] = 0,
				["a"] = 0.5,
			},
			['texture'] = media.statusbar.flat,		-- A.default.statusbar.texture
		},
	}


	bgFile   = default.backdrop.texture
	tile     = nil
	tileSize = nil									-- 16
	edgeFile = default.border.texture
	edgeSize = X
	insets   = {['left'] = 0, ['right'] = 0, ['top'] = 0, ['bottom'] = 0}

	template = {
		backdrop = { --[[							   A.template.backdrop				]]
			['bgFile']	= bgFile,
			['tile']		= tile,
			['tileSize']	= tileSize,
			['edgeFile']	= edgeFile,
			['edgeSize']	= edgeSize,
			['insets']	= insets,
		},
		background = { --[[							   A.template.background				]]
			['bgFile']   	= bgFile,
			['tile']     	= tile,
			['tileSize'] 	= tileSize,
		},
		border = { --[[							   A.template.border				]]
			['edgeFile'] 	= edgeFile,
			['edgeSize'] 	= edgeSize,
			['insets']	= insets,
		},
	}
end


A.media = media
A.default = default
A.template = template


--------------------------------------------------
--	Notes
--------------------------------------------------
--[[ Backdrop
{
	bgFile   = texturefile,					-- path to the background texture
	tile     = true,						-- true to repeat the background texture to fill the frame, false to scale it
	tileSize = 32,							-- size (width or height) of the square repeating background tiles (in pixels)
	edgeFile = texturefile,					-- path to the border texture
	edgeSize = 32,							-- thickness of edge segments and square size of edge corners (in pixels)
	insets = {							-- distance from the edges of the frame to those of the background texture (in pixels)
		left = 11,
		right = 12,
		top = 12,
		bottom = 11
	}
}
--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Medias

media.backdrop = {									-- A.media.backdrop
	['normal'] 	= BACKGROUNDS .. "normal",			-- A.media.backdrop.normal		--  16x16x32
	['tooltip']	= BACKGROUNDS .. "tooltip",			-- A.media.backdrop.tooltip		--  64x64x32
}
media.border = {									-- A.media.border
	['normal']	= BORDERS .. "normal",				-- A.media.border.normal			--  16x16x24
	['tooltip']	= BORDERS .. "tooltip",				-- A.media.border.tooltip		-- 128x16x32
	['glow']		= BORDERS .. "glow",				-- A.media.border.glow			-- 128x16x32
	['iglow']		= BORDERS .. "iglow",				-- A.media.border.iglow			-- 128x16x32
}
media.font = {										-- A.media.font
	['continuum']	= FONTS .. "continuum.ttf",			-- A.media.font.continuum		-- Normal | Monospace
	['grunge']	= FONTS .. "grunge.ttf",				-- A.media.font.grunge			-- ------ | Alerts
	['myriad']	= FONTS .. "myriad.ttf",				-- A.media.font.myriad			-- Number | Condensed
	['visitor']	= FONTS .. "visitor.ttf",			-- A.media.font.visitor			-- Combat | Pixel
	["pixel"]		= FONTS .. "visitor.ttf",
	['pt']		= FONTS .. "paratype.ttf",			-- A.media.font.ptsn
	['pt_bold']	= FONTS .. "paratype_bold.ttf",		-- A.media.font.ptsn_bold
}
media.statusbar = {									-- A.media.statusbar
	['flat'] 		= STATUSBARS .. "flat.tga",			-- A.media.statusbar.flat		-- 256x32x32
	['minimal'] 	= STATUSBARS .. "minimal.tga",		-- A.media.statusbar.minimal		-- 256x32x32
}
media.sound = {										-- A.media.sound
	['error']		= SOUNDS .. "error.mp3",				-- A.media.sound.error
	['femalewarn']	= SOUNDS .. "femalewarn.mp3",			-- A.media.sound.femalewarn
	['whisper']	= SOUNDS .. "whisper.mp3",			-- A.media.sound.whisper
	['warn']		= SOUNDS .. "warn.ogg",				-- A.media.sound.warn
}

--]]
