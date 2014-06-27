local A, C, G, L = select(2, ...):Unpack()

if (not C["Skin"]["Enable"] or not C["Skin"]["Bags"]["Enable"]) then
	return
end




----------------------------------------------------------------------------------------------------
--[[ ContainerFrame Globals (ContainerFrame.lua)

	NUM_CONTAINER_FRAMES 		= 13
	NUM_BAG_FRAMES				= 4
	MAX_CONTAINER_ITEMS 		= 36		-- bags: 36 slots
	NUM_CONTAINER_COLUMNS 		= 4		-- bags:  4 columns

	ROWS_IN_BG_TEXTURE 			= 6
	MAX_BG_TEXTURES 			= 2
	BG_TEXTURE_HEIGHT 			= 512

	CONTAINER_WIDTH 			= 192
	CONTAINER_OFFSET_Y 			= 70
	CONTAINER_OFFSET_X 			= 0
	CONTAINER_SCALE			= 0.75
	CONTAINER_SPACING 			= 0
	  VISIBLE_CONTAINER_SPACING	= 3

	BACKPACK_HEIGHT			= 240
--]]

--[[ Container Constants  (Constants.lua)

	CONTAINER_BAG_OFFSET = 19 				-- Used for PutItemInBag
	BANK_CONTAINER_INVENTORY_OFFSET = 39		-- Used for PickupInventoryItem
	ITEM_INVENTORY_BANK_BAG_OFFSET = 4			-- Number of bags before the first bank bag

	BACKPACK_CONTAINER = 0
	BANK_CONTAINER = -1
	KEYRING_CONTAINER = -2

	NUM_BAG_SLOTS = 4
	NUM_BANKBAGSLOTS = 7
	NUM_BANKGENERIC_SLOTS = 28
--]]
----------------------------------------------------------------------------------------------------


