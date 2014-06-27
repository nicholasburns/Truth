local A, C, G, L = select(2, ...):Unpack()

if (not C["Automation"]["Enable"] or not C["Automation"]["Merchant"]["Enable"]) then
	return
end

local print = function(...)  					-- A.newline()
	A.print("Merchant", ...) 				-- A.newline() end
end

local select = select
local GetMoney = GetMoney
local GetItemInfo = GetItemInfo
local IsShiftKeyDown = IsShiftKeyDown
local RepairAllItems = RepairAllItems
local GetRepairAllCost = GetRepairAllCost
local UseContainerItem = UseContainerItem
local CanMerchantRepair = CanMerchantRepair
local OpenStackSplitFrame = OpenStackSplitFrame
local GetCoinTextureString = GetCoinTextureString
local GetContainerNumSlots = GetContainerNumSlots
local GetContainerItemLink = GetContainerItemLink
local ShowMerchantSellCursor = ShowMerchantSellCursor
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME


-- Properties
-- local startcash-- local profit = 0




local OnEvent = function(self, event, ...)
	if (event == "MERCHANT_SHOW") then
		local profit = 0

		for bag = 0, (NUM_BAG_SLOTS) do

			for slot = 0, (GetContainerNumSlots(bag)) do
				local link = GetContainerItemLink(bag, slot)

				if (link) then
					local price = select(11, GetItemInfo(link)) * select(2, GetContainerItemInfo(bag, slot))
					-->   p = vendorPrice * count

					if (select(3, GetItemInfo(link)) == 0) then		--> itemQuality == 0
						ShowMerchantSellCursor(1)
						UseContainerItem(bag, slot)

						profit = profit + price
					end
				end
			end
		end
		self:RegisterEvent("MERCHANT_CLOSED")
	--[[ -- StackSplitFrame - Increase # of items (buy in bulk)
		hooksecurefunc("MerchantItemButton_OnModifiedClick", function(self, button)
			if (button == "RightButton") and IsShiftKeyDown() then
				OpenStackSplitFrame(100000, self, 'BOTTOMLEFT', 'TOPLEFT')
			end
		end)
	--]]


--~		REPAIR ALL ITEMS
		if (CanMerchantRepair()) then
			local availablemoney = GetMoney()
			local cost, possible = GetRepairAllCost()

			if (possible == 1) then														-- repairs are available (durability < 100%)

				if (cost <= availablemoney) then
					RepairAllItems(0)													-- RepairAllItems(guildflag) --> 1 = use guild funds | 0nil = use player funds

				--	player repaired													-- (& can afford repairs)
					DEFAULT_CHAT_FRAME:AddMessage((L["MERCHANT_REPAIRS_SPENDINGS_FORMAT"]):format(GetCoinTextureString(cost)))				--	print((L["MERCHANT_REPAIRS_SPENDINGS_FORMAT"]):format(GetCoinTextureString(cost)))

				else
				--	player needs more gold for repairs
					DEFAULT_CHAT_FRAME:AddMessage(L["MERCHANT_REPAIRS_ERROR"])
				end

			else
				if (cost <= 0) then
				--	no repairs needed
					DEFAULT_CHAT_FRAME:AddMessage((L["MERCHANT_REPAIRS_SPENDINGS_FORMAT"]):format(GetCoinTextureString(0)))				--	print((L["MERCHANT_REPAIRS_SPENDINGS_FORMAT"]):format(GetCoinTextureString(0)))
				end

			end
		end
	end


--~	AUTO-SELL GREYS: EARNING SUMMARY
	if (event == "MERCHANT_CLOSED") then
		local endcash = GetMoney()
		local gain = endcash - startcash

		if (gain == 0) then
			DEFAULT_CHAT_FRAME:AddMessage((L["MERCHANT_SALES_EARNINGS_FORMAT"]):format(GetCoinTextureString(0)))		--	print((L["MERCHANT_SALES_EARNINGS_FORMAT"]):format(GetCoinTextureString(0)))

		elseif (gain > 0) then
			DEFAULT_CHAT_FRAME:AddMessage((L["MERCHANT_SALES_EARNINGS_FORMAT"]):format(GetCoinTextureString(gain)))		--	print((L["MERCHANT_SALES_EARNINGS_FORMAT"]):format(GetCoinTextureString(gain)))

		end
	end

end


local f = CreateFrame('Frame')
f:RegisterEvent("MERCHANT_SHOW")
f:SetScript("OnEvent", OnEvent)



----------------------------------------------------------------------------------------------------
--	Backup
----------------------------------------------------------------------------------------------------
--[[ Locale

	L["MERCHANT_MINUS"] = "|cffFF0000 - |r"
	L["MERCHANT_PLUS"]  = "|cff00FF00 + |r"
	L["MERCHANT_REPAIRS_HEADER"] = "|cff0000FF Repair\$: |r"
	L["MERCHANT_REPAIRS_SPENDINGS_FORMAT"] = ("%s %s"):format(L["MERCHANT_REPAIRS_HEADER"], L["MERCHANT_MINUS"]) .. "%s"
	L["MERCHANT_REPAIRS_ERROR"] = ("%s %s"):format(L["MERCHANT_REPAIRS_HEADER"], ERR_NOT_ENOUGH_MONEY)
	L["MERCHANT_SALES_HEADER"] = "|cff00FF00 Sales\$: |r"
	L["MERCHANT_SALES_EARNINGS_FORMAT"] = ("%s %s"):format(L["MERCHANT_SALES_HEADER"], L["MERCHANT_PLUS"]) .. "%s"					-- L["MERCHANT_SALES_NO_MONEY_EARNED"] = "Nothing sold"
--]]

