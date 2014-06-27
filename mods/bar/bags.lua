local A, C, G, L = select(2, ...):Unpack()

if (not C["Bar"]["Enable"] or not C["Bar"]["Bags"]["Enable"]) then
	return
end




local ShowBagEvents, CloseBagEvents, BankEvents, OnEvent

do
	local NUM_BAG_FRAMES = NUM_BAG_FRAMES
	local NUM_CONTAINER_FRAMES = NUM_CONTAINER_FRAMES
	local ContainerFrame1 = ContainerFrame1
	local CloseBag, OpenBag = CloseBag, OpenBag
	local CloseAllBags, OpenAllBags = CloseAllBags, OpenAllBags


	ShowBagEvents = {
		["BANKFRAME_OPENED"]		= true,
		["AUCTION_HOUSE_SHOW"]		= true,
		["GUILDBANKFRAME_OPENED"]	= true,
		["MAIL_SHOW"]				= true,
		["MERCHANT_SHOW"]			= true,
		["TRADE_SHOW"]				= true,
		["SOCKET_INFO_UPDATE"]		= true,	-- gem socketing
	}

	CloseBagEvents = {
		["BANKFRAME_CLOSED"]		= true,
		["AUCTION_HOUSE_CLOSED"]		= true,	-- closing the auction window
		["GUILDBANKFRAME_CLOSED"]	= true,	-- closing the guild-banking window
		["MAIL_CLOSED"]			= false,	-- closing the mail window
		["MERCHANT_CLOSED"]			= true,	-- closing the merchant window
		["TRADE_CLOSED"]			= true,	-- closing the trade window
		["SOCKET_INFO_CLOSE"]		= true,	-- closing the gem socketing window
	}

	BankEvents = {
		["BANKFRAME_OPENED"]		= true,
		["BANKFRAME_CLOSED"]		= true,
	}


	OnEvent = function(self, event)
		if (ShowBagEvents[event]) then		-- Show Bags
			OpenAllBags(self)
			if (BankEvents[event]) then
				for i = NUM_BAG_FRAMES + 1, (NUM_CONTAINER_FRAMES) do
					OpenBag(i)
				end
			end
		end
		if (CloseBagEvents[event]) then		-- Close Bags
			ContainerFrame1.backpackWasOpen = nil
			CloseAllBags(self)
			if (BankEvents[event]) then
				for i = NUM_BAG_FRAMES + 1, (NUM_CONTAINER_FRAMES) do
					CloseBag(i)
				end
			end
		end
	end


	local F = CreateFrame('Frame')			-- 'TruthBags')
	F:SetScript("OnEvent", OnEvent)

	for event in pairs(ShowBagEvents) do
		F:RegisterEvent(event)
	end
	for event in pairs(CloseBagEvents) do
		F:RegisterEvent(event)
	end
end


A.print("Bar", "Bags", "Loaded")


--------------------------------------------------
--	Credit
--------------------------------------------------
--[[	Title:	_AllBags or Bags_and_Merchants (Curse name)
	Author:	Elkano
	Notes:	Opens/Closes all bags when at merchant
			(instead of only the backpack)
--]]
--------------------------------------------------