--------------------------------------------------
--	Main Function
--------------------------------------------------
local LoadSkin
do
	local BagItemSearchBox = BagItemSearchBox
	local BackpackTokenFrame = BackpackTokenFrame
	local BankFrame = BankFrame
	local BankItemSearchBox = BankItemSearchBox
	local BankFrameCloseButton = BankFrameCloseButton
	local BankFrameMoneyFrameBorder = BankFrameMoneyFrameBorder
	local BankFrameMoneyFrameInset = BankFrameMoneyFrameInset
	local BankFramePurchaseButton = BankFramePurchaseButton

	-- Container Constants  (Constants.lua)
	local NUM_BAG_SLOTS 		= NUM_BAG_SLOTS		--[[  4 ]]
	local NUM_BANKBAGSLOTS		= NUM_BANKBAGSLOTS		--[[  7 ]]
	local NUM_BANKGENERIC_SLOTS 	= NUM_BANKGENERIC_SLOTS	--[[ 28 ]]

	local BACKPACK_CONTAINER		= BACKPACK_CONTAINER	--[[  0 ]]
	local BANK_CONTAINER 		= BANK_CONTAINER		--[[ -1 ]]
	local KEYRING_CONTAINER 		= KEYRING_CONTAINER		--[[ -2 ]]

	local CONTAINER_BAG_OFFSET			= CONTAINER_BAG_OFFSET			--[[ 19 ]] -- Used for PutItemInBag
	local ITEM_INVENTORY_BANK_BAG_OFFSET	= ITEM_INVENTORY_BANK_BAG_OFFSET	--[[  4 ]] -- Number of bags before the first bank bag
	local BANK_CONTAINER_INVENTORY_OFFSET	= BANK_CONTAINER_INVENTORY_OFFSET	--[[ 39 ]] -- Used for PickupInventoryItem

	-- Guild Bank
  -- local MAX_GUILDBANK_TABS		= MAX_GUILDBANK_TABS	--[[ 8 ]]
  -- local MAX_BUY_GUILDBANK_TABS	= MAX_BUY_GUILDBANK_TABS	--[[ 6 ]]


	LoadSkin = function()

		--------------------------------------------------
		--	BagFrame
		--------------------------------------------------
		for i = 1, ( 5 ) do
			local bag   = _G["ContainerFrame" .. i]
			local close = _G["ContainerFrame" .. i .. "CloseButton"]

			if (bag) then

				bag:Strip(true)
				bag:Backdrop()

				bag.backdrop:Border()
				bag.backdrop:Shadow()
				bag.backdrop:Point('TOPLEFT', 4, -2)
				bag.backdrop:Point('BOTTOMRIGHT', 1, 1)

				close:SkinCloseButton()
				close:Point('TOPRIGHT', bag, -12, -7)
				close:Size(18, 18)

				-- Slots
				for j = 1, ( 36 ) do
					local slot = _G["ContainerFrame" .. i .. "Item" .. j]
					local icon = _G["ContainerFrame" .. i .. "Item" .. j .. "IconTexture"]

					slot:SkinButton()

					icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
					icon:SetInside(slot)
				end
			end

			BackpackTokenFrame:Strip()
		end

		BagItemSearchBox:SetSize(159, 15)
		BagItemSearchBox:SetPoint('TOPLEFT', 19, -29)
		BagItemSearchBox:SkinEditBox()


		--------------------------------------------------
		--	BankFrame
		--------------------------------------------------
		if (BankFrame) then
			BankFrame:Strip(true)
			BankFrame:Backdrop()
			BankFrame.backdrop:Border()
			BankFrame.backdrop:Shadow()

			BankFrameCloseButton:SkinCloseButton()
			BankFrameCloseButton:Point('TOPRIGHT', BankFrame, -12, -7)

			BankFrameMoneyFrameBorder:Strip()
			BankFrameMoneyFrameInset:Strip()

			BankFramePurchaseButton:SetHeight(22)
			BankFramePurchaseButton:SkinButton()

			BankItemSearchBox:Size(159, 15)
			BankItemSearchBox:Point("BOTTOMRIGHT", -29, 70)
			BankItemSearchBox:SkinEditBox()
		  -- BankItemSearchBox.ClearAllPoints = Addon["Dummy"]
		  -- BankItemSearchBox.SetPoint = Addon["Dummy"]


			-- Bank Bags
			for i = 1, (NUM_BANKBAGSLOTS) do
				local bankbags  = _G["BankFrameBag" .. i]
				local icon      = _G["BankFrameBag" .. i .. "IconTexture"]
				local highlight = _G["BankFrameBag" .. i .. "HighlightFrameTexture"]

				bankbags:SkinButton()
				bankbags:StyleButton()

				icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
				icon:SetInside(bankbags)

				highlight:Kill()
			end


			-- Bank Slots
			for i = 1, ( 28 ) do
				local slot = _G["BankFrameItem" .. i]
				local icon = _G["BankFrameItem" .. i .. "IconTexture"]

				slot:SkinButton()

				icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
				icon:SetInside(slot)
			end


			-- Bank Bags Frame
			for i = 6, ( 12 ) do
				local bag   = _G["ContainerFrame" .. i]
				local close = _G["ContainerFrame" .. i .. "CloseButton"]

				if (bag) then

					bag:Strip(true)
					bag:Backdrop()

					bag.backdrop:Shadow()
					bag.backdrop:Border()
					bag.backdrop:Point('TOPLEFT', 4, -2)
					bag.backdrop:Point('BOTTOMRIGHT', 1, 1)

					close:SkinCloseButton()
					close:Size(18, 18)
					close:Point('TOPRIGHT', bag, -12, -7)


					-- Bank Bag Slots
					for j = 1, ( 36 ) do
						local icon = _G["ContainerFrame" .. i .. "Item" .. j .. "IconTexture"]
						local slot = _G["ContainerFrame" .. i .. "Item" .. j]

						slot:SkinButton()

						icon:SetTexCoord(0.08, 0.92, 0.08, 0.92)
						icon:SetInside(slot)
					end
				end
			end
		end
	end
end

--------------------------------------------------
--	Events
--------------------------------------------------
do
	local events = CreateFrame('Frame')
	events:RegisterEvent('PLAYER_ENTERING_WORLD')							-- e:RegisterEvent('ADDON_LOADED')
	events:SetScript('OnEvent', function(self, event, addon)
		LoadSkin()
		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end)
end

--------------------------------------------------
--	Credits
--------------------------------------------------
--	ShestakUI by Shestak
--------------------------------------------------
