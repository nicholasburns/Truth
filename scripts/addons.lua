local A, C, G, L = select(2, ...):Unpack()



--------------------------------------------------
--	Print addons to chat
--------------------------------------------------
do
	local p = CreateFrame('Frame')
	p:RegisterEvent('ADDON_LOADED')
	p:SetScript('OnEvent', function(self, event, addon)
		A.print('', 'ADDON_LOADED  ', addon)
	  -- PlaySoundFile([=[Sound\Spells\Simongame_visual_gametick.wav]=], "Master")
	  -- A.print("Scripts.Addons", "[soundfile]", "simongame_visual_gametick.wav")
	end)
end
--------------------------------------------------



