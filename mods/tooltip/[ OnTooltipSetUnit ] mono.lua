



local OnTooltipSetUnit = function(self)
	local unit = select(2, self:GetUnit())

	if (not unit) then
		local GetMouseFocus = GetMouseFocus()

		if (GetMouseFocus and GetMouseFocus:GetAttribute("unit")) then
			unit = GetMouseFocus:GetAttribute("unit")
		end

		if (not unit or not UnitExists(unit)) then
			return
		end
	end

	wipe(L1)
	wipe(L2)
	wipe(L3)

															-- local unit = select(2, self:GetUnit())
	if (UnitExists(unit)) then														-- if (unit) then
		local ClassName					= UnitClass(unit)
		local Classification				= DEFAULT_CLASSIFICATIONS[UnitClassification(unit)] or ''
		local CreatureType					= UnitCreatureType(unit) or ''
		local Name						= UnitName(unit)
		local Level						= UnitLevel(unit)
		local LevelText					= (Level == -1) and L["BOSS_LEVEL"] or Level
		local RaidIconIndex					= GetRaidTargetIndex(unit)
		local RaidIcon						= RaidIconIndex and ("%s%s|t "):format(ICON_LIST[RaidIconIndex], C["Tooltip"]["Font"][2]) or ''
		local color						= GetQuestDifficultyColor(Level)
		local r, g, b						= GetQuestDifficultyColor(Level).r, GetQuestDifficultyColor(Level).g, GetQuestDifficultyColor(Level).b

		if (UnitIsPlayer(unit)) then
			local GuildName, GuildRank		= GetGuildInfo(unit)
			local Class 					= select(2, UnitClass(unit))
			local Name, Realm				= UnitName(unit)
			local Title					= UnitPVPName(unit)
			local Race 					= UnitRace(unit)
			local Relationship				= UnitRealmRelationship(unit)
			local Away					= (not UnitIsConnected(unit) and L["OFFLINE"]) or (UnitIsDND(unit) and L["DND"]) or (UnitIsAFK(unit) and L["AFK"])

			-----------------------------------
			if (RaidIcon) then
				L1[#L1 + 1] = RaidIcon
			end

			L1[#L1 + 1] = C["Tooltip"]["Text"]["PVPTitle"] and Title or Name

			if (Realm and Realm ~= '') then
				if (C["Tooltip"]["Text"]["Realm"]) then
					L1[#L1 + 1] = ("%s%s"):format(" - ", Realm)
				else
					L1[#L1 + 1] = FOREIGN_SERVER_LABEL --[[" (*)"]]						-- L1[#L1 + 1] = ("%s"):format(" (*) ")
				end
			end

			if (UnitIsDead(unit)) then
				self:AppendText(" (Corpse)")
			elseif (UnitIsGhost(unit)) then
				self:AppendText(" (Ghost)")
			elseif (UnitIsTapped(unit)) and (not UnitIsTappedByPlayer(unit)) then
				if (not UnitIsTappedByAllThreatList(unit)) then
					self:AppendText(A.ConvertRGBtoColorString(A.GRAY_COLOR) .. " (Tapped)|r")
				end
			end

			if (Away) then
				L1[#L1 + 1] = (" %s"):format(Away)
			end

			GameTooltipTextLeft1:SetFormattedText(("%s"):rep(#L1), unpack(L1))				-- GameTooltipStatusBar:SetStatusBarColor(unitClassColor.r, unitClassColor.g, unitClassColor.b)

			-----------------------------------
--[[			if (GuildName and C["Tooltip"]["Text"]["Guild"]) then
				local gcolor
				if (UnitIsInMyGuild(unit)) then																				-- if (IsInGuild() and GuildName == GetGuildInfo("player")) then
					gcolor = "|cffFF0000"
				else
					gcolor = "|cff00FF00"
				end
				L2[#L2 + 1] = ("%s%s%s%s|r"):format(gcolor, L["LEFT_BRACKET"], GuildName, L["RIGHT_BRACKET"])
				if (GuildRank and C["Tooltip"]["Text"]["GuildRank"]) then
					L2[#L2 + 1] = (" |cffFFFFFF%s|r"):format(GuildRank)
				end
			end

			GameTooltipTextLeft2:SetFormattedText(("%s"):rep(#L2), unpack(L2))
--]]
			-- PlayerGuild(self, unit, GuildName, GuildRank)

			-----------------------------------
			local line  = _G["GameTooltipTextLeft3"]
			local text  = GameTooltipTextLeft3:GetText()
			local cff = A.CLASS_COLORS[class]

			cff = ("|cff%.2x%.2x%.2x"):format(color.r * 255, color.g * 255, color.b * 255)

			L3[#L3 + 1] = ("%s%s%s%s|r"):format(r, g, b, LevelText)
			L3[#L3 + 1] = (" |cffFFFFFF%s|r"):format(Race)
			L3[#L3 + 1] = (" %s%s|r"):format(cff, Class)

			GameTooltipTextLeft3:SetFormattedText(("%s"):rep(#L3), unpack(L3))

			-----------------------------------
			local color = A.CLASS_COLORS[Class]
			GameTooltipStatusBar:SetStatusBarColor(color.r, color.g, color.b, 1)		  -- GameTooltipStatusBar:SetStatusBarColor(A.PLAYER_COLOR_RGB.r, A.PLAYER_COLOR_RGB.g, A.PLAYER_COLOR_RGB.b)

		else

			-----------------------------------
			if (RaidIcon) then
				L1[#L1 + 1] = RaidIcon
			end

			local text = GameTooltipTextLeft1:GetText()
			GameTooltipTextLeft1:SetText(("%s%s"):format(L1[1], text))

			-----------------------------------
			for i = 2, (GameTooltip:NumLines()) do
				local line = _G["GameTooltipTextLeft" .. i]
				local text = line:GetText()

				if (text:find(LEVEL) or text:find(CreatureType)) then
					line:SetText(("%s%s%s %s|r %s %s"):format(r, g, b, LevelText, Classification, CreatureType))
					break
				end
			end
		end


		-- TOT
		local TARGET_UNIT = ("%starget"):format(unit)
		if (UnitExists(TARGET_UNIT)) then
			local text

			if (UnitName(TARGET_UNIT) == UnitName("player")) then
				text = L["TARGETING_YOU"]																						-- C["Tooltip"]["Text"]["TOT"]["Color"] .. " >> " .. UNIT_YOU .. " <<|r"					-- text = C["Tooltip"]["Text"]["TOT"]["Color"] .. L["TOOLTIP_TEXT_YOU"] .. "|r"
			else
				local r, g, b = GameTooltip_UnitColor(TARGET_UNIT)
				text = ("|cff%02x%02x%02x%s|r"):format(r * 255, g * 255, b * 255, UnitName(TARGET_UNIT))
			end

			self:AddLine(" ")
			self:AddLine(("%s:  %s"):format(TARGET, text))
		end
	end

	GameTooltip:Show()
end

GameTooltip:HookScript("OnTooltipSetUnit", OnTooltipSetUnit)
