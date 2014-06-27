local A, C, G, L = select(2, ...):Unpack()
local format = format
local print, select, unpack = print, select, unpack
--------------------------------------------------


		if (not false) then
			return
		end



--------------------------------------------------

local GetPoints = function(self)
--	Because GetPoint is so tedious

	if (not self or not self.GetPoint) then
		return
	end

	local left	= self:GetLeft()
	local right	= G.SCREEN_WIDTH - self:GetRight()
	local top		= G.SCREEN_HEIGHT - self:GetTop()
	local bottom	= self:GetBottom()

	local H, V	--[[ Horizontal, Vertical ]]
	local X, Y	--[[ X-Offset, Y-Offset   ]]

	if (top > bottom) then
		V = "BOTTOM"
		Y = bottom
	else
		V = "TOP"
		Y = -top
	end

	if (left > right) then
		H = "RIGHT"
		X = -right
	else
		H = "LEFT"
		X = left
	end

	local point = ("%s%s"):format(V, H)

	return { point, "UIParent", point, X, Y }
end

--------------------------------------------------


-- Player Status

local InCombatLockdown = InCombatLockdown
local UnitAffectingCombat = UnitAffectingCombat
G.PlayerInCombat = function()					-- RestrictedEnvironment (Modified: added InCombatLockdown check)
	return InCombatLockdown() or UnitAffectingCombat("player") or UnitAffectingCombat("pet")
end


local IsInRaid = IsInRaid
local IsInGroup = IsInGroup
G.PlayerInGroup = function()					-- RestrictedEnvironment
	return (IsInRaid() and "raid") or (IsInGroup() and "party")
end


-- Text Formatting

local gsub = string.gsub
local upper = string.upper
A.Capitalize = function(str)				-- Change the first character of a word to upper case
	return str:gsub('^%l', upper)
end

local match = string.match
A.Trim = function(str)					-- Remove leading & trailing whitespace
	return str:match('^%s*(.*%S)%s*$' or '')
end


-- Esc-Friendly Frame

local insert = table.insert
A.CloseOnEsc = function(self)				-- Only works for NAMED frames
	insert(_G.UISpecialFrames, self:GetName())
end


--------------------------------------------------
do	local IsInRaid = IsInRaid
	local IsInGroup = IsInGroup
	local UnitIsGroupLeader = UnitIsGroupLeader
	local IsEveryoneAssistant = IsEveryoneAssistant
	local UnitIsGroupAssistant = UnitIsGroupAssistant
	local LE_PARTY_CATEGORY_INSTANCE = LE_PARTY_CATEGORY_INSTANCE
	local LE_PARTY_CATEGORY_HOME = LE_PARTY_CATEGORY_HOME
	A.GetAnnounceChannel = function(warning)
		if (IsInGroup(LE_PARTY_CATEGORY_INSTANCE)) then
			return "INSTANCE_CHAT"
		elseif (IsInRaid(LE_PARTY_CATEGORY_HOME)) then
			if (warning and (UnitIsGroupLeader('player') or UnitIsGroupAssistant('player') or IsEveryoneAssistant())) then
				return "RAID_WARNING"
			else
				return "RAID"
			end
		elseif (IsInGroup(LE_PARTY_CATEGORY_HOME)) then
			return "PARTY"
		end
		return "SAY"
	end
--	A.CheckChat = A.GetAnnounceChannel
end
do	local UnitBuff = UnitBuff
	A.PlayerHasBuff = function(buffname)
	--	Checks current buffs for a buff that matches "buffname"
		for i = 1, ( 40 ) do
			local name = UnitBuff("player", i)
			if (name == nil) then
				return false
			end
			if (name == buffname) then
				return true
			end
		end
		return false
	end
end
do	local GetSpecialization = GetSpecialization
	local GetSpecializationInfo = GetSpecializationInfo
--[[	A.CheckRole = function()
		local Role
		local Tree = GetSpecialization()
		if((A.PLAYER_CLASS == "MONK"    and Tree == 2)
		or (A.PLAYER_CLASS == "PRIEST"  and (Tree == 1 or Tree == 2))
		or (A.PLAYER_CLASS == "PALADIN" and Tree == 1)
		or (A.PLAYER_CLASS == "DRUID"   and Tree == 4)
		or (A.PLAYER_CLASS == "SHAMAN"  and Tree == 3)) then
			Role = "Healer"
		else
			Role = "DPS"
		end
		return Role
	end
--]]
	A.CheckRole = function()
		local role = ''
		local tree = GetSpecialization()
		if (tree) then
		--[[ local id, name, desc, icon, bg, role = GetSpecializationInfo()
			role = The intended role in a party for current spec ["DAMAGER", "TANK", "HEALER"]
		--]]
			role = select(6, GetSpecializationInfo(tree))
		end
		return role
	end
