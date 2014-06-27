--[[ Toc
	## Interface: 40000
	## Version: 40000.1
	## Title: |cffAF66FF MoveIt by Shervin |r
	## Notes: Makes windows movable, change scale, alpha and more!
	## SavedVariables:
	## SavedVariablesPerCharacter: MoveItData, Moveit_Version
--]]

--[[ Xml

	<Ui xmlns="http://www.blizzard.com/wow/ui/">
		<Script file="MoveIt.lua"/>
		<Script file="MoveIt_WorldMapFrame.lua"/>
		<Script file="MoveIt_FrameList.lua"/>
		<Script file="MoveIt_EasyMove.lua"/>

		<Frame name="MoveItFrame" clampedToScreen="false" frameStrata="TOOLTIP" enableMouse="false" hidden="true" parent="UIParent" movable="true" resizable="true">
			<Size><AbsDimension x="10" y="10"/></Size>
			<ResizeBounds><minResize><AbsDimension x="8" y="8"/></minResize></ResizeBounds>
			<Anchors><Anchor point="CENTER"/></Anchors>

			<Backdrop bgFile="Interface\Tooltips\UI-Tooltip-Background" tile="true" alpha="0.5" edgeFile="_Interface\Tooltips\UI-Tooltip-Border">
				<EdgeSize><AbsValue val="12"/></EdgeSize>
				<TileSize><AbsValue val="16"/></TileSize>
				<BackgroundInsets><AbsInset left="2" right="3" top="2" bottom="2"/></BackgroundInsets>
			</Backdrop>

			<Layers>
				<Layer level="BACKGROUND" movable="true">
					<FontString name="MoveItFrameText" inherits="GameFontRedLarge" hidden="false" movable="false" enableMouse="true">
						<Anchors><Anchor point="CENTER"></Anchor></Anchors></FontString>
				</Layer>
			</Layers>

			<Scripts>
				<OnLoad>	MoveIt_OnLoad(self);				</OnLoad>
				<OnEvent>	MoveIt_OnEvent(self, event, ...);		</OnEvent>
				<OnHide>	if (MoveItToolTipFrame) then
							MoveItToolTipFrame:Hide();
						end
						self:SetScript("OnUpdate", nil);
						MoveItFrameText:SetText("");
						MoveIt_OBJ = nil;
				</OnHide>
				<OnMouseDown>	MoveIt_OnMouseDown(self, button);	</OnMouseDown>
				<OnMouseUp>	MoveIt_Move(false);				</OnMouseUp>
				<OnMouseWheel>	MoveIt_OnMouseWheel(self, delta);	</OnMouseWheel>
			</Scripts>
		</Frame>
	</Ui>
--]]



MOVEIT_VERSION = GetAddOnMetadata("MoveIt", "Version")

BINDING_HEADER_MOVEIT_TITLE = "MoveIt"			-- Binding Variables
BINDING_NAME_MOVEIT_COMMAND_1 = "Toggle main f anchor"
BINDING_NAME_MOVEIT_COMMAND_2 = "Toggle f anchor"
BINDING_NAME_MOVEIT_COMMAND_3 = "Refresh all frames"
BINDING_NAME_MOVEIT_COMMAND_4 = "Open MoveIt GUI"

local DEBUG = "0" --"0" or "1"

local LeftButtonString = "LeftButton"
local RightButtonString = "RightButton"

local MoveItExcludeList = "InterfaceOptionsFrame WorldMapFrame GossipFrame BattlefieldFrame ArenaFrame"

MoveItData = {}
MoveIt_OBJ = nil

local changed = nil
local MoveItToolTipFrame = nil
local MOVEIT_LOAD_DONE = false
local bindingWheelUp = nil
local bindingWheelDown = nil


function MoveIt_OnLoad(self)
	self:RegisterEvent("ADDON_LOADED")
	self:RegisterEvent("VARIABLES_LOADED")
	self:RegisterEvent("PLAYER_ENTERING_WORLD")
	self:RegisterEvent("GUILD_ROSTER_UPDATE")

	SlashCmdList["MOVEIT"] = function(msg) MoveIt_SlashHandler(msg) end
	SLASH_MOVEIT1, SLASH_MOVEIT2 = "/mi", "/moveit"
end

function MoveIt_OnEvent(self, event, ...)
	local arg1 = ...												--DEFAULT_CHAT_FRAME:AddMessage("|cffFF0000" .. event .. "|r - arg1: " .. tostring(arg1))

	if (event == "GUILD_ROSTER_UPDATE") then
		MoveIt_RefreshAll(false, true)
	end

	if (event == "ADDON_LOADED" and MOVEIT_LOAD_DONE) then					--DEFAULT_CHAT_FRAME:AddMessage("|cff0000FFADDON_LOADED|r@" .. MoveItHiddenFrameList[arg1][1] .. "@")
		if (MoveIt_SetEasyModeSingle) then
			MoveIt_SetEasyModeSingle(arg1)
		end

		if (MoveIt_SetEasyMode) then
			MoveIt_SetEasyMode(MoveItFrameList)
		end

		MoveIt_RefreshAll(1)
	end

	if (event == "VARIABLES_LOADED") then
		DEFAULT_CHAT_FRAME:AddMessage("[MoveIt] |cFFFFFF00" .. MOVEIT_VERSION .. "|r loaded.", 1, 0.5, 0.5)

		MoveItFrame:SetBackdropColor(1, 1, 1, 0.5)

		tinsert(UISpecialFrames, self)									-- ESC closes the window

		MoveIt_Upgrade()											-- Upgrade old data
		Moveit_Version = MOVEIT_VERSION
		MoveIt_RefreshAll(1)										--MoveIT_HotFix_Some_Frames()

		local zUIParent_OnShow = UIParent:GetScript("OnShow")
		UIParent:SetScript("OnShow", function(self)
			zUIParent_OnShow(self)
			MoveIt_RefreshAll(false, true)
		end)

		MOVEIT_LOAD_DONE = true
	end
