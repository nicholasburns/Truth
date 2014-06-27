local A, C, G, L = select(2, ...):Unpack()

if (not C["AOM"]["Enable"]) then
	return
end

local M = C["AOM"]

local print = function(...) A.print('AOM', ...) end

if (IsAddOnLoaded('AOM')) then
	A.print('AOM detected (as standalone)', 'Truth version of AOM aborted') return
end

local ipairs, pairs, select = ipairs, pairs, select
local table, concat, tinsert, sort = table, table.concat, table.insert, table.sort
local match, sub, upper = string.match, string.sub, string.upper

local ReloadUI = ReloadUI
local PlaySound = PlaySound
local CreateFrame = CreateFrame
local GetAddOnInfo = GetAddOnInfo
local HideUIPanel, ShowUIPanel = HideUIPanel, ShowUIPanel


--------------------------------------------------
local MARGIN = G.MARGIN or 10
local PAD = G.PAD or 5

local PANEL_MARGIN_TOP = G.PANEL_MARGIN_TOP or 28
local PANEL_MARGIN_BOTTOM = G.PANEL_MARGIN_BOTTOM or 50

local SCROLLBAR_WIDTH = G.SCROLLBAR_WIDTH or 28

local CHECKBUTTON_SIZE = G.CHECKBUTTON_SIZE or 16

local BUTTON_WIDTH = G.BUTTON_WIDTH or 150
local BUTTON_HEIGHT = G.BUTTON_HEIGHT or 22


--------------------------------------------------
--	Addon Frame
--------------------------------------------------
local F = CreateFrame('Frame', "AOM", UIParent)
F:SetWidth(M["Width"] or 400)
F:SetHeight(M["Height"] or 800)
F:ClearAllPoints()
F:SetPoint('CENTER')
F:SetMinResize(200, 400)
F:SetMaxResize(0, 0)
F:SetFrameStrata('DIALOG')
F:Template("TRANSPARENT")
F:Hide()
F:SetScript("OnHide", function() GameMenuFrame:Show() end)
tinsert(UISpecialFrames, "AOM")
A.MakeMovable(F)

----------------------------------------------------------------------------------------------------
--	Elements
----------------------------------------------------------------------------------------------------
local Title = F:CreateFontString(nil, 'OVERLAY', 'GameFontNormalLarge')
Title:SetHeight(PANEL_MARGIN_TOP)
Title:SetPoint('TOPLEFT', MARGIN, -MARGIN)
Title:SetPoint('TOPRIGHT', -SCROLLBAR_WIDTH, -MARGIN)
Title:SetJustifyH('CENTER')
Title:SetText('ADDON MANAGER <AOM>')

local ScrollFrame = CreateFrame("ScrollFrame", "$parent_ScrollFrame", F, 'UIPanelScrollFrameTemplate')
ScrollFrame:Point('TOPLEFT', F, MARGIN, -(PANEL_MARGIN_TOP + MARGIN))
ScrollFrame:Point('BOTTOMRIGHT', F, -SCROLLBAR_WIDTH, PANEL_MARGIN_BOTTOM)
ScrollFrame:Template("TRANSPARENT")
ScrollFrame.ScrollBar:SkinScrollBar()

local Panel = CreateFrame('Frame', "$parent_Panel", ScrollFrame)
Panel:SetWidth(M["Width"] - (MARGIN + PAD * 2 + SCROLLBAR_WIDTH))
Panel:SetHeight(M["Height"] - (PANEL_MARGIN_TOP + MARGIN * 2 + PANEL_MARGIN_BOTTOM))
Panel:SetAllPoints(ScrollFrame)

ScrollFrame:SetScrollChild(Panel)

local CloseButton = CreateFrame("Button", "$parent_CloseButton", F, 'UIPanelCloseButton')
CloseButton:SkinCloseButton()

local ResizeButton = CreateFrame("Button", "$parent_ResizeButton", F)
ResizeButton:SkinResizeButton()					-- ResizeButton:SetPoint('BOTTOMRIGHT', -1, 1)

local ReloadButton = CreateFrame("Button", "$parent_ReloadButton", F, 'UIPanelButtonTemplate')
ReloadButton:SetSize(BUTTON_WIDTH, BUTTON_HEIGHT)
ReloadButton:SetPoint('BOTTOM', 0, MARGIN)
ReloadButton:SkinButton()
ReloadButton:SetText("Reload")
ReloadButton:SetScript("OnClick", function() ReloadUI() end)


