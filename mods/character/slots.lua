local A, C, G, L = select(2, ...):Unpack()

if (not C["Character"]["Slots"]["Enable"]) then return end
local print = function(...) A.print('Char.Slots', ...) end

local select, unpack = select, unpack
local ipairs, pairs = ipairs, pairs
local floor = math.floor



-- Constant
local DURABILITY_FONT = {"Interface\\AddOns\\" .. AddOn .. "\\media\\font\\visitor.ttf", 16, "OUTLINE"}
-- local DURABILITY_FONT = C["Character"]["Slots"]["iDuraFont"]

local ITEM_LEVEL_FONT = {"Interface\\AddOns\\" .. AddOn .. "\\media\\font\\continuum.ttf", 16, "OUTLINE"}
-- local ITEM_LEVEL_FONT = C["Character"]["Slots"]["iLvlFont"]




--------------------------------------------------
--[[ Inventory Slots  (Constants.lua)

	INVSLOT_AMMO		= 0
	INVSLOT_HEAD 		= 1
	INVSLOT_FIRST_EQUIPPED = INVSLOT_HEAD
	INVSLOT_NECK		= 2
	INVSLOT_SHOULDER	= 3
	INVSLOT_BODY		= 4
	INVSLOT_CHEST		= 5
	INVSLOT_WAIST		= 6
	INVSLOT_LEGS		= 7
	INVSLOT_FEET		= 8
	INVSLOT_WRIST		= 9
	INVSLOT_HAND		= 10
	INVSLOT_FINGER1	= 11
	INVSLOT_FINGER2	= 12
	INVSLOT_TRINKET1	= 13
	INVSLOT_TRINKET2	= 14
	INVSLOT_BACK		= 15
	INVSLOT_MAINHAND	= 16
	INVSLOT_OFFHAND	= 17
	INVSLOT_RANGED		= 18
	INVSLOT_TABARD		= 19
	INVSLOT_LAST_EQUIPPED = INVSLOT_TABARD

--]]
--------------------------------------------------

-- Constant
local frame = {
	CharacterHeadSlot,
	CharacterNeckSlot,
	CharacterShoulderSlot,
	CharacterBackSlot,
	CharacterChestSlot,
	CharacterWristSlot,
	CharacterShirtSlot,
	CharacterTabardSlot,
	CharacterMainHandSlot,
	CharacterSecondaryHandSlot,
	CharacterHandsSlot,
	CharacterWaistSlot,
	CharacterLegsSlot,
	CharacterFeetSlot,
	CharacterFinger0Slot,
	CharacterFinger1Slot,
	CharacterTrinket0Slot,
	CharacterTrinket1Slot,
}

local slot = {
	"HeadSlot",
	"NeckSlot",
	"ShoulderSlot",
	"BackSlot",
	"ChestSlot",
	"WristSlot",
	"ShirtSlot",
	"TabardSlot",
	"MainHandSlot",
	"SecondaryHandSlot",
	"HandsSlot",
	"WaistSlot",
	"LegsSlot",
	"FeetSlot",
	"Finger0Slot",
	"Finger1Slot",
	"Trinket0Slot",
	"Trinket1Slot",
	 ------------  "MainHand", 'SecondaryHand",
}

----------------------------------------------------------------------------------------------------

-- Private
local iLow
local iHigh

local iAvg
local iEqAvg

local iDuraFrames = {}
local iQualityFrames = {}

----------------------------------------------------------------------------------------------------


local GetItemInfo = GetItemInfo
local GetInventoryItemID  = GetInventoryItemID
local GetInventorySlotInfo = GetInventorySlotInfo

local function fetchIlvl(slotName)
	local slotId, texture, checkRelic = GetInventorySlotInfo(slotName)
	local itemId = GetInventoryItemID("player", slotId)

	if (itemId) then
		local name, link, quality, iLevel, reqLevel, class, subclass, maxStack, equipSlot, texture, vendorPrice = GetItemInfo(itemId)
		return(iLevel)
	end
end


local GetInventoryItemDurability = GetInventoryItemDurability

local function fetchDura(slotName)
	local slotId, texture, checkRelic = GetInventorySlotInfo(slotName)

	if (slotId) then
		local itemDurability, itemMaxDurability = GetInventoryItemDurability(slotId)

		if (itemDurability) then
			return itemDurability, itemMaxDurability
		end
	end
