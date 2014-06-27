local A, C, G, L = select(2, ...):Unpack()

if (not C["Skin"]["Enable"] or not C["Skin"]["Auction"]["Enable"]) then
	return
end

local select, unpack = select, unpack
local ipairs, pairs = ipairs, pairs
local find = string.find

--	WORKING MACROS
--	/script Auction_LoadUI() ShowUIPanel(AuctionFrame)
--	/script BlackMarket_LoadUI() ShowUIPanel(BlackMarketFrame)
local MARGIN, PAD = G.MARGIN, G.PAD
local BUTTON_WIDTH = G.BUTTON_WIDTH or 80
local BUTTON_HEIGHT = G.BUTTON_HEIGHT or 22
local CHECKBUTTON_SIZE = G.CHECKBUTTON_SIZE or 20
local SCROLLBAR_WIDTH = G.SCROLLBAR_WIDTH or 28
local SCROLLBAR_BUTTON_SIZE = G.SCROLLBAR_BUTTON_SIZE or 16


-- Private
local Skin
local SkinAuctionFrame, SkinDressUpFrame
local SkinItemButtons, SkinObjectItems
local SkinPanels, SkinProgressFrame



SkinItemButtons = function()
	for i = 1, (NUM_BROWSE_TO_DISPLAY) do
		local Row		= _G[("BrowseButton%d"):format(i)]
		local Icon	= _G[("BrowseButton%dItem"):format(i)]
		local Texture	= _G[("BrowseButton%dItemIconTexture"):format(i)]

		if (Texture) then
			Texture:SkinTexture()
		--	Texture:SetTexCoord(G.TexCoords:Unpack())
		--	Texture:SetInside()
		end

		if (Icon) then
			Icon:StyleItemButton()
		--	Icon:StyleButton()
		--	Icon:Template("TRANSPARENT")
		--	Icon:GetNormalTexture():SetTexCoord(G.TexCoords:Unpack())
		--	Icon:GetNormalTexture():SetInside()
		end

		if (Row) then
			Row:StyleButton()
			_G[("BrowseButton%dHighlight"):format(i)] = Row:GetHighlightTexture()
			Row:GetHighlightTexture():Point('TOPLEFT', Icon, 2, 0)
			Row:GetHighlightTexture():Point('BOTTOMRIGHT', Row, -2, 5)
			Row:GetPushedTexture():SetAllPoints(Row:GetHighlightTexture())
		end
	end
end