end

function MoveIt_Upgrade()
	if (not Moveit_Version or Moveit_Version == MOVEIT_VERSION) then return end
	MoveIt_Message(format("[MoveIt] Upgrading data from version |cFFFFFF00%s|r to |cFFFFFF00%s|r", Moveit_Version or "0", MOVEIT_VERSION), nil, true)

	MoveItData["AudioOptionsFrame"] = MoveItData["SoundOptionsFrame"]
	MoveItData["SoundOptionsFrame"] = nil

	MoveIt_Message("[MoveIt] Upgrade completed.", nil, true)
end

function MoveIt_SlashHandler(msg)
	if (InCombatLockdown()) then return end

	if (msg) then
		local command
		local arg

		_, _, command, arg = string.find(msg, "^(%w+)%s*(.*)$")

		if (command) then
			command = string.upper(command)
		end

		if (command == "MOVE") then
			if (MoveItFrame:IsShown()) then
				MoveIT_Toggle()
			end

			MoveIt_OBJ =  _G[arg]
			MoveIT_Toggle()

		elseif (command == "EXIT") then
			if (MoveIt_OBJ) then
				MoveIT_Toggle()
			end

		elseif (command == "RESET") then
			MoveIt_ResetFrame(arg, true)

			if (MoveItFrame:IsShown()) then
				changed = nil
				MoveIT_Toggle()
			end

		elseif (command == "RESETALL") then
			MoveIt_ResetAllFrames()

		elseif (command == "GUI") then
			MoveIt_Toggle_MoveIt_GUI()

		elseif (command =="LIST") then
			local i = 0

			for name, _ in pairs(MoveItData) do
				i = i + 1
				MoveIt_Message("[MoveIt] " .. i .. " - |cFFFFFF00" .. name .. "|r", nil, true)
			end

			MoveIt_Message("[MoveIt] Total frames: |cFFFFFF00" .. tostring(i) .. "|r", nil, true)

		elseif (command == "DEBUG") then
			if (arg) then DEBUG = arg end

			message("[MoveIt] DEBUG = " .. tostring(DEBUG) .. "\n\n|cffFFFF00 1 = enable\n 0 = disable|r")

		else
			sError_Message = "Invalid command.\nUsage:" ..
				"\nmove  <f name>  - Activates the f under mouse cursor for moving" ..
				"\nexit - Exit the edit mode" ..
				"\ngui - Opens the GUI f" ..
				"\nreset <f name>  - Resets a f" ..
				"\nresetall  - Resets all frames" ..
				"\nlist  - Shows a list of the saved frames"
			MoveIt_Message(sError_Message, nil, true)
		end
	end
end

function MoveIt_Command(id, keystate)									--DEFAULT_CHAT_FRAME:AddMessage(tostring(MoveItFrame:IsVisible()) .. "   " .. tostring(not MoveItFrame:IsVisible()))
	if (InCombatLockdown()) then return end

	if (id == 1) then
		if (not MoveItFrame:IsShown()) then
			MoveIt_OBJ = GetMouseFocus()
			MoveIt_OBJ = MoveIt_GetTopParent(MoveIt_OBJ)
		end

		MoveIT_Toggle()

	elseif (id == 2) then
		if (not MoveItFrame:IsShown()) then
			MoveIt_OBJ = GetMouseFocus()
		end

		MoveIT_Toggle()

	elseif (id == 3) then
		MoveIt_RefreshAll(true, true)

	elseif (id == 4) then
		MoveIt_Toggle_MoveIt_GUI()

	else
		MoveIt_Message("Unknown Command: " .. id, true, true)
	end
end

function MoveIt_Toggle_MoveIt_GUI()
	if (not MoveItGUIFrame) then
		local loaded, message = LoadAddOn("MoveIt_GUI")
		if (not loaded) then
			PlaySoundFile("Sound\\interface\\Error.wav")
			MoveIt_Message("Error loading MoveIt_GUI!\nReason: " .. message, nil, true)
		end

		return
	end

	if (MoveItGUIFrame:IsShown()) then
		HideUIPanel(MoveItGUIFrame)
	else
		ShowUIPanel(MoveItGUIFrame)
	end
end

