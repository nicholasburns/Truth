local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["Enable"] or not C["Dev"]["Dump"]["Enable"]) then
	return
end

local Truth = _G[A.ADDON_NAME]

local ipairs = ipairs
local format, tostring = string.format, tostring
local GetMouseFocus = GetMouseFocus


local RIGHT_ARROW = ("  %s  "):format(L["RIGHT_BRACKET"])
local BLUE_CFF_FORMAT  = "|cff3399FF%s|r"
local WHITE_CFF_FORMAT = "|cffFFFFFF%s|r"
local RED_CFF_FORMAT   = "|cffCC3333%s|r"


local D = function(k, v, z, ...)
	k, v, z = tostring(k or " "), tostring(v or ' '), tostring(z or ' ')
	DEFAULT_CHAT_FRAME:AddMessage(("%s|cffFFD200%s|r |cff82C5FF%s|r |cffEEEEEE%s|r "):format(L["INDENT"], k, v, z))
end


function Truth:DebugFrameAtCursor()				-- Keybind Accessable
	local FrameName = GetMouseFocus():GetName()
	local Frame = _G[FrameName]

	if (Frame) then
		if (Frame == WorldFrame) then
			Frame = UIParent
		end
		A.divider()
		Truth:Dumper(Frame)
		A.divider()
	end
end


function Truth:Dumper(F)
	local Parent = F.GetParent and F:GetParent() or WorldFrame
	local p1, p2, p3, p4, p5 = F:GetPoint()

	local Anchor
	if (p2) then
		Anchor = p2
	elseif (F == UIParent) then
		Anchor = WorldFrame
	else
		Anchor = UIParent
	end

	D((RED_CFF_FORMAT .. WHITE_CFF_FORMAT .. BLUE_CFF_FORMAT):format(
		Parent:GetName(),
		RIGHT_ARROW,
		F:GetName()),
		("%s%s%s%s%s"):format(L["TAB"], L["TAB"], L["TAB"], L["TAB"], L["TAB"]), ("|cff999999(%s)|r"):format(F.GetObjectType and F:GetObjectType()
	))

	DEFAULT_CHAT_FRAME:AddMessage(" ")

	local t = {
		{ L["SIZE"],
			("|cffEEEEEE   %.1f,  %.1f |r"):format(F:GetWidth(), F:GetHeight()),
		},
		{ L["POINT"],
			("|cff77BB77 %s |r, |cffC41F3B %s |r, |cff77BB77 %s |r, |cffEEEEEE %.0f |r, |cffEEEEEE %.0f |r"):format(p1, Anchor:GetName(), p3, p4, p5),
		},
		{ L["SCALE"],
			("|cffEEEEEE  %.1f |r"):format(F:GetScale()),
			("|cff999999 %.1f |r"):format(F:GetEffectiveScale()),
		},
		{ L["ALPHA"],
			("|cffEEEEEE %.1f |r"):format(F:GetAlpha()),
			("|cff999999 %.1f |r"):format(F:GetEffectiveAlpha()),
		},
		{ L["STRATA"],
			("|cff77BB77 %s |r"):format(F.GetFrameStrata and F:GetFrameStrata()),
			("|cff999999 %d |r"):format(F:GetFrameLevel()),
		},
	}

	for _, row in ipairs(t) do
		D(row[1], row[2], row[3], row[4])
	end
end


--------------------------------------------------
--	Backup
--------------------------------------------------
 --[[
      --------------------------------------------
      Frame     PlayerFrame (UIParent)
      Size      232.0, 100.0
      Point     TOPLEFT, UIParent, TOPLEFT, -19, -4
      Scale     1.0 (0.6)
      Alpha     1.0 (1.0)
      Strata    LOW (1)
      --------------------------------------------
--]]
--[[
     ----------------------------------------------
      Type   CheckButton
      Name   ActionButton1
      Parent   MainMenuBarArtFrame

      Width   36.0
      Height   36.0
      Scale   1.0
      EScale   0.6

      Point     BOTTOMLEFT, MainMenuBarArtFrame, BOTTOMLEFT, 8, 4
     ----------------------------------------------
--]]



