local A, C, G, L = select(2, ...):Unpack()

if (not C["Tooltip"]["Enable"] or not C["Tooltip"]["Mono"]["Enable"]) then
	return
end

local find = string.find
local format = string.format
local ipairs = ipairs
local min = math.min
local max = math.max
local match = string.match
local split = string.split
local select = select
local type = type
local unpack = unpack
local wipe = table.wipe
local GetItem = GetItem
local GetItemInfo = GetItemInfo
local GetItemQualityColor = GetItemQualityColor
local GameTooltip = GameTooltip
local GameTooltipStatusBar = GameTooltipStatusBar
local ItemRefTooltip = ItemRefTooltip


-- Constant
local DEFAULT_SCALE = 1

local DEFAULT_FONT_FILE = A.default.font[1]
local DEFAULT_FONT_FLAG = "OUTLINE"

local DEFAULT_CLASSIFICATIONS = {
	['elite']     = L["TOOLTIP_CLASSIFICATION_ELITE"],
	['rare']      = L["TOOLTIP_CLASSIFICATION_RARE"],
	['rareelite'] = L["TOOLTIP_CLASSIFICATION_RAREELITE"],
	['worldboss'] = L["TOOLTIP_CLASSIFICATION_WORLDBOSS"],
}

local DEFAULT_TOOLTIPS = {
	GameTooltip,
	ItemRefTooltip,
	ItemRefShoppingTooltip1,
	ItemRefShoppingTooltip2,
	ItemRefShoppingTooltip3,
	ShoppingTooltip1,
	ShoppingTooltip2, ShoppingTooltip3,
	WorldMapTooltip,
	WorldMapCompareTooltip1,
	WorldMapCompareTooltip2,
	WorldMapCompareTooltip3,
	DropDownList1MenuBackdrop,
	DropDownList2MenuBackdrop,
}

-- Datatables
local L1, L2, L3 = {}, {}, {}




do
	local OnShow = function(self)
		self:Template("TRANSPARENT")

		local item
		if (self.GetItem) then
			item = select(2, self:GetItem())
		end

		if (item) then
			local quality = select(3, GetItemInfo(item))
			if (quality and quality > 1) then
				local r, g, b = GetItemQualityColor(quality)
				self:SetBackdropBorderColor(r, g, b)
			end
		else
			self:SetBackdropBorderColor(0, 0, 0, 1)
		end
	end

	local OnHide = function(self)
		self:SetBackdropBorderColor(0, 0, 0, 1)
	end

	for i, Tooltip in ipairs(DEFAULT_TOOLTIPS) do				--~  print('Tooltip: ', Tooltip:GetName())
		Tooltip:Template("TRANSPARENT")
		Tooltip:HookScript("OnShow", OnShow)
		Tooltip:HookScript("OnHide", OnHide)
	end


	---------------------------------------------
	--	GameTooltip
	---------------------------------------------
	GameTooltip:HookScript("OnUpdate", function(self)
		if (not C["Tooltip"]["Anchor"]["Cursor"]) then
			return
		end

		if (GetMouseFocus() == WorldFrame) then
			if (UnitExists("mouseover")) then
				local x, y = GetCursorPosition()
				local scale = self:GetEffectiveScale()

				self:ClearAllPoints()
				self:SetPoint('BOTTOMLEFT', UIParent, x / scale, y / scale)

			else
				if (self:GetUnit("mouseover")) then
					self:Hide()
				end
			end
		end
	end)


	---------------------------------------------
	--	Items
	---------------------------------------------
	local OnTooltipSetItem = function(self)
		local _, link = self:GetItem()
		if (not link) then
			return
		end

		local id = string.match(link, "item:(%d+)")
		local itemtype, subtype = select(6, GetItemInfo(id))
		if (itemtype == "Trade Goods") then
			self:AddLine(itemtype .. ": |cffAAFF77" .. (subtype or UNKNOWN))
		end
	end

	GameTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
	ItemRefTooltip:HookScript("OnTooltipSetItem", OnTooltipSetItem)
end


--------------------------------------------------
do

	local Fonts = function()
		GameTooltipHeaderText:SetFont(DEFAULT_FONT_FILE, 20, DEFAULT_FONT_FLAG)
		GameTooltipText:SetFont(DEFAULT_FONT_FILE, 14, DEFAULT_FONT_FLAG)
		Tooltip_Small:SetFont(DEFAULT_FONT_FILE, 10, DEFAULT_FONT_FLAG)
	end

	local Handler = function()
		GameTooltipStatusBar:Template("TRANSPARENT")
		GameTooltipStatusBar:SetStatusBarTexture(C["Tooltip"]["StatusBar"]["Texture"])			-- [=[Interface\TargetingFrame\UI-TargetingFrame-BarFill]=]
	end

	local hook = CreateFrame('Frame')
	hook:RegisterEvent('PLAYER_ENTERING_WORLD')
	hook:SetScript('OnEvent', function(self, event, ...)

		Fonts()
		Handler()

		self:UnregisterEvent(event)
	end)
end
--------------------------------------------------
do
	local hide = CreateFrame('Frame')
	hide:RegisterEvent("CURSOR_UPDATE")
	hide:SetScript('OnEvent', function()
		if (GameTooltip:IsOwned(UIParent)) then
			if (not UnitExists("mouseover")) then
				GameTooltip:Hide()				-- Instantly fade the tooltip
			end
		end
	end)
end
--------------------------------------------------
--[[ PLAYER_ENTERING_WORLD

	local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:SetScript('OnEvent', function(self, event, addon, ...)

		-- BAM!

		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end)

--]]