function MoveIt_ResetFrame(framename, showError)
	local f = _G[framename]

	if (f) then
		f:HiddenSetAlpha(1)
		f:HiddenSetScale(1)
		f:HiddenClearAllPoints()
		f:HiddenSetPoint("CENTER")
	end

	if (f and f.IsMovable and f:IsMovable()) then
		f:SetUserPlaced(0)
	end

	if (MoveItData[framename]) then
		if (MoveIt_ClearOnMouseDownEvents) then
			MoveIt_ClearOnMouseDownEvents(f)
		end

		MoveItData[framename] = nil

		if (MoveItGUIFrame) then										-- Refresh the GUI list
			MoveItGUI_LoadData()
		end

		if (showError) then
			MoveIt_ShowReloadUIMsg(framename .. " is reseted.")
		end
	else
		if (showError) then MoveIt_Message("[" .. framename .. "] not found.", true, true) end
	end
end

function MoveIt_ResetAllFrames()
	MoveItData = {}

	MoveIt_ShowReloadUIMsg("All frames are reseted!\n")

	if (MoveItGUIFrame) then
		MoveItGUI_LoadData()
	end
end

function MoveIT_HotFix_Some_Frames()
	ColorPickerFrame:EnableKeyboard(false)

	PVPBattlegroundFrameFrameLabel:ClearAllPoints()
	PVPBattlegroundFrameFrameLabel:SetPoint("TOP", PVPBattlegroundFrame, "TOP", 0, -17)

	local original_PVPFrame_OnShow = PVPParentFrame:GetScript("OnShow")
	PVPParentFrame:SetScript("OnShow" , function()						--msg("PVPFrame:Show()")
		original_PVPFrame_OnShow()
		PVPFrame:Show()
	end)
end

function MoveIT_PreventExternalMovement(f)
	if (InCombatLockdown()) then return end

	if (f.HiddenShow == nil) then f.HiddenShow = f.Show end
	if (f.HiddenHide == nil) then f.HiddenHide = f.Hide end

	if (f.HiddenSetPoint == nil) then
		f.HiddenSetPoint = f.SetPoint
		f.SetPoint = function() end
	end
	if (f.HiddenSetAllPoints == nil) then
		f.HiddenSetAllPoints = f.SetAllPoints
		f.SetAllPoints = function() end
	end
	if (f.HiddenClearAllPoints == nil) then
		f.HiddenClearAllPoints = f.ClearAllPoints
		f.ClearAllPoints = function() end
	end
	if (f.SetClampedToScreen) then
		f.HiddenSetClampedToScreen = f.SetClampedToScreen
	else
		f.HiddenSetClampedToScreen = function() end
	end
	if (f.GetScale) then
		f.HiddenGetScale = f.GetScale
	else
		f.HiddenGetScale = function() end
	end
	if (f.GetEffectiveScale) then
		f.HiddenGetEffectiveScale = f.GetEffectiveScale
	else
		f.HiddenGetEffectiveScale = function() return f:GetParent():GetScale() end
	end
	if (f.GetAlpha) then
		f.HiddenGetAlpha = f.GetAlpha
	end
	if (f.SetScale) then
		if ((f.HiddenSetScale == nil)) then
			f.HiddenSetScale = f.SetScale
			f.SetScale = function() end
		end
	else
		f.HiddenSetScale = function() end
	end
	if (f.SetAlpha) then
		if (f.HiddenSetAlpha == nil) then
			f.HiddenSetAlpha = f.SetAlpha
		end
	else
		f.HiddenSetAlpha = function() end
	end

	-- Prevent Children
	if (f.attachedChildren) then
		for i, val in pairs(f.attachedChildren) do
			MoveIT_PreventExternalMovement(val)
		end
	end
end

function MoveIT_AllowExternalMovement(f)
	if (InCombatLockdown()) then return end

	if (f.HiddenShow) then
		f.Show = f.HiddenShow
		f.HiddenShow = nil
	end
	if (f.HiddenHide) then
		f.Hide = f.HiddenHide
		f.HiddenHide = nil
	end
	if (f.HiddenSetPoint) then
		f.SetPoint = f.HiddenSetPoint
		f.HiddenSetPoint = nil
	end
	if (f.HiddenSetAllPoints) then
		f.SetAllPoints = f.HiddenSetAllPoints
		f.HiddenSetAllPoints = nil
	end
	if (f.HiddenClearAllPoints) then
		f.ClearAllPoints = f.HiddenClearAllPoints
		f.HiddenClearAllPoints = nil
	end
	if (f.HiddenSetScale) then
		f.SetScale = f.HiddenSetScale
		f.HiddenSetScale = nil
	end
	if (f.HiddenSetAlpha) then
		f.SetAlpha = f.HiddenSetAlpha
		f.HiddenSetAlpha = nil
	end

	-- Allow Children
	if (f.attachedChildren) then
		for i, val in pairs(f.attachedChildren) do
			MoveIT_AllowExternalMovement(val)
		end
	end
end

