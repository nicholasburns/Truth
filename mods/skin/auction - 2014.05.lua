local A, C, G, L = select(2, ...):Unpack()

if (not C["Skin"]["Enable"] or not C["Skin"]["Auction"]["Enable"]) then
	return
end

--		WORKING MACROS
--
--	/script Auction_LoadUI() ShowUIPanel(AuctionFrame)
--
--	/script BlackMarket_LoadUI() ShowUIPanel(BlackMarketFrame)


-- Constant
local MARGIN, PAD = G.MARGIN, G.PAD

local BUTTON_WIDTH = G.BUTTON_WIDTH or 80
local BUTTON_HEIGHT = G.BUTTON_HEIGHT or 22

local CHECKBUTTON_SIZE = G.CHECKBUTTON_SIZE or 20

local SCROLLBAR_WIDTH = G.SCROLLBAR_WIDTH or 28
local SCROLLBAR_BUTTON_SIZE = G.SCROLLBAR_BUTTON_SIZE or 16
local SCROLLBAR_THUMB_TEXTURE = G.SCROLLBAR_THUMB_TEXTURE or [=[Interface\Buttons\UI-ScrollBar-Knob]=]



-- Private
local Skin
local SkinAuctionFrame, SkinDressUpFrame
local SkinItemButtons, SkinObjectItems
local SkinPanels, SkinProgressFrame

