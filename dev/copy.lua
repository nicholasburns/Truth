local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["Enable"] or not C["Dev"]["Copy"]["Enable"]) then
	return
end

local M = C["Dev"]["Copy"]

local tconcat = table.concat
local tinsert = table.insert

local MARGIN, PAD = G.MARGIN, G.PAD





----------------------------------------------------------------------------------------------------
--	XML
----------------------------------------------------------------------------------------------------
local CopyThatFrame = CreateFrame('Frame', "CopyThatFrame", UIParent, "DialogBoxFrame")
A.MakeMovable(CopyThatFrame)
CopyThatFrame:Size(500, 400)
CopyThatFrame:Template("TRANSPARENT")
CopyThatFrame:Hide()
table.insert(UISpecialFrames, "CopyThatFrame")


CopyThatFrame.Title = CopyThatFrame:CreateFontString("CopyThatFrameText", 'ARTWORK', 'GameFontHighlight')
CopyThatFrame.Title:SetPoint('TOPLEFT', CopyThatFrame, 5, -5)


CopyThatFrame.Scroll = CreateFrame("ScrollFrame", "CopyThatFrameScroll", CopyThatFrame, 'UIPanelScrollFrameTemplate')
CopyThatFrame.Scroll:Size(455, 330)
CopyThatFrame.Scroll:Point('TOP', -10, -16)
CopyThatFrame.Scroll.ScrollBar:SkinScrollBar()


CopyThatFrame.ScrollText = CreateFrame("EditBox", "CopyThatFrameScrollText", CopyThatFrame)		-- CopyThatFrame.Scroll)
CopyThatFrame.ScrollText:Size(450, 344)
CopyThatFrame.ScrollText:Template("CLASSCOLOR")
CopyThatFrame.ScrollText:SetMultiLine(true)
CopyThatFrame.ScrollText:SetMaxLetters(99999)
CopyThatFrame.ScrollText:EnableMouse(true)
CopyThatFrame.ScrollText:SetAutoFocus(true)
CopyThatFrame.ScrollText:SetFontObject("ChatFontNormal")
--	CopyThatFrame.ScrollText:SetScript("OnTextChanged", function(self)
--		CopyThat:OnTextChanged(self)
--	end)
CopyThatFrame.ScrollText:SetScript("OnEscapePressed", function(self)
	CopyThat:Hide(self)
end)


CopyThatFrame.Scroll:SetScrollChild(CopyThatFrame.ScrollText)


local Close = CreateFrame("Button", "$parent_CloseButton", CopyThatFrame, 'UIPanelCloseButton')	Close:SkinCloseButton()

local Resize = CreateFrame("Button", "$parent_ResizeButton", CopyThatFrame)					Resize:SkinResizeButton()

----------------------------------------------------------------------------------------------------

CopyThat = {}
CopyThat.Lines = {}
CopyThat.Texts = nil


function CopyThat:ScrapeMouseoverFrame()
	local Name  = GetMouseFocus():GetName()
	local Frame = _G[Name]

	if (Frame) then
		if (Frame == WorldFrame) then
			Frame = UIParent
		end

		CopyThat:ScrapeTopFrame(Frame)		-- (GetMouseFocus())
	end
end
function CopyThat:ScrapeGameTooltip()
	CopyThat:ScrapeTopFrame(GameTooltip)
end


function CopyThat:ScrapeTopFrame(F)			-- if (F == nil) then return end
	CopyThat.Lines = {}

	self:ScrapeFrame(F)

	self.Texts = tconcat(self.Lines, "\n")

	local name = F:GetName() or ""
	CopyThatFrameText:SetText(name .. " Text")
	CopyThatFrameScrollText:SetText(self.Texts)

	CopyThatFrame:Show()
end


function CopyThat:ScrapeFrame(F)				-- if (F == nil) then return end
	local Lines = { F:GetRegions() }

	for i = #Lines, (1), -1 do
		if (Lines[i]:GetObjectType() == "FontString") then
			tinsert(self.Lines, Lines[i]:GetText())
		end
	end

	local children = { F:GetChildren() }

	for j = 1, (#children) do
		self:ScrapeFrame(children[j])
	end
end


function CopyThat:OnTextChanged(this)
	if (this:GetText() ~= self.Texts) then
		this:SetText(self.Texts)
	end

	local ScrollBar = CopyThatFrameScrollScrollBar

	this:GetParent():UpdateScrollChildRect()

	local _, m = ScrollBar:GetMinMaxValues()

	if (m > 0 and this.max ~= m) then
		this.max = m

		ScrollBar:SetValue(m)
	end
end


function CopyThat:Hide()
	CopyThatFrame:Hide()
end



--------------------------------------------------
--	Slash
--------------------------------------------------
_G.SlashCmdList["COPYTEXT"] = function(FrameName)
	local Frame = _G[FrameName]

	if (Frame and Frame.GetName) then
		CopyThat:ScrapeTopFrame(Frame)
	end
end

_G["SLASH_COPYTEXT1"] = "/ct"