function MoveIt_Move(Move)
	if (Move == true) then
		changed = true

		MoveIt_GetObjPoint()
		MoveIt_OBJ.Oldx, MoveIt_OBJ.Oldy = GetCursorPosition()

		MoveItFrame:SetScript("OnUpdate", function()
			local x, y = GetCursorPosition()
			local newX = (x - MoveIt_OBJ.Oldx) / MoveIt_OBJ:HiddenGetEffectiveScale()
			local newY = (y - MoveIt_OBJ.Oldy) / MoveIt_OBJ:HiddenGetEffectiveScale()

			MoveIt_OBJ:HiddenSetPoint(MoveIt_OBJ.HiddenPoint, MoveIt_OBJ.HiddenRelativeTo or nil, MoveIt_OBJ.HiddenRelativePoint, MoveIt_OBJ.HiddenX + newX, MoveIt_OBJ.HiddenY + newY)
			MoveIt_ToolTipUpdate()
		end)

		MoveItFrame:SetBackdropColor(1, 0, 0, 0.5)
	else
		MoveItFrame:SetScript("OnUpdate", function() MoveIt_ToolTipUpdate() end)
		MoveItFrame:SetBackdropColor(1, 1, 1, 0.5)
	end
end

function MoveIt_Dettach()
	local p = { MoveIt_OBJ:GetPoint() }

	if ((p[2] == nil) and (MoveIt_OBJ:GetParent() == UIParent)) then
		p = nil
		MoveIt_Message("[MoveIt] - |cFFFFFF00[" .. tostring(MoveIt_OBJ:GetName()) .. "]|r is already dettached!", true, true)
		return
	end	p = nil

	local left = MoveIt_OBJ:GetLeft()
	local bottom = MoveIt_OBJ:GetBottom()
	local scale = MoveIt_GetTopParent(MoveIt_OBJ):GetScale()

	MoveIt_OBJ:SetParent("UIParent")
	MoveIt_OBJ.parent = MoveIt_OBJ:GetParent():GetName()
	MoveIt_OBJ:HiddenClearAllPoints()
	MoveIt_OBJ:HiddenSetPoint("BOTTOMLEFT", nil, "BOTTOMLEFT", left, bottom)
	MoveIt_OBJ:HiddenSetScale(scale)
end

function MoveIT_Toggle()
	if (not MoveIt_OBJ or not MoveIt_OBJ:GetName()) then
		MoveIt_Message("# MoveIT_Toggle: [" .. "?" .. "] not found.", true, true)
		PlaySoundFile("Sound\\interface\\Error.wav")
		return
	end

	if (MoveIt_OBJ == WorldFrame or MoveIt_OBJ == MoveItFrame or MoveIt_OBJ == UIParent) then
		MoveIt_Message("Invalid f: |cFFFFFF00" .. tostring(MoveIt_OBJ:GetName()) .. "|r", true, true)
		PlaySoundFile("Sound\\interface\\Error.wav")
		return
	end

	if (MoveItFrame:IsShown()) then
		PlaySound("igMainMenuOptionCheckBoxOff")

		if (bindingWheelUp and bindingWheelDown) then					-- Restore the original mousewheel key bindings
			SetBinding("MOUSEWHEELUP", bindingWheelUp)
			SetBinding("MOUSEWHEELDOWN", bindingWheelDown)

			bindingWheelUp = nil
			bindingWheelDown = nil
		end

		if (changed and MoveIt_SetOnMouseEvents) then
			MoveIt_SetOnMouseEvents(MoveIt_OBJ:GetName())
		end

		if (MoveIt_OBJ.EnableMouse) then
			MoveIt_OBJ:EnableMouse(MoveIt_OBJ.IS_MOUSE_ENABLED)			--msg("MoveIt_OBJ.IS_MOUSE_ENABLED  =   " .. tostring(MoveIt_OBJ.IS_MOUSE_ENABLED))
		end

		MoveIt_Move(false)
		MoveIt_SaveFrameSettings()

		UIFrameFlashStop(MoveItFrame)
		MoveItFrame:Hide()
		MoveItFrame:SetAlpha(1)

		MoveItToolTipFrame:Hide()
	else
		local name = MoveIt_OBJ:GetName()

		PlaySound("igMainMenuOptionCheckBoxOn")

		MoveIT_PreventExternalMovement(MoveIt_OBJ)

		MoveItFrame:SetAllPoints(MoveIt_OBJ)
		MoveItFrame:SetScale(MoveIt_OBJ:HiddenGetScale() or 1)

		MoveIt_Message("Active window: |cFFFFFF00" .. name .. "|r", nil, true)
		MoveItFrameText:SetText(name)

		bindingWheelUp   = GetBindingAction("MOUSEWHEELUP")				-- Save the original mousewheel key bindings
		bindingWheelDown = GetBindingAction("MOUSEWHEELDOWN")
		SetBinding("MOUSEWHEELUP", nil)								-- Clear mousewheel key bindings
		SetBinding("MOUSEWHEELDOWN", nil)

		MoveIt_ToolTipShow()
		MoveItFrame:SetScript("OnUpdate", function() MoveIt_ToolTipUpdate() end)

		UIFrameFlash(MoveItFrame, 0.05, 0.05, 0.5, true, 0.05, 0.05)		-- Show MoveIt main f

		if (MoveIt_OBJ.IsMouseEnabled) then
			MoveIt_OBJ.IS_MOUSE_ENABLED = MoveIt_OBJ:IsMouseEnabled()		--msg("MoveIt_OBJ.IS_MOUSE_ENABLED  =   " .. tostring(MoveIt_OBJ.IS_MOUSE_ENABLED))
		end
	end

	if (MoveItGUI_LoadData) then
		MoveItGUI_LoadData()
	end
end

