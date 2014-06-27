local A, C, G, L = select(2, ...):Unpack()

if (not C["Auto"]["Enable"] or not C["Auto"]["Release"]["Enable"]) then
	return
end

local print = function(...)
	A.print("Release", ...)
end





--------------------------------------------------
--	Auto Release [ BGs only ]
--------------------------------------------------
do
	local time = time
	local RepopMe = RepopMe
	local IsInInstance = IsInInstance

	local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_DEAD')
	f:SetScript('OnEvent', function(self, event, ...)

		local inInstance, instanceType = IsInInstance()

		if ((inInstance) and (instanceType == "pvp")) then
			RepopMe()

			print("TOD:", A.FormatTime(time()), "Pop!")
		end

	end)
end


--------------------------------------------------

	   if (not false) then return end

--------------------------------------------------
--[[
do
	local RepopMe = RepopMe
	local IsInInstance = IsInInstance

	local function eventHandler(self, event, ...)
		local inInstance, instanceType = IsInInstance()

		if ((inInstance) and (instanceType == 'pvp')) then
			RepopMe()
			print('<release> You are Repopped!')
		end
	end

	local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_DEAD')
	f:SetScript('OnEvent', eventHandler)
end
--]]

--------------------------------------------------
--	Credits
--------------------------------------------------
-- credit: BG Auto Release