--[[ --====================================--
	--	VENDOR WINDOW:  CLOSE
	--====================================--
	elseif (event == "MERCHANT_CLOSED") then
		local vendorstring = 'VendorTotal'
		local endcash = GetMoney()
		local gain = endcash - startcash

		if (gain == 0) then
			print(vendorstring, 'No items bought or sold.') 								-- f:UnregisterEvent("MERCHANT_CLOSED") return end
		elseif (gain < 0) then
			gain	= startcash - endcash
			print(vendorstring, RED_FONT_COLOR_CODE .. '-|r' .. GetCoinTextureString(gain))
		else
			print(vendorstring, GREEN_FONT_COLOR_CODE .. '+|r' .. GetCoinTextureString(gain))
		end
		f:UnregisterEvent("MERCHANT_CLOSED")
	end
end)
--]]
--[[ elseif (event == "MERCHANT_CLOSED") then
		local vendorstring = 'VendorTotal'
		local endcash = GetMoney()
		local gain = endcash - startcash
		if (gain == 0) then
			if (toggle == 0) then
				print(vendorstring, 'No items bought or sold.')
				toggle = 1
			else
				toggle = 0
			end
			return
		end
		if (gain < 0) then
			gain	= startcash - endcash
			print(vendorstring, RED_FONT_COLOR_CODE .. '-|r' .. GetCoinTextureString(gain))
		else
			print(vendorstring, GREEN_FONT_COLOR_CODE .. '+|r' .. GetCoinTextureString(gain))
		end
		f:UnregisterEvent("MERCHANT_CLOSED")
	end
--]]


----------------------------------------------------------------------------------------------------

--	Reference

----------------------------------------------------------------------------------------------------
--[=[ GetCoinText(10000)
	-- returns "1 Gold"

	GetCoinText(500050)
	-- returns "50 Gold, 50 Copper"

	GetCoinText(123456, " / ")
	-- returns "12 Gold / 4 Silver / 56 Copper"

	GetCoinTextureString(10000)
	-- returns "1|TInterface\\MoneyFrame\\UI-GoldIcon:14:14:2:0|t"

	GetCoinTextureString(500050)
	-- returns "50|TInterface\\MoneyFrame\\U-GoldIcon:14:14:2:0|t 50|TInterface\\MoneyFrame\\UI-CopperIcon:14:14:2:0|t"

	GetCoinTextureString(123456)
	-- returns "12|TInterface\\MoneyFrame\\UI-GoldIcon:14:14:2:0|t 34|TInterface\\MoneyFrame\\UI-SilverIcon:14:14:2:0|t 56|TInterface\\MoneyFrame\\UI-CopperIcon:14:14:2:0|t"

	--[[ <merchant> Repairs:  None ]] 												-- DEFAULT_CHAT_FRAME:AddMessage(str .. "None |r")
	--[[ <merchant> Repairs:  0 {Gold texture} ]] 									-- DEFAULT_CHAT_FRAME:AddMessage(str .. "0|TInterface\\MoneyFrame\\UI-GoldIcon:14:14:2:0|t")
	--[[ <merchant> Repairs:  1 {Gold texture} ]] 									-- DEFAULT_CHAT_FRAME:AddMessage(str .. GetCoinTextureString(10000))
	--[[ <merchant> Repairs:  12 {Gold texture} 34 {Silver texture} 56 {Copper texture} ]] 	-- DEFAULT_CHAT_FRAME:AddMessage(str .. GetCoinTextureString(123456))
	--[[ <merchant> Repairs:  12 Gold, 34 Silver, 56 Copper ]] 							-- DEFAULT_CHAT_FRAME:AddMessage(str .. GetCoinText(123456, ", "))
--]=]
----------------------------------------------------------------------------------------------------
--[[
		NORMAL_FONT_COLOR_CODE		= '|cffffd200'
		HIGHLIGHT_FONT_COLOR_CODE	= '|cffffffff'
		RED_FONT_COLOR_CODE			= '|cffff2020'
		GREEN_FONT_COLOR_CODE		= '|cff20ff20'
		GRAY_FONT_COLOR_CODE		= '|cff808080'
		YELLOW_FONT_COLOR_CODE		= '|cffffff00'
		LIGHTYELLOW_FONT_COLOR_CODE	= '|cffffff9a'
		ORANGE_FONT_COLOR_CODE		= '|cffff7f3f'
		ACHIEVEMENT_COLOR_CODE		= '|cffffff00'
		BATTLENET_FONT_COLOR_CODE	= '|cff82c5ff'
--]]
----------------------------------------------------------------------------------------------------
--[[
	The Modulus Operator (%)		<http://luatut.com/crash_course.html>
	Remainder between the division of two numbers

		print(14 % 5)
		> 4

		print(10 % 3) 				-->  10 - 3 * 3
		> 1 						-->  = 1

		print(27.17 % 100)

	compacted: (10 - 3 * 3 = 1)
--]]
----------------------------------------------------------------------------------------------------