function MoveIt_RefreshAll(show_msg, force_refresh)
	if (InCombatLockdown()) then return end

	if (not MoveItData) then
		MoveIt_Message("[MoveIt] Error in setting file!\nPlease reset settings and reload UI (/moveit resetall)", nil, true)
		return
	end

	local i, total, obj = 0, 0

	for name, _ in pairs(MoveItData) do								--MoveIt_Message("[MoveIt] " .. i .. " Refreshing: |cFFFFFF00" .. name .. "|r", nil, true)
		obj = _G[name]

		if (obj and not obj.HiddenHide or force_refresh) then
			i = MoveIT_RefreshFrame(name) or 0
			total = total + i
		end
	end

	if (show_msg) then
		MoveIt_Message("[MoveIt] Fixed |cFFFFFF00" .. total .. "|r frames.", nil, true)
	end
end

function MoveIT_RefreshFrame(name)
	if (InCombatLockdown()) then return end

	local settings = MoveItData[name]
	if (not settings) then
		return 0
	end

	if (((name == "UIOptionsFrame") and (not MoveIt_Fix_UIOptionsFrame)) or (name == "WorldMapFrame")) then return end

	MoveIt_OBJ = _G[name]
	if (MoveIt_OBJ == nil) then
		MoveIt_Message("# MoveIt.Refresh: [" .. name .. "] not found.", true)
		return 0
	end

	MoveIt_Message("[MoveIt] Refreshing: |cFFFFFF00" .. name .. "|r")

	if (MoveIt_SetOnMouseEvents) then
		MoveIt_SetOnMouseEvents(name)
	end

	MoveIt_FixSpecialFrame(name, settings.special)
	MoveIT_PreventExternalMovement(MoveIt_OBJ)

	if (settings.relativeTo and _G[settings.relativeTo] and settings.point and settings.relativePoint) then
		MoveIt_OBJ:HiddenSetPoint(settings.point, settings.relativeTo or nil, settings.relativePoint, settings.x, settings.y)
	else
		if (name ~= "WorldMapFrame") then
			MoveIt_Message("# MoveIt.Refresh: Invalid point settings for [" .. name .. "].", true)
		end
	end

	MoveIt_OBJ:HiddenSetScale(settings.scale)
	MoveIt_OBJ:HiddenSetAlpha(settings.alpha)

	if (settings.parent) then
		MoveIt_OBJ:SetParent(settings.parent)
		MoveIt_OBJ:HiddenShow()
	end

	if (settings.hidden == true) then
		MoveIt_OBJ:HiddenHide()
	end

	MoveIt_OBJ = nil

	return 1
end

function MoveIt_SaveFrameSettings()
	if (not changed) then return end
	local name = MoveIt_OBJ:GetName()
	local settings = MoveItData[name]

	if (not settings) then
		settings = {}
	end

	if (MoveIt_OBJ.parent) then
		settings.parent = MoveIt_OBJ.parent
	end

	settings.alpha = MoveIt_math_round(MoveIt_OBJ:HiddenGetAlpha(), 2)
	settings.scale = MoveIt_math_round(MoveIt_OBJ:HiddenGetScale(), 2)
	settings.hidden = (not MoveIt_OBJ:IsShown())

	MoveIt_GetObjPoint()

	settings.point = MoveIt_OBJ.HiddenPoint
	settings.relativeTo = MoveIt_OBJ.HiddenRelativeTo
	settings.relativePoint = MoveIt_OBJ.HiddenRelativePoint
	settings.x = MoveIt_math_round(MoveIt_OBJ.HiddenX, 2)
	settings.y = MoveIt_math_round(MoveIt_OBJ.HiddenY, 2)
	settings.special = settings.special or (UIPanelWindows[name] ~= nil)

	MoveIt_FixSpecialFrame(name, settings.special)						--MoveIt_Message(" >>> |cFF00CCFFMoveIt Save - " .. tostring(name) .. "|r")

	MoveItData[name] = settings

	changed = nil
end

function MoveIt_OnMouseWheel(self, delta)
	if (delta == 1) then
		MoveIt_OnMouseDown(self, LeftButtonString, true)
	else
		MoveIt_OnMouseDown(self, RightButtonString, true)
	end
end

