local A, C, G, L = select(2, ...):Unpack()

if (not C["Tooltip"]["Enable"] or not C["Tooltip"]["Aura"]["Enable"]) then
	return
end




do
	local GameTooltip = GameTooltip
	local UnitAura, UnitName = UnitAura, UnitName
	local UnitBuff, UnitDebuff = UnitBuff, UnitDebuff


	local SetAuraInfo = function(self, caster, spellID)

		if (C["Tooltip"]["Aura"]["SpellID"] and spellID) then									-- print(spellID)
			GameTooltip:AddLine(L["NEWLINE"] .. L["TOOLTIP_AURA_SPELL_ID"] .. spellID)				-- ("ID: " .. spellID)
			GameTooltip:Show()
		end

		if (C["Tooltip"]["Aura"]["AppliedBy"] and caster) then									-- print(caster)
			local Class, CLASS = UnitClass(caster)
			local Classcolor = A.CLASS_COLORS[ CLASS ]

			local color = ("|c%s"):format(Classcolor.colorStr)

			GameTooltip:AddLine(L["TOOLTIP_AURA_APPLIED_BY"] .. color .. UnitName(caster))			-- ('Applied by: ' .. color .. UnitName(caster))
			GameTooltip:Show()
		end
	end

	hooksecurefunc(GameTooltip, "SetUnitAura", function(self, ...)
		local _,_,_,_,_,_,_,caster,_,_,spellID = UnitAura(...)
		SetAuraInfo(self, caster, spellID)
	end)

	hooksecurefunc(GameTooltip, "SetUnitBuff", function(self, ...)
		local _,_,_,_,_,_,_,caster,_,_,spellID = UnitBuff(...)
		SetAuraInfo(self, caster, spellID)
	end)

	hooksecurefunc(GameTooltip, "SetUnitDebuff", function(self, ...)
		local _,_,_,_,_,_,_,caster,_,_,spellID = UnitDebuff(...)
		SetAuraInfo(self, caster, spellID)
	end)
end


A.print("Tooltip", "Aura", "Loaded")