local SkinItemButtons_2 = function()

	-- Bid Frame

	for i = 1, (NUM_BIDS_TO_DISPLAY) do
		local BidButton					= _G["BidButton" .. i]
		local BidButtonHighlightTexture		= _G["BidButton" .. i .. "Highlight"]

		local Item						= _G["BidButton" .. i .. "Item"]
		local IconTexture					= _G["BidButton" .. i .. "ItemIconTexture"]

		IconTexture:SetTexCoord(G.TexCoords:Unpack())									-- _G["BidButton" .. i .. "ItemIconTexture"]:SetTexCoord(G.TexCoords:Unpack())
		IconTexture:SetInside()														-- _G["BidButton" .. i .. "ItemIconTexture"]:SetInside()

		Item:StyleButton()
		Item:Template("TRANSPARENT")
		Item:GetNormalTexture():SetTexCoord(G.TexCoords:Unpack())
		Item:GetNormalTexture():SetInside()

		BidButton:StyleButton()
		BidButtonHighlightTexture = BidButton:GetHighlightTexture()

		BidButton:GetHighlightTexture():Point('TOPLEFT', Item, 'TOPRIGHT', 2, 0)
		BidButton:GetHighlightTexture():Point('BOTTOMRIGHT', BidButton, 'BOTTOMRIGHT', -2, 5)

		BidButton:GetPushedTexture():SetAllPoints(BidButton:GetHighlightTexture())
	end


	-- Auction Frames

	for i = 1, (NUM_AUCTIONS_TO_DISPLAY) do
		local Button    					= _G["AuctionsButton" .. i]
		local AuctionsButtonIcon				= _G["AuctionsButton" .. i .. "Item"]
		local ItemIconTexture				= _G["Button" .. i .."ItemIconTexture"]

		ItemIconTexture:SetTexCoord(G.TexCoords:Unpack())									-- _G["Button" .. i .."ItemIconTexture"]:SetTexCoord(G.TexCoords:Unpack())

		hooksecurefunc(_G["Button" .. i .."ItemIconTexture"], "SetTexCoord", function(self, x1, y1, x2, y2)
			local x3, y3, x4, y4 = G.TexCoords:Unpack()
			if (x1 ~= x3 or y1 ~= y3 or x2 ~= x4 or y2 ~= y4) then
				self:SetTexCoord(G.TexCoords:Unpack())
			end
		end)

		AuctionsButtonIcon:StyleButton()
		AuctionsButtonIcon:Template("TRANSPARENT")
		AuctionsButtonIcon:GetNormalTexture():SetTexCoord(G.TexCoords:Unpack())
		AuctionsButtonIcon:GetNormalTexture():SetInside()

		Button:StyleButton()
		_G["Button" .. i .. "Highlight"] = Button:GetHighlightTexture()
		Button:GetHighlightTexture():Point('TOPLEFT', AuctionsButtonIcon, 'TOPRIGHT', 2, 0)
		Button:GetHighlightTexture():Point('BOTTOMRIGHT', Button, 'BOTTOMRIGHT', -2, 5)
		Button:GetPushedTexture():SetAllPoints(Button:GetHighlightTexture())
	end
end