function MoveIt_OnMouseDown(self, button, wheel)
	if (InCombatLockdown()) then return end

	if (button == LeftButtonString) then

		-- Reset Frame
		if (IsAltKeyDown() and IsControlKeyDown() and IsShiftKeyDown()) then
			MoveIt_ResetFrame(MoveIt_OBJ:GetName(), true)
			MoveIT_Toggle()
			return

		-- Hide
		elseif (IsAltKeyDown() and IsControlKeyDown()) then
			MoveIt_OBJ:HiddenHide()
			changed = true
			return

		-- Dettach
		elseif (IsControlKeyDown() and IsShiftKeyDown()) then
			MoveIt_Dettach()
			changed = true
			return

		-- Alpha (+)
		elseif (IsAltKeyDown()) then
			MoveIt_Set_OnUpdateScript(function() MoveIt_OBJ:HiddenSetAlpha(MoveIt_OBJ:HiddenGetAlpha() + 0.01) end, wheel)
			changed = true
			return

		-- Scale (+)
		elseif (IsControlKeyDown()) then
			MoveIt_Set_OnUpdateScript(function() MoveIt_OBJ:HiddenSetScale((MoveIt_OBJ:HiddenGetScale() or 0) + 0.01) end, wheel)
			changed = true
			return

		-- Move & clamped
		else
			if (ChatFrameEditBox:IsVisible()) then
				ChatFrameEditBox:Insert(MoveIt_OBJ:GetName())
			end
			MoveIt_OBJ:HiddenSetClampedToScreen(IsShiftKeyDown())
			MoveIt_Move(true)
			changed = true
			return
		end

	elseif (button == RightButtonString) then

		-- Show
		if (IsAltKeyDown() and IsControlKeyDown()) then
			MoveIt_OBJ:HiddenShow()
			changed = true
			return

		-- Alpha (-)
		elseif (IsAltKeyDown()) then
			MoveIt_Set_OnUpdateScript(function() MoveIt_OBJ:HiddenSetAlpha(MoveIt_OBJ:HiddenGetAlpha() - 0.01) end, wheel)
			changed = true
			return

		-- Scale (-)
		elseif (IsControlKeyDown()) then
			MoveIt_Set_OnUpdateScript(
				function()			--MoveIt_Message((MoveIt_OBJ:HiddenGetScale() or 0) - 0.01)
					if ((MoveIt_OBJ:HiddenGetScale() or 0) - 0.02 > 0) then
						MoveIt_OBJ:HiddenSetScale((MoveIt_OBJ:HiddenGetScale() or 0) - 0.01)
					end
				end, wheel
			)
			changed = true
			return

		-- Exit edit mode
		elseif (not IsModifierKeyDown()) then
			MoveIT_Toggle()
			return
		end
	end
end

function MoveIt_Set_OnUpdateScript(func, wheel)							--DEFAULT_CHAT_FRAME:AddMessage(tostring(wheel) .. " " .. math.random(100))
	if (wheel == true) then
		func()
		MoveItFrame:SetScale(MoveIt_OBJ:HiddenGetScale() or 1)
	else
		MoveItFrame:SetScript("OnUpdate", function()
			func()
			MoveIt_ToolTipUpdate()
			MoveItFrame:SetScale(MoveIt_OBJ:HiddenGetScale() or 1)
		end)
	end
end

function MoveIt_ToolTipShow()
	if (not MoveItToolTipFrame) then
		MoveItToolTipFrame = CreateFrame("GameTooltip", "MoveItToolTipFrame", UIParent, "GameTooltipTemplate")
		MoveItToolTipFrame:SetBackdrop(GameTooltip:GetBackdrop())
		MoveItToolTipFrame:SetBackdropBorderColor(GameTooltip:GetBackdropBorderColor())
		MoveItToolTipFrame:SetPadding(0)

		MoveItToolTipFrame:CreateTitleRegion():SetAllPoints(MoveItToolTipFrame)
		MoveItToolTipFrame:EnableMouse(true)
		MoveItToolTipFrame:SetMovable(true)							--msg("####   1   #####   MoveItToolTipFrame:IsMovable: " .. MoveItToolTipFrame:IsMovable())
	end

	MoveItToolTipFrame:SetOwner(UIParent, "ANCHOR_TOPLEFT", (GetScreenWidth() - 300) / 2, 0)
	MoveIt_ToolTipUpdate()
	ShowUIPanel(MoveItToolTipFrame)
end

