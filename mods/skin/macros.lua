local A, C, G, L = select(2, ...):Unpack()

if (not C["Skin"]["Enable"] or not C["Skin"]["Macros"]["Enable"]) then
	return
end

local ipairs = ipairs
local format = string.format


local MARGIN = G.MARGIN		-- 10
local PAD = G.PAD			-- 5


do
	local OnEvent = function(self, event, addon, ...)
		if (addon ~= "Blizzard_MacroUI") then
			return
		end

		local MacroFrame						= MacroFrame
		local MacroFrameCloseButton				= MacroFrameCloseButton
		local MacroFrameTab1					= MacroFrameTab1
		local MacroFrameTab2					= MacroFrameTab2
		local MacroFrameInset					= MacroFrameInset
		local MacroFrameTextBackground			= MacroFrameTextBackground
		local MacroButtonScrollFrame				= MacroButtonScrollFrame
		local MacroPopupFrame					= MacroPopupFrame
		local MacroPopupScrollFrame				= MacroPopupScrollFrame
		local MacroPopupEditBox					= MacroPopupEditBox
		local MacroEditButton					= MacroEditButton
		local MacroDeleteButton					= MacroDeleteButton
		local MacroNewButton					= MacroNewButton
		local MacroExitButton					= MacroExitButton
		local MacroFrameSelectedMacroButton		= MacroFrameSelectedMacroButton
		local MacroFrameSelectedMacroButtonIcon		= MacroFrameSelectedMacroButtonIcon
		local MacroFrameCharLimitText				= MacroFrameCharLimitText
		local MAX_ACCOUNT_MACROS					= MAX_ACCOUNT_MACROS

		local Buttons = {
			"MacroDeleteButton",
			"MacroNewButton",
			"MacroExitButton",
			"MacroEditButton",
			"MacroFrameTab1",
			"MacroFrameTab2",
			"MacroPopupOkayButton",
			"MacroPopupCancelButton",
			"MacroSaveButton",
			"MacroCancelButton"
		}

		for _, button in ipairs(Buttons) do
			_G[button]:Strip(true)
			_G[button]:SkinButton()
		end

		----------------------------------------

		MacroFrameTab1:Height(24)
		MacroFrameTab1:Point('TOPLEFT', MacroFrame, MARGIN, -39)				-- MacroFrameTab1:Point('TOPLEFT', MacroFrame, 'TOPLEFT', 12, -39)

		MacroFrameTab2:Height(24)
		MacroFrameTab2:Point('LEFT', MacroFrameTab1, 'RIGHT', PAD, 0)		-- MacroFrameTab2:Point('LEFT', MacroFrameTab1, 'RIGHT', 4, 0)

		----------------------------------------

		MacroFrame:Strip(true)
		MacroFrame:Template("TRANSPARENT")
		MacroFrame:Shadow()
		A.MakeMovable(MacroFrame)
		MacroFrameInset:Strip()
		-- MacroFrameTextBackground:Strip()
		-- MacroFrameTextBackground:Backdrop("TRANSPARENT")
		-- MacroFrameTextBackground.backdrop:Point('TOPLEFT', 4, -3)
		-- MacroFrameTextBackground.backdrop:Point('BOTTOMRIGHT', -23, 0)
		MacroFrameTextBackground:Strip()
		MacroFrameTextBackground:Template("TRANSPARENT")
		MacroFrameTextBackground:SetFrameLevel(1)
	  -- MacroFrameTextBackground:Point('TOPLEFT', 4, -3)
	  -- MacroFrameTextBackground:Point('BOTTOMRIGHT', -23, 0)


		MacroButtonScrollFrame:Strip()
		MacroButtonScrollFrame:Template("CLASSCOLOR")
		MacroButtonScrollFrame:Height(155)
		MacroButtonScrollFrame:Point('TOPLEFT', MacroFrameTab1, 'BOTTOMLEFT', 0, -PAD)
		--	 MacroButtonScrollFrameTop:Kill()		-- Interface\PaperDollInfoFrame\UI-Character-ScrollBar
		--	 MacroButtonScrollFrameBottom:Kill()	-- Interface\PaperDollInfoFrame\UI-Character-ScrollBar
		--	 MacroButtonScrollFrameMiddle:Kill()	-- Interface\PaperDollInfoFrame\UI-Character-ScrollBar
		MacroButtonScrollFrameScrollBar:SkinScrollBar()



	   --[[ MacroPopupFrame ]]
		MacroPopupFrame:Strip()
		MacroPopupFrame:Template("TRANSPARENT")
		MacroPopupFrame:HookScript("OnShow", function(self)
			self:Point('TOPLEFT', MacroFrame, 'TOPRIGHT', 3, 0)
		end)
		MacroPopupScrollFrame:Strip()
		MacroPopupScrollFrame:Template("TRANSPARENT")
	  -- MacroPopupScrollFrame:Point('TOPLEFT', 51, 2)
	  -- MacroPopupScrollFrame:Point('BOTTOMRIGHT', -PAD, PAD)		-- MacroPopupScrollFrame.backdrop:Point('BOTTOMRIGHT', -4, 4)
	  -- MacroPopupScrollFrame:Backdrop("TRANSPARENT")
	  -- MacroPopupScrollFrame.backdrop:Point('TOPLEFT', 51, 2)
	  -- MacroPopupScrollFrame.backdrop:Point('BOTTOMRIGHT', -PAD, PAD)		-- MacroPopupScrollFrame.backdrop:Point('BOTTOMRIGHT', -4, 4)
		MacroPopupScrollFrameScrollBar:SkinScrollBar()


		MacroPopupEditBox:Strip(true)
		MacroPopupEditBox:Backdrop("TRANSPARENT")
		MacroPopupEditBox.backdrop:Point('TOPLEFT', -PAD, 0)
		-- MacroPopupEditBox.backdrop:Point('TOPLEFT', -3, 0)
		MacroPopupEditBox.backdrop:Point('BOTTOMRIGHT', 0, 0)

		MacroFrameCloseButton:SkinCloseButton(MacroFrame)


	   --[[ Reposition buttons ]]
		MacroEditButton:Point('BOTTOMLEFT', MacroFrameSelectedMacroButton, 'BOTTOMRIGHT', MARGIN, 0)		-- MacroEditButton:Point('BOTTOMLEFT', MacroFrameSelectedMacroButton, 'BOTTOMRIGHT', 10, 0)

		MacroDeleteButton:Point('BOTTOMLEFT', MacroFrame, 'BOTTOMLEFT', MARGIN, -MARGIN)					-- MacroDeleteButton:Point('BOTTOMLEFT', MacroFrame, 'BOTTOMLEFT', 9, 4)
		MacroNewButton:Point('RIGHT', MacroExitButton, 'LEFT', -PAD, 0)							-- MacroNewButton:Point('RIGHT', MacroExitButton, 'LEFT', -3, 0)
		MacroExitButton:Point('BOTTOMRIGHT', MacroFrame, 'BOTTOMRIGHT', -MARGIN, MARGIN)

