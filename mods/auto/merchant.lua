local A, C, G, L = select(2, ...):Unpack()

if (not C["Auto"]["Enable"] or not C["Auto"]["Merchant"]["Enable"]) then
	return
end

local select = select
local floor = math.floor
local format = string.format

--[[ API Notes

	-- Constant
	NUM_BAG_SLOTS			= 4				-- # bags
	NUM_BANKBAGSLOTS		= 7				-- # bank bags
	NUM_BANKGENERIC_SLOTS	= 28				-- # bank itemslots


	GetItemInfo( itemID or itemName or itemLink )
	---------------------------------------------
	>  name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(item)

	GetContainerItemInfo(container, slot)
	---------------------------------------------
	>  texture, count, locked, quality, readable, lootable, link, isFiltered = GetContainerItemInfo(bag, slot)

--]]


local OnEvent = function(self, event, ...)
	local profit = 0

	for bag = 0, (4) do
		for slot = 1, (GetContainerNumSlots(bag)) do
			local link = GetContainerItemLink(bag, slot)

			if (link) then
				local value = select(11, GetItemInfo(link)) * select(2, GetContainerItemInfo(bag, slot))	-- Item Value (price * count)

				if (select(3, GetItemInfo(link)) == ITEM_QUALITY_POOR) then
					UseContainerItem(bag, slot)
					PickupMerchantItem()

					profit = profit + value
				end
			end
		end
	end

	DEFAULT_CHAT_FRAME:AddMessage((L["MERCHANT_SALES_EARNINGS_FORMAT"]):format(GetCoinTextureString(profit)))	-- Profit Summary



	-- Repairs
	if (CanMerchantRepair()) then
		local cost, beneficial = GetRepairAllCost()

		if (cost > 0) then					-- Repairs needed (cost > 0)

			if (beneficial) then			-- Player has any damage at all
				RepairAllItems(0)

			--	Repair and report
				DEFAULT_CHAT_FRAME:AddMessage((L["MERCHANT_REPAIRS_SPENDINGS_FORMAT"]):format(GetCoinTextureString(cost)))
			else
			--	Gold needed for repairs
				DEFAULT_CHAT_FRAME:AddMessage(L["MERCHANT_REPAIRS_ERROR"])
			end

		else								-- No repairs needed (cost = 0)

			DEFAULT_CHAT_FRAME:AddMessage((L["MERCHANT_REPAIRS_SPENDINGS_FORMAT"]):format(GetCoinTextureString(0)))				--	print((L["MERCHANT_REPAIRS_SPENDINGS_FORMAT"]):format(GetCoinTextureString(0)))

		end
	end
end

local f = CreateFrame('Frame')
f:RegisterEvent('MERCHANT_SHOW')
f:SetScript('OnEvent', OnEvent)


--------------------------------------------------
--[[ Bigger Stacks

	hooksecurefunc("MerchantItemButton_OnModifiedClick", function(self, button)
		if ((button == 'RightButton') and IsShiftKeyDown()) then
			OpenStackSplitFrame(100000, self, 'BOTTOMLEFT', 'TOPLEFT')
		end
	end)
--]]
--------------------------------------------------


--------------------------------------------------
--	Credits
--------------------------------------------------
--[[ ncImprovedMerchant TOC

	## Interface: 30300
	## Title: ncImprovedMerchant
	## Version: 1.1
	## Author: Nightcracker
	## Notes: Some small improvements for the merchant frame.
--]]
--------------------------------------------------