function MoveIt_ToolTipUpdate()
	if (not MoveItToolTipFrame) then return end							--msg(GetTime() .. "  ####   2   #####  MoveItToolTipFrame:IsMovable: " .. MoveItToolTipFrame:IsMovable())

	local sParent = "N/A"
	local sParentParent = "N/A"
	local sRelativeTo = "N/A"


	-- Parent & ParentParent
	if (MoveIt_OBJ) then
		local MoveIt_OBJ_parent = MoveIt_OBJ:GetParent()
		if (MoveIt_OBJ_parent) then
			-- Parent
			sParent = MoveIt_OBJ_parent:GetName()
			local MoveIt_OBJ_parent_parent = MoveIt_OBJ:GetParent():GetParent()
			if (MoveIt_OBJ_parent_parent) then
				-- ParentParent
				sParentParent = MoveIt_OBJ_parent_parent:GetName()
			end
		end

		-- RelativeTo
		local point, relativeTo, relativePoint, xOfs, yOfs = MoveIt_OBJ:GetPoint()
		if (relativeTo) then
			sRelativeTo = relativeTo:GetName()
		end

		-- Cursor-X & Cursor-Y
		local x, y = GetCursorPosition()


		MoveItToolTipFrame:ClearLines()

		-- MoveItToolTipFrame:AddDoubleLine("[ MoveIt ]", ModifiedText, 1.0, 0.8, 0.0, 1, 0, 0)

		MoveItToolTipFrame:AddDoubleLine("\n", "\n")

		MoveItToolTipFrame:AddDoubleLine("Object:",		MoveIt_OBJ:GetName(),		1, 1, 1, 0, 1, 0)
		MoveItToolTipFrame:AddDoubleLine("Parent:",		sParent,					1, 1, 1, 0, 1, 0)
		MoveItToolTipFrame:AddDoubleLine("TopParent:",	sParentParent,				1, 1, 1, 0, 1, 0)
		MoveItToolTipFrame:AddDoubleLine("Type:",		MoveIt_OBJ:GetObjectType() , 	1, 1, 1, 0, 1, 0)						-- DEFAULT_CHAT_FRAME:AddMessage(MoveIt_OBJ:GetObjectType())

		if (MoveIt_OBJ:IsObjectType("Frame") or MoveIt_OBJ:IsObjectType("Button")) then
			MoveItToolTipFrame:AddDoubleLine("Level:", MoveIt_OBJ:GetFrameLevel(), 1, 1, 1, 0, 1, 0)
			MoveItToolTipFrame:AddDoubleLine("Strata:", MoveIt_OBJ:GetFrameStrata(), 1, 1, 1, 0, 1, 0)
			MoveItToolTipFrame:AddDoubleLine("Scale:", format("%.2f", MoveIt_OBJ:HiddenGetScale()), 1, 1, 1, 0, 1, 0)
		end

		MoveItToolTipFrame:AddDoubleLine("Alpha:", format("%.2f", MoveIt_OBJ:HiddenGetAlpha()), 1, 1, 1, 0, 1, 0)

		MoveItToolTipFrame:AddDoubleLine("Point:", point, 1, 1, 1, 0, 1, 0)
		MoveItToolTipFrame:AddDoubleLine("RelativeTo:", sRelativeTo, 1, 1, 1, 0, 1, 0)
		MoveItToolTipFrame:AddDoubleLine("RelativePoint:", relativePoint, 1, 1, 1, 0, 1, 0)
		MoveItToolTipFrame:AddDoubleLine("X-Offset:", format("%.2f", (xOfs or 0)), 1, 1, 1, 0, 1, 0)
		MoveItToolTipFrame:AddDoubleLine("Y-Offset:", format("%.2f", (yOfs or 0)), 1, 1, 1, 0, 1, 0)

		-- Cursor coords
		MoveItToolTipFrame:AddDoubleLine(format("Cursor-X: |cFF00FF00%.0f|r", x), format("Top: |cFF00FF00%.2f|r", (MoveIt_OBJ:GetTop() or 0)), 1, 1, 1, 1, 1, 1)
		MoveItToolTipFrame:AddDoubleLine(format("Cursor-Y: |cFF00FF00%.0f|r", y), format("Right: |cFF00FF00%.2f|r", (MoveIt_OBJ:GetRight() or 0)), 1, 1, 1, 1, 1, 1)


--[[		Modifiers: Mapped to functions

		MoveItToolTipFrame:AddDoubleLine("\n", "\n")
		MoveItToolTipFrame:AddDoubleLine("Alt+Click/Wheel", 		"+/- Alpha", 	MoveIt_GetTooltipColor(IsAltKeyDown(), not IsControlKeyDown(), not IsShiftKeyDown()))
		MoveItToolTipFrame:AddDoubleLine("Ctrl+Click/Wheel", 		"+/- Scale", 	MoveIt_GetTooltipColor(not IsAltKeyDown(), IsControlKeyDown(), not IsShiftKeyDown()))
		MoveItToolTipFrame:AddDoubleLine("Shift+Drag", 			"Clamped",	MoveIt_GetTooltipColor(not IsAltKeyDown(), not IsControlKeyDown(), IsShiftKeyDown())) -- Clamped to screen
		MoveItToolTipFrame:AddDoubleLine("Alt+Ctrl+Click", 		"Hide/Show", 	MoveIt_GetTooltipColor(IsAltKeyDown(), IsControlKeyDown(), not IsShiftKeyDown()))
		MoveItToolTipFrame:AddDoubleLine("Ctrl+Shift+Click",		"Dettach f", 	MoveIt_GetTooltipColor(not IsAltKeyDown(), IsControlKeyDown(), IsShiftKeyDown()))
		MoveItToolTipFrame:AddDoubleLine("Ctrl+Alt+Shift+Click", 	"Reset f", 	MoveIt_GetTooltipColor(IsAltKeyDown(), IsControlKeyDown(), IsShiftKeyDown()))
		MoveItToolTipFrame:AddDoubleLine("RightClick", 			"Exit edits",	MoveIt_GetTooltipColor())
--]]

		MoveItToolTipFrame:SetBackdropColor(0, 0, 0)


		--DEFAULT_CHAT_FRAME:AddMessage(format("%d %d %d %d %d %d", MoveIt_GetTooltipColor(IsAltKeyDown())))
	end
end

function MoveIt_GetTooltipColor(alt, ctrl, shift)
	if (alt and ctrl and shift) then
		return 0.2, 0.5, 1.0, 0.2, 0.5, 1.0
	else
		return 1, 1, 0, 1, 1, 0
	end
end

function MoveIt_Message(text, error, forceShow)
	if (not forceShow and (not DEBUG or DEBUG == "0")) then return end

	if (error) then
		DEFAULT_CHAT_FRAME:AddMessage(tostring(text), 1, 0, 0)
	else
		DEFAULT_CHAT_FRAME:AddMessage(tostring(text), 1, 0.5, 0.5)
	end
end

function MoveIt_SearchInTable(t, text)
	for i, s in pairs(t) do
		if (s[1] == text) then
			return true
		end
		--DEFAULT_CHAT_FRAME:AddMessage(tostring(i) .. " - " .. tostring(s[1]), 0.5, 0.5, 0.5)
	end

	return false
