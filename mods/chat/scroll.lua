local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Enable"] or not C["Chat"]["Scroll"]["Enable"]) then
	return
end




local IsShiftKeyDown = IsShiftKeyDown


local OnMouseScroll = function(self, direction)
    if (direction > 0) then
        if (IsShiftKeyDown()) then
            self:ScrollToTop()
        else
            self:ScrollUp()
            self:ScrollUp()
        end
    elseif (direction < 0)  then
        if (IsShiftKeyDown()) then
            self:ScrollToBottom()
        else
            self:ScrollDown()
            self:ScrollDown()
        end
    end

    if (C["Chat"]["Scroll"]["ShowBottomBotton"]) then
        local buttonBottom = _G[self:GetName() .. "ButtonFrameBottomButton"]

        if (self:AtBottom()) then
            buttonBottom:Hide()
        else
            buttonBottom:Show()
            buttonBottom:SetAlpha(0.7)
        end
    end
end


hooksecurefunc("FloatingChatFrame_OnMouseScroll", OnMouseScroll)





if (not false) then return end





local OnMouseWheel
do
	local IsShiftKeyDown = IsShiftKeyDown

	OnMouseWheel = function(f, delta)
		if (delta > 0) then
			if (IsShiftKeyDown()) then
				f:ScrollToTop()
			else
				for i = 1, (C["Chat"]["Scroll"]["NumLines"]) do
					f:ScrollUp()
				end
			end
		else
			if (IsShiftKeyDown()) then
				f:ScrollToBottom()
			else
				for i = 1, (C["Chat"]["Scroll"]["NumLines"]) do
					f:ScrollDown()
				end
			end
		end
	end
end

--------------------------------------------------
--	Chat Frames
--------------------------------------------------
local ChatFrame
do
	for i = 1, (G.NUM_CHAT_FRAMES) do
		ChatFrame = _G['ChatFrame' .. i]

		ChatFrame:EnableMouseWheel(true)
		ChatFrame:SetScript('OnMouseWheel', OnMouseWheel)
	end

	hooksecurefunc("FloatingChatFrame_OnMouseScroll", OnMouseWheel)
end

--------------------------------------------------
--	CVars & Options
--------------------------------------------------
do
	local SetCVar = SetCVar
	local InterfaceOptionsSocialPanelChatMouseScroll_SetScrolling =
		 InterfaceOptionsSocialPanelChatMouseScroll_SetScrolling


	-- CVar: chatMouseScroll
	SetCVar("chatMouseScroll", "1")			-- 1 = allow mouse scrolling in chat


	-- Options: SocialPanel
	InterfaceOptionsSocialPanelChatMouseScroll_SetScrolling("0")
	InterfaceOptionsSocialPanelChatMouseScroll_SetScrolling("1")
end


--------------------------------------------------
--	Chatter Version
--------------------------------------------------
--[[	do
		local SetCVar = SetCVar
		local InterfaceOptionsSocialPanelChatMouseScroll_SetScrolling = InterfaceOptionsSocialPanelChatMouseScroll_SetScrolling


		-- CVar: chatMouseScroll
		-- 1 = allow mouse scrolling in chat
		-- 0 = NO MOUSEY
		SetCVar("chatMouseScroll", "1")


		hooksecurefunc("FloatingChatFrame_OnMouseScroll", function(frame, delta)
			if (delta > 0) then
				if (IsShiftKeyDown()) then
					frame:ScrollToTop()
				elseif (IsControlKeyDown()) then
					frame:PageUp()
				else
					for i = 1, (C["Chat"]["Scroll"]["NumLines"]) do
						frame:ScrollUp()
					end
				end
			else
				if (IsShiftKeyDown()) then
					frame:ScrollToBottom()
				elseif (IsControlKeyDown()) then
					frame:PageDown()
				else
					for i = 1, (C["Chat"]["Scroll"]["NumLines"]) do
						frame:ScrollDown()
					end
				end
			end
		end)


		InterfaceOptionsSocialPanelChatMouseScroll_SetScrolling("0")
		InterfaceOptionsSocialPanelChatMouseScroll_SetScrolling("1")
	end
--]]

--------------------------------------------------
--	PhanxChat Version
--------------------------------------------------
--[[	do
		local hooksecurefunc = hooksecurefunc
		local IsShiftKeyDown = IsShiftKeyDown
		local IsControlKeyDown = IsControlKeyDown


		local NUM_LINES_TO_SCROLL = 5

		FloatingChatFrame_OnMouseScroll = function(self, delta)
			if (delta > 0) then
				if (IsShiftKeyDown()) then
					self:ScrollToTop()
				elseif (IsControlKeyDown()) then
					self:PageUp()
				else
					for i = 1, (NUM_LINES_TO_SCROLL) do
						self:ScrollUp()
					end
				end
			elseif (delta < 0) then
				if (IsShiftKeyDown()) then
					self:ScrollToBottom()
				elseif (IsControlKeyDown()) then
					self:PageDown()
				else
					for i = 1, (NUM_LINES_TO_SCROLL) do
						self:ScrollDown()
					end
				end
			end
		end
	end
--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ for _, frame in pairs(CHAT_FRAMES) do
		local f = _G[frame]
		f:SetScript("OnMouseWheel", FloatingChatFrame_OnMouseScroll)
		f:EnableMouseWheel(true)
	end
--]]
--------------------------------------------------
--	Credits
--------------------------------------------------
--	PhanxChat by Phanx
--	Chatter by Antiarc


















