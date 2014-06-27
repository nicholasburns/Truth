local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["Frames"]) then return end
local print = function(...) Addon.print('Dev.Frames', ...) end
local Debug = print
--
local ipairs = ipairs
local type = type



--------------------------------------------------
--	List Textures
--------------------------------------------------
local ListTextures = function(O)
	for _, child in ipairs({O:GetRegions()}) do

		if (child and child:IsObjectType("texture")) then

			local texture = child:GetTexture()

			if (texture) then
				Debug(texture, child:GetName())
			end
		end
	end

	for _, child in ipairs({O:GetChildren()}) do

		if (child and child:IsObjectType("Frame")) then

			if (not child:IsObjectType("button")) then
				ListTextures(child)
			end
		end
	end
end

--------------------------------------------------
--	List Children
--------------------------------------------------
local ListChildren = function(O)
	if (not O) then return end

	if (type(O) == "string") then
		print(type(O), O)
	end

	for _, child in ipairs({O:GetRegions()}) do

		if (child) then
			Debug(child:GetName(), "region")
		end
	end

	for _, child in ipairs({O:GetChildren()}) do

		if (child and child:IsObjectType("Frame")) then

			Debug(child:GetName(), "frame")

			if (not child:IsObjectType("button")) then
				ListTextures(child)
			end
		end
	end
end

--------------------------------------------------
--	Show Textures
--------------------------------------------------
local ShowTextures = function(O)														-- if (not O) then return end
	for _, child in ipairs({O:GetRegions()}) do

		if (child and child:IsObjectType("texture")) then

			child:Show()

			local texture = child:GetTexture()

			if (texture) then
				Debug(texture, child:GetName())
			end
		end
	end

	for _, child in ipairs({O:GetChildren()}) do

		if (child and child:IsObjectType("Frame")) then

			child:Show()

			if (not child:IsObjectType("button")) then
				ListTextures(child)
			end
		end
	end
end


--------------------------------------------------
--	Debugging
--------------------------------------------------
--[[ Tests

/run ListTextures(TargetFrame)
/run ListChildren(TargetFrame)
/run ShowTextures(TargetFrame)

--]]

--[[ Debug Macro

/run ListTextures(GetMouseFocus():GetName())
/run ListChildren(GetMouseFocus():GetName())
/run ShowTextures(GetMouseFocus():GetName())


/run DEFAULT_CHAT_FRAME:AddMessage(GetMouseFocus():GetName())
/run ChatFrame3:AddMessage(GetMouseFocus():GetName())

--]]


--------------------------------------------------
--	Macro Backups
--------------------------------------------------
--[[ Framestack & Outline Frame

	/framestack
	/script MN=GetMouseFocus():GetName() DEFAULT_CHAT_FRAME:AddMessage(MN)
	/run MF=_G[MN] MFB=CreateFrame('Frame',nil,MF)

	MFB:SetAllPoints()MFB:SetBackdrop({edgeFile='Interface\\BUTTONS\\WHITE8X8',edgeSize=5})
	MFB:SetBackdropBorderColor(1,0,0,1)

--]]

--[[ Framestack & Print Name to ChatFrame3 (followed by a comma)

	/framestack true
	/run DEFAULT_CHAT_FRAME:AddMessage(GetMouseFocus():GetName())
	/run ChatFrame3:AddMessage(GetMouseFocus():GetName() .. ",")

--]]


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ local RemoveTextures = function(O)
		for _, child in ipairs({O:GetRegions()}) do

			if (child and child:IsObjectType("texture")) then
				child:SetTexture(nil)
			end
		end
	end
--]]

--[[ local debug = function(value, name)
		if (name) then
			DEFAULT_CHAT_FRAME:AddMessage("debug " .. name  .. ": " .. (value or "nil"), 1, 1, 1, 1, 10)
		else
			DEFAULT_CHAT_FRAME:AddMessage("debug: " .. (value or "nil"), 1, 1, 1, 1, 10)
		end
	end
--]]




--------------------------------------------------
--	Credits
--------------------------------------------------
--	credit: CleanUI