--------------------------------------------------
local GetDependencies = function(AddOn)
	local output = ""
	local dependencies = GetAddOnDependencies(AddOn)

	if (dependencies) then
		for i = 1, select("#", dependencies) do
			if (i == 1) then
				output = "|n|n|cffFF4400Dependencies: " .. select(i, dependencies)
			else
				output = output .. ", " .. select(i, dependencies)
			end
		end
	end

	return output .. "|r"
end


--------------------------------------------------
local LoadAddonManager = function()
	local AddOns = {}

	for i = 1, (GetNumAddOns()) do
		AddOns[i] = select(1, GetAddOnInfo(i))
	end

	sort(AddOns)


	for i, AddOn in ipairs(AddOns) do
		local Name, Title, Notes, Enabled = GetAddOnInfo(AddOn)

		----------------------------------------
		--	Row
		----------------------------------------
		local Row = CreateFrame("Button", "Row" .. i, Panel, 'SecureActionButtonTemplate')
		Row:SetSize(Panel:GetWidth(), CHECKBUTTON_SIZE + 2)

		if (i == 1) then
			Row:SetPoint('TOPLEFT', Panel, PAD, -MARGIN)
		else
			Row:SetPoint('TOPLEFT', _G["Row" .. i - 1], 'BOTTOMLEFT', 0, -2)
		end

		local highlight = Row:CreateTexture(nil, nil, Row)
		highlight:SetTexture(1, 1, 1, 0.3)
		highlight:SetInside()
		Row:SetHighlightTexture(highlight)

		--	 Row.highlight = Row:CreateTexture(nil, "HIGHLIGHT ", Row)
		--	 Row.highlight:SetTexture(1, 1, 1, 0.3)
		--	 Row.highlight:SetAllPoints()
		--	 Row:SetHighlightTexture(Row.highlight)


		----------------------------------------
		--	CheckButton
		----------------------------------------
		local Check = CreateFrame("CheckButton", AddOn .. "_CheckButton", Row, 'InterfaceOptionsCheckButtonTemplate')
		Check:SetPoint('TOPLEFT', MARGIN * 2, 0)
		Check:SkinCheckButton(CHECKBUTTON_SIZE)
		if (Enabled) then
			Check:SetChecked(true)
		else
			Check:SetChecked(false)
		end

		--	Text Anchor
--		local TextAnchor = CreateFrame('Frame', "$parent_BackdropForText", Check)
--		TextAnchor:SetWidth(200)
--		TextAnchor:Point("LEFT", Check, "RIGHT", PAD, 0)
--		TextAnchor:Point("RIGHT", Row, -PAD, 0)
--		TextAnchor:Template("CLASSCOLOR")

		--	Text
		local Text = Check:CreateFontString(nil, "BACKGROUND", 'GameFontNormal')
--		Text:SetPoint("CENTER", TextAnchor, 0, 0)
		Text:Point("LEFT", Check, "RIGHT", PAD, 0)
		Text:SetFont(unpack(A.default.font))
		Text:SetText(Title)


		----------------------------------------
		--	Tooltip Text
		----------------------------------------
		local Tiptext
		local Dependencies = GetDependencies(AddOn)

		Title = Title and ("%s|r"):format(Title)
		Notes = Notes and ("|n|cffFFFFFF".. Notes .."|r") or "|n|n|cffFF4400[No Addon Notes]|r|n"

	--[[ if (GetAddOnDependencies(AddOn)) then
			for i = 1, select("#", GetAddOnDependencies(AddOn)) do
				if (i == 1) then
					Deps = "|n|n|cffFF4400Dependencies: " .. select(i, GetAddOnDependencies(AddOn))
				else
					Deps =  Deps .. ", " .. select(i, GetAddOnDependencies(AddOn))
				end
			end
		else
			Deps = ""
		end
	--]]

		Tiptext = ("%s%s%s"):format(Title, Notes, Dependencies)								-- Tiptext = Title .. Notes .. Dependencies

		----------------------------------------
		--	Events
		----------------------------------------
		local OnEnter = function()
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(Row, "ANCHOR_LEFT")									-- GameTooltip:SetOwner(self, "ANCHOR_TOPRIGHT")
			GameTooltip:AddLine(Tiptext)												-- GameTooltip:AddLine(Title) -- GameTooltip:AddLine(Notes)
			GameTooltip:Show()
		end

		local OnLeave = function()
			GameTooltip:Hide()
		end

		local OnClick = function()													-- local OnMouseDown = function()
			if (Enabled) then
				Check:SetChecked(false)
				DisableAddOn(Name)
				Enabled = false
			else
				Check:SetChecked(true)
				EnableAddOn(Name)
				Enabled = true
			end
		end

		Check:SetScript("OnEnter", OnEnter)
		Check:SetScript("OnLeave", OnLeave)
		Check:SetScript("OnClick", OnClick)												-- Check:SetScript("OnMouseDown", OnMouseDown)

		Row:SetScript("OnEnter", OnEnter)
		Row:SetScript("OnLeave", OnLeave)
		Row:SetScript("OnClick", OnClick)												-- Row:SetScript("OnMouseDown", OnMouseDown)
	end
