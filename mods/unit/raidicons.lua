local A, C, G, L = select(2, ...):Unpack()

if (not C["Unit"]["Enable"] or not C["Unit"]["RaidIcons"]["Enable"]) then
	return
end


do
	local EasyMenu = EasyMenu
	local UnitExists = UnitExists
	local IsRaidLeader = IsRaidLeader
	local IsRaidOfficer = IsRaidOfficer
	local SetRaidTarget = SetRaidTarget
	local IsShiftKeyDown = IsShiftKeyDown
	local IsControlKeyDown = IsControlKeyDown
	local GetNumGroupMembers = GetNumGroupMembers


	local MenuFrame = CreateFrame('Frame', "TruthRaidIconMenu", UIParent, 'UIDropDownMenuTemplate')

	local MenuList = {
		[1] = {
			text = L["RAIDICON_SKULL"],
			func = function()
					SetRaidTarget("target", 8)
				  end
		},
		[2] = {
			text = L["RAIDICON_CROSS"],
			func = function()
					SetRaidTarget("target", 7)
				  end
		},
		[3] = {
			text = L["RAIDICON_SQUARE"],
			func = function()
					SetRaidTarget("target", 6)
				  end
		},
		[4] = {
			text = L["RAIDICON_MOON"],
			func = function()
					SetRaidTarget("target", 5)
				  end
		},
		[5] = {
			text = L["RAIDICON_TRIANGLE"],
			func = function()
					SetRaidTarget("target", 4)
				  end
		},
		[6] = {
			text = L["RAIDICON_DIAMOND"],
			func = function()
					SetRaidTarget("target", 3)
				  end
		},
		[7] = {
			text = L["RAIDICON_CIRCLE"],
			func = function()
					SetRaidTarget("target", 2)
				  end
		},
		[8] = {
			text = L["RAIDICON_STAR"],
			func = function()
					SetRaidTarget("target", 1)
				  end
		},
		[9] = {
			text = L["RAIDICON_NONE"],
			func = function()
					SetRaidTarget("target", 0)
				  end
		},
	}

	local OnMouseDown = function(self, button)
		if (	button == "RightButton"
			and IsShiftKeyDown()
			and IsControlKeyDown()
			and UnitExists("mouseover")
		) then
			local inParty = (GetNumGroupMembers() > 0)
			local inRaid  = (GetNumGroupMembers() > 0)

			if (( inRaid
				and (IsRaidLeader() or IsRaidOfficer())
				or (inParty and not inRaid))
				or (not inParty and not inRaid)
			) then
				EasyMenu(MenuList, MenuFrame, "cursor", 0, 0, "MENU", nil)
			end
		end
	end

	WorldFrame:HookScript("OnMouseDown", OnMouseDown)
end


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Locale Cache

	local L_RAIDICON_SKULL		= L["RAIDICON_SKULL"]
	local L_RAIDICON_CROSS		= L["RAIDICON_CROSS"]
	local L_RAIDICON_SQUARE		= L["RAIDICON_SQUARE"]
	local L_RAIDICON_MOON		= L["RAIDICON_MOON"]
	local L_RAIDICON_TRIANGLE	= L["RAIDICON_TRIANGLE"]
	local L_RAIDICON_DIAMOND		= L["RAIDICON_DIAMOND"]
	local L_RAIDICON_CIRCLE		= L["RAIDICON_CIRCLE"]
	local L_RAIDICON_STAR		= L["RAIDICON_STAR"]
	local L_RAIDICON_NONE		= L["RAIDICON_NONE"]	-- "None"
	local L_RAIDICON_ICON		= L["RAIDICON_ICON"]	-- "Target Marker Icon"
--]]

--------------------------------------------------
--	Credits
--------------------------------------------------
--[[ Tukui by Tukz
	All code was ninja'd from Tukui addon

  	Source:
	~/Tukui/modules/blizzard/symbol.lua
--]]
--------------------------------------------------

