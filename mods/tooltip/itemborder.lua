local A, C, G, L = select(2, ...):Unpack()

if (not C["Tooltip"]["Enable"] or not C["Tooltip"]["ItemBorder"]["Enable"]) then
	return
end

local r, g, b, a = unpack(A.default.backdrop.color)


--	 local r, g, b = C["Tooltip"]["ItemBorder"]["BackdropColor"]
--	 local a = C["Tooltip"]["ItemBorder"]["BackdropAlpha"]


local OnTooltipSetItem

do
	local next = next
	local GetItemInfo = GetItemInfo
	local GetItemQualityColor = GetItemQualityColor


	OnTooltipSetItem = function(self, ...)
		local _, item = self:GetItem()

		if (item) then
			local _, _, quality = GetItemInfo(item)

			if (quality) then

				self:SetBackdropColor(r, g, b, a)
			--	self:SetBackdropColor(BACKDROP_COLOR[1], BACKDROP_COLOR[2], BACKDROP_COLOR[3], BACKDROP_ALPHA)
			--	self:SetBackdropColor(BACKDROP_COLOR.r, BACKDROP_COLOR.g, BACKDROP_COLOR.b, BACKDROP_ALPHA)


				self:SetBackdropBorderColor(GetItemQualityColor(quality))					--	local Qred, Qgreen, Qblue = GetItemQualityColor(quality)
			--	local Qred, Qgreen, Qblue = GetItemQualityColor(quality)
			--	self:SetBackdropBorderColor(Qred, Qgreen, Qblue)

			end
		end
	end


	for _, Tooltip in next, {
		GameTooltip,
		ShoppingTooltip1,
		ShoppingTooltip2,
		ShoppingTooltip3,
		ItemRefTooltip,
	} do
		Tooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
	end
end


A.print("Tooltip", "ItemBorder", "Loaded")


--------------------------------------------------
--	Credits
--------------------------------------------------
--[[ Chippu.toc
	## Interface: 40300
	## Title: Chippu
	## Author: Haste
	## Version: 1.4
	## Notes: Tooltip borders colored by item quality
--]]
--------------------------------------------------