end


--------------------------------------------------
--	Events
--------------------------------------------------
local loader = CreateFrame('Frame')
loader:RegisterEvent('PLAYER_ENTERING_WORLD')
loader:SetScript('OnEvent', function(self, event, addon)
	LoadAddonManager()
	self:UnregisterEvent('PLAYER_ENTERING_WORLD')
end)


--------------------------------------------------
--	Game Menu
--------------------------------------------------
local GameMenuFrame = GameMenuFrame

GameMenuFrame:Strip()
GameMenuFrame:Template("DEFAULT")

local GameMenuButtons = {
	"Help",
	"Store",
	"Options",
	"UIOptions",
	"Keybindings",
	"Macros",
	"MacOptions",
	"Logout",
	"Quit",
	"Continue",
}
for _, button in ipairs(GameMenuButtons) do
	_G["GameMenuButton" .. button]:SkinButton()
end
GameMenuButtons = nil

local AddonButton = CreateFrame("Button", "$parent_AddonButton", GameMenuFrame, "GameMenuButtonTemplate")
AddonButton:Point('BOTTOM', GameMenuFrame, 'TOP', 0, 15)
AddonButton:Width(AddonButton:GetWidth() + 50)
AddonButton:Height(AddonButton:GetHeight() + 10)
AddonButton:SkinButton()
AddonButton:SetText(ADDONS)
AddonButton:SetScript("OnClick", function()
	if (InCombatLockdown()) then
		return
	end
	GameMenuFrame:Hide()
	F:Show()
end)


_G["SLASH_TRUTH_AOM1"] = "/aom"
_G.SlashCmdList["TRUTH_AOM"] = function()
	GameMenuFrame:Hide()
	F:Show()
end

--------------------------------------------------
--	Notes
--------------------------------------------------
--[[	Dumps

	select(1, GetAddOnInfo("Truth")) -->
		[1] = 'Truth',
		[2] = 'Truth',
		[4] = 1,
		[5] = 1,
		[7] = 'INSECURE',

--]]

--[[	+--------------+
	|   F.addon    |
	+--------------+------------------------+
	|	TipTac						|
	|	Tooltip Enhancement Addon		|
	|	Dependencies: Truth				|
	+---------------------------------------+
--]]

--[[	F:SetBackdrop({bgFile = [=[Interface\Buttons\WHITE8x8]=]})
	F:SetBackdropColor(.2, .2, .2, 1)
	F:SetBackdrop({bgFile = Addon.default.backdrop.textureAlt}) 					-- F:SetBackdrop({bgFile = [=[Interface\Buttons\WHITE8x8]=]})
	F:SetBackdropColor(unpack(Addon.default.backdrop.colorAlt)) 					-- F:SetBackdropColor(.2, .2, .2, 1)
--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[==[ -- Addon List

local AddOns = {}
local Rows = {}

do
	for i = 1, (GetNumAddOns()) do
		AddOns[i] = select(1, GetAddOnInfo(i))
	end
	sort(AddOns)


	local point = {'TOP', Panel, 0, -10}

	for i, AddOn in ipairs(AddOns) do
		local name, title, notes, enabled = GetAddOnInfo(AddOn)

	--[[ -- Row
		local row = CreateFrame("Button", "$parent_Row" .. i, Panel)
		row:Point(unpack(point))
		row:Point("LEFT", 16, 0)
		row:Point("RIGHT", -(16 * 2 - 8), 0)
		row:Height(20)

		point = {'TOP', row, 'BOTTOM', 0, -2}
		Rows[i] = row

		-- Check
		local b = CreateFrame("Button", AddOn .. "_CheckButton", Panel)						-- "SecureActionButtonTemplate")
		b:Size(16, 16)
		b:Point("LEFT", row, 0, 0)
		b:SetFrameLevel(Panel:GetFrameLevel() + 1)
		b:Template()

		row.check = b
	--]]

		-- Text
		local text = b:CreateFontString(nil, 'OVERLAY')
		text:Point('LEFT', b, 'RIGHT', 10, 1)
		text:SetFont(unpack(A.default.font))
		text:SetText(title)

		row.text = text

		--====================================--
		--	Scripts
		--====================================--
		local dependencies = GetDependencies(AddOn)

		b:SetScript("OnEnter", function(self)
			GameTooltip:ClearLines()
			GameTooltip:SetOwner(self, "ANCHOR_RIGHT")
			GameTooltip:AddLine(title)		--   1, 1, 1)
			GameTooltip:AddLine(notes)		-- 0.5, 0.5, 0.5)
			GameTooltip:AddLine(dependencies and dependencies or '')	-- nil, nil, nil, 1)
			GameTooltip:Show()
		end)

		b:SetScript("OnLeave", function()
			GameTooltip:Hide()
		end)

		b:SetScript("OnClick", function()
			PlaySound((enabled and 'gsLoginChangeRealmCancel' or 'igMainMenuOptionCheckBoxOn'), 'Master')

			if (enabled) then
				b:SetBackdropBorderColor(1, 0, 0)
				DisableAddOn(name)
				enabled = false
			else
				b:SetBackdropBorderColor(0, 1, 0)
				EnableAddOn(name)
				enabled = true
			end
		end)
	end