end

local function makeText(frame)
	local ilvlText = frame:CreateFontString(nil, "ARTWORK")

	ilvlText:SetFont(ITEM_LEVEL_FONT[1], ITEM_LEVEL_FONT[2], ITEM_LEVEL_FONT[3])

	if (frame == CharacterHeadSlot or frame == CharacterNeckSlot or frame == CharacterShoulderSlot or frame == CharacterBackSlot or frame == CharacterChestSlot or frame == CharacterWristSlot or frame == CharacterShirtSlot or frame == CharacterTabardSlot) then
		ilvlText:SetPoint("CENTER", frame, 42, 0)
	elseif (frame == CharacterHandsSlot or frame == CharacterWaistSlot or frame == CharacterLegsSlot or frame == CharacterFeetSlot or frame == CharacterFinger0Slot or frame == CharacterFinger1Slot or frame == CharacterTrinket0Slot or frame == CharacterTrinket1Slot) then
		ilvlText:SetPoint("CENTER", frame, -42, 0)
	elseif (frame == CharacterMainHandSlot or frame == CharacterSecondaryHandSlot or frame == CharacterRangedSlot) then
		ilvlText:SetPoint("CENTER", frame, 0, 42)
	end

	frame.text = ilvlText
end


local function makeDurability(frame, slot)
	local iDura = iDuraFrames[slot]

	if (not iDura) then
		iDura = CreateFrame("Frame", "Durability", frame)		-- nil, frame)

		if (frame == CharacterHeadSlot or frame == CharacterNeckSlot or frame == CharacterShoulderSlot or frame == CharacterBackSlot or frame == CharacterChestSlot or frame == CharacterWristSlot or frame == CharacterShirtSlot or frame == CharacterTabardSlot) then
			iDura:SetPoint("BOTTOM", frame, "BOTTOM", 42, 0)
		elseif (frame == CharacterHandsSlot or frame == CharacterWaistSlot or frame == CharacterLegsSlot or frame == CharacterFeetSlot or frame == CharacterFinger0Slot or frame == CharacterFinger1Slot or frame == CharacterTrinket0Slot or frame == CharacterTrinket1Slot) then
			iDura:SetPoint("BOTTOM", frame, "BOTTOM", -42, 0)
		elseif (frame == CharacterMainHandSlot or frame == CharacterSecondaryHandSlot or frame == CharacterRangedSlot) then
			iDura:SetPoint("BOTTOM", frame, "BOTTOM", 0, 42)
		end

		iDura:SetSize(10, 10)
		iDura:SetBackdrop({
			tileSize	= 32,
			edgeSize 	= 0,
			insets 	= {left = 0, right = 0, top = 0, bottom = 0}})
		iDura:SetBackdropColor(0, 0, 0, 0)

		local iDuraText = iDura:CreateFontString(nil, "ARTWORK")

		iDuraText:SetFont(DURABILITY_FONT[1], DURABILITY_FONT[2], DURABILITY_FONT[3])

		iDuraText:SetPoint("CENTER", iDura, "CENTER", 0, 0)

		iDura.text = iDuraText


		local itemDurability, itemMaxDurability = fetchDura(slot)

		if (itemDurability) then
			local itemDurabilityPercentage = (itemDurability / itemMaxDurability) * 100

			if (itemDurabilityPercentage > 25) then
				iDura.text:SetFormattedText("|cFF00FF00%i%%", itemDurabilityPercentage)

			elseif (itemDurabilityPercentage > 0 and itemDurabilityPercentage <= 25) then
				iDura.text:SetFormattedText("|cFFFFFF00%i%%", itemDurabilityPercentage)

			elseif (itemDurabilityPercentage == 0) then
				iDura.text:SetFormattedText("|cFFFF0000%i%%", itemDurabilityPercentage)
			end

		else
			iDura.text:SetFormattedText("")
		end

		iDuraFrames[slot] = iDura

	else

		local itemDurability, itemMaxDurability = fetchDura(slot)

		if (itemDurability) then
			local itemDurabilityPercentage = (itemDurability / itemMaxDurability) * 100

			if (itemDurabilityPercentage > 25) then
				iDura.text:SetFormattedText("|cFF00FF00%i%%", itemDurabilityPercentage)

			elseif (itemDurabilityPercentage > 0 and itemDurabilityPercentage <= 25) then
				iDura.text:SetFormattedText("|cFFFFFF00%i%%", itemDurabilityPercentage)

			elseif (itemDurabilityPercentage == 0) then
				iDura.text:SetFormattedText("|cFFFF0000%i%%", itemDurabilityPercentage)
			end
		else
			iDura.text:SetFormattedText("")
		end

		iDuraFrames[slot] = iDura
	end

	iDura:Show()
