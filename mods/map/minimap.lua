local A, C, G, L = select(2, ...):Unpack()

if (not C["Map"]["Enable"] or not C["Map"]["Minimap"]["Enable"]) then
	return
end

local print = function(...)
	A.print("Minimap", ...)
end

local OnEvent


local F = CreateFrame("Frame", "Truth_MinimapFrame", UIParent)
local coord = F:CreateFontString("MyAddOnText", "OVERLAY")



OnEvent = function()
   F:SetWidth(125)
   F:SetHeight(15)
   F:SetPoint("TOP", Minimap, "BOTTOM", 0, -5)							-- Puts our frame at near the center bottom of the Minimap down 10 pixels from the bottom of the Minimap

   coord:SetFontObject(GameFontNormalSmall)
   coord:SetPoint("CENTER", F, 0, 0)							-- Puts the text dead center in our frame element
   coord:SetJustifyH("CENTER")										-- Sets the text justification
   coord:SetText("Hello")

   F:SetScript("OnUpdate", function()
      local x, y = GetPlayerMapPosition("player")
      local posX, posY = abs(x * 100), abs(y * 100)
      coord:SetFormattedText("%.1f, %.1f", posX, posY)
   end)
end

F:SetScript('OnEvent', OnEvent)
F:RegisterEvent('PLAYER_ENTERING_WORLD')
-- F:RegisterEvent('PLAYER_LOGIN')