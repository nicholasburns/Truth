local A, C, G, L = select(2, ...):Unpack()

if (not C["Tooltip"]["Enable"] or not C["Tooltip"]["Icons"]["Enable"]) then
	return
end


local DEFAULT_ICON_SIZE = C["Tooltip"]["Icons"]["Size"] or A["PixelSizes"][24] or 24

do
	local select = select
	local GetItemIcon = GetItemIcon
	local GetSpellInfo = GetSpellInfo


	local CreateIcon = function(self, icon)
	--	Add Icon to the Tooltip
		local title = icon and _G[self:GetName() .. "TextLeft1"]
		if (title) then
			title:SetFormattedText("|T%s:%d|t %s", icon, DEFAULT_ICON_SIZE, title:GetText())
		end
	end

	local CreateHook = function(method, func)
	--	Tooltip Hook Generator
		return function(tooltip)
			local modified = false
			tooltip:HookScript("OnTooltipCleared", function(self, ...)
				modified = false
			end)
			tooltip:HookScript(method, function(self, ...)
				if (not modified)  then
					modified = true
					func(self, ...)
				end
			end)
		end
	end

	---------------------------------------------

	local HookItems = CreateHook("OnTooltipSetItem", function(self, ...)
		local name, link = self:GetItem()
		if (link) then
			CreateIcon(self, GetItemIcon(link))
		end
	end)

	local HookSpells = CreateHook("OnTooltipSetSpell", function(self, ...)
		local name, rank, id = self:GetSpell()
		if (id) then
			CreateIcon(self, select(3, GetSpellInfo(id)))
		end
	end)

	---------------------------------------------

	for _, tooltip in pairs({GameTooltip, ItemRefTooltip}) do
		HookItems(tooltip)
		HookSpells(tooltip)
	end
end


A.print("Tooltip", "Icons", "Loaded")


--------------------------------------------------
--	Credits
--------------------------------------------------
--	Tipachu by Tuller
--	Adds item icons to tooltips
--------------------------------------------------