--------------------------------------------------
--	Backup
--------------------------------------------------
--[==[ function Truth:Dump(F)
--[[  Output
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
	D(L["DIV"])

	local Parent = F:GetParent() and F:GetParent() or UIParent
	local p1, p2, p3, p4, p5 = F:GetPoint()
	p2 = p2 and p2 or UIParent

	D(L["FRAME"],  format("  %s", F:GetName()), format("(%s)", (F ~= Parent) and Parent:GetName() or L["UNKNOWN"]))					-- print(L["PARENT"], format("  (%s)", (F ~= Parent) and Parent:GetName() or L["UNKNOWN"]))
	D(L["SIZE"],   format("   %.1f,", F:GetWidth()), format("%.1f", F:GetHeight()))
	D(L["POINT"],  format("  %s, %s, %s, %.0f, %.0f  ", p1, p2:GetName(), p3, format("%.1f", p4), format("%.1f", p5)))
	D(L["SCALE"],  format("  %.1f", F:GetScale()), format("(%.1f)", F:GetEffectiveScale()))
	D(L["ALPHA"],  format("  %.1f", F:GetAlpha()), format("(%.1f)", F:GetEffectiveAlpha()))
	D(L["STRATA"], format(" %s", F.GetFrameStrata and F:GetFrameStrata()), format("(%d)", F:GetFrameLevel())) D(L["DIV"])
end
--]==]


--------------------------------------------------
-- Cleanup Function
--------------------------------------------------
--[[ Original Output

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

--[[ Mockup

 ----------------------------------------------
  Type   Button
  Name   PlayerFrame
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

--[[ Current
	----------------------------------------------
	 Type   CheckButton
	 Name   ActionButton1
	 Parent   MainMenuBarArtFrame

	 Width   36.0
	 Height   36.0
	 Scale   1.0
	 EScale   0.6

	 Point     BOTTOMLEFT, MainMenuBarArtFrame, BOTTOMLEFT, 8, 4
	----------------------------------------------
	  VERSION #2
	 Type   CheckButton
	 Name   ActionButton1
	 Parent   MainMenuBarArtFrame

	 Width   36.0
	 Height   36.0
--]]

--[==[ DUMPER REVERT

	function Truth:Dumper(o)
		local parent = o:GetParent() and o:GetParent() or UIParent
		local p1, p2, p3, p4, p5 = o:GetPoint()
		local Anchor = p2 and p2 or UIParent

		A["Divider"]()
		D(L["TYPE"], o.GetObjectType and o:GetObjectType() or L["UNKNOWN"])
		D(L["NAME"], o:GetName())
		D(L["PARENT"], (o ~= parent) and parent:GetName() or L["UNKNOWN"])
		D(" ", " ")
		D(L["WIDTH"], format("%.1f", o:GetWidth()))
		D(L["HEIGHT"], format("%.1f", o:GetHeight()))
		D(L["SCALE"], format("%.1f", o:GetScale()))
		D(L["ESCALE"], format("%.1f", o:GetEffectiveScale()))
		D(" ", " ")
		D(L["POINT"], format("  %s, %s, %s, %.0f, %.0f  ", p1, Anchor:GetName(), p3, format("%.1f", p4), format("%.1f", p5)))
		A["Divider"]()

		local t = {
			{ L["TYPE"], o.GetObjectType and o:GetObjectType() or L["UNKNOWN"] },
			{ L["NAME"], o:GetName() },
			{ L["PARENT"], (o ~= parent) and parent:GetName() or L["UNKNOWN"] },
			{ " ", " " },
			{ L["WIDTH"], format("%.1f", o:GetWidth()) },
			{ L["HEIGHT"], format("%.1f", o:GetHeight()) },
			{ L["SCALE"], format("%.1f", o:GetScale()) },
			{ L["ESCALE"], format("%.1f", o:GetEffectiveScale()) },
			{ " ", " " },
			{ L["POINT"], format("  %s, %s, %s, %.0f, %.0f  ", p1, Anchor:GetName(), p3, format("%.1f", p4), format("%.1f", p5)) },
		}	-- { L[""], VALUE },
		for _, row in ipairs(t) do
			D(row[1], row[2])
		end
		A["Divider"]()
	end
--]==]

--------------------------------------------------
--	Raw Info Dump
--------------------------------------------------
--[[	A["Divider"]()
	-------------------------------------------
	-- Frame

	local parent = o:GetParent() and o:GetParent() or UIParent

	D(L["PARENT"], (o ~= parent) and parent:GetName() or L["UNKNOWN"])
	D(L["NAME"], o:GetName())
	D(L["TYPE"], o.GetObjectType and o:GetObjectType() or L["UNKNOWN"])

	-- D(L["NEWLINE"])
	A["newline"]()
	-------------------------------------------
	-- Size

	D(L["WIDTH"],  format("%.1f", o:GetWidth()))
	D(L["HEIGHT"], format("%.1f", o:GetHeight()))
	D(L["SCALE"],  format("%.1f", o:GetScale()))
	D(L["EFFECTIVE_SCALE"], format("%.1f", o:GetEffectiveScale()))

	-- D(L["NEWLINE"])
	A["newline"]()
	-------------------------------------------
	-- Position

	-- /d TruthCopyFrame_EditBox:GetPoint()

	local p1, p2, p3, p4, p5 = o:GetPoint()
	p2 = p2 and p2 or UIParent

	D(L["POINT"],  format("  %s, %s, %s, %.0f, %.0f  ", p1, p2:GetName(), p3, format("%.1f", p4), format("%.1f", p5)))
	-- D(L["TOP"],    format("%.1f", o:GetTop()))
	-- D(L["RIGHT"],  format("%.1f", o:GetRight()))
	-- D(L["BOTTOM"], format("%.1f", o:GetBottom()))
	-- D(L["LEFT"],   format("%.1f", o:GetLeft()))

	-- D(L["NEWLINE"])
	A["newline"]()
	-------------------------------------------
	-- Stack Order

	D(L["TOPLEVEL"], o.IsToplevel and o:IsToplevel() and "true" or "false")
	D(L["STRATA"], o.GetFrameStrata and o:GetFrameStrata())
	D(L["LEVEL"], o.GetFrameLevel and o:GetFrameLevel())

	-- D(L["NEWLINE"])
	A["newline"]()
	-------------------------------------------
	-- Visibility

	D(L["SHOWN"], o.IsShown and o:IsShown() and "true" or "false")
	D(L["VISIBLE"], o.IsShown and o.IsVisible and o:IsVisible() and "true" or "false")
	-- D(L["ALPHA"], format("%.1f", o:GetAlpha()))
	-- D(L["EFFECTIVE_ALPHA"], format("%.1f", o:GetEffectiveAlpha()))

	-- D(L["NEWLINE"])
	A["newline"]()
	-------------------------------------------
	-- Responds to User

	-- D(L["USER_PLACED"], o.IsUserPlaced and o:IsUserPlaced() and "true" or "false")
	-- D(L["MOVABLE"],     o.IsMovable and o:IsMovable() and "true" or "false")
	-- D(L["RESIZABLE"],   o.IsResizable and o:IsResizable() and "true" or "false")

	-- D(L["NEWLINE"])
	-------------------------------------------
	-- Responds to Hardware

	-- D(L["KEYBOARD_ENABLED"], o.IsKeyboardEnabled and o:IsKeyboardEnabled() and "true" or "false")
	-- D(L["MOUSE_ENABLED"], o.IsMouseEnabled and o:IsMouseEnabled() and "true" or "false")
	-- D(L["MOUSEWHEEL_ENABLED"], o.IsMouseWheelEnabled and o:IsMouseWheelEnabled() and "true" or "false")

	-- D(L["NEWLINE"])
	-------------------------------------------
	A["Divider"]()

	-- D(L["DIV"])
--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Text Formatting Shortcuts

	local Divider = function()
		DEFAULT_CHAT_FRAME:AddMessage(L["INDENT"] .. L["DIV"])
	end

	local newline = function()
		DEFAULT_CHAT_FRAME:AddMessage(" ") -- L["NEWLINE"])
	end
--]]

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
--	Dump Revert (Working & Stable)
--------------------------------------------------
--[=[ function Truth:Dumper(o)
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
--]=]

--------------------------------------------------
--	Credits
--------------------------------------------------
--[[ MoveAnything by Wagthaa  (MoveAnything.lua)
--]]

