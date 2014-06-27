local A, C, G, L = select(2, ...):Unpack()

if (not C["Tooltip"]["Enable"] or not C["Tooltip"]["ToT"]["Enable"]) then
	return
end




do
	local GameTooltip = GameTooltip
	local UnitIsUnit = UnitIsUnit
	local UnitExists = UnitExists
	local UnitName = UnitName


	local OnTooltipSetUnit = function()
		local name, unit = GameTooltip:GetUnit()

		if (not unit) then
			return
		end

		if (UnitIsUnit("player", unit .. "target")) then
			GameTooltip:AddLine(L["TOOLTIP_TOT_TARGETING_YOU"], 0.5, 1)										-- GameTooltip:AddLine("< YOU >", 0.5, 1)

		elseif (UnitExists(unit .. "target")) then
			GameTooltip:AddLine(UnitName(unit .. "target"), 0.5, 1)

		end
	end

	GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
end



--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ if (C["Tooltip"]["TOT"]["LookingAtMe"]) then

	local format = string.format
	local tostring = tostring
	local RAID_CLASS_COLORS = RAID_CLASS_COLORS
	local NORMAL_FONT_COLOR = NORMAL_FONT_COLOR
	local GameTooltip = GameTooltip
	local UnitExists = UnitExists
	local UnitName = UnitName
	local UnitLevel = UnitLevel
	local UnitClass = UnitClass


	LookinAtMe = {}

	function LookinAtMe:AddTargetLine(pTT)
		local _, unitID = pTT:GetUnit()
		if (not unitID) then
			return
		end

		local targetID = unitID .. "target"
		if (not UnitExists(targetID)) then
			return
		end

		local targetName = UnitName(targetID)
		local targetLevel = UnitLevel(targetID)
		local className, cID = UnitClass(targetID)

		local color = RAID_CLASS_COLORS[cID] or NORMAL_FONT_COLOR							-- local r, g, b = color.r * 255, color.g * 255, color.b * 255
		local cff = "|cff" .. A.DecimalToHex(color.r, color.g, color.b)						-- local ccf = format('|cff%02x%02x%02x', r + 0.5, g + 0.5, b + 0.5)

		local string

		if (targetLevel > 0) then
			if (className and (className ~= targetName)) then
				string = cff .. "[" .. targetLevel .. "] " .. className .. "|r"		-- tostring(className)
			else
				string = cff .. "[" .. targetLevel .. "]|r"
			end
		else
			string = "Level ??"
		end

		pTT:AddLine("Target:|r " .. cff .. targetName .. " " .. string, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
	  -- pTT:AddLine('Target:|r |cff' .. cff .. targetName .. string, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)
	  -- pTT:AddLine('Target:|r |cff' .. cff .. targetName .. string, NORMAL_FONT_COLOR.r, NORMAL_FONT_COLOR.g, NORMAL_FONT_COLOR.b, true)

		pTT:Show()																-- Tooltip is not resized after :AddLine().. so use :Show() afterwards
	end


	function LookinAtMe:Initialize()
		GameTooltip:HookScript('OnTooltipSetUnit', function (tooltip)
			if (tooltip:IsUnit('mouseover')) then
				LookinAtMe:AddTargetLine(tooltip)
			end
		end)
	end


	LookinAtMe:Initialize()

end
--]]


--------------------------------------------------
--	Credits
--------------------------------------------------
--
--	GreenTip
--	Credit:  TotTooltip by Fixeh
--
--	Adds target of target to your Tooltip in green
--	  +  Displays < YOU > when something is targeting you
--	  +  Takes 1 KB of memory
--
--------------------------------------------------
--
--	LookingAtMe
--
--------------------------------------------------