do
	local select, unpack = select, unpack
	local ipairs, pairs = ipairs, pairs
	local find = string.find

	Skin = function()

		AuctionFrameCloseButton:SkinCloseButton()


		AuctionFrame:Strip(true)
		AuctionFrame:Template("DEFAULT")


		AuctionsScrollFrame:Strip()
		BrowseFilterScrollFrame:Strip()
		BrowseScrollFrame:Strip()
		BidScrollFrame:Strip()


		BrowseDropDown:SkinDropDownBox()
		PriceDropDown:SkinDropDownBox()
		DurationDropDown:SkinDropDownBox()


		IsUsableCheckButton:SkinCheckButton(CHECKBUTTON_SIZE)
		ShowOnPlayerCheckButton:SkinCheckButton(CHECKBUTTON_SIZE)


		BrowseNextPageButton:SkinNextPrevButton("RIGHT")
		BrowsePrevPageButton:SkinNextPrevButton("LEFT")


		-- Normal Buttons
		do
			local Buttons = {
				['BrowseBidButton'] = BrowseBidButton,				--1
				['BrowseBuyoutButton'] = BrowseBuyoutButton,
				['BrowseCloseButton'] = BrowseCloseButton,
				['BrowseResetButton'] = BrowseResetButton,
				['BrowseSearchButton'] = BrowseSearchButton,
				['BidBidButton'] = BidBidButton,					--2
				['BidCloseButton'] = BidCloseButton,
				['BidBuyoutButton'] = BidBuyoutButton,
				['AuctionsCloseButton'] = AuctionsCloseButton,		--3
				['AuctionsCancelAuctionButton'] = AuctionsCancelAuctionButton,
				['AuctionsCreateAuctionButton'] = AuctionsCreateAuctionButton,
				['AuctionsNumStacksMaxButton'] = AuctionsNumStacksMaxButton,
				['AuctionsStackSizeMaxButton'] = AuctionsStackSizeMaxButton,
			}
			for ButtonName, Button in pairs(Buttons) do
				Button:SkinButton()
			end
		end


		-- Sort Buttons
		do
			local SortButtons = {
				['BrowseLevelSort'] = BrowseLevelSort,				--1
				['BrowseQualitySort'] = BrowseQualitySort,
				['BrowseDurationSort'] = BrowseDurationSort,
				['BrowseCurrentBidSort'] = BrowseCurrentBidSort,
				['BrowseHighBidderSort'] = BrowseHighBidderSort,
				['BidBidSort'] =  BidBidSort,						--2
				['BidLevelSort'] = BidLevelSort,
				['BidBuyoutSort'] = BidBuyoutSort,
				['BidStatusSort'] = BidStatusSort,
				['BidQualitySort'] = BidQualitySort,
				['BidDurationSort'] = BidDurationSort,
				['AuctionsBidSort'] = AuctionsBidSort,				--3
				['AuctionsQualitySort'] = AuctionsQualitySort,
				['AuctionsDurationSort'] = AuctionsDurationSort,
				['AuctionsHighBidderSort'] = AuctionsHighBidderSort,
			}
			for SortButtonName, SortButton in pairs(SortButtons) do
				SortButton.highlight = SortButton:CreateTexture('Frame', nil, SortButton)
				SortButton.highlight:SetTexture(1, 1, 1, 0.35)
				SortButton.highlight:SetInside()
				SortButton:SetHighlightTexture(SortButton.highlight)

				SortButton:Border("TOP")

				local Text = _G[("%sText"):format(SortButtonName)]
				Text:SetWidth(SortButton:GetWidth())
				Text:SetJustifyH("CENTER")
			end
		end


		-- Filter Buttons
		for i = 1, (NUM_FILTERS_TO_DISPLAY) do
			local FilterButton = _G["AuctionFilterButton" .. i]
			FilterButton:StyleButton()
		end


		-- Final Button Fixes
		BrowseBidButton:Point('RIGHT', BrowseBuyoutButton, 'LEFT', -PAD, 0)			--1
		BrowseBuyoutButton:Point('RIGHT', BrowseCloseButton, 'LEFT', -PAD, 0)
		BrowseResetButton:Point('TOPLEFT', AuctionFrameBrowse, 'TOPLEFT', 81, -74)
		BrowseSearchButton:Point('TOPRIGHT', AuctionFrameBrowse, 'TOPRIGHT', 25, -34)
		BrowseCloseButton:Point('BOTTOMRIGHT', AuctionFrameBrowse, 66, PAD)
		BidBidButton:Point('RIGHT', BidBuyoutButton, 'LEFT', -PAD, 0)				--2
		BidBuyoutButton:Point('RIGHT', BidCloseButton, 'LEFT', -PAD, 0)
		BidCloseButton:Point('BOTTOMRIGHT', AuctionFrameBid, 66, PAD)

		AuctionsItemButton:StyleButton()										--3
		AuctionsItemButton:Template("DEFAULT")
		AuctionsItemButton:SetScript("OnUpdate", function()
			if (AuctionsItemButton:GetNormalTexture()) then
				AuctionsItemButton:GetNormalTexture():SetTexCoord(G.TexCoords:Unpack())
				AuctionsItemButton:GetNormalTexture():SetInside()
			end
		end)
		AuctionsCloseButton:Point('BOTTOMRIGHT', AuctionFrameAuctions, 66, PAD) --MARGIN)
		AuctionsCancelAuctionButton:Point('RIGHT', AuctionsCloseButton, 'LEFT', -PAD, 0)


		-- Dress Frame
		do
			local SideDressFrame	= _G["SideDressUpFrame"]
			local ResetButton		= _G["SideDressUpModelResetButton"]
			local CloseButton		= _G["SideDressUpModelCloseButton"]

			CloseButton:SkinCloseButton()
			CloseButton:Point("TOPRIGHT", SideDressFrame, -PAD, -PAD)

			ResetButton:SkinButton()
			ResetButton:Point("BOTTOM", SideDressFrame, 0, PAD)

			SideDressFrame:HookScript("OnShow", function(self)
				self:Strip(true)
				SideDressFrame:Template("TRANSPARENT")
				SideDressFrame:Point('LEFT', AuctionFrame, 'RIGHT', PAD, 0)
			end)

			local Model = _G["SideDressUpModel"]
			Model:Template("CLASSCOLOR")
			Model:Point("TOPLEFT", SideDressFrame, 0, -(CloseButton:GetHeight() + PAD + PAD))
			Model:Point("BOTTOMRIGHT", SideDressFrame, 0, (ResetButton:GetHeight() + PAD + PAD))

			----------------------------------------

			local SideDressUpControlButtons = {
				[1] = SideDressUpModelControlFrameZoomInButton,
				[2] = SideDressUpModelControlFrameZoomOutButton,
				[3] = SideDressUpModelControlFramePanButton,
				[4] = SideDressUpModelControlFrameRotateLeftButton,
				[5] = SideDressUpModelControlFrameRotateRightButton,
				[6] = SideDressUpModelControlFrameRotateResetButton,
			}

			-- Control Frame
			local ControlFrame = _G["SideDressUpModelControlFrame"]
			ControlFrame:Width((SideDressUpModelControlFrameZoomInButton:GetWidth() * #SideDressUpControlButtons) + (PAD * 2) + (PAD * 6))
			ControlFrame:Height(SideDressUpModelControlFrameZoomInButton:GetHeight() + (PAD * 2))
			ControlFrame:Point("TOP", Model, 0, -PAD)


			for i = 1, (#SideDressUpControlButtons) do
				local ControlButton  = SideDressUpControlButtons[i]

				ControlButton:SkinRotateButton()

				if (i == 1) then
					ControlButton:Point('LEFT', ControlFrame, PAD, 0)
				else
					ControlButton:Point('LEFT', SideDressUpControlButtons[i - 1], 'RIGHT', PAD, 0)
				end
			end
		end


		-- Progress Frame
		do
			local ProgressFrame		= AuctionProgressFrame
			local CancelButton		= AuctionProgressFrameCancelButton
			local ProgressBar		= AuctionProgressBar
			local ProgressBarIcon	= AuctionProgressBarIcon
			local ProgressBarText	= AuctionProgressBarText

			ProgressFrame:Strip()
			ProgressFrame:Template("DEFAULT")
			CancelButton:StyleButton()
			CancelButton:Template("DEFAULT")
			CancelButton:SetHitRectInsets(0, 0, 0, 0)
			CancelButton:GetNormalTexture():SetInside()
			CancelButton:GetNormalTexture():SetTexCoord(0.67, 0.37, 0.61, 0.26)
			CancelButton:Size(28, 28)
			CancelButton:Point('LEFT', ProgressBar, 'RIGHT', 8, 0)

			ProgressBar:Strip()
			ProgressBar:Backdrop("DEFAULT")
			ProgressBar:SetStatusBarTexture(A.default.statusbar.texture)
			ProgressBar:SetStatusBarColor(1, 1, 0)
			ProgressBarIcon:SetTexCoord(0.67, 0.37, 0.61, 0.26)
			local backdrop = CreateFrame('Frame', nil, ProgressBarIcon:GetParent())
			backdrop:Template("DEFAULT")
			backdrop:SetOutside(ProgressBarIcon)
			ProgressBarIcon:SetParent(backdrop)
			ProgressBarText:Point('CENTER')
		end


		-- Tabs
		do
			for i = 1, (AuctionFrame.numTabs) do
				local Tab = _G["AuctionFrameTab" .. i]

				Tab:SkinTab()

				if (i == 1) then
					Tab:Point('TOPLEFT', AuctionFrame, 'BOTTOMLEFT', PAD, 0)
				else
					Tab:Point('LEFT', _G["AuctionFrameTab" .. i - 1], 'RIGHT', 0, 0)
				end
			end
		end


		-- EditBoxes
		do
			local EditBoxes = {
				['BrowseName'] =  BrowseName,						--1
				['BrowseMinLevel'] = BrowseMinLevel,
				['BrowseMaxLevel'] = BrowseMaxLevel,
				['AuctionsStackSizeEntry'] = AuctionsStackSizeEntry,	--3
				['AuctionsNumStacksEntry'] = AuctionsNumStacksEntry,
			}
			for _, EditBox in pairs(EditBoxes) do
				EditBox:SkinEditBox()
			end


			local CurrencyEditBoxes = {
				['BrowseBidPrice']  = BrowseBidPrice,		--1
				['BidBidPrice']   	= BidBidPrice,			--2
				['StartPrice']   	= StartPrice,			--3
				['BuyoutPrice']   	= BuyoutPrice,
			}
			for CurrencyEditBoxName, CurrencyEditBox in pairs(CurrencyEditBoxes) do
				_G[("%sGold"):format(CurrencyEditBoxName)]:SkinEditBox()
				_G[("%sSilver"):format(CurrencyEditBoxName)]:SkinEditBox()
				_G[("%sCopper"):format(CurrencyEditBoxName)]:SkinEditBox()
			end

			BrowseMaxLevel:Point('LEFT', BrowseMinLevel, 'RIGHT', 3, 0)		-- 8, 0)

			AuctionsStackSizeEntry.backdrop:ClearAllPoints()
			AuctionsStackSizeEntry.backdrop:SetAllPoints()

			AuctionsNumStacksEntry.backdrop:ClearAllPoints()
			AuctionsNumStacksEntry.backdrop:SetAllPoints()
		end


		-- Item Buttons
		SkinItemButtons()


		-- Custom Backdrops
		AuctionFrameBrowse:Panel("CLASSCOLOR")
		AuctionFrameBrowse.panel:Point('TOPLEFT', 20, -103)
		AuctionFrameBrowse.panel:Point('BOTTOMRIGHT', -575, 40)
		AuctionFrameBrowse:Panel("CLASSCOLOR")
		AuctionFrameBrowse.panel[2]:Point('TOPLEFT', AuctionFrameBrowse.panel, 'TOPRIGHT', 4, 0)
		AuctionFrameBrowse.panel[2]:Point('BOTTOMRIGHT', AuctionFrame, 'BOTTOMRIGHT', -8, 40)
		AuctionFrameBid:Panel("CLASSCOLOR")
		AuctionFrameBid.panel:Point('TOPLEFT', 22, -72)
		AuctionFrameBid.panel:Point('BOTTOMRIGHT', 66, 39)
		AuctionFrameAuctions:Panel("CLASSCOLOR")
		AuctionFrameAuctions.panel:Point('TOPLEFT', 15, -70)
		AuctionFrameAuctions.panel:Point('BOTTOMRIGHT', -545, 35)
		AuctionFrameAuctions:Panel("CLASSCOLOR")
		AuctionFrameAuctions.panel[2]:Point('TOPLEFT', AuctionFrameAuctions.panel, 'TOPRIGHT', 3, 0)
		AuctionFrameAuctions.panel[2]:Point('BOTTOMRIGHT', AuctionFrame, -8, 35)


		-- Scroll Frames
		BrowseFilterScrollFrame:Height(300)
		BrowseScrollFrame:Height(300)
		BidScrollFrame:Height(332)
		AuctionsScrollFrame:Height(336)


		-- Scroll Bars
		AuctionsScrollFrameScrollBar:SkinScrollBar()
		BrowseFilterScrollFrameScrollBar:SkinScrollBar()
		BrowseScrollFrameScrollBar:SkinScrollBar()
		BidScrollFrameScrollBar:SkinScrollBar()
	end
end


G.SkinFuncs["Blizzard_AuctionUI"] = Skin



--------------------------------------------------
--[[ for i = 1, (AuctionFrameBrowse:GetNumRegions()) do
		local region = select(i, AuctionFrameBrowse:GetRegions())
		if (region:GetObjectType() == "FontString") then
			print(region:GetText(), region:GetName())
		end
	end
--]]
--------------------------------------------------


