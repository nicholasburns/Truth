local format = string.format
local print = print
local tostring = tostring
local type = type
local unpack = unpack
local concat = table.concat
local UIParent = UIParent
local WorldFrame = WorldFrame
local DEFAULT_CHAT_FRAME = DEFAULT_CHAT_FRAME
local FONT_COLOR_CODE_CLOSE = FONT_COLOR_CODE_CLOSE
local GetMouseFocus = GetMouseFocus
--------------------------------------------------
--	Addon
--------------------------------------------------
local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["Dump"]) then return end

local Truth = A 							-- local Truth = _G[AddOn]




--------------------------------------------------
--	Color
--------------------------------------------------
local CFF = {}
CFF["r"] 		= A.color.r.cff
CFF["g"] 		= A.color.g.cff
CFF["b"] 		= A.color.b.cff
CFF["RED"]	= A.color.red.cff
CFF["GREEN"]	= A.color.green.cff
CFF["BLUE"]	= A.color.blue.cff
CFF["WHITE"]	= A.color.white.cff
CFF["GREY"]	= A.color.grey.cff
CFF["BLACK"]	= A.color.black.cff
CFF["YELLOW"]	= NORMAL_FONT_COLOR_CODE

--------------------------------------------------
--	Dump Printer
--------------------------------------------------
local D
do
	local format = string.format
	local tostring = tostring

	D = function(Key, Value, ...)
		if (not Key) then return end

		local Dots = ... and ... or ""

		Key   = format("%s%s|r ", CFF["YELLOW"], tostring(Key))
		Value = format("%s%s|r",  CFF["WHITE"],  tostring(Value and Value or " "))
		Dots  = (...) and (CFF["GREY"] .. ...) or " "

		print("     ", format("%s  %s", Key, Value), Dots)
	end
end

--------------------------------------------------
--	Keybind Accessable
--------------------------------------------------
function Truth:DebugFrameAtCursor()
	local o = GetMouseFocus()
	if (o) then
		if (o ~= WorldFrame and o ~= UIParent) then
			-- Truth:Dump(o)
			Truth:Dumper(o)
		end
	end
end

--------------------------------------------------
--	Dump
--------------------------------------------------
function Truth:Dump(F)
 --[[ Output
      --------------------------------------------
      Frame     PlayerFrame (UIParent)
      Size      232.0, 100.0
      Point     TOPLEFT, UIParent, TOPLEFT, -19, -4
      Scale     1.0 (0.6)
      Alpha     1.0 (1.0)
      Strata    LOW (1)
      --------------------------------------------
 --]]
	if (type(F) ~= "table") then return end

	local Parent = F:GetParent() and F:GetParent() or UIParent

	local p1, p2, p3, p4, p5 = F:GetPoint()
	p2 = p2 and p2 or UIParent

	D(L["DIV"])

	D(L["FRAME"],  format("  %s", F:GetName()), format("(%s)", (F ~= Parent) and Parent:GetName() or L["UNKNOWN"]))					-- print(L["PARENT"], format("  (%s)", (F ~= Parent) and Parent:GetName() or L["UNKNOWN"]))
	D(L["SIZE"],   format("   %.1f,", F:GetWidth()), format("%.1f", F:GetHeight()))
	D(L["POINT"],  format("  %s, %s, %s, %.0f, %.0f  ", p1, p2:GetName(), p3, format("%.1f", p4), format("%.1f", p5)))
	D(L["SCALE"],  format("  %.1f", F:GetScale()), format("(%.1f)", F:GetEffectiveScale()))
	D(L["ALPHA"],  format("  %.1f", F:GetAlpha()), format("(%.1f)", F:GetEffectiveAlpha()))
	D(L["STRATA"], format(" %s", F.GetFrameStrata and F:GetFrameStrata()), format("(%d)", F:GetFrameLevel()))

	D(L["DIV"])
end

