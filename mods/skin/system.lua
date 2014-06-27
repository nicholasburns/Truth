local A, C, G, L = select(2, ...):Unpack()

if (not C["Skin"]["Enable"] or not C["Skin"]["System"]["Enable"]) then
	return
end


local ipairs, pairs = ipairs, pairs




local LoadSkin

do
	local VideoOptionsFrame = VideoOptionsFrame
	local VideoOptionsFrameCategoryFrame = VideoOptionsFrameCategoryFrame
	local VideoOptionsFrameHeader = VideoOptionsFrameHeader
	local LoopbackVUMeter = LoopbackVUMeter


	LoadSkin = function()
		VideoOptionsFrame:Strip()
		VideoOptionsFrame:Template("TRANSPARENT")
		VideoOptionsFrame:Shadow()

		VideoOptionsFrameCategoryFrame:Strip()

		VideoOptionsFrameHeader:SetTexture(nil)
		VideoOptionsFrameHeader:Point("TOP", VideoOptionsFrame, 0, 0)


		local Panels = {
			"VideoOptionsFrameCategoryFrame",
			"VideoOptionsFramePanelContainer",

			"AudioOptionsSoundPanel",
			"AudioOptionsSoundPanelPlayback",
			"AudioOptionsSoundPanelHardware",
			"AudioOptionsSoundPanelVolume",
			"AudioOptionsVoicePanel",
		}
		for _, panel in ipairs(Panels) do
			_G[panel]:Template("CLEAR")		-- ("TRANSPARENT")			-- ("OVERLAY")
		end


		local Buttons = {
			"VideoOptionsFrameOkay",
			"VideoOptionsFrameCancel",
			"VideoOptionsFrameDefaults",
			"VideoOptionsFrameApply",
			"RecordLoopbackSoundButton",
			"PlayLoopbackSoundButton",
			"AudioOptionsVoicePanelChatMode1KeyBindingButton",
		}
		for _, button in ipairs(Buttons) do
			_G[button]:SkinButton()
		end


		local Checkboxes = {
			"Advanced_MaxFPSCheckBox",
			"Advanced_MaxFPSBKCheckBox",
			"Advanced_DesktopGamma",

			"AudioOptionsSoundPanelEnableSound",
			"AudioOptionsSoundPanelSoundEffects",
			"AudioOptionsSoundPanelErrorSpeech",
			"AudioOptionsSoundPanelEmoteSounds",
			"AudioOptionsSoundPanelPetSounds",
			"AudioOptionsSoundPanelMusic",
			"AudioOptionsSoundPanelLoopMusic",
			"AudioOptionsSoundPanelAmbientSounds",
			"AudioOptionsSoundPanelSoundInBG",
			"AudioOptionsSoundPanelReverb",
			"AudioOptionsSoundPanelHRTF",
			"AudioOptionsSoundPanelEnableDSPs",
			"AudioOptionsSoundPanelPetBattleMusic",
			"AudioOptionsVoicePanelEnableVoice",
			"AudioOptionsVoicePanelEnableMicrophone",
			"AudioOptionsVoicePanelPushToTalkSound",

			"NetworkOptionsPanelOptimizeSpeed",
			"NetworkOptionsPanelUseIPv6",
			"NetworkOptionsPanelAdvancedCombatLogging",
		}
		for _, checkbox in ipairs(Checkboxes) do
			_G[checkbox]:SkinCheckButton()
			-- _G[checkbox .. "Label"]:Point('LEFT', _G[checkbox], 'RIGHT', 20, 0)
		end


		local Dropdowns = {
			"Graphics_DisplayModeDropDown",

			"Graphics_ResolutionDropDown",
			"Graphics_RefreshDropDown",

			"Graphics_PrimaryMonitorDropDown",

			"Graphics_MultiSampleDropDown",
			"Graphics_VerticalSyncDropDown",
			"Graphics_TextureResolutionDropDown",
			"Graphics_FilteringDropDown",
			"Graphics_ProjectedTexturesDropDown",
			"Graphics_ViewDistanceDropDown",
			"Graphics_EnvironmentalDetailDropDown",
			"Graphics_GroundClutterDropDown",

			"Graphics_ShadowsDropDown",
			"Graphics_LiquidDetailDropDown",
			"Graphics_SunshaftsDropDown",
			"Graphics_ParticleDensityDropDown",
			"Graphics_SSAODropDown",

			"Advanced_BufferingDropDown",
			"Advanced_LagDropDown",
			"Advanced_HardwareCursorDropDown",
			"Advanced_GraphicsAPIDropDown",

			"AudioOptionsSoundPanelHardwareDropDown",
			"AudioOptionsSoundPanelSoundChannelsDropDown",
			"AudioOptionsVoicePanelInputDeviceDropDown",
			"AudioOptionsVoicePanelChatModeDropDown",
			"AudioOptionsVoicePanelOutputDeviceDropDown",
		}
		for _, dropdown in ipairs(Dropdowns) do
			_G[dropdown]:SkinDropDownBox(120)		-- (110)	-- (165)
		end

	--[[ Dumplog

		Graphics_PrimaryMonitorDropDown:GetPoint() = {
			[1] = 'TOPRIGHT',
			[2] =  {},
			[3] = 'BOTTOMRIGHT',
			[4] = 16,
			[5] = -4,
	--]]
		Graphics_PrimaryMonitorDropDown:Point('TOPRIGHT', "$parentDisplayHeaderUnderline", 'BOTTOMRIGHT', -16, -4)
	  -- Graphics_PrimaryMonitorDropDown:Point('TOPRIGHT', Graphics_DisplayHeaderUnderline 'BOTTOMRIGHT', -16, -4)



		local Sliders = {
			"Graphics_Quality",
			"Advanced_UIScaleSlider",
			"Advanced_MaxFPSSlider",
			"Advanced_MaxFPSBKSlider",
			"Advanced_GammaSlider",
			"AudioOptionsSoundPanelSoundQuality",
			"AudioOptionsSoundPanelMasterVolume",
			"AudioOptionsSoundPanelSoundVolume",
			"AudioOptionsSoundPanelMusicVolume",
			"AudioOptionsSoundPanelAmbienceVolume",
			"AudioOptionsVoicePanelMicrophoneVolume",
			"AudioOptionsVoicePanelSpeakerVolume",
			"AudioOptionsVoicePanelSoundFade",
			"AudioOptionsVoicePanelMusicFade",
			"AudioOptionsVoicePanelAmbienceFade",
		}
		for _, slider in ipairs(Sliders) do
			_G[slider]:SkinSlider()
			_G[slider]:SetFrameLevel(_G[slider]:GetFrameLevel() + 2)
		end


		--------------------------------------------------
		--	Cleanup
		--------------------------------------------------
		_G["Graphics_Quality"].SetBackdrop = Addon["Dummy"]
		_G["Graphics_RightQuality"]:Strip()

		LoopbackVUMeter:Backdrop()			-- ("OVERLAY")
		LoopbackVUMeter:SetFrameLevel(LoopbackVUMeter:GetFrameLevel() + 1)
		LoopbackVUMeter.backdrop:Point("TOPLEFT", -4, 4)
		LoopbackVUMeter.backdrop:Point("BOTTOMRIGHT", 4, -4)

		_G["VideoOptionsFrameDefaults"]:Point("TOPLEFT", _G["VideoOptionsFrameCategoryFrame"], "BOTTOMLEFT", 0, -14)
		_G["VideoOptionsFrameCancel"]:Point("TOPRIGHT", _G["VideoOptionsFramePanelContainer"], "BOTTOMRIGHT", 0, -14)
		_G["VideoOptionsFrameOkay"]:Point("RIGHT", _G["VideoOptionsFrameCancel"], "LEFT", -4, 0)
		_G["VideoOptionsFrameApply"]:Point("RIGHT", _G["VideoOptionsFrameOkay"], "LEFT", -4, 0)

		_G["AudioOptionsVoicePanelPushToTalkSound"]:Point("BOTTOMLEFT", _G["AudioOptionsVoicePanelBinding"], "BOTTOMLEFT", 0, 0)
		_G["AudioOptionsVoicePanelChatMode1KeyBindingButton"]:Point("CENTER", _G["AudioOptionsVoicePanelBinding"], "CENTER", 0, -10)

	end
end

--------------------------------------------------
--	Events
--------------------------------------------------
do
	local e = CreateFrame('Frame')
	e:RegisterEvent('PLAYER_ENTERING_WORLD')
	e:SetScript('OnEvent', function(self, event)

		LoadSkin()

		self:UnregisterEvent(event)
	end)
end


--------------------------------------------------
--	Credits
--------------------------------------------------
--	ShestakUI by Shestak







