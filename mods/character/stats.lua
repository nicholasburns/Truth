-- credit: NishaUi @ modules\extra\ilvlr.lua
local A, C, G, L = select(2, ...):Unpack()

if (not C["Character"]["Stats"]["Enable"]) then return end

local pairs = pairs
local floor = math.floor



--------------------------------------------------
--	Hide Stats from Char Frame (Inomena - p3lim)
--------------------------------------------------
PAPERDOLL_STATCATEGORIES = {
	GENERAL = {
		id = 1,
		stats = {
			"ITEMLEVEL",
			"MOVESPEED",
		},
	},
	MELEE = {
		id = 2,
		stats = {
			"STRENGTH",
			"AGILITY",
			"MELEE_AP",
			"ENERGY_REGEN",
			"RUNE_REGEN",
			"HASTE",
			"CRITCHANCE",
			"HITCHANCE",
			"EXPERTISE",
			"MASTERY",
		},
	},
	RANGED = {
		id = 2,
		stats = {
			"AGILITY",
			"RANGED_AP",
			"RANGED_HASTE",
			"FOCUS_REGEN",
			"CRITCHANCE",
			"RANGED_HITCHANCE",
			"MASTERY",
		},
	},
	SPELL = {
		id = 2,
		stats = {
			"SPIRIT",
			"INTELLECT",
			"SPELLDAMAGE",
			"SPELLHEALING",
			"SPELL_HASTE",
			"MANAREGEN",
			"SPELLCRIT",
			"SPELL_HITCHANCE",
			"MASTERY",
		},
	},
	DEFENSE = {
		id = 3,
		stats = {
			"STAMINA",
			"ARMOR",
			"DODGE",
			"PARRY",
			"BLOCK",
			"RESILIENCE_REDUCTION",
			"PVP_POWER",
		},
	},
}

local sort  = {
	[1] = {
		"GENERAL",
		"MELEE",
		"DEFENSE",
	},
	[2] = {
		"GENERAL",
		"RANGED",
		"DEFENSE",
	},
	[3] = {
		"GENERAL",
		"SPELL",
		"DEFENSE",
	},
}

local specs = {
	{1, 1, 1},
	{3, 1, 1},
	{2, 2, 2},
	{1, 1, 1},
	{3, 3, 3},
	{1, 1, 1},
	{3, 1, 3},
	{3, 3, 3},
	{3, 3, 3},
	{1, 3, 1},
	{3, 1, 1, 3},
}


local spec
local orig  = PaperDoll_InitStatCategories
local class = select(3, UnitClass("player"))

local handler = CreateFrame('Frame')
handler:RegisterEvent("PLAYER_TALENT_UPDATE")
handler:SetScript('OnEvent', function()

	spec = GetSpecialization()

	if (spec) then
		PaperDoll_InitStatCategories = function()
			orig(sort[specs[class][spec]], nil, nil, "player")

			PaperDollFrame_CollapseStatCategory(CharacterStatsPaneCategory4)
		end
	end

end)



for index = 1, ( 3 ) do
	local toolbar = _G["CharacterStatsPaneCategory" .. index .. "Toolbar"]

	toolbar:SetScript("OnEnter", nil)
	toolbar:SetScript("OnClick", nil)
	toolbar:RegisterForDrag()
end


--------------------------------------------------
--	Hooks:  Show/Hide Stats
--------------------------------------------------
do
	-- Stats

	local setStat = PaperDollFrame_SetStat

	function PaperDollFrame_SetStat(self, unit, statIndex, ...)
		if (statIndex == 1 and class ~= 6 and class ~= 2 and class ~= 1) then
			return self:Hide()
		end

		setStat(self, unit, statIndex, ...)
	end

	-- Block

	local setSpellHit = PaperDollFrame_SetSpellHitChance

	function PaperDollFrame_SetSpellHitChance(self, ...)
		if (class == 5 and spec ~= 3) then
			return self:Hide()
		elseif ((class == 11 or class == 7) and spec == 3) then
			return self:Hide()
		end

		setSpellHit(self, ...)
	end

	-- Block

	local setParry = PaperDollFrame_SetParry

	function PaperDollFrame_SetParry(self, ...)
		if (class ~= 2 and class ~= 1 and class ~= 6 and not (class == 10 and spec == 2)) then
			return self:Hide()
		end

		setParry(self, ...)
	end

	-- Block

	local setBlock = PaperDollFrame_SetBlock

	function PaperDollFrame_SetBlock(self, ...)
		if (class ~= 2 and class ~= 1) then
			return self:Hide()
		end

		setBlock(self, ...)
	end

end


