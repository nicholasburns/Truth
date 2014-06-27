local A, C, G, L = select(2, ...):Unpack()

if (not C["Skin"]["Enable"] or not C["Skin"]["Debug"]["Enable"]) then
	return
end


local select = select
local UIParent = UIParent





--------------------------------------------------
--[[ BasicScriptErrors Skin

	IDK where this code belongs
	It's here temporarily
--]]
do
	BasicScriptErrors:Strip(true)
	BasicScriptErrors:Template("TRANSPARENT")
	BasicScriptErrors:Shadow()
	BasicScriptErrors:SetScale(G.UISCALE)
	BasicScriptErrorsButton:SkinButton()
end
--------------------------------------------------
local OnShow, OnEvent

do
	local color = A.PLAYER_COLOR
	local font = A.default.font
	local scale = G.UISCALE

	OnShow = function(self)
		self:SetScale(scale)
		self:Template("TRANSPARENT")
	end



	OnEvent = function(self, event, addon)
		if (addon ~= "Blizzard_DebugTools") then
			return
		end

		-- Tooltips

		if (FrameStackTooltip) then
			FrameStackTooltip:SetScale(G.UISCALE)
			FrameStackTooltip:HookScript("OnShow", OnShow)
		end

		if (EventTraceTooltip) then
			EventTraceTooltip:HookScript("OnShow", OnShow)
		end

		-- ScriptErrors

		ScriptErrorsFrame:SetParent(UIParent)
		ScriptErrorsFrame:Strip(true)
		ScriptErrorsFrame:Template("TRANSPARENT")


	-- Increase the error frame size

	local BASE_HEIGHT = ScriptErrorsFrame:GetHeight()
	local BASE_WIDTH  = ScriptErrorsFrame:GetWidth()

	local NEW_HEIGHT = 95
	local NEW_WIDTH  = 16

	ScriptErrorsFrame:SetWidth(BASE_WIDTH + NEW_WIDTH)
	ScriptErrorsFrame:SetHeight(BASE_HEIGHT + NEW_HEIGHT)

	ScriptErrorsFrameScrollFrame:SetWidth(ScriptErrorsFrameScrollFrame:GetWidth() + NEW_WIDTH)
	ScriptErrorsFrameScrollFrame:SetHeight(ScriptErrorsFrameScrollFrame:GetHeight() + NEW_HEIGHT + 4)


		ScriptErrorsFrameClose:SkinCloseButton()

		-- Buttons

		for i = 1, (ScriptErrorsFrame:GetNumChildren()) do
			local child = select(i, ScriptErrorsFrame:GetChildren())
			if (child:GetObjectType() == "Button" and not child:GetName()) then
				child:SkinButton()

				print(child:GetName())
			end
		end

		-- ScrollFrame

		ScriptErrorsFrameScrollFrame:Backdrop()
		ScriptErrorsFrameScrollFrame:SetFrameLevel(ScriptErrorsFrameScrollFrame:GetFrameLevel() + 2)
		ScriptErrorsFrameScrollFrameText:SetFont(font["file"], font["size"], font["flag"])
		ScriptErrorsFrameScrollFrameScrollBar:SkinScrollBar()


		----------------------------------------


		-- EventTrace

		EventTraceFrame:Strip(true)
		EventTraceFrame:Template("TRANSPARENT")
		EventTraceFrame:Shadow()
		EventTraceFrameCloseButton:SkinCloseButton()


		-- ScrollFrame

		EventTraceFrameScrollBG:SetTexture(nil)

		if (not EventTraceFrameScroll.trackbg) then
			EventTraceFrameScroll.trackbg = CreateFrame('Frame', "$parent_Track_Background", EventTraceFrameScroll)
			EventTraceFrameScroll.trackbg:SetPoint('TOPLEFT', EventTraceFrameScroll, 'BOTTOMLEFT', 0, -1)
			EventTraceFrameScroll.trackbg:SetPoint('BOTTOMRIGHT', EventTraceFrameScroll, 'TOPRIGHT', 0, 1)
			EventTraceFrameScroll.trackbg:SetFrameLevel(EventTraceFrameScroll:GetFrameLevel() - 1)
			EventTraceFrameScroll.trackbg:Template("TRANSPARENT")
		end


		if (EventTraceFrameScroll:GetThumbTexture()) then
			EventTraceFrameScroll:GetThumbTexture():SetTexture(nil)

			if (not EventTraceFrameScroll.thumbbg) then
				EventTraceFrameScroll.thumbbg = CreateFrame('Frame', "$parent_Thumb_Background", EventTraceFrameScroll)
				EventTraceFrameScroll.thumbbg:SetPoint('TOPLEFT', EventTraceFrameScroll:GetThumbTexture(), 2, -3)
				EventTraceFrameScroll.thumbbg:SetPoint('BOTTOMRIGHT', EventTraceFrameScroll:GetThumbTexture(), -2, 3)
				EventTraceFrameScroll.thumbbg:SetFrameLevel(EventTraceFrameScroll.trackbg and EventTraceFrameScroll.trackbg:GetFrameLevel() or EventTraceFrameScroll:GetFrameLevel() + 1)

				EventTraceFrameScroll.thumbbg:Template("TRANSPARENT")
				EventTraceFrameScroll.thumbbg:SetBackdropBorderColor(color.r, color.g, color.b)
				EventTraceFrameScroll.thumbbg:SetBackdropColor(color.r/3, color.g/3, color.b/3)
			end
		end


		self:UnregisterEvent("ADDON_LOADED")
	end


	local f = CreateFrame('Frame')
	f:RegisterEvent('ADDON_LOADED')
	f:SetScript('OnEvent', OnEvent)
end


--------------------------------------------------

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Events

	local f = CreateFrame('Frame')
	f:RegisterEvent('ADDON_LOADED')
	f:SetScript('OnEvent', function(self, event, addon)
		if (addon == "Blizzard_DebugTools") then

			if (FrameStackTooltip) then
				FrameStackTooltip:Template("TRANSPARENT")									-- FrameStackTooltip:SetScale(0.64)
			end

			LoadSkin()

			self:UnregisterEvent('ADDON_LOADED')
		end
	end)
--]]

--[[ Remove Textures

	for i, texture in ipairs({
		'TopLeft',
		'TopRight',
		'Top',
		'BottomLeft',
		'BottomRight',
		'Bottom',
		'Left',
		'Right',
		'TitleBG',
		'DialogBG'
	}) do
		_G["EventTraceFrame" .. texture]:SetTexture(nil)
		_G["ScriptErrorsFrame" .. texture]:SetTexture(nil)
	end

--]]

--[[	PLAYER_ENTERING_WORLD

	local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:SetScript('OnEvent', function(self, event, addon)
		LoadSkin()
		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end)
--]]

--[[ Frame Cache

	local FrameStackTooltip = FrameStackTooltip
	local EventTraceTooltip = EventTraceTooltip
	local ScriptErrorsFrame = ScriptErrorsFrame
	local ScriptErrorsFrameClose = ScriptErrorsFrameClose
	local EventTraceFrame = EventTraceFrame
	local EventTraceFrameCloseButton = EventTraceFrameCloseButton
	local EventTraceFrameScrollBG = EventTraceFrameScrollBG
--]]


