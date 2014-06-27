local A, C, G, L = select(2, ...):Unpack()

if (not C["Tooltip"]["Enable"] or not C["Tooltip"]["Anchor"]["Enable"]) then
	return
end




local UIParent = UIParent
local WorldFrame = WorldFrame
local CONTAINER_OFFSET_X = CONTAINER_OFFSET_X
local CONTAINER_OFFSET_Y = CONTAINER_OFFSET_Y
local GetMouseFocus = GetMouseFocus


hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)

	if (C["Tooltip"]["Anchor"]["Cursor"]) then

		if (GetMouseFocus() == WorldFrame) then

			self:SetOwner(parent, "ANCHOR_CURSOR")

		else

			self:SetOwner(parent, "ANCHOR_NONE")
			self:ClearAllPoints()
			self:SetPoint("RIGHT", UIParent, "RIGHT", -100, 0)
		--	self:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -CONTAINER_OFFSET_X, CONTAINER_OFFSET_Y)

		end
	end

end)


A.print("Tooltip", "Anchor", "Loaded")


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[	Revert

	hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)
		if (C["Tooltip"]["Anchor"]["Cursor"]) and (GetMouseFocus() == WorldFrame) then
			self:SetOwner(parent, "ANCHOR_CURSOR")
		else
			self:SetOwner(parent, "ANCHOR_NONE")
			self:ClearAllPoints()
			self:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -90, CONTAINER_OFFSET_Y + 70)
		end
	end)
--]]

--[[ Previous Version

	if (C["Tooltip"]["Anchor"]["Cursor"]) then

		hooksecurefunc("GameTooltip_SetDefaultAnchor", function(self, parent)
			self:SetOwner(parent, "ANCHOR_CURSOR")
		end)

	elseif (C["Tooltip"]["Anchor"]["None"]) then

		GameTooltip_SetDefaultAnchor = function(self, parent)
			self:SetOwner(parent, "ANCHOR_NONE")
			self:SetPoint("BOTTOMRIGHT", UIParent, "BOTTOMRIGHT", -70, CONTAINER_OFFSET_Y + 70)
			self.default = 1
		end

	elseif (C["Tooltip"]["Anchor"]["Smart"]) then
		-- Some smart shit happens here
	end
--]]


--------------------------------------------------
--	Credit
--------------------------------------------------
--	TT at Cursor:
--	CursorCompanion Version ( Jaliborc )
--
--	TT at Anchor:
--	sTooltip Version (Shantalya)
--------------------------------------------------
