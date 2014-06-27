local A, C, G, L = select(2, ...):Unpack()

-- local print = function(...)
--	A.print('Script.GC', ...)
-- end



do
	local collectgarbage = collectgarbage
	local UnitIsAFK = UnitIsAFK


	local memory

	local CollectGarbage = CreateFrame('Frame')
	CollectGarbage:RegisterEvent('PLAYER_FLAGS_CHANGED')
	CollectGarbage:RegisterEvent('PLAYER_ENTERING_WORLD')
	CollectGarbage:SetScript('OnEvent', function(self, event, unit)
		if (event == "PLAYER_FLAGS_CHANGED") then
			if (unit ~= "player") then return end

			if (UnitIsAFK(unit)) then
			--	memory = collectgarbage("count")
			--	A.print('Script.GC', "Total memory in use before we collect it: ", memory .. "(Kbytes)")
				collectgarbage("collect")
			--	A.print('Script.GC', "Garbage Collection: ", "successful")
			end
		end

		if (event == "PLAYER_ENTERING_WORLD") then
			collectgarbage("collect")
		--	A.print('Script.GC', "Garbage Collection: ", "successful")
			self:UnregisterEvent('PLAYER_ENTERING_WORLD')
		end
	end)
end


----------------------------------------------------------------------------------------------------
--	API Documentation
----------------------------------------------------------------------------------------------------
--[[ Garbage Collection API

	* "restart": 		restarts the garbage collector
	* "collect": 		performs a full garbage-collection cycle. This is the default action if opt is not specified
	* "count": 		returns the total memory in use by Lua (in Kbytes)
	* "step": 		performs a garbage-collection step
					The step "size" is controlled by arg (larger values mean more steps) in a non-specified way
					If you want to control the step size you must experimentally tune the value of arg
					Returns true if the step finished a collection cycle
	* "setpause": 		sets arg/100 as the new value for the pause of the collector (see §2.10)
	* "setstepmul": 	sets arg/100 as the new value for the step multiplier of the collector (see §2.10)

--]]				  -- source: wowwiki.com/API_collectgarbage
----------------------------------------------------------------------------------------------------