--------------------------------------------------
-- Cleanup Function
--------------------------------------------------
--[[

      ----------------------------------------------
      Name   PlayerFrame
      Type   Button
      Parent   UIParent
      Width   232.0
      Height   100.0
      Scale   1.0
      EffectiveScale   0.6
      Point     TOPLEFT, UIParent, TOPLEFT, -19, -4
      Top   1196.0
      Right   213.0
      Bottom   1096.0
      Left   -19.0
      Strata   LOW
      Level   1
      TopLevel   true
      Shown   true
      Visible   true
      Visible   true
      Alpha   1.0
      EffectiveAlpha   1.0
      UserPlaced   false
      Movable   true
      Resizable   false
      KeyboardEnabled   false
      MouseEnabled   true
      MouseWheelEnabled   false
      ----------------------------------------------


--]]
function Truth:Dumper(o)

	D(L["DIV"])
	-------------------------------------------
	-- Frame

	--[[	Name  PlayerFrame
		Type  Button
		Parent  UIParent ]]
	-- L["NAME"] = "Name"
	-- L["TYPE"] = "Type"
	-- L["PARENT"] = "Parent"
	D(L["NAME"], o:GetName())
	D(L["TYPE"], o.GetObjectType and o:GetObjectType() or L["UNKNOWN"])
	local parent = o:GetParent() and o:GetParent() or UIParent
	D(L["PARENT"], (o ~= parent) and parent:GetName() or L["UNKNOWN"])
	-------------------------------------------
	-- Size
	--[[ Width  232.0
		Height  100.0
		Scale  1.0
		EffectiveScale  0.6 ]]
	-- L["WIDTH"] = "Width"
	-- L["HEIGHT"] = "Height"
	-- L["SCALE"] = "Scale"
	-- L["EFFECTIVE_SCALE"] = "EffectiveScale"
	D(L["WIDTH"],  format("%.1f", o:GetWidth()))
	D(L["HEIGHT"], format("%.1f", o:GetHeight()))
	D(L["SCALE"],  format("%.1f", o:GetScale()))
	D(L["EFFECTIVE_SCALE"], format("%.1f", o:GetEffectiveScale()))
	-------------------------------------------
	-- Position
	--[[	Point  TOPLEFT, UIParent, TOPLEFT, -19, -4
		Top  1196.0
		Left  213.0
		Bottom  1096.0
		Right  -19.0 ]]
	-- L["POINT"] = "Point"
	-- L["TOP"] = "Top"
	-- L["RIGHT"] = "Right"
	-- L["BOTTOM"] = "Bottom"
	-- L["LEFT"] = "Left"
	local p1, p2, p3, p4, p5 = o:GetPoint()
	p2 = p2 and p2 or UIParent
	D(L["POINT"],  format("  %s, %s, %s, %.0f, %.0f  ", p1, p2:GetName(), p3, format("%.1f", p4), format("%.1f", p5)))
	D(L["TOP"],    format("%.1f", o:GetTop()))
	D(L["RIGHT"],  format("%.1f", o:GetRight()))
	D(L["BOTTOM"], format("%.1f", o:GetBottom()))
	D(L["LEFT"],   format("%.1f", o:GetLeft()))
	-------------------------------------------
	-- Stack Order
	--[[ Strata  LOW
		Level  1
		TopLevel  true ]]
	-- L["STRATA"] = "Strata"
	-- L["LEVEL"] = "Level"
	-- L["TOPLEVEL"] = "TopLevel"
	D(L["STRATA"], o.GetFrameStrata and o:GetFrameStrata())
	D(L["LEVEL"], o.GetFrameLevel and o:GetFrameLevel())
	D(L["TOPLEVEL"], o.IsToplevel and o:IsToplevel() and "true" or "false")
	-------------------------------------------
	-- Visibility
	--[[	Shown  true
		Visible  true
		Alpha  1.0
		EffectiveAlpha  1.0 ]]
	-- L["SHOWN"] = "Shown"
	-- L["VISIBLE"] = "Visible"
	-- L["ALPHA"] = "Alpha"
	-- L["EFFECTIVE_ALPHA"] = "EffectiveAlpha"
	D(L["SHOWN"], o.IsShown and o:IsShown() and "true" or "false")
	D(L["VISIBLE"], o.IsShown and o.IsVisible and o:IsVisible() and "true" or "false")
	D(L["ALPHA"], format("%.1f", o:GetAlpha()))
	D(L["EFFECTIVE_ALPHA"], format("%.1f", o:GetEffectiveAlpha()))
	-------------------------------------------
	-- Responds to User
	--[[ UserPlaced  false
		Movable  true
		Resizable  false ]]
	-- L["USER_PLACED"] = "UserPlaced"
	-- L["MOVABLE"] = "Movable"
	-- L["RESIZABLE"] = "Resizable"
	D(L["USER_PLACED"], o.IsUserPlaced and o:IsUserPlaced() and "true" or "false")
	D(L["MOVABLE"],     o.IsMovable and o:IsMovable() and "true" or "false")
	D(L["RESIZABLE"],   o.IsResizable and o:IsResizable() and "true" or "false")
	-------------------------------------------
	-- Responds to Hardware
	--[[ KeyboardEnabled  false
		MouseEnabled  true
		MouseWheelEnabled  false ]]
	-- L["KEYBOARD_ENABLED"] = "KeyboardEnabled"
	-- L["MOUSE_ENABLED"] = "MouseEnabled"
	-- L["MOUSEWHEEL_ENABLED"] = "MouseWheelEnabled"
	D(L["KEYBOARD_ENABLED"], o.IsKeyboardEnabled and o:IsKeyboardEnabled() and "true" or "false")
	D(L["MOUSE_ENABLED"], o.IsMouseEnabled and o:IsMouseEnabled() and "true" or "false")
	D(L["MOUSEWHEEL_ENABLED"], o.IsMouseWheelEnabled and o:IsMouseWheelEnabled() and "true" or "false")
	-------------------------------------------
	D(L["DIV"])

end




