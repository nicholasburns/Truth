local select, unpack	= select, unpack
local CreateFrame = CreateFrame
local UIParent = UIParent
local ChatFontNormal = ChatFontNormal
local ChatFrame1EditBox = ChatFrame1EditBox
--------------------------------------------------
--	A
--------------------------------------------------
local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["DumpWindow"]) then return end
local print = function(...) A.print('Dev.DumpWindow', ...) end




--------------------------------------------------
--	Properties
--------------------------------------------------
local inset = 10
local pad = 10
--
local editbox


--------------------------------------------------
--	Window
--------------------------------------------------
local f = CreateFrame('Frame', 'TruDumpwindow', ChatFrame1)
f:SetScale(1)
f:SetPoint('TOPLEFT', UIParent, 10, -100)
f:SetPoint('BOTTOMRIGHT', ChatFrame1EditBox, 'TOPRIGHT', -3, 10)
f:SetBackdrop(A.template.backdrop)
f:SetBackdropColor(unpack(A.default.backdrop.color))
f:SetBackdropBorderColor(unpack(A.default.border.color))
f:SetFrameStrata('BACKGROUND')
f:Hide()


-- Scroll
f.scroll = CreateFrame('ScrollFrame', '$parentScrollFrame', f, 'UIPanelScrollFrameTemplate')
f.scroll:SetPoint('TOPLEFT', f, 8, -30)
f.scroll:SetPoint('BOTTOMRIGHT', f, -30, 8)


-- EditBox
f.textArea = CreateFrame("EditBox", '$parentEditBox', f.scroll)
f.textArea:SetAutoFocus(false)
f.textArea:SetMultiLine(true)
f.textArea:SetFontObject(GameFontHighlightSmall)
f.textArea:SetMaxLetters(99999)
f.textArea:EnableMouse(true)
f.textArea:SetScript("OnEscapePressed", f.textArea.ClearFocus)
f.textArea:SetWidth(450)												-- XXX why the fuck doesn't SetPoint work on the editbox?


-- Scroll Child
f.scroll:SetScrollChild(f.textArea)
-- f.scroll:SetScrollChild(editbox)


-- Toggle
f.toggle = CreateFrame('Button', "$parent_ToggleButton", UIParent)			-- , UIPanelButtonTemplate)									-- f.toggle = CreateFrame('Button', '$parentToggleButton', f, 'UIPanelCloseButton')
f.toggle:SetSize(30, 30)
f.toggle:SetPoint('BOTTOMLEFT', f, 'BOTTOMRIGHT', 10, 0)
f.toggle:SetNormalTexture([=[Interface\BUTTONS\UI-Panel-CollapseButton-Disabled]=])													-- f.toggle:SetNormalTexture([=[Interface\BUTTONS\UI-GuildButton-PublicNote-Disabled]=])
f.toggle:SetHighlightTexture([=[Interface\BUTTONS\UI-Panel-CollapseButton-Up]=])												-- f.toggle:SetHighlightTexture([=[Interface\BUTTONS\UI-GuildButton-PublicNote-Up]=])
f.toggle:GetHighlightTexture():SetAllPoints(f.toggle:GetNormalTexture())
f.toggle:Show()
f.toggle:SetScript('OnMouseUp', function(self)
	if (TruDumpwindow:IsShown()) then
		TruDumpwindow:Hide()

		self:Show()
	else
		TruDumpwindow:Show()
	end
end)

-- f.toggle:HookScript("OnHide", function(self)
	-- self:Show()
	-- print('HookScript', 'OnHide')
-- end)

-- f.toggle = CreateFrame('Button', '$parentToggleButton', f)													-- f.toggle = CreateFrame('Button', '$parentToggleButton', f, 'UIPanelCloseButton')
-- f.toggle:SetPoint('BOTTOMLEFT', f, 'BOTTOMRIGHT', 10, 0)
-- f.toggle:SetSize(20, 20)
-- f.toggle:SetNormalTexture(C["Dev"]["Dump"]["ButtonNormal"])
-- f.toggle:GetNormalTexture():SetSize(20, 20)
-- f.toggle:SetHighlightTexture(C["Dev"]["Dump"]["ButtonHighlight"])
-- f.toggle:GetHighlightTexture():SetAllPoints(f.toggle:GetNormalTexture())
-- f.toggle:Show()
-- f.toggle:SetScript('OnMouseUp', function(self)
	-- if (TruDumpwindow:IsShown()) then
		-- TruDumpwindow:Hide()
		-- return
	-- end
	-- TruDumpwindow:Show()
-- end)


-- local editbox = CreateFrame('EditBox', '$parentEditBox', f)
-- editbox:SetSize(f:GetWidth() - pad, f:GetHeight() - pad)
-- editbox:SetFontObject(ChatFontNormal)
-- editbox:SetFont(unpack(C["Dev"]["Dump"]["Font"]))

-- editbox:SetAutoFocus(false)
-- editbox:EnableMouse(true)
-- editbox:SetMultiLine(true)
-- editbox:SetMaxLetters(99999)