end


----------------------------------------------------------------------------------------------------
--	Backup
----------------------------------------------------------------------------------------------------
--[[	Class Validation

	local isWarrior 	= function(unit) return select(2, UnitClass(unit)) == CLASS_SORT_ORDER[1]  end  -- "WARRIOR"
	local isDK		= function(unit) return select(2, UnitClass(unit)) == CLASS_SORT_ORDER[2]  end  -- "DEATHKNIGHT"
	local isPaladin	= function(unit) return select(2, UnitClass(unit)) == CLASS_SORT_ORDER[3]  end  -- "PALADIN"
	local isMonk		= function(unit) return select(2, UnitClass(unit)) == CLASS_SORT_ORDER[4]  end  -- "MONK"
	local isPriest 	= function(unit) return select(2, UnitClass(unit)) == CLASS_SORT_ORDER[5]  end  -- "PRIEST"
	local isShaman 	= function(unit) return select(2, UnitClass(unit)) == CLASS_SORT_ORDER[6]  end  -- "SHAMAN"
	local isDruid 		= function(unit) return select(2, UnitClass(unit)) == CLASS_SORT_ORDER[7]  end  -- "DRUID"
	local isRogue		= function(unit) return select(2, UnitClass(unit)) == CLASS_SORT_ORDER[8]  end  -- "ROGUE"
	local isMage 		= function(unit) return select(2, UnitClass(unit)) == CLASS_SORT_ORDER[9]  end  -- "MAGE"
	local isWarlock	= function(unit) return select(2, UnitClass(unit)) == CLASS_SORT_ORDER[10] end  -- "WARLOCK"
	local isHunter		= function(unit) return select(2, UnitClass(unit)) == CLASS_SORT_ORDER[11] end  -- "HUNTER"

	A.PlayerIsWarrior	= function() return isWarrior("player") end
	A.PlayerIsDK		= function() return isDK("player") 	end
	A.PlayerIsPaladin	= function() return isPaladin("player") end
	A.PlayerIsMonk		= function() return isMonk("player") 	end
	A.PlayerIsPriest	= function() return isPriest("player") 	end
	A.PlayerIsShaman	= function() return isShaman("player") 	end
	A.PlayerIsDruid	= function() return isDruid("player")	end
	A.PlayerIsRogue	= function() return isRogue("player") 	end
	A.PlayerIsMage		= function() return isMage("player") 	end
	A.PlayerIsWarlock	= function() return isWarlock("player") end
	A.PlayerIsHunter	= function() return isHunter("player") 	end
--]]

--[[	Class Color

	A.GetClassColor = function(class)														--~  credit: Prat3.0\services\classcolor.lua
	--~	All-in-1 ClassColor Function

		local class = class:upper()

		if (CUSTOM_CLASS_COLORS and CUSTOM_CLASS_COLORS[class]) then
			return CUSTOM_CLASS_COLORS[class].r, CUSTOM_CLASS_COLORS[class].g, CUSTOM_CLASS_COLORS[class].b
		end

		if (RAID_CLASS_COLORS and RAID_CLASS_COLORS[class]) then
			return RAID_CLASS_COLORS[class].r, RAID_CLASS_COLORS[class].g, RAID_CLASS_COLORS[class].b
		end

		return 0.63, 0.63, 0.63
	end
--]]

--[[ Addon Control

	A.EnableAddon = function(AddonName)		-- credit: ElvUI.commands
		local _,_,_,_,_, reason = GetAddOnInfo(AddonName)

		if (reason ~= "MISSING") then
			EnableAddOn(AddonName)
			ReloadUI()
		else
			print("|cffFF0000[Error] Addon: '" .. AddonName .. "' not found|r")
		end
	end

	A.DisableAddon = function(AddonName)		-- credit: ElvUI.commands
		local _,_,_,_,_, reason = GetAddOnInfo(AddonName)

		if (reason ~= "MISSING") then
			DisableAddOn(AddonName)
			ReloadUI()
		else
			print("|cffFF0000[Error] Addon: '" .. AddonName .. "' not found|r")
		end
	end
--]]

