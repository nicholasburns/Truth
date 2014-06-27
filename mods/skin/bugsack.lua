local A, C, G, L = select(2, ...):Unpack()

if (not C["Skin"]["Enable"] or not C["Skin"]["BugSack"]["Enable"]) then
	return
end


local ipairs = ipairs



--[[ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦
  ◦  A.BugSack.lua  (by Saiket)                                                               ◦
  ◦  Modifies the BugSack addon                                                                    ◦
  ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ]]

--	 local mod = {}
--	 A.BugSack = mod



--[[ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦
  ◦  Function: A.BugSack.OnLoad                                                               ◦
  ◦  Description: Makes modifications just after the addon is loaded.                              ◦
  ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ◦ ]]					--@ http://wow-saiket.googlecode.com/svn/tags/A/2.4.2/A.BugSack.lua

local Load = function()

	-- Reskin Error Frame
	BugSackFrame:SetMovable(true)
	BugSackFrame:SetUserPlaced(true)
	BugSackFrame:SetClampedToScreen(true)
	BugSackFrame:CreateTitleRegion():SetAllPoints()
	BugSackFrame:Template("DEFAULT")													-- BugSackFrame:SetBackdrop({bgFile = 'Interface\\TutorialFrame\\TutorialFrameBackground', edgeFile = 'Interface\\TutorialFrame\\TutorialFrameBorder', edgeSize = 32, insets = {left = 7, right = 5, top = 3, bottom = 6}})
	BugSackFrame:EnableMouse(true)

	BugSackFrameScroll:SetHeight(370)
	BugSackFrameScroll:SetPoint('TOPLEFT', BugSackErrorText, 'BOTTOMLEFT', 12, -8)

	BugSackFrameScrollText:SetFontObject(A.MonospaceNumberFont)
	BugSackFrameScrollText:SetFont(BugSackFrameScrollText:GetFont(), 20)		-- 12)


	-- Reposition Buttons
	BugSackFrameButton:Hide()

	local LastButton = CreateFrame("Button", nil, BugSackFrame, 'UIPanelCloseButton')
	LastButton:SetPoint('TOPRIGHT', 4, 4)

	local InitButton = function(Button, Label)
		Button:SetText(Label)
		Button:SetSize(24, 18)
		Button:Point('RIGHT', LastButton, 'LEFT', -8, 0)

		LastButton = Button
	end

	InitButton(BugSackLastButton , ">>")
	InitButton(BugSackNextButton , ">")
	InitButton(BugSackPrevButton , "<")
	InitButton(BugSackFirstButton, "<<")
end



local f = CreateFrame('Frame')
f:RegisterEvent('ADDON_LOADED')
f:SetScript("OnEvent", function(self, event, addon)
	if (addon == "BugSack") or (addon == A.ADDON_NAME) then
		if (BugSackFrame) then
			Load()
		end
	end
end)




--[[----------------------------------------------
  -------------------- Revert --------------------
  -------------------- Revert --------------------
  -------------------- Revert --------------------
--]]----------------------------------------------


			if (not false) then
				return
			end


--------------------------------------------------
--[[ Events

	local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:SetScript('OnEvent', function(self)

		local name, _, _, enabled = GetAddOnInfo("BugSack")

		if ((not name) or (not enabled)) then
			print("BugSackSkin", "false")
			return
		end

		if (name and enabled) then
			print("BugSackSkin", "true")
		end

		_G["BugSackFrame"]:Template("TRANSPARENT") --[1]
		BugSackScroll:Template("TRANSPARENT") --[2]
	  -- BugSackScrollText --[3]

		for i, Button in ipairs({
			BugSackPrevButton,
			BugSackSendButton,
			BugSackNextButton,
		}) do
			_G[Button]:SkinButton()
		end

		for i, Tab in ipairs({
			BugSackTabAll,
			BugSackTabSession,
			BugSackTabLast,
		}) do
			_G[Tab]:SkinTab()
		end

		BugSackScrollScrollBar:SkinScrollBar() --[3]


		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end)
--]]


