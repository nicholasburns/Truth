


--------------------------------------------------
--	List Textures
--------------------------------------------------
local ListTextures
do
	local ipairs = ipairs

	ListTextures = function(O)

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
end

Addon.ListTextures = ListTextures


--------------------------------------------------
--	List Children
--------------------------------------------------
local ListChildren
do
	local ipairs = ipairs
	local type = type


	ListChildren = function(O)
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
end

Addon.ListChildren = ListChildren

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

Addon.ShowTextures = ShowTextures