--[[		/d MacroFrameSelectedMacroBackground:GetPoint()	=>	{'TOPLEFT', MacroFrame, 'TOPLEFT', 5, -218}
--]]
--[[		/d MacroFrameScrollFrame:GetPoint()	=>	{'TOPLEFT', MacroFrameSelectedMacroBackground, 'BOTTOMLEFT', 11, -13}
--]]

		MacroFrameScrollFrame:Template("CLASSCOLOR")
		MacroFrameScrollFrameScrollBar:SkinScrollBar()


	   --[[ Big Icons ]]
		MacroFrameSelectedMacroButton:Strip()
		MacroFrameSelectedMacroButton:StyleButton()
		MacroFrameSelectedMacroButton:GetNormalTexture():SetTexture(nil)
		MacroFrameSelectedMacroButton:Template("DEFAULT")
		MacroFrameSelectedMacroButtonIcon:SetTexCoord(G.TexCoords:Unpack())
		MacroFrameSelectedMacroButtonIcon:SetInside()

	   --[[ Moving text ]]
		MacroFrameCharLimitText:Point('BOTTOM', MacroFrame, 0, -MARGIN)			-- MacroFrameCharLimitText:Point('BOTTOM', MacroFrameTextBackground, 0, -12)

	   --[[ Skin all macro icons ]]
		for i = 1, (MAX_ACCOUNT_MACROS) do
			local Button			= _G[format("MacroButton%d", i)]
			local ButtonIcon		= _G[format("MacroButton%dIcon", i)]
			local PopupButton		= _G[format("MacroPopupButton%d", i)]
			local PopupButtonIcon	= _G[format("MacroPopupButton%dIcon", i)]

			if (Button) then
				Button:Strip()
				Button:StyleButton()
				Button:Template("TRANSPARENT")	-- ("DEFAULT")
			end

			if (ButtonIcon) then
				ButtonIcon:SetTexCoord(G.TexCoords:Unpack())
				ButtonIcon:SetInside()
			end																	-- ButtonIcon:ClearAllPoints() ButtonIcon:Point('TOPLEFT', 2, -2) ButtonIcon:Point('BOTTOMRIGHT', -2, 2)

			if (PopupButton) then
				PopupButton:Strip()
				PopupButton:StyleButton()
				PopupButton:Template("TRANSPARENT")	-- ("DEFAULT")
			end

			if (PopupButtonIcon) then
				PopupButtonIcon:SetTexCoord(G.TexCoords:Unpack())
				PopupButtonIcon:SetInside()
			end																	-- PopupButtonIcon:ClearAllPoints() PopupButtonIcon:Point('TOPLEFT', 2, -2) PopupButtonIcon:Point('BOTTOMRIGHT', -2, 2)
		end

		self:UnregisterEvent("ADDON_LOADED")
	end


	local f = CreateFrame('Frame')
	f:RegisterEvent('ADDON_LOADED')
	f:SetScript('OnEvent', OnEvent)