do
	local select, unpack = select, unpack
	local ipairs, pairs = ipairs, pairs
	local find = string.find


	SkinItemButtons = function()
		for i = 1, (NUM_BROWSE_TO_DISPLAY) do
			local BrowseButton = _G["BrowseButton" .. i]
			local BrowseButtonIcon = _G["BrowseButton" .. i .. "Item"]

			if  (_G["BrowseButton" .. i .. "ItemIconTexture"]) then
				_G["BrowseButton" .. i .. "ItemIconTexture"]:SetTexCoord(G.Coords())
				_G["BrowseButton" .. i .. "ItemIconTexture"]:SetInside()
			end

			if (BrowseButtonIcon) then
				BrowseButtonIcon:Strip()
				BrowseButtonIcon:StyleButton()
				BrowseButtonIcon:Template("TRANSPARENT")
				BrowseButtonIcon:GetNormalTexture():SetTexCoord(G.Coords())
				BrowseButtonIcon:GetNormalTexture():SetInside()
			end

			BrowseButton:Strip()
			BrowseButton:StyleButton()
			_G["BrowseButton" .. i .. "Highlight"] = BrowseButton:GetHighlightTexture()
			BrowseButton:GetHighlightTexture():Point('TOPLEFT', BrowseButtonIcon, 'TOPRIGHT', 2, 0)
			BrowseButton:GetHighlightTexture():Point('BOTTOMRIGHT', BrowseButton, 'BOTTOMRIGHT', -2, 5)
			BrowseButton:GetPushedTexture():SetAllPoints(BrowseButton:GetHighlightTexture())
		end


		--[[ 2 ]]------------------------------------------------------------------

		for i = 1, (NUM_BIDS_TO_DISPLAY) do
			local BidButton	= _G["BidButton" .. i]
			local BidButtonIcon = _G["BidButton" .. i .. "Item"]

			_G["BidButton" .. i .. "ItemIconTexture"]:SetTexCoord(G.Coords())
			_G["BidButton" .. i .. "ItemIconTexture"]:SetInside()

			BidButtonIcon:Strip()
			BidButtonIcon:StyleButton()
			BidButtonIcon:Template("TRANSPARENT")
			BidButtonIcon:GetNormalTexture():SetTexCoord(G.Coords())
			BidButtonIcon:GetNormalTexture():SetInside()

			BidButton:Strip()
			BidButton:StyleButton()
			_G["BidButton" .. i .. "Highlight"] = BidButton:GetHighlightTexture()
			BidButton:GetHighlightTexture():Point('TOPLEFT', BidButtonIcon, 'TOPRIGHT', 2, 0)
			BidButton:GetHighlightTexture():Point('BOTTOMRIGHT', BidButton, 'BOTTOMRIGHT', -2, 5)
			BidButton:GetPushedTexture():SetAllPoints(BidButton:GetHighlightTexture())
		end


		--[[ 3 ]]------------------------------------------------------------------

		for i = 1, (NUM_AUCTIONS_TO_DISPLAY) do
			local AuctionsButton     = _G["AuctionsButton" .. i]
			local AuctionsButtonIcon = _G["AuctionsButton" .. i .. "Item"]

			_G["AuctionsButton" .. i .."ItemIconTexture"]:SetTexCoord(G.Coords())  -- ElvUI Version
			hooksecurefunc(_G["AuctionsButton" .. i .."ItemIconTexture"], "SetTexCoord", function(self, x1, y1, x2, y2)
				local x3, y3, x4, y4 = G.Coords()

				if (x1 ~= x3 or y1 ~= y3 or x2 ~= x4 or y2 ~= y4) then
					self:SetTexCoord(G.Coords())
				end
			end)

			AuctionsButtonIcon:Strip()
			AuctionsButtonIcon:StyleButton()
			AuctionsButtonIcon:Template("TRANSPARENT")
			AuctionsButtonIcon:GetNormalTexture():SetTexCoord(G.Coords())
			AuctionsButtonIcon:GetNormalTexture():SetInside()

			AuctionsButton:Strip()
			AuctionsButton:StyleButton()
			_G["AuctionsButton" .. i .. "Highlight"] = AuctionsButton:GetHighlightTexture()
			AuctionsButton:GetHighlightTexture():Point('TOPLEFT', AuctionsButtonIcon, 'TOPRIGHT', 2, 0)
			AuctionsButton:GetHighlightTexture():Point('BOTTOMRIGHT', AuctionsButton, 'BOTTOMRIGHT', -2, 5)
			AuctionsButton:GetPushedTexture():SetAllPoints(AuctionsButton:GetHighlightTexture())
		end
	end


	SkinAuctionFrame = function()

		-- Scroll Frames
		BrowseFilterScrollFrame:Strip()	--1
		BrowseScrollFrame:Strip()
		BidScrollFrame:Strip()			--2
		AuctionsScrollFrame:Strip()		--3

		-- Auction Frame
		AuctionFrame:Strip(true)
		AuctionFrame:Template("TRANSPARENT")
		AuctionFrame:Shadow()
		A.MakeMovable(AuctionFrame)

		-- Close Button
		AuctionFrameCloseButton:SkinCloseButton()
		AuctionFrameCloseButton:Point('TOPRIGHT', AuctionFrame, -MARGIN, -MARGIN)

		-- Tabs
		AuctionFrameTab1:Point('TOPLEFT', AuctionFrame, 'BOTTOMLEFT', MARGIN, 0)		-- -2)
		AuctionFrameTab2:Point('TOPLEFT', AuctionFrameTab1, 'TOPRIGHT', PAD, 0)
		AuctionFrameTab3:Point('TOPLEFT', AuctionFrameTab2, 'TOPRIGHT', PAD, 0)

		for i = 1, (AuctionFrame.numTabs) do
			_G["AuctionFrameTab" .. i]:Size(100, 30)
			_G["AuctionFrameTab" .. i]:SkinTab()
		end
	end


	SkinPanels = function()
		AuctionFrameBrowse.Background1 = CreateFrame('Frame', "bg1", AuctionFrameBrowse)
		AuctionFrameBrowse.Background1:Template("C")
		AuctionFrameBrowse.Background1:Point('TOPLEFT', MARGIN, -103) -- 20, -103)
		AuctionFrameBrowse.Background1:Point('BOTTOMRIGHT', -575, (BUTTON_HEIGHT + MARGIN + PAD))

		AuctionFrameBrowse.Background2 = CreateFrame('Frame', "bg2", AuctionFrameBrowse)
		AuctionFrameBrowse.Background2:Template("C")
		AuctionFrameBrowse.Background2:Point('TOPLEFT', AuctionFrameBrowse.Background1, 'TOPRIGHT', PAD, 0)							-- 4, 0)
		AuctionFrameBrowse.Background2:Point('BOTTOMRIGHT', AuctionFrame, -MARGIN, (BUTTON_HEIGHT + MARGIN + PAD)) 	-- 40) -- -8, 40)

		AuctionFrameBid.Background = CreateFrame('Frame', "AuctionFrameBid_Background", AuctionFrameBid)
		AuctionFrameBid.Background:Template("TRANSPARENT")
		AuctionFrameBid.Background:Point('TOPLEFT', AuctionFrame, MARGIN, -72)														-- 22, -72)
		AuctionFrameBid.Background:Point('BOTTOMRIGHT', AuctionFrame, -MARGIN, (BUTTON_HEIGHT + MARGIN + PAD))		-- 66, 40) -- 39)

		AuctionFrameAuctions.Background1 = CreateFrame('Frame', "AuctionFrameAuctions_Background1", AuctionFrameAuctions)
		AuctionFrameAuctions.Background1:SetFrameLevel(AuctionFrameAuctions.Background1:GetFrameLevel() - 2)
		AuctionFrameAuctions.Background1:Template("TRANSPARENT")
		AuctionFrameAuctions.Background1:Point('TOPLEFT', MARGIN, -70)																-- 15, -70)
		AuctionFrameAuctions.Background1:Point('BOTTOMRIGHT', -545, (BUTTON_HEIGHT + MARGIN + PAD))						-- 35)

		AuctionFrameAuctions.Background2 = CreateFrame('Frame', "AuctionFrameAuctions_Background2", AuctionFrameAuctions)
		AuctionFrameAuctions.Background2:SetFrameLevel(AuctionFrameAuctions.Background2:GetFrameLevel() - 2)
		AuctionFrameAuctions.Background2:Template("TRANSPARENT")
		AuctionFrameAuctions.Background2:Point('TOPLEFT', AuctionFrameAuctions.Background1, 'TOPRIGHT', PAD, 0) 						-- 3, 0)
		AuctionFrameAuctions.Background2:Point('BOTTOMRIGHT', AuctionFrame, -MARGIN, (BUTTON_HEIGHT + MARGIN + PAD))	-- -8, 35)

		-- Fix Scrolls
		local h = BrowseFilterScrollFrame:GetHeight()
		local w = BrowseFilterScrollFrame:GetWidth() + 1
		print(h)
		BrowseFilterScrollFrame:Height(h)		--(304)			--1
		--	 BrowseFilterScrollFrame:Point('TOPLEFT', bg1, 'TOPRIGHT', PAD, -16)
		BrowseFilterScrollFrame:ClearAllPoints()
		BrowseFilterScrollFrame:SetPoint('TOPRIGHT', "bg1", 'TOPRIGHT', -1, -1)
		BrowseFilterScrollFrame:SetPoint('BOTTOMLEFT', "bg1", 'BOTTOMRIGHT', -w, 1)


		BrowseScrollFrame:Height(304)					--2
		BidScrollFrame:Height(336) 			-- (332)	--2
		AuctionsScrollFrame:Height(342) 		-- (336)	--3

		-- Scrollbars
		BrowseFilterScrollFrameScrollBar:SkinScrollBar()	--1
		BrowseScrollFrameScrollBar:SkinScrollBar()		--1
		BidScrollFrameScrollBar:SkinScrollBar()			--2
		AuctionsScrollFrameScrollBar:SkinScrollBar()		--3
	end

