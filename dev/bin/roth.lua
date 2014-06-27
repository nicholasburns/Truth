local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["Roth"]) then return end
local print = function(...) Addon.print('Roth', ...) end

local ipairs, pairs, select, unpack = ipairs, pairs, select, unpack
local GetSpellInfo = GetSpellInfo
local CreateFrame = CreateFrame
local UIParent = UIParent

--[[ ●
--]]

--------------------------------------------------
--	Colors
--------------------------------------------------
local L = {
	WHITE	= {1, 1, 1},
	GREY		= {1/2, 1/2, 1/2},
	BLACK	= {0, 0, 0},
	RED		= {1, 0, 0},
	GREEN	= {0, 1, 0},
	BLUE		= {0, 0, 1},
}

--------------------------------------------------
--	Constants
--------------------------------------------------
local ICONSIZE = 32					-- 128
local ICONPADDING = 25				-- 50

--------------------------------------------------
--	Frames
--------------------------------------------------
local FrameList = {

	[1] = {
		bgFile = Addon.media.backdrop.normal,
		bgColor = L.GREY,

		edgeFile = Addon.media.border.glow,
		edgeColor = L.BLACK,

		edgeSize = 20,
		inset = 10,

		["border"] = {						[1] = 8,
			bgFile = Addon.media.backdrop.normal,
			bgColor = L.WHITE,
			edgeFile = Addon.media.border.iglow,
			edgeColor = L.BLACK,
			edgeSize = 1,
			inset = 3,
		},
	},

	[2] = {
		bgFile = Addon.media.backdrop.normal,
		bgColor = L.GREY,

		edgeFile = Addon.media.border.glow,
		edgeColor = L.BLACK,

		edgeSize = 1,
		inset = 1,

		["border"] = {						[1] = 8,
			bgFile = Addon.media.backdrop.normal,
			bgColor = L.GREY,

			edgeFile = Addon.media.border.iglow,
			edgeColor = L.BLACK,

			edgeSize = 32,
			inset = 32,
		},
	},

	[3] = {
		bgFile = Addon.media.backdrop.normal,
		bgColor = L.GREY,

		edgeFile = Addon.media.border.glow,
		edgeColor = L.BLACK,

		edgeSize = 10,
		inset = 10,

		["border"] = {						[1] = 8,
			bgFile = Addon.media.backdrop.normal,
			bgColor = L.WHITE,

			edgeFile = Addon.media.border.iglow,
			edgeColor = L.BLACK,

			edgeSize = 1,
			inset = 1,
		},
	},

	[4] = {
		bgFile = Addon.media.backdrop.normal,
		bgColor = L.GREY,

		edgeFile = Addon.media.border.glow,
		edgeColor = L.BLACK,

		edgeSize = 1,
		inset = 1,

		["iglow"] = {						[1] = 8,
			bgFile = Addon.media.backdrop.normal,
			bgColor = L.WHITE,

			edgeFile = Addon.media.border.iglow,
			edgeColor = L.BLACK,

			edgeSize = 1,
			inset = 10,
		},

		["border"] = {						[1] = 8,
			bgFile = Addon.media.backdrop.normal,
			bgColor = L.RED,

			edgeFile = Addon.media.border.solid,
			edgeColor = L.WHITE,

			edgeSize = 1,
			inset = 1,
		},
	},

	[5] = {
		bgFile = Addon.media.backdrop.normal,
		bgColor = L.GREY,

		edgeFile = Addon.media.border.glow,
		edgeColor = L.BLACK,

		edgeSize = 1,
		inset = 1,

		["iglow"] = {						[1] = 8,
			bgFile = Addon.media.backdrop.normal,
			bgColor = L.WHITE,

			edgeFile = Addon.media.border.iglow,
			edgeColor = L.RED,

			edgeSize = 8,
			inset = 8,
		},

		["border"] = {						[1] = 8,
			bgFile = Addon.media.backdrop.normal,
			bgColor = L.BLUE,

			edgeFile = Addon.media.border.thick,
			edgeColor = L.WHITE,

			edgeSize = 1,
			inset = 1,
		},
	},
}