end













--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Events

	local e = CreateFrame('Frame')
	e:RegisterEvent("ADDON_LOADED")
	e:SetScript('OnEvent', function(self, event, addon)
		if (addon == "Blizzard_MacroUI") then
			LoadSkin()

			local MacroFrame = MacroFrame
			local MacroFrameCloseButton = MacroFrameCloseButton

			MacroFrame:MakeMovable()

			local MACRO_UI_BUTTONS = {
				"MacroEditButton",
				"MacroSaveButton",
				"MacroCancelButton",
				"MacroExitButton",
				"MacroNewButton",
				"MacroDeleteButton",
			}
			for _, button in ipairs(MACRO_UI_BUTTONS) do
				_G[button]:SkinButton()
			end
			MACRO_UI_BUTTONS = nil				-- Release

			MacroFrameCloseButton:SkinCloseButton()

			self:UnregisterEvent("ADDON_LOADED")
		end
	end)
--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ LoadSkin

	local LoadSkin
	do
		local MacroFrame = MacroFrame
		local MacroFrameCloseButton = MacroFrameCloseButton


		LoadSkin = function()

			-- MacroFrame
			MacroFrame:MakeMovable()

			-- Buttons
			local MACRO_UI_BUTTONS = {
				"MacroEditButton",
				"MacroSaveButton",
				"MacroCancelButton",
				"MacroExitButton",
				"MacroNewButton",
				"MacroDeleteButton",
			}
			for _, button in ipairs(MACRO_UI_BUTTONS) do
				_G[button]:SkinButton()
			end

			MACRO_UI_BUTTONS = nil			-- Release

			-- Close Button
			MacroFrameCloseButton:SkinCloseButton()

		end
	end
--]]
