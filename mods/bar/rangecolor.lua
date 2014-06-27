local A, C, G, L = select(2, ...):Unpack()

if (not C["Bar"]["Enable"] or not C["Bar"]["RangeColor"]["Enable"]) then
	return
end

local hooksecurefunc = hooksecurefunc



-- Constant
local DEFAULT_OOR_COLOR			= {r = 1.0, g = 0.2, b = 0.2}
local DEFAULT_OOM_COLOR			= {r = 0.2, g = 0.2, b = 1.0}
local DEFAULT_OOR_AND_OOM_COLOR	= {r = 1.0, g = 1.0, b = 0.2}

-- Datatable
local COLORS = {}


local OnUpdate, UpdateUsable, WatchFrame_Item_OnUpdate
do
	local TOOLTIP_UPDATE_TIME = TOOLTIP_UPDATE_TIME
	local IsActionInRange = IsActionInRange
	local ActionButton_UpdateUsable = ActionButton_UpdateUsable
	local IsUsableAction = IsUsableAction
	local GetQuestLogSpecialItemInfo = GetQuestLogSpecialItemInfo
	local IsQuestLogSpecialItemInRange = IsQuestLogSpecialItemInRange


	OnUpdate = function(self, elapsed)										-- function COLORS.ActionButtonOnUpdate(self, elapsed)
		if (not self.rangeTimer) then
			return
		end

		local name = self:GetName()
		if (not COLORS[name]) then
			COLORS[name] = {}
		end

		if (not COLORS[name].timer) then
			COLORS[name].timer = -1
		end

		local rangeTimer = COLORS[name].timer
		rangeTimer = rangeTimer - elapsed

		if (rangeTimer <= 0) then
			local outofrange = IsActionInRange(self.action) == 0

			if (COLORS[name].outOfRange ~= outofrange) then
				COLORS[name].outOfRange = outofrange
				ActionButton_UpdateUsable(self)
			end

			rangeTimer = TOOLTIP_UPDATE_TIME
		end

		COLORS[name].timer = rangeTimer
	end
	hooksecurefunc("ActionButton_OnUpdate", OnUpdate)							-- Hook for checking button range


	UpdateUsable = function(self, elapsed)												-- function COLORS.ActionButtonUpdateUsable(self)
		local name = self:GetName()
		if (not COLORS[name]) then
			return
		end

		local normal = _G[name .. "NormalTexture"]
		if (not normal) then
			return
		end

		local outofrange = COLORS[name].outOfRange
		local usable, oom = IsUsableAction(self.action)
		local icon = _G[name .. "Icon"]

		if (oom and outofrange) then
			local color = DEFAULT_OOR_AND_OOM_COLOR
			icon:SetVertexColor(color.r, color.g, color.b)
			normal:SetVertexColor(color.r, color.g, color.b)
		elseif (oom) then
			local color = DEFAULT_OOM_COLOR
			icon:SetVertexColor(color.r, color.g, color.b)
			normal:SetVertexColor(color.r, color.g, color.b)
		elseif (usable and outofrange) then
			local color = DEFAULT_OOR_COLOR
			icon:SetVertexColor(color.r, color.g, color.b)
			normal:SetVertexColor(color.r, color.g, color.b)
		elseif (usable) then
			icon:SetVertexColor(1, 1, 1)
			normal:SetVertexColor(1, 1, 1)
		else
			icon:SetVertexColor(0.4, 0.4, 0.4)
			normal:SetVertexColor(1, 1, 1)
		end
	end
	hooksecurefunc("ActionButton_UpdateUsable", UpdateUsable)					-- Hook for setting button color


	WatchFrame_Item_OnUpdate = function(self, elapsed)									-- COLORS.WatchFrameItemOnUpdate(self, elapsed)
		if (not self.rangeTimer) then
			return
		end

		local name = self:GetName()

		if (not COLORS[name]) then
			COLORS[name] = {}
		end
		if (not COLORS[name].timer) then
			COLORS[name].timer = -1
		end

		local rangeTimer = COLORS[name].timer
		rangeTimer = rangeTimer - elapsed

		if (rangeTimer <= 0) then
			local link, item, charges = GetQuestLogSpecialItemInfo(self:GetID())
			if (not charges or charges ~= self.charges) then
				return
			end

			local normal = _G[name .. "NormalTexture"]
			if (not normal) then
				return
			end

			if (not COLORS[name]) then
				return
			end

			local icon = _G[name .. "IconTexture"]
			local valid = IsQuestLogSpecialItemInRange(self:GetID())

			if (valid == 0) then
				local color = DEFAULT_OOR_COLOR
				icon:SetVertexColor(color.r, color.g, color.b)
				normal:SetVertexColor(color.r, color.g, color.b)
			elseif (valid == 1) then
				icon:SetVertexColor(1, 1, 1)
				normal:SetVertexColor(1, 1, 1)
			end

			rangeTimer = TOOLTIP_UPDATE_TIME
		end

		COLORS[name].timer = rangeTimer
	end

	hooksecurefunc("WatchFrameItem_OnUpdate", WatchFrame_Item_OnUpdate)			-- Hook for setting extra button range
end


-- A.print("Bar", "RangeColor", "Loaded")


--------------------------------------------------
--	Credits
--------------------------------------------------
--[[ COLORS.toc

	## Interface: 50400
	## Title: COLORS 2.3.2
	## Notes: Out of range and out of mana action button coloration
	## SavedVariables: COLORS_SavedVars

	Localization.lua
	COLORS.lua
	COLORSOptions.lua
	COLORSOptions.xml

--]]
--------------------------------------------------