--------------------------------------------------
--	Create Icons
--------------------------------------------------
local function CreateIcon(Icon, i)
	local f
	if (not i) then
		f = CreateFrame('Frame', 'Container', UIParent)
		f:SetPoint("TOP", UIParent, 0, -20)
		f:SetWidth((ICONSIZE + ICONPADDING) * #FrameList + ICONPADDING)
		f:SetHeight(ICONSIZE + (ICONPADDING * 2))
		f:SetFrameStrata("LOW")
	else
		f = CreateFrame('Frame', 'Icon' .. i, UIParent)
		f:SetSize(ICONSIZE, ICONSIZE)
		if (i == 1) then
			f:SetPoint("LEFT", 'Container', ICONSIZE * (i - 1) + ICONPADDING , 0)
		else
			f:SetPoint("LEFT", _G["Icon" .. i - 1], "RIGHT", ICONPADDING, 0)
		end
		f:SetFrameLevel(1)
	end

	--  [1]
	f:SetBackdrop({
		bgFile = Icon.bgFile,
		edgeFile = Icon.edgeFile,
		edgeSize = Icon.edgeSize,
		insets = {left = Icon.inset, right = Icon.inset, top = Icon.inset, bottom = Icon.inset}})
	f:SetBackdropColor(unpack(Icon.bgColor))
	f:SetBackdropBorderColor(unpack(Icon.edgeColor))

	if (false) then
		f.t = f:CreateTexture(nil, "ARTWORK")
		f.t:SetPoint('TOPLEFT', f, Icon.inset, -Icon.inset)
		f.t:SetPoint('BOTTOMRIGHT', -Icon.inset, Icon.inset)
		f.t:SetTexture(select(3, GetSpellInfo(6673)))
		f.t:SetTexCoord(0.1, 0.9, 0.1, 0.9)
	end

	--  [2]
	if (Icon.iglow) then
		local glow = Icon.iglow
		f.i = CreateFrame('Frame', "$parent_IGlow", f)
		f.i:SetPoint('TOPLEFT', f, glow[1], -glow[1])
		f.i:SetPoint('BOTTOMRIGHT', f, -glow[1], glow[1])
		f.i:SetBackdrop({bgFile = glow.bgFile, edgeFile = glow.edgeFile, edgeSize = glow.edgeSize, insets = {left = glow.inset, right = glow.inset, top = glow.inset, bottom = glow.inset}})
		f.i:SetBackdropColor(unpack(glow.bgColor))
		f.i:SetBackdropBorderColor(unpack(glow.edgeColor))
		f.i:SetFrameLevel(2)
	end

	--  [3]
	if (Icon.border) then
		local edge = Icon.border
		f.s = CreateFrame('Frame', "$parent_Border", f)
		f.s:SetPoint('TOPLEFT', f, edge[1], -edge[1])
		f.s:SetPoint('BOTTOMRIGHT', f, -edge[1], edge[1])
		f.s:SetBackdrop({bgFile = edge.bgFile, edgeFile = edge.edgeFile, edgeSize = edge.edgeSize, insets = {left = edge.inset, right = edge.inset, top = edge.inset, bottom = edge.inset}})
		f.s:SetBackdropColor(unpack(edge.bgColor))
		f.s:SetBackdropBorderColor(unpack(edge.edgeColor))
		f.s:SetFrameLevel(3)
	end

	Icon.IconFrame = f
end

--------------------------------------------------
--	Container Frame
--------------------------------------------------
--[[

	/d Container:GetBackdrop() = {
	    ['bgFile']   = 'Interface\\Tooltips\\UI-Tooltip-Background',
	    ['tileSize'] = 0,
	    ['edgeFile'] = 'Interface\\Tooltips\\UI-Tooltip-Border',
	    ['edgeSize'] = 20,
	    ['insets']   =  {['top'] = 10, ['right'] = 10, ['left'] = 10, ['bottom'] = 10},
	}

	/d Container_IGlow:GetBackdrop() = {
	    ['bgFile']   = 'Interface\\AddOns\\Truth\\media\\background\\flat',
	    ['tileSize'] = 0,
	    ['edgeFile'] = 'Interface\\AddOns\\Truth\\media\\border\\iglow',
	    ['edgeSize'] = 32,
	    ['insets']   =  { ['top'] = 32, ['right'] = 32, ['left'] = 32, ['bottom'] = 32},
	}

	/d Container_Border:GetBackdrop() = {
	    ['bgFile']   = 'Interface\\AddOns\\Truth\\media\\background\\flat',
	    ['tileSize'] = 0,
	    ['edgeFile'] = 'Interface\\AddOns\\Truth\\media\\border\\thin',
	    ['edgeSize'] = 1,
	    ['insets']   =  { ['top'] = 8, ['right'] = 8, ['left'] = 8, ['bottom'] = 8},
	}
	/d Container_Subframe:GetBackdropColor()
	/d Container_Subframe:GetBackdropBorderColor()

--]]

local ContainerList = {
	[1] = {
		bgFile = Addon.media.backdrop.normal,
		bgColor = L.GREY,

		edgeFile = Addon.media.border.glow,
		edgeColor = L.BLACK,

		edgeSize = 1,
		inset = 1,

		["iglow"] = {						[1] = 8,
			bgFile = Addon.media.backdrop.normal,
			bgColor = L.WHITE,

			edgeFile = Addon.media.border.iglow,
			edgeColor = L.RED,

			edgeSize = 8,
			inset = 8,
		},

		["border"] = {						[1] = 8,
			bgFile = Addon.media.backdrop.normal,
			bgColor = L.GREY,

			edgeFile = Addon.media.border.vivid,
			edgeColor = L.GREY,

			edgeSize = 1,
			inset = 1,
		},
	},
}

CreateIcon(ContainerList[1])

--------------------------------------------------
-- 	Batch
--------------------------------------------------
for i, _ in ipairs(FrameList) do
	local v = FrameList[i]

	if (not v.IconFrame) then
		CreateIcon(v, i)
	end
end

--------------------------------------------------
--	Zorks origina table values (refencee data)
--------------------------------------------------
-- local R = {}
--[[
R[1] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat", -- 32x32x32
	bgColor = {r = 0.15, g = 0.15, b = 0.15, a = 0.8},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\glow", 		-- 128x16x32
	edgeColor = {r = 0, g = 0, b = 0, a = 1},
	edgeSize = 10,
	inset = 10,
	["border"] = {
		insets = 10,
		bgFile = "",
		bgColor = {r = 1, g = 1, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\tvtest_tooltip_border", -- 128x16x32
		edgeColor = {r = 1, g = 1, b = 1, a = 1},
		edgeSize = 1,
		inset = 3,
	},
}
R[2] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
	bgColor = {r = 0.15, g = 0.8, b = 1, a = 0.2},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\glow",
	edgeColor = {r = 0, g = 0, b = 0, a = 1},
	edgeSize = 10,
	inset = 10,
	["border"] = {
		insets = 8,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 1, g = 1, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\diablo3_tooltip_border",	-- 128x16x32
		edgeColor = {r = 1, g = 1, b = 1, a = 1},
		edgeSize = 1,
		inset = 3,
	},
}
R[3] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
	bgColor = {r = 0.15, g = 0.15, b = 0.15, a = 1},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\glow",					-- 128x16x32
	edgeColor = {r = 0, g = 0, b = 0, a = 1},
	edgeSize = 10,
	inset = 10,
	["border"] = {
		insets = 8,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 0.15, g = 0.8, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\diablo3_tooltip_border",
		edgeColor = {r = 1, g = 1, b = 1, a = 1},
		edgeSize = 1,
		inset = 3,
	},
}
R[4] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_button",
	bgColor = {r = 0.5, g = 0.5, b = 0.5, a = 0.8},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\glow",
	edgeColor = {r = 0, g = 0, b = 0, a = 1},
	edgeSize = 10,
	inset = 10,
	["border"] = {
		insets = 8,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 0.15, g = 0.8, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\diablo3_tooltip_border",
		edgeColor = {r = 1, g = 1, b = 1, a = 1},
		edgeSize = 1,
		inset = 3,
	},
}
R[5] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
	bgColor = {r = 0.2, g = 0.2, b = 0.2, a = 0.6},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\tvtest_tooltip_border",
	edgeColor = {r = 1, g = 1, b = 1, a = 1},
	edgeSize = 1,
	inset = 3,
	["border"] = {
		insets = 8,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 0.15, g = 0.8, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\diablo3_tooltip_border",
		edgeColor = {r = 1, g = 1, b = 1, a = 1},
		edgeSize = 1,
		inset = 3,
	},
}
R[6] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
	bgColor = {r = 0.15, g = 0.15, b = 0.15, a = 0.6},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\UI-Tooltip-Border",
	edgeColor = {r = 1, g = 1, b = 1, a = 1},
	edgeSize = 1,
	inset = 3,
	["border"] = {
		insets = 8,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 0.15, g = 0.8, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\diablo3_tooltip_border",
		edgeColor = {r = 1, g = 1, b = 1, a = 1},
		edgeSize = 1,
		inset = 3,
	},
}
R[7] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
	bgColor = {r = 0.15, g = 0.8, b = 1, a = 0.2},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\glow",
	edgeColor = {r = 0, g = 0, b = 0, a = 1},
	edgeSize = 10,
	inset = 10,
	["border"] = {
		insets = 8,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 1, g = 1, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\diablo3_tooltip_border",
		edgeColor = {r = 0.8, g = 0, b = 0, a = 1},
		edgeSize = 1,
		inset = 3,
	},
}
R[8] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
	bgColor = {r = 0.15, g = 0.8, b = 1, a = 0.5},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\glow",
	edgeColor = {r = 0, g = 0, b = 0, a = 1},
	edgeSize = 10,
	inset = 10,
	["border"] = {
		insets = 9,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 1, g = 1, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\inner_glow",
		edgeColor = {r = 0, g = 0, b = 0, a = 1},
		edgeSize = 1,
		inset = 10,
	},
}
R[9] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
	bgColor = {r = 0.15, g = 0.15, b = 0.15, a = 1},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\glow",
	edgeColor = {r = 0, g = 0, b = 0, a = 1},
	edgeSize = 1,
	inset = 1,
	["iglow"] = {
		insets = 15,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 1, g = 1, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\inner_glow",
		edgeColor = {r = 0, g = 0, b = 0, a = 1},
		edgeSize = 1,
		inset = 10,
	},
	["border"] = {
		insets = 6,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 0.15, g = 0.8, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\diablo3_tooltip_border",
		edgeColor = {r = 1, g = 1, b = 1, a = 1},
		edgeSize = 1,
		inset = 3,
	},
}
R[10] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
	bgColor = {r = 0.15, g = 0.15, b = 0.15, a = 1},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\glow",
	edgeColor = {r = 0, g = 0, b = 0, a = 1},
	edgeSize = 12,
	inset = 12,
	["iglow"] = {
		insets = 6,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 1, g = 1, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\inner_glow",
		edgeColor = {r = 0, g = 0, b = 0, a = 1},
		edgeSize = 1,
		inset = 10,
	},
	["border"] = {
		insets = 6,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 0.15, g = 0.8, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\diablo3_tooltip_border",
		edgeColor = {r = 1, g = 1, b = 1, a = 1},
		edgeSize = 1,
		inset = 3,
	},
}
R[11] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
	bgColor = {r = 0.15, g = 0.15, b = 0.15, a = 1},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\glow",
	edgeColor = {r = 0, g = 0, b = 0, a = 1},
	edgeSize = 12,
	inset = 12,
	["iglow"] = {
		insets = 12,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 1, g = 1, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\inner_glow",
		edgeColor = {r = 0, g = 1, b = 0, a = 1},
		edgeSize = 1,
		inset = 10,
	},
	["border"] = {
		insets = 10,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 0.15, g = 0.8, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\diablo3_tooltip_border",
		edgeColor = {r = 0, g = 1, b = 0, a = 1},
		edgeSize = 1,
		inset = 3,
	},
}
R[12] = {
	bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
	bgColor = {r = 0.15, g = 0.15, b = 0.15, a = 1},
	edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\glow",
	edgeColor = {r = 0, g = 0, b = 0, a = 1},
	edgeSize = 12,
	inset = 12,
	["iglow"] = {
		insets = 13,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 1, g = 1, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\inner_glow",
		edgeColor = {r = 1, g = 0, b = 1, a = 0.8},
		edgeSize = 1,
		inset = 10,
	},
	["border"] = {
		insets = 9,
		bgFile = "Interface\\AddOns\\rSetBackdrop\\tga\\background_flat",
		bgColor = {r = 0.15, g = 0.8, b = 1, a = 0},
		edgeFile = "Interface\\AddOns\\rSetBackdrop\\tga\\UI-Tooltip-Border",
		edgeColor = {r = 1, g = 0, b = 1, a = 1},
		edgeSize = 1,
		inset = 3,
	},
}
--]]