end

function MoveIt_GetTopParent(f)
	if (type(f) == "string") then
		f =  _G[f]
	end

	if (not f or f == WorldFrame) then
		return f
	end

	local parent = f
	while (parent and parent ~= UIParent) do
		f = parent
		parent = parent:GetParent()
	end

	return f
end

function MoveIt_GetObjPoint()
	local p = { MoveIt_OBJ:GetPoint() }

	MoveIt_OBJ.HiddenPoint = p[1]

	if (p[2]) then
		MoveIt_OBJ.HiddenRelativeTo = p[2]:GetName()
	else
		MoveIt_OBJ.HiddenRelativeTo = nil
	end

	MoveIt_OBJ.HiddenRelativePoint = p[3]
	MoveIt_OBJ.HiddenX = p[4]
	MoveIt_OBJ.HiddenY = p[5]

	-- p = nil
end

--[[ Per panel settings

	UIPanelWindows = {}
	UIPanelWindows["GameMenuFrame"]			= {area = "center",	pushable = 0,	whileDead = 1}
	UIPanelWindows["InterfaceOptionsFrame"]		= {area = "center",	pushable = 0,	whileDead = 1}
	UIPanelWindows["AudioOptionsFrame"]		= {area = "center",	pushable = 0,	whileDead = 1}
	UIPanelWindows["OptionsFrame"]			= {area = "full",	pushable = 0,	whileDead = 1}
	UIPanelWindows["CharacterFrame"]			= {area = "left",	pushable = 3,	whileDead = 1}
	UIPanelWindows["ItemTextFrame"]			= {area = "left",	pushable = 0}
	UIPanelWindows["SpellBookFrame"]			= {area = "left",	pushable = 0,	whileDead = 1}
	UIPanelWindows["LootFrame"]				= {area = "left",	pushable = 7}
	UIPanelWindows["TaxiFrame"]				= {area = "left",	pushable = 0}
	UIPanelWindows["QuestFrame"]				= {area = "left",	pushable = 0}
	UIPanelWindows["QuestLogFrame"]			= {area = "left",	pushable = 0,	whileDead = 1}
	UIPanelWindows["MerchantFrame"]			= {area = "left",	pushable = 0}
	UIPanelWindows["TradeFrame"]				= {area = "left",	pushable = 1}
	UIPanelWindows["BankFrame"]				= {area = "left",	pushable = 6,	width = 425 }
	UIPanelWindows["FriendsFrame"]			= {area = "left",	pushable = 0,	whileDead = 1}
	UIPanelWindows["WorldMapFrame"]			= {area = "full",	pushable = 0,	whileDead = 1}
	UIPanelWindows["CinematicFrame"]			= {area = "full",	pushable = 0}
	UIPanelWindows["TabardFrame"]				= {area = "left",	pushable = 0}
	UIPanelWindows["PVPBannerFrame"]			= {area = "left",	pushable = 0}
	UIPanelWindows["GuildRegistrarFrame"]		= {area = "left",	pushable = 0}
	UIPanelWindows["ArenaRegistrarFrame"]		= {area = "left",	pushable = 0}
	UIPanelWindows["PetitionFrame"]			= {area = "left",	pushable = 0}
	UIPanelWindows["HelpFrame"]				= {area = "center",	pushable = 0,	whileDead = 1}
	UIPanelWindows["KnowledgeBaseFrame"]		= {area = "center",	pushable = 0,	whileDead = 1}
	UIPanelWindows["GossipFrame"]				= {area = "left",	pushable = 0}
	UIPanelWindows["MailFrame"]				= {area = "left",	pushable = 0}
	UIPanelWindows["BattlefieldFrame"]			= {area = "left",	pushable = 0}
	UIPanelWindows["PetStableFrame"]			= {area = "left",	pushable = 0}
	UIPanelWindows["WorldStateScoreFrame"]		= {area = "center",	pushable = 0,	whileDead = 1}
	UIPanelWindows["DressUpFrame"]			= {area = "left",	pushable = 2}
	UIPanelWindows["MinigameFrame"]			= {area = "left",	pushable = 0}
	UIPanelWindows["LFGParentFrame"]			= {area = "left",	pushable = 0,	whileDead = 1}
	UIPanelWindows["ArenaFrame"]				= {area = "left",	pushable = 0}

--]]

function MoveIt_FixSpecialFrame(name, special)
	if (InCombatLockdown()) then return end
	if (special == true) then
		if (string.find(MoveItExcludeList, name) == nil) then
			--MoveIt_Message("|cffFF0000<MoveIt_FixSpecialFrame>  -->  |r" .. name)
		end
	end
end

function MoveIt_ShowReloadUIMsg(text)
	local importantString  = "|cFFFFFF00\n================= IMPORTANT =================\n" ..
		"You must reload the UI for the changes to take effect!\nType: /console reloadui\n============================================\n|r"
	MoveIt_Message((text or "") .. importantString, nil, true)
end

function MoveIt_math_round(num, idp)
	if (not num) then return nil end
	local mult = 10 ^ (idp or 0)
	return math.floor(num  * mult + 0.5) / mult
end


