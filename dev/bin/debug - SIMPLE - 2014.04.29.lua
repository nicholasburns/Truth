local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["Frames"]) then
	return
end






--------------------------------------------------
--	Debug Printer
--------------------------------------------------
local Debug = function(value, name)
	local f = ChatFrame3
	if (name) then
		f:AddMessage("debug " .. name .. ": " .. (value or "nil"), 1, 1, 1, 1, 10)
	else
		f:AddMessage("debug: " .. (value or "nil"), 1, 1, 1, 1, 10)
	end
end


--------------------------------------------------
--[[ /d Truth.List(BrowsePrevPageButton)
--]]
--------------------------------------------------
A.ListTextures = function(frame)
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

A.ListChildren = function(frame)
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
--	Credits
--------------------------------------------------
--	credit: CleanUI

