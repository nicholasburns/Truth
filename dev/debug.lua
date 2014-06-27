local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["Enable"] or not C["Dev"]["Debug"]["Enable"]) then
	return
end

local Truth = _G[A.ADDON_NAME]

local type = type
local ipairs = ipairs
local format, tostring = string.format, tostring
local tinsert, select, unpack = table.insert, select, unpack
local UIParent, WorldFrame = UIParent, WorldFrame
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local GetMouseFocus = GetMouseFocus


--------------------------------------------------

local D = function(object, value)
--	Debug Message Printer

	object = object or ""
	value  = value  or ""

	DEFAULT_CHAT_FRAME:AddMessage(L["DEBUG_MESSAGE_FORMAT"]:format(object, value))
end


--------------------------------------------------
--[[

	UIParent:GetObjectType()					-->  "Frame"

	PlayerFrame:GetObjectType()				-->  "Button"

--]]


local family = {}
local counter = 1


local ListRelatedWidgets = function(self)
	if (not self) then
		return
	end

	self.family	= family
	self.name		= self:GetName()													-- tinsert(family, 1, self:GetName())
	self.parent	= self:GetParent()
	self.type		= self:GetObjectType()


	D(self:GetObjectType(), self:GetName()) 	--> Frame PlayerFrame


	for _, child in ipairs({ self:GetRegions() }) do

		if (child and child:IsObjectType("Texture")) then
			local texture = child:GetTexture()

			if (texture) then
				D(child.GetName and child:GetName() or "", texture)

			end
		end
	end

	for _, child in ipairs({ self:GetChildren() }) do
		if (child and child:IsObjectType("Frame")) then

			if (not child:IsObjectType("Button")) then
				ListRelatedWidgets(child)

			end
		end
	end
end

--	 if (self:IsObjectType("Frame")) then D("Frame", self:GetName()) end




function Truth:ListTextures()
	local target = GetMouseFocus()
	if (not target) then
		return
	end
	if (target == WorldFrame or target == UIParent) then
		return
	end

	DEFAULT_CHAT_FRAME:AddMessage(" ")
	DEFAULT_CHAT_FRAME:AddMessage(L["DIV"])
	DEFAULT_CHAT_FRAME:AddMessage(L["INDENT_FORMAT"]:format(L["LIST_TEXTURES_HEADER"]))

	ListRelatedWidgets(target)

end




function Truth:ListChildren()
	local object = GetMouseFocus()
	if (not object) then
		return
	end

-- if (object == WorldFrame or object == UIParent) then return end
-- A.divider(L["LIST_CHILDREN_HEADER"])

	DEFAULT_CHAT_FRAME:AddMessage(" ")
	DEFAULT_CHAT_FRAME:AddMessage(L["DIV"])
	DEFAULT_CHAT_FRAME:AddMessage(L["INDENT_FORMAT"]:format(L["LIST_CHILDREN_HEADER"]))


	for _, child in ipairs({ object:GetRegions() }) do
		if (child) then
			D(child:GetName(), "region")
		end
	end

	for _, child in ipairs({ object:GetChildren() }) do

		if (child and child:IsObjectType("Frame")) then
			D(child:GetName(), L["FRAME"]) 											-- "frame")

			if (not child:IsObjectType("Button")) then
				ListRelatedWidgets(child)

			end
		end
	end

	A.divider(L["LIST_CHILDREN_HEADER"])
end

--
--------------------------------------------------
-- returns the addon object which is the topmost object in the hierarchy
-- :GetAncestor()
-- 	@return <table> the topmost object in the hierarchy, or 'self' if we're on top
local GetAncestor = function(self)
	--	 return gCore:GetAddon(self:GetFamilyTree())
end