--------------------------------------------------
--	Backup
--------------------------------------------------
--[==[ Complete List of Dump Info
 

	D(L["DIV"])
	-------------------------------------------
	-- Frame

	--[[	Name  PlayerFrame
		Type  Button
		Parent  UIParent ]]
	-- L["NAME"] = "Name"
	-- L["TYPE"] = "Type"
	-- L["PARENT"] = "Parent"
	D(L["NAME"], o:GetName())
	D(L["TYPE"], o.GetObjectType and o:GetObjectType() or L["UNKNOWN"])
	local parent = o:GetParent() and o:GetParent() or UIParent
	D(L["PARENT"], (o ~= parent) and parent:GetName() or L["UNKNOWN"])
	-------------------------------------------
	-- Size
	--[[ Width  232.0
		Height  100.0
		Scale  1.0
		EffectiveScale  0.6 ]]
	-- L["WIDTH"] = "Width"
	-- L["HEIGHT"] = "Height"
	-- L["SCALE"] = "Scale"
	-- L["EFFECTIVE_SCALE"] = "EffectiveScale"
	D(L["WIDTH"],  format("%.1f", o:GetWidth()))
	D(L["HEIGHT"], format("%.1f", o:GetHeight()))
	D(L["SCALE"],  format("%.1f", o:GetScale()))
	D(L["EFFECTIVE_SCALE"], format("%.1f", o:GetEffectiveScale()))
	-------------------------------------------
	-- Position
	--[[	Point  TOPLEFT, UIParent, TOPLEFT, -19, -4
		Top  1196.0
		Left  213.0
		Bottom  1096.0
		Right  -19.0 ]]
	-- L["POINT"] = "Point"
	-- L["TOP"] = "Top"
	-- L["RIGHT"] = "Right"
	-- L["BOTTOM"] = "Bottom"
	-- L["LEFT"] = "Left"
	local p1, p2, p3, p4, p5 = o:GetPoint()
	p2 = p2 and p2 or UIParent
	D(L["POINT"],  format("  %s, %s, %s, %.0f, %.0f  ", p1, p2:GetName(), p3, format("%.1f", p4), format("%.1f", p5)))
	D(L["TOP"],    format("%.1f", o:GetTop()))
	D(L["RIGHT"],  format("%.1f", o:GetRight()))
	D(L["BOTTOM"], format("%.1f", o:GetBottom()))
	D(L["LEFT"],   format("%.1f", o:GetLeft()))
	-------------------------------------------
	-- Stack Order
	--[[ Strata  LOW
		Level  1
		TopLevel  true ]]
	-- L["STRATA"] = "Strata"
	-- L["LEVEL"] = "Level"
	-- L["TOPLEVEL"] = "TopLevel"
	D(L["STRATA"], o.GetFrameStrata and o:GetFrameStrata())
	D(L["LEVEL"], o.GetFrameLevel and o:GetFrameLevel())
	D(L["TOPLEVEL"], o.IsToplevel and o:IsToplevel() and "true" or "false")
	-------------------------------------------
	-- Visibility
	--[[	Shown  true
		Visible  true
		Alpha  1.0
		EffectiveAlpha  1.0 ]]
	-- L["SHOWN"] = "Shown"
	-- L["VISIBLE"] = "Visible"
	-- L["ALPHA"] = "Alpha"
	-- L["EFFECTIVE_ALPHA"] = "EffectiveAlpha"
	D(L["SHOWN"], o.IsShown and o:IsShown() and "true" or "false")
	D(L["VISIBLE"], o.IsShown and o.IsVisible and o:IsVisible() and "true" or "false")
	D(L["ALPHA"], format("%.1f", o:GetAlpha()))
	D(L["EFFECTIVE_ALPHA"], format("%.1f", o:GetEffectiveAlpha()))
	-------------------------------------------
	-- Responds to User
	--[[ UserPlaced  false
		Movable  true
		Resizable  false ]]
	-- L["USER_PLACED"] = "UserPlaced"
	-- L["MOVABLE"] = "Movable"
	-- L["RESIZABLE"] = "Resizable"
	D(L["USER_PLACED"], o.IsUserPlaced and o:IsUserPlaced() and "true" or "false")
	D(L["MOVABLE"],     o.IsMovable and o:IsMovable() and "true" or "false")
	D(L["RESIZABLE"],   o.IsResizable and o:IsResizable() and "true" or "false")
	-------------------------------------------
	-- Responds to Hardware
	--[[ KeyboardEnabled  false
		MouseEnabled  true
		MouseWheelEnabled  false ]]
	-- L["KEYBOARD_ENABLED"] = "KeyboardEnabled"
	-- L["MOUSE_ENABLED"] = "MouseEnabled"
	-- L["MOUSEWHEEL_ENABLED"] = "MouseWheelEnabled"
	D(L["KEYBOARD_ENABLED"], o.IsKeyboardEnabled and o:IsKeyboardEnabled() and "true" or "false")
	D(L["MOUSE_ENABLED"], o.IsMouseEnabled and o:IsMouseEnabled() and "true" or "false")
	D(L["MOUSEWHEEL_ENABLED"], o.IsMouseWheelEnabled and o:IsMouseWheelEnabled() and "true" or "false")
	-------------------------------------------
	D(L["DIV"])
--]==]


--------------------------------------------------
--	Credits
--------------------------------------------------
--[[ MoveAnything by Wagthaa  (MoveAnything.lua)
--]]