--[[ Sort Button Textures

	BrowseQualitySortLeft  		Interface\FriendsFrame\WhoFrame-ColumnTabs
	BrowseQualitySortRight  		Interface\FriendsFrame\WhoFrame-ColumnTabs
	BrowseQualitySortMiddle  	Interface\FriendsFrame\WhoFrame-ColumnTabs
	BrowseQualitySortArrow  		Interface\Buttons\UI-SortArrow
							Interface\PaperDollInfoFrame\UI-Character-Tab-Highlight
							Color-999999f

--]]


	SkinObjectItems = function()					-- Buttons, ScrollBars, Tabs, etc.
		local SortingButtons = {
			"BrowseCurrentBidSort",	--1
			"BrowseDurationSort",
			"BrowseHighBidderSort",
			"BrowseLevelSort",
			"BrowseQualitySort",
			"BidQualitySort",		--2
			"BidLevelSort",
			"BidDurationSort",
			"BidBuyoutSort",
			"BidStatusSort",
			"BidBidSort",
			"AuctionsQualitySort",	--3
			"AuctionsDurationSort",
			"AuctionsHighBidderSort",
			"AuctionsBidSort",
		} for _, Button in pairs(SortingButtons) do
			local self = _G[Button]

			--	 if (self.SetHighlightTexture) then self:SetHighlightTexture('') end

			self.highlight = self:CreateTexture("Frame", nil, self)
			self.highlight:SetTexture(1, 1, 1, 0.35)
			self.highlight:SetInside()
			self:SetHighlightTexture(self.highlight)

			self:Border("TOP")

			_G[Button .. "Text"]:SetWidth(_G[Button]:GetWidth())
			_G[Button .. "Text"]:SetJustifyH('CENTER')
		end

		-- Money Frame
		AuctionFrameMoneyFrame:Height(BUTTON_HEIGHT)
		AuctionFrameMoneyFrame:Point('BOTTOMLEFT', AuctionFrame, MARGIN, MARGIN)

		-- Money Bar (Bottom)
		BrowseBidPrice:Height(BUTTON_HEIGHT)
		BrowseBidPrice:Point('BOTTOM', AuctionFrame, 25, MARGIN)
		BrowseBidText:Point('RIGHT', BrowseBidPrice, 'LEFT', -PAD, 0)


		-- Buttons
		local StandardButtons = {
			"BrowseBidButton",		--1
			"BrowseBuyoutButton",
			"BrowseCloseButton",
			"BrowseResetButton",
			"BrowseSearchButton",
			"BidCloseButton",		--2
			"BidBidButton",
			"BidBuyoutButton",
			"AuctionsCloseButton",	--3
			"AuctionsCancelAuctionButton",
			"AuctionsCreateAuctionButton",
			"AuctionsNumStacksMaxButton",
			"AuctionsStackSizeMaxButton",
		} for _, button in ipairs(StandardButtons) do
			_G[button]:SkinButton()
		end

		-- 1

		-- Frame
		BrowseTitle:Point('BOTTOM', AuctionFrame, 'TOP', 0, MARGIN)
		BrowseSearchCountText:Point('BOTTOM', 80, 53)
		BrowseNoResultsText:Point('TOP', 115, -120)
		BrowseSearchDotsText:Point('LEFT', BrowseNoResultsText, 'RIGHT', 0, 0)

		-- Item Name
		BrowseName:Point('TOPLEFT', AuctionFrame, MARGIN, -(MARGIN * 3))
		BrowseNameText:Point('BOTTOMLEFT', BrowseName, 'TOPLEFT', 0, PAD)

		-- Reset: Button
		BrowseResetButton:Size(BUTTON_WIDTH, BUTTON_HEIGHT)
		BrowseResetButton:Point('TOPRIGHT', BrowseName, 'BOTTOMRIGHT', 0, -PAD)

		-- Level Range
		BrowseMinLevel:Point('TOPLEFT', BrowseName, 'TOPRIGHT', PAD, 0)
		BrowseLevelHyphen:Point('LEFT', BrowseMinLevel, 'RIGHT', PAD, 0)
		BrowseMaxLevel:Point('LEFT', BrowseLevelHyphen, 'RIGHT', PAD, 0)
		BrowseLevelText:Point('BOTTOMLEFT', BrowseMinLevel, 'TOPLEFT', PAD, PAD)
		BrowseLevelText:SetJustifyH('LEFT')

		-- Dropdown
		BrowseDropDown:SkinDropDownBox()
		BrowseDropDown:Point('TOPLEFT', BrowseMaxLevel, 'TOPRIGHT', (PAD * 2), -1)
		BrowseDropDownName:Point('BOTTOMLEFT', BrowseDropDown, 'TOPLEFT', 0, PAD)
		BrowseDropDownName:SetJustifyH('LEFT')

		-- IsUsable: Checkbutton
		IsUsableCheckButton:Size(CHECKBUTTON_SIZE)
		IsUsableCheckButton:Point('TOPLEFT', BrowseDropDown, 'TOPRIGHT', PAD, 0)
		IsUsableCheckButton:SkinCheckButton()
		IsUsableCheckButtonText:Point('LEFT', IsUsableCheckButton, 'RIGHT', PAD, 0)

		-- ShowOnPlayer: Checkbutton
		ShowOnPlayerCheckButton:Size(CHECKBUTTON_SIZE)
		ShowOnPlayerCheckButton:Point('TOP', IsUsableCheckButton, 'BOTTOM', 0, -PAD)
		ShowOnPlayerCheckButton:SkinCheckButton()
		ShowOnPlayerCheckButtonText:Point('LEFT', ShowOnPlayerCheckButton, 'RIGHT', PAD, 0)

		-- Next: Button
		BrowseNextPageButton:Point('TOPRIGHT', AuctionFrameCloseButton, 'BOTTOMLEFT', -30, -MARGIN)
		BrowseNextPageButton:SkinPageButton("RIGHT")
		--	 BrowseNextPageButton:SkinPageButton("HORIZONTAL")
		BrowseNextPageButton:Size(BUTTON_HEIGHT)

		-- Search: Button
		BrowseSearchButton:Size(BUTTON_WIDTH, BUTTON_HEIGHT)
		BrowseSearchButton:Point('TOPRIGHT', BrowseNextPageButton, 'TOPLEFT', -25, 0)

		-- Prev: Button
		BrowsePrevPageButton:Point('TOPRIGHT', BrowseSearchButton, 'TOPLEFT', -25, 0)
		BrowsePrevPageButton:SkinPageButton("LEFT")
		--	 BrowsePrevPageButton:SkinPageButton("HORIZONTAL")
		BrowsePrevPageButton:Size(BUTTON_HEIGHT)

		-- Filter Buttons
		AuctionFilterButton1:Point('TOPLEFT', AuctionFrameBrowse.Background1, 0, 0)
		AuctionFilterButton1:Point('TOPRIGHT', AuctionFrameBrowse.Background1, -(SCROLLBAR_WIDTH + PAD), 0)

		-- [ BrowseBidButton ] [ BrowseBuyoutButton ] [ BrowseCloseButton ]
		BrowseCloseButton:Size(BUTTON_WIDTH, BUTTON_HEIGHT)
		BrowseCloseButton:Point('BOTTOMRIGHT', AuctionFrame, -MARGIN, MARGIN)
		BrowseBuyoutButton:Size(BUTTON_WIDTH, BUTTON_HEIGHT)
		BrowseBuyoutButton:Point('RIGHT', BrowseCloseButton, 'LEFT', -PAD, 0)
		BrowseBidButton:Size(BUTTON_WIDTH, BUTTON_HEIGHT)
		BrowseBidButton:Point('RIGHT', BrowseBuyoutButton, 'LEFT', -PAD, 0)


		-- 2

		-- Money Bar (Bottom)
		BidBidPrice:Height(BUTTON_HEIGHT)
		BidBidPrice:Point('BOTTOM', AuctionFrame, 'BOTTOM', 25, MARGIN)
		BidBidText:Point('RIGHT', BidBidPrice, 'LEFT', -PAD, 0)		-- FontString

		--  [ BidBidButton ] [ BidBuyoutButton ] [ BidCloseButton ]
		BidCloseButton:Size(BUTTON_WIDTH, BUTTON_HEIGHT)
		BidCloseButton:Point('BOTTOMRIGHT', AuctionFrame, -MARGIN, MARGIN)
		BidBuyoutButton:Size(BUTTON_WIDTH, BUTTON_HEIGHT)
		BidBuyoutButton:Point('RIGHT', BidCloseButton, 'LEFT', -PAD, 0)
		BidBidButton:Size(BUTTON_WIDTH, BUTTON_HEIGHT)
		BidBidButton:Point('RIGHT', BidBuyoutButton, 'LEFT', -PAD, 0)


		-- 3

		-- Item Button
		AuctionsItemButton:Strip()
		AuctionsItemButton:StyleButton()
		AuctionsItemButton:Template("TRANSPARENT", true)
		AuctionsItemButton:SetScript("OnUpdate", function()
			if (AuctionsItemButton:GetNormalTexture()) then
				AuctionsItemButton:GetNormalTexture():SetTexCoord(G.Coords())
				AuctionsItemButton:GetNormalTexture():SetInside()
			end
		end)

		-- Price
		PriceDropDown:SkinDropDownBox(100)
		PriceDropDown:Point('BOTTOMRIGHT', AuctionFrameAuctions.Background1, 'RIGHT', -(PriceDropDownButton:GetWidth() + MARGIN), 0)

		StartPrice:Point('TOPRIGHT', AuctionFrameAuctions.Background1, 'RIGHT', -MARGIN, -PAD)
		BuyoutPrice:Point('TOPRIGHT', StartPrice, 'BOTTOMRIGHT', 0, -20)

		-- Duration
		DurationDropDown:SkinDropDownBox(100)
		DurationDropDown:Point('BOTTOMRIGHT', AuctionsDepositMoneyFrame, 'TOPRIGHT', -DurationDropDownButton:GetWidth(), PAD)

		-- Deposit
		AuctionsDepositText:Point('BOTTOMLEFT', AuctionsCreateAuctionButton, 'TOPLEFT', 0, PAD)
		AuctionsDepositMoneyFrame:Point('LEFT', AuctionsDepositText, 'RIGHT', PAD, 0)
		AuctionsDepositMoneyFrame:Point('BOTTOMRIGHT', AuctionsCreateAuctionButton, 'TOPRIGHT', 0, PAD)

		-- Create
		AuctionsCreateAuctionButton:Height(BUTTON_HEIGHT)
		AuctionsCreateAuctionButton:Point('BOTTOMLEFT', AuctionFrameAuctions.Background1, MARGIN, MARGIN)
		AuctionsCreateAuctionButton:Point('BOTTOMRIGHT', AuctionFrameAuctions.Background1, -MARGIN, MARGIN)

		-- [ AuctionsCancelAuctionButton ] [ AuctionsCloseButton ]
		AuctionsCloseButton:Size(BUTTON_WIDTH, BUTTON_HEIGHT)
		AuctionsCloseButton:Point('BOTTOMRIGHT', AuctionFrame, 'BOTTOMRIGHT', -MARGIN, MARGIN)
		AuctionsCancelAuctionButton:Size(126, BUTTON_HEIGHT)
		AuctionsCancelAuctionButton:Point('RIGHT', AuctionsCloseButton, 'LEFT', -PAD, 0)



		-- Filter Buttons
		for i = 1, (NUM_FILTERS_TO_DISPLAY) do
			_G["AuctionFilterButton" .. i]:Strip()
			_G["AuctionFilterButton" .. i]:StyleButton(true)
		end

		-- Editboxes
		local Editboxes = {
			"BrowseName",				--1
			"BrowseMinLevel",
			"BrowseMaxLevel",
			"BrowseBidPriceGold",
			"BrowseBidPriceSilver",
			"BrowseBidPriceCopper",
			"BidBidPriceGold",			--2
			"BidBidPriceSilver",
			"BidBidPriceCopper",
			"AuctionsStackSizeEntry",	--3
			"AuctionsNumStacksEntry",
			"BuyoutPriceGold",
			"BuyoutPriceSilver",
			"BuyoutPriceCopper",
			"StartPriceGold",
			"StartPriceSilver",
			"StartPriceCopper",
		}
		for _, Editbox in ipairs(Editboxes) do
			_G[Editbox]:SkinEditBox()
			_G[Editbox]:SetTextInsets(1, 1, -1, 1)
		end

		AuctionsStackSizeEntry.backdrop:SetAllPoints()
		AuctionsNumStacksEntry.backdrop:SetAllPoints()
	end


	SkinDressUpFrame = function()
		SideDressUpFrame:HookScript("OnShow", function(self)
			self:Strip(true)
			SideDressUpFrame:Template("TRANSPARENT")
			SideDressUpFrame:Point('LEFT', AuctionFrame, 'RIGHT', PAD, 0)
		end)

		SideDressUpModelCloseButton:SkinCloseButton()
		SideDressUpModelCloseButton:Point('TOPRIGHT', SideDressUpFrame, -MARGIN, -MARGIN)

		SideDressUpModelResetButton:SkinButton()
		SideDressUpModelResetButton:Point('BOTTOM', SideDressUpFrame, 0, MARGIN)
	end


	SkinProgressFrame = function()
		AuctionProgressFrame:Strip()
		AuctionProgressFrame:Template("TRANSPARENT")

		AuctionProgressBarIcon:SetTexCoord(G.Coords())

		local Backdrop = CreateFrame('Frame', nil, AuctionProgressBarIcon:GetParent())
		Backdrop:SetOutside(AuctionProgressBarIcon)
		Backdrop:Template("TRANSPARENT")
		AuctionProgressBarIcon:SetParent(Backdrop)

		AuctionProgressBarText:Point("CENTER")

		AuctionProgressBar:Strip()
		AuctionProgressBar:Backdrop()
		AuctionProgressBar:SetStatusBarTexture(A.default.statusbar.texture)
		AuctionProgressBar:SetStatusBarColor(1, 1, 0)

		AuctionProgressFrameCancelButton:StyleButton()
		AuctionProgressFrameCancelButton:Template("DEFAULT")
		AuctionProgressFrameCancelButton:SetHitRectInsets(0, 0, 0, 0)
		AuctionProgressFrameCancelButton:GetNormalTexture():SetInside()
		AuctionProgressFrameCancelButton:GetNormalTexture():SetTexCoord(0.67, 0.37, 0.61, 0.26)
		AuctionProgressFrameCancelButton:Size(28, 28)
		AuctionProgressFrameCancelButton:Point('LEFT', AuctionProgressBar, 'RIGHT', 8, 0)
	end

	--[[ local f = CreateFrame('Frame')
		f:RegisterEvent('ADDON_LOADED')
		f:SetScript('OnEvent', function(self, event, addon)
			if (addon == "Blizzard_AuctionUI") then
				SkinItemButtons()
				SkinAuctionFrame()
				SkinPanels()
				SkinObjectItems()
				SkinDressUpFrame()
				SkinProgressFrame()
				self:UnregisterEvent('ADDON_LOADED')
			end
		end)
	--]]