--
-- returns the whole family tree leading to the 'self' object
-- first return value is the name of the top level addon for use with :GetAddon(name)
-- all following values (if any) are the names of the subsequent modules for use with :GetModule(name)
--
-- :GetFamilyTree([skipancestor[, skipself]])
-- 	@param skipancestor <boolean> if 'true', the top level object is omitted from the results
-- 	@param skipself <boolean> if 'true', the 'self' object is omitted from the results
-- 	@return name, name, name, name, ... <string>
local GetFamilyTree = function(self, skipancestor, skipself, asTable)
	local family = {}

	if (not skipself) then
		tinsert(family, 1, self:GetName())
	end

	local child
	local parent = self:GetParent()
	while (parent) do
		child = parent
		parent = child:GetParent()

		if (skipancestor) then
			if (parent) then
				tinsert(family, 1, child:GetName())
			end
		else
			tinsert(family, 1, child:GetName())
		end
	end

	if (#family > 0) then
		if (asTable) then
			return family
		else
			return unpack(family)
		end
	else
		return nil
	end
end

--------------------------------------------------
--	Backup - Original Functions
--------------------------------------------------
--[[ @ListTextures

	A.divider(L["LIST_TEXTURES_HEADER"])
	A.divider(L["LIST_TEXTURES_HEADER"])
--]]

--[[ @ListChildren

	DEFAULT_CHAT_FRAME:AddMessage(" ")
	DEFAULT_CHAT_FRAME:AddMessage(L["DIV"])
	DEFAULT_CHAT_FRAME:AddMessage(L["LIST_CHILDREN_HEADER")								-- L["INDENT"]:format("|cffCC3366ListChildren|r")
--]]

--[[ Locale
	L["DEBUG_MESSAGE_FORMAT"] = L["INDENT"] .. "|cff82C5FF%s|r  |cffCCCCCC%s|r"
	L["DEBUG_LIST_TEXTURES_HEADER"] = L["INDENT_S"]:format("|cff66CC33ListTextures|r")
	L["DEBUG_LIST_CHILDREN_HEADER"] = L["INDENT_S"]:format("|cffCC3366ListChildren|r")
--]]

--[[ DEBUGMODE

	local DEBUGMODE = A["DEBUGMODE"]											-- Dumps debug info in chat
	local DEBUGMODE_CHAT_REMINDER = DEBUGMODE and A["DEBUGMODE_CHAT_REMINDER"] or ""	-- Chat Reminder
--]]

--[[ D

	local D = function(k, v)
		k = ("|cff82C5FF%s|r"):format(tostring(k or ""))
		v = ("|cffCCCCCC%s|r"):format(tostring(v or ""))
		if (A["DEBUGMODE"]) then
			DEFAULT_CHAT_FRAME:AddMessage(("%s     %s  %s"):format(DEBUGMODE_CHAT_REMINDER, k, v))
		else
			DEFAULT_CHAT_FRAME:AddMessage(("     %s  %s"):format(k, v))
		end
	end
--]]

--[[ ListRelatedWidgets

	function Truth:ListRelatedWidgets(object)
		if (object:IsObjectType("frame")) then
			D("Frame", object:GetName())
		end
		for _, child in ipairs({ object:GetRegions() }) do
			if (child and child:IsObjectType("Texture")) then
				local Texture = child:GetTexture()
				if (Texture) then
					local childname = child:GetName() and child:GetName() or ""
					D(childname, Texture)
				end

			end
		end
		for _, child in ipairs({ object:GetChildren() }) do
			if (child and child:IsObjectType("frame")) then
				if (not child:IsObjectType("button")) then
					Truth:ListRelatedWidgets(child)
				end

			end
		end
	end
--]]

--[[ DumpChildren

	function Truth:DumpChildren(object)
	--	objtype = type(object) if (DEBUGMODE) then D("Type", objtype) end
	--	if (not object) then print("ListRelatedWidgets", "No frame was entered - Frame is required") end
		for _, child in ipairs({ object:GetRegions() }) do if (child) then D(child:GetName(), "region") end end
		for _, child in ipairs({ object:GetChildren() }) do
			if (child and child:IsObjectType("frame")) then D(child:GetName(), "frame")
				if (not child:IsObjectType("button")) then Truth:ListRelatedWidgets(child) end
			end
		end
	end
--]]

--------------------------------------------------
--	Output
--------------------------------------------------
--[[ CHATDUMP

      ----------------------------------------------
      ActionButton1Icon  Interface\Icons\Ability_Rogue_ShadowStrikes
      ActionButton1Flash  Interface\Buttons\UI-QuickslotRed
      ActionButton1FlyoutBorder  Interface\Buttons\ActionBarFlyoutButton
      ActionButton1FlyoutBorderShadow  Interface\Buttons\ActionBarFlyoutButton
      ActionButton1FlyoutArrow  Interface\Buttons\ActionBarFlyoutButton
      ActionButton1Border  Interface\Buttons\UI-ActionButton-Border
      ActionButton1NormalTexture  Interface\Buttons\UI-Quickslot2
        Interface\Buttons\UI-Quickslot-Depress
        Interface\Buttons\ButtonHilight-Square
        Interface\Buttons\CheckButtonHilight
      ----------------------------------------------

--]]
--[[ CHATDUMP (while DEBUGMODE is active)

	[DEBUGMODE]      ----------------------------------------------
	[DEBUGMODE]      Type  table
	[DEBUGMODE]      ActionButton1Icon  Interface\Icons\Ability_Rogue_ShadowStrikes
	[DEBUGMODE]      ActionButton1Flash  Interface\Buttons\UI-QuickslotRed
	[DEBUGMODE]      ActionButton1FlyoutBorder  Interface\Buttons\ActionBarFlyoutButton
	[DEBUGMODE]      ActionButton1FlyoutBorderShadow  Interface\Buttons\ActionBarFlyoutButton
	[DEBUGMODE]      ActionButton1FlyoutArrow  Interface\Buttons\ActionBarFlyoutButton
	[DEBUGMODE]      ActionButton1Border  Interface\Buttons\UI-ActionButton-Border
	[DEBUGMODE]      ActionButton1NormalTexture  Interface\Buttons\UI-Quickslot2
	[DEBUGMODE]        Interface\Buttons\UI-Quickslot-Depress
	[DEBUGMODE]        Interface\Buttons\ButtonHilight-Square
	[DEBUGMODE]        Interface\Buttons\CheckButtonHilight
	[DEBUGMODE]      Type  table
	[DEBUGMODE]      ----------------------------------------------

--]]

--------------------------------------------------
--[[	Notes

	Texture = object:CreateTexture(["name"] [,"layer"])
	> Creates a Texture (object); also becomes child of frame

	FontStr = object:CreateFontString(["name"] [,"layer"])
	> Creates a FontString (object); also becomes child of frame

	NumRegions = object:GetNumRegions()
	> Returns # of regions (Textures/FontStrings) attached to a frame

	a, b, c, ... = object:GetRegions()
	> Returns regions attached to a frame

--]]

--[[ API Notes

	GetRegions
	---------------
	Returns a list of non-Frame child regions of the frame
		Usage:	... = Frame:GetRegions()
		Return:	... = (list) A list of each non-Frame
					 child region belonging to the frame, i.e.:
						> FontStrings or Textures

	GetChildren
	---------------
	Returns a list of child frames of the frame
		Useage:	... = Frame:GetChildren()
		Return:	... = (list) A list of the frames which
					 are children of this frame

	GetNumChildren
	---------------
	Returns the number of child frames belonging to the frame
		Usage:	NumChildren = object:GetNumChildren()
		Return:	NumChildren — (number) # of child frames

	IsObjectType
	---------------
	Returns whether the obj belongs to a given widget type
		Useage:	isType = UIObject:IsObjectType("type")
		Args:	type   - (string) Name of an obj type:
						> Frame, Button, FontString, etc
		Return:	isType - (1nil) 1 if obj is the type
						(or a subtype); else nil
--]]

--------------------------------------------------
--	Revert Code
--------------------------------------------------
--[[ local ListTextures_Revert = function(frame)
		for _, child in ipairs({frame:GetRegions()}) do
			if (child and child:IsObjectType("texture")) then
				local texture = child:GetTexture()
				if (texture) then
					D(texture, child:GetName())
				end
			end
		end
		for _, child in ipairs({frame:GetChildren()}) do
			if (child and child:IsObjectType("frame")) then
				if (not child:IsObjectType("button")) then
					ListTextures(child)
				end
			end
		end
	end

	local ListChildren_Revert = function(frame)
		for _, child in ipairs({frame:GetRegions()}) do
			if (child) then
				D(child:GetName(), "region")
			end
		end
		for _, child in ipairs({frame:GetChildren()}) do
			if (child and child:IsObjectType("frame")) then
				D(child:GetName(), "frame")

				if (not child:IsObjectType("button")) then
					ListTextures(child)
				end
			end
		end
	end
--]]

--------------------------------------------------
--	Credits
--------------------------------------------------
--[[	Credit: CleanUI
--]]
--------------------------------------------------