end

local GetAverageItemLevel = GetAverageItemLevel


-- OnLoad
local function iLvLrOnLoad()
	iEqAvg, iAvg = GetAverageItemLevel()

	for k , v in pairs(slot) do
		local iLevel = fetchIlvl(v)

		if (iLevel) then

			makeText(frame[k])

			if (v == "ShirtSlot" or v == "TabardSlot") then
				frame[k].text:SetFormattedText("", iLevel)
			else

				if (iLevel <= (floor(iEqAvg) - 10)) then
					frame[k].text:SetFormattedText("|cFFFF0000%i", iLevel)

				elseif (iLevel >= (floor(iEqAvg) +10)) then
					frame[k].text:SetFormattedText("|cFF00FF00%i", iLevel)

				else
					frame[k].text:SetFormattedText("|cFFFFFFFF%i", iLevel)
				end

				makeDurability(frame[k], v)
			end
		end
	end
end


-- OnUpdate
local function iLvLrOnUpdate()
	iEqAvg, iAvg = GetAverageItemLevel()

	for k, v in pairs(slot) do
		local iLevel = fetchIlvl(v)

		if (iLevel) then

			if (not frame[k].text) then
				makeText(frame[k])
			end

			if (v == "ShirtSlot" or v == "TabardSlot") then
				frame[k].text:SetFormattedText("", iLevel)
			else
				if (iLevel <= (floor(iEqAvg) - 10)) then
					frame[k].text:SetFormattedText("|cFFFF0000%i", iLevel)

				elseif (iLevel >= (floor(iEqAvg) + 10)) then
					frame[k].text:SetFormattedText("|cFF00FF00%i", iLevel)

				else
					frame[k].text:SetFormattedText("|cFFFFFFFF%i", iLevel)
				end

				makeDurability(frame[k], v)
			end

		else

			if (frame[k].text) then
				frame[k].text:SetFormattedText("")
			end

			if (iDuraFrames[v]) then
				iDuraFrames[v]:Hide()
			end

		end
	end
end


-- OnEvent
--[[ local function iLvLrOnEvent(self, event, arg1)
		if (event == "ADDON_LOADED" and arg1 == "iLvLr") then
			iLvLrOnLoad()
		elseif (event == "UNIT_INVENTORY_CHANGED" or event == "UPDATE_INVENTORY_DURABILITY") then
			iLvLrOnUpdate()
		end
	end
--]]


-- A Frame
local f = CreateFrame("Frame", "iLvLrFrame", UIParent)


-- Register Events
f:RegisterEvent("ADDON_LOADED")
f:RegisterEvent("UNIT_INVENTORY_CHANGED")
f:RegisterEvent("UPDATE_INVENTORY_DURABILITY")


-- Event Handler
f:SetScript("OnEvent", function(self, event, arg1)
	if (event == "ADDON_LOADED" and arg1 == "iLvLr") then
		iLvLrOnLoad()

		self:UnregisterEvent("ADDON_LOADED")

	elseif (event == "UNIT_INVENTORY_CHANGED" or event == "UPDATE_INVENTORY_DURABILITY") then
		iLvLrOnUpdate()

	end
end)





--------------------------------------------------
--	Backup
--------------------------------------------------
--[[  local function iLvLrMain()
		local f = CreateFrame("Frame", "iLvLrFrame", UIParent)
		f:RegisterEvent("ADDON_LOADED")
		f:RegisterEvent("UNIT_INVENTORY_CHANGED")
		f:RegisterEvent("UPDATE_INVENTORY_DURABILITY")
		f:SetScript("OnEvent", iLvLrOnEvent)
	end
	iLvLrMain()--]]
--------------------------------------------------
--	Credits
--------------------------------------------------
--	NishaUi
--	NishaUi\modules\extra\ilvlr.lua
--------------------------------------------------