--------------------------------------------------
--	Texture Constants
--------------------------------------------------
-- local FLAT		= Addon.media.backdrop.normal
-- local SOLID		= Addon.media.backdrop.solid
-- local GLOW		= Addon.media.border.glow
-- local IGLOW		= Addon.media.border.iglow
-- local THICK		= Addon.media.border.thick
-- local THIN		= Addon.media.border.thin
-- local VIVID		= Addon.media.border.vivid

--------------------------------------------------
--	Color Constants
--------------------------------------------------
--[[	L.WHITE	= {1, 1, 1}
	L.GREY	= {.5, .5, .5}
	L.BLACK	= {0, 0, 0}
	L.RED	= {1, 0, 0}
	L.GREEN	= {0, 1, 0}
	L.BLUE	= {0, 0, 1}

	-- L.WHITE	= {8/9, 8/9, 8/9}
	-- L.GREY		= {1/3, 1/3, 1/3}
	-- L.BLACK	= {0/1, 0/1, 0/1}
	-- L.RED		= {4/5, 2/5, 2/5}
	-- L.GREEN	= {1/3, 4/5, 1/3}
	-- L.BLUE		= {1/5, 2/5, 3/4}
--]]


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ local ContainerList = {
		[1] = {
			bgFile 	= TOOLTIP,
			edgeFile	= TIPPER,
			edgeSize  = 20,
			inset	= 10,
			bgColor	= {0, 0, 0, 1},
			edgeColor	= {1, 0, 0, 1},

			["iglow"] = {
			insets = 8,
				bgFile	= FLAT,
				edgeFile	= IGLOW,
				edgeSize	= 32,
				inset	= 32,
				bgColor	= {1, 1, 1, 1},
				edgeColor	= {1, 0, 0, 1},
			},

			["border"] = {
			insets = 8,
				bgFile	= FLAT,
				edgeFile	= THIN,
				edgeSize	= 1,
				inset	= 8,
				bgColor	= {1, 1, 1, 1},
				edgeColor	= {1, 1, 1, 1},
			},
		},
	}
--]]