end


Skin = function()
	SkinItemButtons()
	SkinAuctionFrame()
	SkinPanels()
	SkinObjectItems()
	SkinDressUpFrame()
	SkinProgressFrame()
end

G.SkinFuncs["Blizzard_AuctionUI"] = Skin


-- A.print("Skin", "Auction", "Loaded")


----------------------------------------------------------------------------------------------------
--	Black Market UI
----------------------------------------------------------------------------------------------------
if (not C["Skin"]["Enable"] or not C["Skin"]["BlackMarket"]["Enable"]) then
	return
end


local SkinBlackMarketFrame, SkinBlackMarketItemButtons

do
	SkinBlackMarketFrame = function()
		BlackMarketFrame:Strip()
		BlackMarketFrame.Inset:Strip()
		BlackMarketFrame:Template("TRANSPARENT")

		BlackMarketScrollFrameScrollBar:SkinScrollBar()

		BlackMarketFrame.MoneyFrameBorder:Strip()

		BlackMarketBidPriceGold:SkinEditBox()
		BlackMarketBidPriceGold:SetHeight(18)

		BlackMarketFrame.BidButton:SkinButton()
		BlackMarketFrame.BidButton:SetHeight(20)

		BlackMarketFrame.HotDeal:Strip()
		BlackMarketFrame.HotDeal.Item.IconTexture:SetTexCoord(G.Coords()) -- (0.1, 0.9, 0.1, 0.9)
		BlackMarketFrame.HotDeal.Item:Backdrop("DEFAULT")
		BlackMarketFrame.HotDeal.Item:StyleButton()
		BlackMarketFrame.HotDeal.Item.hover:SetAllPoints()
		BlackMarketFrame.HotDeal.Item.pushed:SetAllPoints()

		BlackMarketFrame.CloseButton:SkinCloseButton()

		local Tabs = {
			"ColumnName",
			"ColumnLevel",
			"ColumnType",
			"ColumnDuration",
			"ColumnHighBidder",
			"ColumnCurrentBid",
		}

		for _, Tab in pairs(Tabs) do
			BlackMarketFrame[Tab]:Strip()			-- local tab = BlackMarketFrame[tab] -- tab:Strip()
		end


		SkinBlackMarketItemButtons = function()

			local buttons  = BlackMarketScrollFrame.buttons
			local offset   = HybridScrollFrame_GetOffset(BlackMarketScrollFrame)
			local numItems = C_BlackMarket.GetNumItems()

			for i = 1, (#buttons) do
				local button = buttons[i]
				local index = offset + i

				if (not button.skinned) then
					button:Strip()

					button.Item:Strip()
					button.Item:StyleButton()
					button.Item:Template("DEFAULT")

					button.Item.IconTexture:SetTexCoord(G.Coords()) -- (0.1, 0.9, 0.1, 0.9)
					-- button.Item.IconTexture:ClearAllPoints()
					-- button.Item.IconTexture:SetPoint("TOPLEFT", 2, -2)
					-- button.Item.IconTexture:SetPoint("BOTTOMRIGHT", -2, 2)
					button.Item.IconTexture:SetInside()

					button:SetHighlightTexture(C.media.texture)
					button:GetHighlightTexture():SetVertexColor(0.243, 0.570, 1, 0.2)

					button.skinned = true
				end


				if (button:IsShown() and button.itemLink) then
					local _, _, quality = GetItemInfo(button.itemLink)
					button.Name:SetTextColor(GetItemQualityColor(quality))
				end


				if (index <= numItems) then
					local name, texture = C_BlackMarket.GetItemInfoByIndex(index)
					if (name) then
						button.Item.IconTexture:SetTexture(texture)
					end
				end
			end
		end


		hooksecurefunc("BlackMarketScrollFrame_Update", SkinBlackMarketItemButtons)
		BlackMarketScrollFrame:HookScript("OnVerticalScroll", SkinBlackMarketItemButtons)
		BlackMarketScrollFrame:HookScript("OnMouseWheel", SkinBlackMarketItemButtons)


		hooksecurefunc("BlackMarketFrame_UpdateHotItem", function(self)
			local hotDeal = self.HotDeal
			if (hotDeal:IsShown() and hotDeal.itemLink) then
				local _, _, quality = GetItemInfo(hotDeal.itemLink)
				hotDeal.Name:SetTextColor(GetItemQualityColor(quality))
			end
		end)

	end

	--[[ local f = CreateFrame('Frame')
		f:RegisterEvent('ADDON_LOADED')
		f:SetScript('OnEvent', function(self, event, addon)
			if (addon == "Blizzard_BlackMarketUI") then
				SkinBlackMarketFrame()
				SkinBlackMarketItemButtons()
				self:UnregisterEvent('ADDON_LOADED')
			end
		end)	--]]
end


Skin = function()
	SkinBlackMarketFrame()
	SkinBlackMarketItemButtons()
end

G.SkinFuncs["Blizzard_BlackMarketUI"] = Skin


----------------------------------------------------------------------------------------------------
--	Backup
----------------------------------------------------------------------------------------------------
--[[ Print Region Text & Name

	for i = 1, (AuctionFrameBrowse:GetNumRegions()) do
		local region = select(i, AuctionFrameBrowse:GetRegions())
		if (region:GetObjectType() == "FontString") then
			print(region:GetText(), region:GetName())
		end
	end
--]]

--[[ ScrollFrame API Notes

	  > ScrollFrame  	The frame actually doing the visual clipping of its contents
					Although the scroll frame provides an API for scrolling horiz & vertically,
					it does not provide any scroll bars on its own.

	  > ScrollChild 	A frame that contains the contents

--]]


