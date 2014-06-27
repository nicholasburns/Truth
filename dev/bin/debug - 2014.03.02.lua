local ipairs = ipairs
local type = type
local format = string.format
local tostring = tostring
--------------------------------------------------
-- Addon
--------------------------------------------------
local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["D"]) then return end
local print = function(...) A.print('D', ...) end

local D

--[[ Color
	A.color.blue.cff
	A.color.white.cff
	A["color"]["blue"]["cff"]
	A["color"]["white"]["cff"]
--]]

local DEFAULT_KEY_COLOR = A.color.blue.cff
local DEFAULT_VAL_COLOR = A.color.white.cff

--------------------------------------------------
--	Dump Printer
--------------------------------------------------
D = function(key, val)
	local k = tostring(key and key or "")
	local v = tostring(val and val or "")

	key = format("%s%s|r", A.color.blue.cff, k)											-- DEFAULT_KEY_COLOR, k)
	val = format("%s%s|r", A.color.white.cff, v)											-- DEFAULT_VAL_COLOR, v)

	print(format("%s%s  %s", L["INDENT"], key, val))
end


--------------------------------------------------
--	Textures
--------------------------------------------------
local ListTextures = function(F)
	for _, child in ipairs({F:GetRegions()}) do
		if (child and child:IsObjectType("texture")) then
			local texture = child:GetTexture()
			if (texture) then
				D(texture, child:GetName())
			end
		end
	end

	for _, child in ipairs({Object:GetChildren()}) do
		if (child and child:IsObjectType("frame")) then
			if (not child:IsObjectType("button")) then
				ListTextures(child)
			end
		end
	end
end

--------------------------------------------------
--	Children
--------------------------------------------------
local ListChildren = function(name)
	print("name:", name)

	if (not name) then return end
	-- if (type(name) == "string") then print(typ, name) return end						-- print("ListChildren:Name >", name)

	local Object = _G[name]

	-- local typ = type(Object)
	-- if (typ == "frame") then print(typ, Object:GetName()) end
	-- if (typ == "fontstring") then print(typ, Object) end
	-- if (typ == "table") then print(typ, #Object) end

	-- local regions = ({Object:GetRegions()})
	-- if (#regions < 2) then return end

	for _, child in pairs({_G[name]:GetRegions()}) do
		if (child) then
			D(child:GetName(), "region")
		end
	end

	for _, child in pairs({Object:GetRegions()}) do
		if (child and child:IsObjectType("frame")) then

			D(child:GetName(), "Object")

			if (not child:IsObjectType("button")) then
				ListChildren(child)
			end
		end
	end
end


--------------------------------------------------
--[[ API Notes

GetRegions
Returns a list of non-Frame child regions of the frame
	Usage:	... = Frame:GetRegions()
	Return:	... = (list) A list of each non-Frame
				 child region belonging to the frame, i.e.:
					> FontStrings or Textures

GetChildren
Returns a list of child frames of the frame
	Useage:	... = Frame:GetChildren()
	Return:	... = (list) A list of the frames which
				 are children of this frame

IsObjectType
Returns whether the obj belongs to a given widget type
	Useage:	isType = UIObject:IsObjectType("type")
	Args:	type   - (string) Name of an obj type:
					> Frame, Button, FontString, etc
	Return:	isType - (1nil) 1 if obj is the type
					(or a subtype); else nil
--]]
--------------------------------------------------



--------------------------------------------------
--	Revert Code
--------------------------------------------------
local ListTextures_Revert = function(frame)
	for _, child in ipairs({frame:GetRegions()}) do
		if (child and child:IsObjectType("texture")) then
			local texture = child:GetTexture()
			if (texture) then
				Debug(texture, child:GetName())
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
			Debug(child:GetName(), "region")
		end
	end
	for _, child in ipairs({frame:GetChildren()}) do
		if (child and child:IsObjectType("frame")) then
			Debug(child:GetName(), "frame")

			if (not child:IsObjectType("button")) then
				ListTextures(child)
			end
		end
	end
end


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ D = function(value, name)
		local CF = ChatFrame1
		if (name) then
			CF:AddMessage("debug " .. name .. ": " .. (value or "nil"), 1, 1, 1, 1, 10)
		else
			CF:AddMessage("debug: " .. (value or "nil"), 1, 1, 1, 1, 10)
		end
	end
--]]

--[[ local ListFont = function(name)
		print("[1] name:", name)
		if (type(f) == "table") then return end
		local f = _G[name]
		for i = 1, ( f:GetNumRegions() ) do
			print("[2] GetNumRegions:", f:GetNumRegions())
			local region = select(i, f:GetRegions())
			if (region:GetObjectType() == "FontString") then
				print("[3] " .. region:GetText() .. ":", region:GetName())
			end
		end
	end
--]]


--------------------------------------------------
--	Credits
--------------------------------------------------
--	Credit: CleanUI