end
--]==]

--------------------------------------------------
--	Unused Sort Function
--------------------------------------------------
--[[ local function sortAddonsByName(a, b)
		return a < b
	end
--]]

--[[ table.concat (list, [sep], [i], [j],)

	●  All elements must be STRINGS or NUMBERS

	●  Return
		- list[i] .. sep .. list[i+1] ··· sep .. list[j]
		- string value

	●  Defaults
		- sep:	Empty string
		- i:		1
		- j:		#list

	[NOTE]: If (i > j) then it returns empty string

	---------------------------------------------
	table.concat({ 1, 2, "three", 4, "five" })
	> 12three4five

	table.concat({ 1, 2, "three", 4, "five" }, ", ")
	> 1, 2, three, 4, five

	table.concat({ 1, 2, "three", 4, "five" }, ", ", 2)
	> 2, three, 4, five

	table.concat({ 1, 2, "three", 4, "five" }, ", ", 2, 4)
	> 2, three, 4
--]]

--[[ local Sort = function(t, func)
		local temp = {}

		for n in pairs(t) do
			insert(temp, n)
		end

		sort(temp, func) -- func)
	  -- table.sort(temp, func) -- func)


		-- Iterator
		local i = 0

		local iter = function()
			i = i + 1

			if (temp[i] == nil) then
				return nil
			else
				return temp[i], t[ temp[i] ]
			end
		end

		return iter
	end
--]]

--------------------------------------------------
--	Reference
--------------------------------------------------
--[[ SetAnchorType
--~  Sets the method for anchoring the tooltip relative to its owner

	[use]
	GameTooltip:SetAnchorType(anchor, [X-off], [Y-off])

	[args]
	• anchor - Token identifying the positioning method for the tooltip relative to its owner frame (string)

		• ANCHOR_BOTTOMLEFT - Align the top right of the tooltip with the bottom left of the owner
		• ANCHOR_CURSOR - Toolip follows the mouse cursor
		• ANCHOR_LEFT - Align the bottom right of the tooltip with the top left of the owner
		• ANCHOR_NONE - Tooltip appears in the default position
		• ANCHOR_PRESERVE - Tooltip's position is saved between sessions (useful if the tooltip is made user-movable)
		• ANCHOR_RIGHT - Align the bottom left of the tooltip with the top right of the owner
		• ANCHOR_TOPLEFT - Align the bottom left of the tooltip with the top left of the owner
		• ANCHOR_TOPRIGHT - Align the bottom right of the tooltip with the top right of the owner

	• xOffset - Horizontal distance from the anchor to the tooltip (number)
	• yOffset - Vertical distance from the anchor to the tooltip (number)

--]]

--------------------------------------------------
--	Debugging
--------------------------------------------------
--[[ show:SetScript('OnClick', function()
	  -- willplay [flag]:  returns true if the sound will be played nil otherwise
		local willplay = PlaySound('igMainMenuOption', 'Master')
	  -- Error Message: only displays if the sound will not be played (mostly for sound typos)
		if (not willplay) then
			print('<F> AOMGameMenuButton: Sound returned nil')
		end
		HideUIPanel(GameMenuFrame)
		F:Show()
	end)
--]]

