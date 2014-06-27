local A, C, G, L = select(2, ...):Unpack()

if (not C["Tooltip"]["Enable"] or not C["Tooltip"]["Offset"]["Enable"]) then
	return
end

local M = C["Tooltip"]["Offset"]

M["MouseOffsetX"] = 0
M["MouseOffsetY"] = 0
M["OverrideCombat"] = false
M["HideInCombat"] = false


--------------------------------------------------
local E, L, V, P, G, _ = unpack(ElvUI)
local TTOS = E:NewModule('TooltipOffset', 'AceEvent-3.0')
local TT = E:GetModule('Tooltip')
--------------------------------------------------

function TTOS:GameTooltip_SetDefaultAnchor(TIP, parent)

	if (M.anchor == "CURSOR") then
		if (parent) then
			TIP:SetOwner(parent, "ANCHOR_CURSOR")
			TTOS:AnchorFrameToMouse(TIP)
		end

		if (InCombatLockdown() and M["HideInCombat"] and not (M["OverrideCombat"] and IsShiftKeyDown())) then
			TIP:Hide()
		else
			TT:SetStatusBarAnchor('TOP')
		end

	elseif (M.anchor == "SMART") then
		if (parent) then
			TIP:SetOwner(parent, "ANCHOR_NONE")
		end

		TIP:ClearAllPoints()

		if (BagsFrame and BagsFrame:IsShown()) then
			TIP:Point('BOTTOMRIGHT', BagsFrame, 'TOPRIGHT', 0, 18)

		elseif (RightChatPanel:GetAlpha() == 1) then
			TIP:Point('BOTTOMRIGHT', RightChatPanel, 'TOPRIGHT', 0, 18)

		else
			TIP:Point('BOTTOMRIGHT', RightChatPanel, 'BOTTOMRIGHT', 0, 18)
		end

		TT:SetStatusBarAnchor('BOTTOM')

	else
		if (parent) then
			TIP:SetOwner(parent, "ANCHOR_NONE")
		end

		TIP:ClearAllPoints()

		local point = E:GetScreenQuadrant(TooltipMover)
		if (point == "TOPLEFT") then
			TIP:Point("TOPLEFT", TooltipMover, "BOTTOMLEFT", 1, -4)
		elseif (point == "TOPRIGHT") then
			TIP:Point("TOPRIGHT", TooltipMover, "BOTTOMRIGHT", -1, -4)
		elseif (point == "BOTTOMLEFT" or point == "LEFT") then
			TIP:Point("BOTTOMLEFT", TooltipMover, "TOPLEFT", 1, 18)
		else
			TIP:Point("BOTTOMRIGHT", TooltipMover, "TOPRIGHT", -1, 18)
		end

		TT:SetStatusBarAnchor('BOTTOM')
	end
end


function TTOS:GameTooltip_OnUpdate(TIP)
	if ((TIP.needRefresh) and --[[ (TIP:GetAnchorType() == "ANCHOR_CURSOR") and ]] (not C["Tooltip"]["Anchor"]["Cursor"])) then

		TIP:SetBackdropColor(unpack(A.default.backdrop.color))
		TIP:SetBackdropBorderColor(unpack(A.default.border.color))

		TIP.needRefresh = nil

	elseif (TIP.forceRefresh) then
		TIP.forceRefresh = nil

	else
		TTOS:AnchorFrameToMouse(TIP)
	end
end


function TTOS:AnchorFrameToMouse(Frame)
	if (Frame:GetAnchorType() ~= "ANCHOR_CURSOR") then
		return
	end

	local x, y = GetCursorPosition()
	local effScale = Frame:GetEffectiveScale()

	Frame:Point("BOTTOMLEFT", UIParent, "BOTTOMLEFT", (x / effScale + M["MouseOffsetX"]),  (y / effScale + M["MouseOffsetY"]))
end


function TTOS:MODIFIER_STATE_CHANGED(event, key)
	if (InCombatLockdown() and M["HideInCombat"] and not (M["OverrideCombat"] and IsShiftKeyDown())) then
			GameTooltip:Hide()
	end
end



-- Hook
local TTOSFrame = CreateFrame('Frame', 'TTOS')
TTOSFrame:RegisterEvent("PLAYER_ENTERING_WORLD")
TTOSFrame:RegisterEvent("MODIFIER_STATE_CHANGED")
TTOSFrame:SetScript("OnEvent",function(self, event)
    if (event == "PLAYER_ENTERING_WORLD") then

		hooksecurefunc(TT, "GameTooltip_SetDefaultAnchor", TTOS.GameTooltip_SetDefaultAnchor)
		hooksecurefunc(TT, "GameTooltip_OnUpdate", TTOS.GameTooltip_OnUpdate)

		TTOSFrame:UnregisterEvent("PLAYER_ENTERING_WORLD")
	end
end)


print("TT.Offset", "Loaded")

