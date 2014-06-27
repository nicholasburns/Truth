




--------------------------------------------------
--	Debugging
--------------------------------------------------
--[[

/run DEFAULT_CHAT_FRAME:AddMessage(GetMouseFocus():GetName())

/run ChatFrame3:AddMessage(GetMouseFocus():GetName())



--]]

--[[ Tests

/run ListTextures(TargetFrame)
/run ListChildren(TargetFrame)
/run ShowTextures(TargetFrame)

--]]

--[[ Debug Macro

/run ListTextures(GetMouseFocus():GetName())
/run ListChildren(GetMouseFocus():GetName())
/run ShowTextures(GetMouseFocus():GetName())


/run DEFAULT_CHAT_FRAME:AddMessage(GetMouseFocus():GetName())
/run ChatFrame3:AddMessage(GetMouseFocus():GetName())

--]]


--------------------------------------------------
--	Macro Backups
--------------------------------------------------
--[[ Framestack & Outline Frame

	/framestack
	/script MN=GetMouseFocus():GetName() DEFAULT_CHAT_FRAME:AddMessage(MN)
	/run MF=_G[MN] MFB=CreateFrame('Frame',nil,MF)

	MFB:SetAllPoints()MFB:SetBackdrop({edgeFile='Interface\\BUTTONS\\WHITE8X8',edgeSize=5})
	MFB:SetBackdropBorderColor(1,0,0,1)

--]]

--[[ Framestack & Print Name to ChatFrame3 (followed by a comma)

	/framestack true
	/run DEFAULT_CHAT_FRAME:AddMessage(GetMouseFocus():GetName())
	/run ChatFrame3:AddMessage(GetMouseFocus():GetName() .. ",")

--]]







