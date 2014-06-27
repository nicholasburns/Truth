local A, C, G, L = select(2, ...):Unpack()

if (not C["Skin"]["Enable"] or not C["Skin"]["Others"]["Enable"]) then
	return
end

local ipairs, pairs = ipairs, pairs
local select = select
local hooksecurefunc = hooksecurefunc






--------------------------------------------------
--	Skin
--------------------------------------------------
local LoadSkin
do
	local UnitIsUnit = UnitIsUnit
	local IsAddOnLoaded = IsAddOnLoaded
	local ChatFrame1 = ChatFrame1
	local QueueStatusFrame = QueueStatusFrame
	local GuildInviteFrame = GuildInviteFrame


	LoadSkin = function()

		local Backgrounds = {					-- Blizzard Frame reskin
			"GameMenuFrame",
			"BNToastFrame",
			"TicketStatusFrameButton",
			"AutoCompleteBox",
			"ReadyCheckFrame",
			"ColorPickerFrame",
			"LFDRoleCheckPopup",
			"ChannelPulloutBackground",
			"ChannelPulloutTab",
			"GuildInviteFrame",
			"RolePollPopup",
			"StackSplitFrame",
			"OpacityFrame",
			"GeneralDockManagerOverflowButtonList",
			"QueueStatusFrame",
			"BasicScriptErrors",
		}

		QueueStatusFrame:Strip()

		for _, background in ipairs(Backgrounds) do
			--[[ DEBUG ]]-- if (not _G[background]) then print(background) return end
			_G[background]:Template("TRANSPARENT")
		end




		-- Popups
		for i = 1, ( 4 ) do

			for j = 1, ( 3 ) do
				_G["StaticPopup" .. i .. "Button" .. j]:SkinButton()
			end

			_G["StaticPopup" .. i]:Template("TRANSPARENT")

			_G["StaticPopup" .. i .. "EditBox"]:SkinEditBox()

			_G["StaticPopup" .. i .. "MoneyInputFrameGold"]:SkinEditBox()
			_G["StaticPopup" .. i .. "MoneyInputFrameSilver"]:SkinEditBox()
			_G["StaticPopup" .. i .. "MoneyInputFrameCopper"]:SkinEditBox()

			_G["StaticPopup" .. i .. "EditBox"].backdrop:Point("TOPLEFT", -3, -6)
			_G["StaticPopup" .. i .. "EditBox"].backdrop:Point("BOTTOMRIGHT", -3, 6)

			_G["StaticPopup" .. i .. "MoneyInputFrameGold"].backdrop:Point("TOPLEFT", -3, 0)
			_G["StaticPopup" .. i .. "MoneyInputFrameSilver"].backdrop:Point("TOPLEFT", -3, 0)
			_G["StaticPopup" .. i .. "MoneyInputFrameCopper"].backdrop:Point("TOPLEFT", -3, 0)

			_G["StaticPopup" .. i .. "ItemFrame"]:GetNormalTexture():Kill()
			_G["StaticPopup" .. i .. "ItemFrame"]:Template("DEFAULT")
			_G["StaticPopup" .. i .. "ItemFrame"]:StyleButton()
			_G["StaticPopup" .. i .. "ItemFrameNameFrame"]:Kill()
			_G["StaticPopup" .. i .. "ItemFrameIconTexture"]:SetTexCoord(0.1, 0.9, 0.1, 0.9)
			_G["StaticPopup" .. i .. "ItemFrameIconTexture"]:SetInside()
		  -- _G["StaticPopup" .. i .. "ItemFrameIconTexture"]:Point("TOPLEFT", 2, -2)
		  -- _G["StaticPopup" .. i .. "ItemFrameIconTexture"]:Point("BOTTOMRIGHT", -2, 2)

			_G["StaticPopup" .. i .. "CloseButton"]:SetNormalTexture("")
			_G["StaticPopup" .. i .. "CloseButton"].SetNormalTexture = Addon["Dummy"]
			_G["StaticPopup" .. i .. "CloseButton"]:SetPushedTexture("")
			_G["StaticPopup" .. i .. "CloseButton"].SetPushedTexture = Addon["Dummy"]
			_G["StaticPopup" .. i .. "CloseButton"]:SkinCloseButton()
		end


		-- Cinematic
		_G["CinematicFrameCloseDialog"]:Template("TRANSPARENT")
		_G["CinematicFrameCloseDialogConfirmButton"]:SkinButton()
		_G["CinematicFrameCloseDialogResumeButton"]:SkinButton()


		-- PetBattle
		_G["PetBattleQueueReadyFrame"]:Template("TRANSPARENT")
		_G["PetBattleQueueReadyFrame"].AcceptButton:SkinButton()
		_G["PetBattleQueueReadyFrame"].DeclineButton:SkinButton()


		-- Dropdown Menu
		hooksecurefunc("UIDropDownMenu_InitializeHelper", function(frame)
			for i = 1, ( UIDROPDOWNMENU_MAXLEVELS ) do
				_G["DropDownList" .. i .. "Backdrop"]:Template("TRANSPARENT")
				_G["DropDownList" .. i .. "MenuBackdrop"]:Template("TRANSPARENT")
			end
		end)


		-- Chat Menus
		local ChatMenus = {
			"ChatMenu",
			"EmoteMenu",
			"LanguageMenu",
			"VoiceMacroMenu",
		}
		for _, menu in ipairs(ChatMenus) do		-- for i = 1, getn(ChatMenus) do
			if (menu == "ChatMenu") then
				_G[menu]:HookScript("OnShow", function(self)
					self:Template("TRANSPARENT")
					self:Point("BOTTOMRIGHT", ChatFrame1, 0, 30)
				end)
			else
				_G[menu]:HookScript("OnShow", function(self) self:Template("TRANSPARENT") end)
			end
		end


		-- Header Textures
		local Headers = {
			"GameMenuFrame",
			"ColorPickerFrame",
		}
		for _, header in ipairs(Headers) do
			_G[header .. "Header"]:SetTexture(nil)
			_G[header .. "Header"]:Point("TOP", header, 0, 7)
		end


		-- Buttons
		local Buttons = {
			"GameMenuButtonOptions",
			"GameMenuButtonHelp",
			"GameMenuButtonStore",
			"GameMenuButtonUIOptions",
			"GameMenuButtonKeybindings",
			"GameMenuButtonMacros",
			"GameMenuButtonRatings",
			"GameMenuButtonLogout",
			"GameMenuButtonQuit",
			"GameMenuButtonContinue",
			"GameMenuButtonMacOptions",
			"ReadyCheckFrameYesButton",
			"ReadyCheckFrameNoButton",
			"ColorPickerOkayButton",
			"ColorPickerCancelButton",
			"GuildInviteFrameJoinButton",
			"GuildInviteFrameDeclineButton",
			"RolePollPopupAcceptButton",
			"LFDRoleCheckPopupDeclineButton",
			"LFDRoleCheckPopupAcceptButton",
			"StackSplitOkayButton",
			"StackSplitCancelButton",
			"BasicScriptErrorsButton",
			"CompactRaidFrameManagerDisplayFrameLeaderOptionsRaidWorldMarkerButton",		-- Raid tools
		  --  -------------------------
		  --  Broken Buttons (2/1/2014)
		  --  -------------------------
		  -- "GameMenuButtonAddOns", "GameMenuButtonOptionHouse", "GameMenuButtonAddonManager", "GameMenuButtonSettingsUI",
		  -- "RaidUtilityConvertButton", "RaidUtilityMainTankButton", "RaidUtilityMainAssistButton", "RaidUtilityRoleButton",
		  -- "RaidUtilityReadyCheckButton", "RaidUtilityShowButton", "RaidUtilityCloseButton", "RaidUtilityDisbandButton", "RaidUtilityRaidControlButton",
		}
		for _, button in ipairs(Buttons) do
			--[[ DEBUG ]]-- if (not _G[button]) then print(button) return end
			_G[button]:SkinButton()
		end


		-- Button & Text Layout
		_G["ColorPickerOkayButton"]:Point("BOTTOMLEFT", _G["ColorPickerFrame"], 6, 6)
		_G["ColorPickerCancelButton"]:Point("BOTTOMRIGHT", _G["ColorPickerFrame"], -6, 6)

		_G["ReadyCheckFrameYesButton"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameNoButton"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameYesButton"]:Point("RIGHT", _G["ReadyCheckFrame"], "CENTER", 0, -22)
		_G["ReadyCheckFrameNoButton"]:Point("LEFT", _G["ReadyCheckFrameYesButton"], "RIGHT", 6, 0)
		_G["ReadyCheckFrameText"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameText"]:Point("TOP", 0, -12)

		_G["ChannelPulloutTabText"]:Point("TOP", _G["ChannelPulloutTab"], 0, -6)
		_G["ChannelPulloutTab"]:SetHeight(20)
		_G["ChannelPullout"]:Point("TOP", _G["ChannelPulloutTab"], "BOTTOM", 0, -3)


		-- Other
		for i = 1, ( 10 ) do
			select(i, GuildInviteFrame:GetRegions()):Hide()
		end

		_G["GeneralDockManagerOverflowButtonList"]:SetFrameStrata("HIGH")

		_G["ReadyCheckListenerFrame"]:SetAlpha(0)
		_G["ReadyCheckFrame"]:HookScript("OnShow", function(self) if (UnitIsUnit("player", self.initiator)) then self:Hide() end end)

		_G["StackSplitFrame"]:GetRegions():Hide()
		_G["StackSplitFrame"]:SetFrameStrata("TOOLTIP")

		_G["ChannelPulloutTabLeft"]:SetTexture(nil)
		_G["ChannelPulloutTabMiddle"]:SetTexture(nil)
		_G["ChannelPulloutTabRight"]:SetTexture(nil)

		_G["StaticPopup1CloseButton"]:HookScript("OnShow", function(self)
			self:Strip(true)
			self:SkinCloseButton(nil, "-")
		end)

		_G["ChannelPulloutCloseButton"]:SkinCloseButton()
		_G["RolePollPopupCloseButton"]:SkinCloseButton()
		_G["ItemRefCloseButton"]:SkinCloseButton()
		_G["BNToastFrameCloseButton"]:SkinCloseButton()


		-- Clique
		if (IsAddOnLoaded("Clique")) then
			CliqueSpellTab:GetRegions():SetSize(0.1, 0.1)
			CliqueSpellTab:GetNormalTexture():SetTexCoord(0.1, 0.9, 0.1, 0.9)
			CliqueSpellTab:GetNormalTexture():Point("TOPLEFT", 2, -2)
			CliqueSpellTab:GetNormalTexture():Point("BOTTOMRIGHT", -2, 2)
			CliqueSpellTab:Backdrop("DEFAULT")
			CliqueSpellTab.backdrop:SetAllPoints()
			CliqueSpellTab:StyleButton()
		end
	end
end

--------------------------------------------------
--	Events
--------------------------------------------------
do
	local events = CreateFrame('Frame')
	events:RegisterEvent('PLAYER_ENTERING_WORLD')							-- e:RegisterEvent('ADDON_LOADED')
	events:SetScript('OnEvent', function(self, event, addon)

		LoadSkin()

		self:UnregisterEvent(event)
	end)
end


--------------------------------------------------
--	Credits
--------------------------------------------------
--	ShestakUI by Shestak


--------------------------------------------------
--	Tukui Version
--------------------------------------------------
--[==[

local LoadSkin
do
	local BankFrame = BankFrame
	local BankItemSearchBox = BankItemSearchBox
	local BankFrameCloseButton = BankFrameCloseButton
	local BankFrameMoneyFrameBorder = BankFrameMoneyFrameBorder
	local BankFrameMoneyFrameInset = BankFrameMoneyFrameInset
	local BankFramePurchaseButton = BankFramePurchaseButton


	LoadSkin = function()

		-- Other blizzard frames to reskin
		local skins = {
			"StaticPopup1",
			"StaticPopup2",
			"StaticPopup3",
			"StaticPopup4",
			"GameMenuFrame",
			"InterfaceOptionsFrame",
			"VideoOptionsFrame",
			"AudioOptionsFrame",
			"LFDDungeonReadyStatus",
			"TicketStatusFrameButton",
			"LFDSearchStatus",
			"AutoCompleteBox",
			"ConsolidatedBuffsTooltip",
			"ReadyCheckFrame",
			"StackSplitFrame",
			"CharacterFrame",
			"VoiceChatTalkers"
		}

		for i = 1, getn(skins) do
			if (_G[skins[i]]) then
				_G[skins[i]]:Template("DEFAULT")
				if (_G[skins[i]] ~= _G["AutoCompleteBox"]) then -- frame to blacklist from create shadow function
					_G[skins[i]]:Shadow("DEFAULT")
				end
			end
		end

		--LFD Role Picker frame
		LFDRoleCheckPopup:Strip()
		LFDRoleCheckPopup:Template("DEFAULT")
		LFDRoleCheckPopupAcceptButton:SkinButton()
		LFDRoleCheckPopupDeclineButton:SkinButton()
		LFDRoleCheckPopupRoleButtonTank:GetChildren():SkinCheckButton()
		LFDRoleCheckPopupRoleButtonDPS:GetChildren():SkinCheckButton()
		LFDRoleCheckPopupRoleButtonHealer:GetChildren():SkinCheckButton()
		LFDRoleCheckPopupRoleButtonTank:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonTank:GetChildren():GetFrameLevel() + 1)
		LFDRoleCheckPopupRoleButtonDPS:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonDPS:GetChildren():GetFrameLevel() + 1)
		LFDRoleCheckPopupRoleButtonHealer:GetChildren():SetFrameLevel(LFDRoleCheckPopupRoleButtonHealer:GetChildren():GetFrameLevel() + 1)

		-- Cinematic popup
		CinematicFrameCloseDialog:Template()
		CinematicFrameCloseDialog:SetScale(C.general.uiscale)
		CinematicFrameCloseDialogConfirmButton:SkinButton()
		CinematicFrameCloseDialogResumeButton:SkinButton()

		-- Report Cheats
		ReportCheatingDialog:Strip()
		ReportCheatingDialog:Template()
		ReportCheatingDialogReportButton:SkinButton()
		ReportCheatingDialogCancelButton:SkinButton()
		ReportCheatingDialogCommentFrame:Strip()
		ReportCheatingDialogCommentFrameEditBox:SkinEditBox()

		-- Report Name
		ReportPlayerNameDialog:Strip()
		ReportPlayerNameDialog:Template()
		ReportPlayerNameDialogReportButton:SkinButton()
		ReportPlayerNameDialogCancelButton:SkinButton()
		ReportPlayerNameDialogCommentFrame:Strip()
		ReportPlayerNameDialogCommentFrameEditBox:SkinEditBox()

		-- reskin popup buttons
		for i = 1, 4 do
			for j = 1, 3 do
				_G["StaticPopup" .. i .. "Button" .. j]:SkinButton()
				_G["StaticPopup" .. i .. "EditBox"]:SkinEditBox()
				_G["StaticPopup" .. i .. "MoneyInputFrameGold"]:SkinEditBox()
				_G["StaticPopup" .. i .. "MoneyInputFrameSilver"]:SkinEditBox()
				_G["StaticPopup" .. i .. "MoneyInputFrameCopper"]:SkinEditBox()
				_G["StaticPopup" .. i .. "EditBox"].backdrop:Point("TOPLEFT", -2, -4)
				_G["StaticPopup" .. i .. "EditBox"].backdrop:Point("BOTTOMRIGHT", 2, 4)
				_G["StaticPopup" .. i .. "ItemFrameNameFrame"]:Kill()
				_G["StaticPopup" .. i .. "ItemFrame"]:GetNormalTexture():Kill()
				_G["StaticPopup" .. i .. "ItemFrame"]:Template("DEFAULT")
				_G["StaticPopup" .. i .. "ItemFrame"]:StyleButton()
				_G["StaticPopup" .. i .. "ItemFrameIconTexture"]:SetTexCoord(.08, .92, .08, .92)
				_G["StaticPopup" .. i .. "ItemFrameIconTexture"]:ClearAllPoints()
				_G["StaticPopup" .. i .. "ItemFrameIconTexture"]:Point("TOPLEFT", 2, -2)
				_G["StaticPopup" .. i .. "ItemFrameIconTexture"]:Point("BOTTOMRIGHT", -2, 2)
			end
		end

		-- reskin all esc/menu buttons
		local BlizzardMenuButtons = {
			"Options",
			"SoundOptions",
			"UIOptions",
			"Keybindings",
			"Macros",
			"Ratings",
			"AddOns",
			"Logout",
			"Quit",
			"Continue",
			"MacOptions",
			"Help"
		}

		for i = 1, getn(BlizzardMenuButtons) do
			local button = _G["GameMenuButton" .. BlizzardMenuButtons[i]]
			if (button) then
				button:SkinButton()
			end
		end

		if (IsAddOnLoaded("OptionHouse")) then
			GameMenuButtonOptionHouse:SkinButton()
		end

		-- hide header textures and move text/buttons.
		local BlizzardHeader = {
			"GameMenuFrame",
			"InterfaceOptionsFrame",
			"AudioOptionsFrame",
			"VideoOptionsFrame",
		}

		for i = 1, getn(BlizzardHeader) do
			local title = _G[BlizzardHeader[i] .. "Header"]
			if (title) then
				title:SetTexture("")
				title:ClearAllPoints()
				if (title == _G["GameMenuFrameHeader"]) then
					title:Point("TOP", GameMenuFrame, 0, 7)
				else
					title:Point("TOP", BlizzardHeader[i], 0, 0)
				end
			end
		end

		-- here we reskin all "normal" buttons
		local BlizzardButtons = {
			"VideoOptionsFrameOkay",
			"VideoOptionsFrameCancel",
			"VideoOptionsFrameDefaults",
			"VideoOptionsFrameApply",
			"AudioOptionsFrameOkay",
			"AudioOptionsFrameCancel",
			"AudioOptionsFrameDefaults",
			"InterfaceOptionsFrameDefaults",
			"InterfaceOptionsFrameOkay",
			"InterfaceOptionsFrameCancel",
			"ReadyCheckFrameYesButton",
			"ReadyCheckFrameNoButton",
			"StackSplitOkayButton",
			"StackSplitCancelButton",
			"RolePollPopupAcceptButton",
			"InterfaceOptionsHelpPanelResetTutorials",
			"CompactUnitFrameProfilesGeneralOptionsFrameResetPositionButton",
		}

		for i = 1, getn(BlizzardButtons) do
			local Buttons = _G[BlizzardButtons[i]]
			if (Buttons) then
				Buttons:SkinButton()
			end
		end

		-- if (a button position is not really where we want, we move it here
		_G["VideoOptionsFrameCancel"]:ClearAllPoints()
		_G["VideoOptionsFrameCancel"]:Point("RIGHT", _G["VideoOptionsFrameApply"], "LEFT", -4, 0)
		_G["VideoOptionsFrameOkay"]:ClearAllPoints()
		_G["VideoOptionsFrameOkay"]:Point("RIGHT", _G["VideoOptionsFrameCancel"], "LEFT", -4, 0)
		_G["AudioOptionsFrameOkay"]:ClearAllPoints()
		_G["AudioOptionsFrameOkay"]:Point("RIGHT", _G["AudioOptionsFrameCancel"], "LEFT", -4, 0)
		_G["InterfaceOptionsFrameOkay"]:ClearAllPoints()
		_G["InterfaceOptionsFrameOkay"]:Point("RIGHT", _G["InterfaceOptionsFrameCancel"], "LEFT", -4, 0)
		_G["ReadyCheckFrameYesButton"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameNoButton"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameYesButton"]:ClearAllPoints()
		_G["ReadyCheckFrameNoButton"]:ClearAllPoints()
		_G["ReadyCheckFrameYesButton"]:Point("RIGHT", _G["ReadyCheckFrame"], "CENTER", -2, -20)
		_G["ReadyCheckFrameNoButton"]:Point("LEFT", _G["ReadyCheckFrameYesButton"], "RIGHT", 3, 0)
		_G["ReadyCheckFrameText"]:SetParent(_G["ReadyCheckFrame"])
		_G["ReadyCheckFrameText"]:ClearAllPoints()
		_G["ReadyCheckFrameText"]:Point("TOP", 0, -12)

		-- others
		_G["ReadyCheckListenerFrame"]:SetAlpha(0)
		_G["ReadyCheckFrame"]:HookScript("OnShow", function(self) if (UnitIsUnit("player", self.initiator)) then self:Hide() end end) -- bug fix, don't show it if (initiator
		_G["StackSplitFrame"]:GetRegions():Hide()
		_G["GeneralDockManagerOverflowButtonList"]:Template()

		RolePollPopup:Template("DEFAULT")
		RolePollPopup:Shadow("DEFAULT")
		RolePollPopupCloseButton:SkinCloseButton()

		BasicScriptErrors:Strip()
		BasicScriptErrors:Template()
		BasicScriptErrors:Shadow()
		BasicScriptErrorsButton:SkinButton()
		BasicScriptErrors:SetScale(C.general.uiscale)

		for i = 1, 4 do
			local button = _G["StaticPopup" .. i .. "CloseButton"]
			button:SetNormalTexture("")
			button.SetNormalTexture = Addon["Dummy"]
			button:SetPushedTexture("")
			button.SetPushedTexture = Addon["Dummy"]
			button:SkinCloseButton()
		end

		local frames = {
			"VideoOptionsFrameCategoryFrame",
			"VideoOptionsFramePanelContainer",
			"InterfaceOptionsFrameCategories",
			"InterfaceOptionsFramePanelContainer",
			"InterfaceOptionsFrameAddOns",
			"AudioOptionsSoundPanelPlayback",
			"AudioOptionsSoundPanelVolume",
			"AudioOptionsSoundPanelHardware",
			"AudioOptionsVoicePanelTalking",
			"AudioOptionsVoicePanelBinding",
			"AudioOptionsVoicePanelListening",
		}

		for i = 1, getn(frames) do
			local SkinFrames = _G[frames[i]]
			if (SkinFrames) then
				SkinFrames:Strip()
				SkinFrames:Backdrop("TRANSPARENT")
				if (SkinFrames ~= _G["VideoOptionsFramePanelContainer"] and SkinFrames ~= _G["InterfaceOptionsFramePanelContainer"]) then
					SkinFrames.backdrop:Point("TOPLEFT", -1, 0)
					SkinFrames.backdrop:Point("BOTTOMRIGHT", 0, 1)
				else
					SkinFrames.backdrop:Point("TOPLEFT", 0, 0)
					SkinFrames.backdrop:Point("BOTTOMRIGHT", 0, 0)
				end
			end
		end

		local interfacetab = {
		"InterfaceOptionsFrameTab1",
		"InterfaceOptionsFrameTab2",
		}
		for i = 1, getn(interfacetab) do
			local itab = _G[interfacetab[i]]
			if (itab) then
				itab:Strip()
				itab:SkinTab()
			end
		end
		InterfaceOptionsFrameTab1:ClearAllPoints()
		InterfaceOptionsFrameTab1:Point("BOTTOMLEFT", InterfaceOptionsFrameCategories, "TOPLEFT", -11, -2)

		VideoOptionsFrameDefaults:ClearAllPoints()
		InterfaceOptionsFrameDefaults:ClearAllPoints()
		InterfaceOptionsFrameCancel:ClearAllPoints()
		VideoOptionsFrameDefaults:Point("TOPLEFT", VideoOptionsFrameCategoryFrame, "BOTTOMLEFT", -1, -5)
		InterfaceOptionsFrameDefaults:Point("TOPLEFT", InterfaceOptionsFrameCategories, "BOTTOMLEFT", -1, -5)
		InterfaceOptionsFrameCancel:Point("TOPRIGHT", InterfaceOptionsFramePanelContainer, "BOTTOMRIGHT", 0, -6)

		local interfacecheckbox = {
		-- Controls
		"ControlsPanelStickyTargeting",
		"ControlsPanelAutoDismount",
		"ControlsPanelAutoClearAFK",
		"ControlsPanelBlockTrades",
		"ControlsPanelBlockGuildInvites",
		"ControlsPanelLootAtMouse",
		"ControlsPanelAutoLootCorpse",
		"ControlsPanelAutoOpenLootHistory",
		"ControlsPanelInteractOnLeftClick",
		-- Combat
		"CombatPanelAttackOnAssist",
		"CombatPanelStopAutoAttack",
		"CombatPanelNameplateClassColors",
		"CombatPanelTargetOfTarget",
		"CombatPanelShowSpellAlerts",
		"CombatPanelReducedLagTolerance",
		"CombatPanelActionButtonUseKeyDown",
		"CombatPanelLossOfControl",
		"CombatPanelEnemyCastBarsOnPortrait",
		"CombatPanelEnemyCastBarsOnNameplates",
		"CombatPanelAutoSelfCast",
		-- Display
		"DisplayPanelShowCloak",
		"DisplayPanelShowHelm",
		"DisplayPanelShowAggroPercentage",
		"DisplayPanelPlayAggroSounds",
		"DisplayPanelDetailedLootInfo",
		"DisplayPanelShowSpellPointsAvg",
		"DisplayPanelemphasizeMySpellEffects",
		"DisplayPanelShowFreeBagSpace",
		"DisplayPanelCinematicSubtitles",
		"DisplayPanelRotateMinimap",
		"DisplayPanelScreenEdgeFlash",
		--Objectives
		"ObjectivesPanelAutoQuestTracking",
		"ObjectivesPanelAutoQuestProgress",
		"ObjectivesPanelMapQuestDifficulty",
		"ObjectivesPanelAdvancedWorldMap",
		"ObjectivesPanelWatchFrameWidth",
		-- Social
		"SocialPanelProfanityFilter",
		"SocialPanelSpamFilter",
		"SocialPanelChatBubbles",
		"SocialPanelPartyChat",
		"SocialPanelChatHoverDelay",
		"SocialPanelGuildMemberAlert",
		"SocialPanelChatMouseScroll",
		"SocialPanelWholeChatWindowClickable",
		-- Action bars
		"ActionBarsPanelBottomLeft",
		"ActionBarsPanelBottomRight",
		"ActionBarsPanelRight",
		"ActionBarsPanelRightTwo",
		"ActionBarsPanelLockActionBars",
		"ActionBarsPanelAlwaysShowActionBars",
		"ActionBarsPanelSecureAbilityToggle",
		-- Names
		"NamesPanelMyName",
		"NamesPanelFriendlyPlayerNames",
		"NamesPanelFriendlyPets",
		"NamesPanelFriendlyGuardians",
		"NamesPanelFriendlyTotems",
		"NamesPanelUnitNameplatesFriends",
		"NamesPanelUnitNameplatesFriendlyGuardians",
		"NamesPanelUnitNameplatesFriendlyPets",
		"NamesPanelUnitNameplatesFriendlyTotems",
		"NamesPanelGuilds",
		"NamesPanelGuildTitles",
		"NamesPanelTitles",
		"NamesPanelNonCombatCreature",
		"NamesPanelEnemyPlayerNames",
		"NamesPanelEnemyPets",
		"NamesPanelEnemyGuardians",
		"NamesPanelEnemyTotems",
		"NamesPanelUnitNameplatesEnemyPets",
		"NamesPanelUnitNameplatesEnemies",
		"NamesPanelUnitNameplatesEnemyGuardians",
		"NamesPanelUnitNameplatesEnemyTotems",
		-- Combat Text
		"CombatTextPanelTargetDamage",
		"CombatTextPanelPeriodicDamage",
		"CombatTextPanelPetDamage",
		"CombatTextPanelHealing",
		"CombatTextPanelTargetEffects",
		"CombatTextPanelOtherTargetEffects",
		"CombatTextPanelEnableFCT",
		"CombatTextPanelDodgeParryMiss",
		"CombatTextPanelDamageReduction",
		"CombatTextPanelRepChanges",
		"CombatTextPanelReactiveAbilities",
		"CombatTextPanelFriendlyHealerNames",
		"CombatTextPanelCombatState",
		"CombatTextPanelComboPoints",
		"CombatTextPanelLowManaHealth",
		"CombatTextPanelEnergyGains",
		"CombatTextPanelPeriodicEnergyGains",
		"CombatTextPanelHonorGains",
		"CombatTextPanelAuras",
		"CombatTextPanelAutoSelfCast",
		-- Status Text
		"StatusTextPanelPlayer",
		"StatusTextPanelPet",
		"StatusTextPanelParty",
		"StatusTextPanelTarget",
		"StatusTextPanelAlternateResource",
		"StatusTextPanelPercentages",
		"StatusTextPanelXP",
		-- Unit Frames
		"UnitFramePanelPartyPets",
		"UnitFramePanelArenaEnemyFrames",
		"UnitFramePanelArenaEnemyCastBar",
		"UnitFramePanelArenaEnemyPets",
		"UnitFramePanelFullSizeFocusFrame",
		-- Buffs & Debuffs
		"BuffsPanelBuffDurations",
		"BuffsPanelDispellableDebuffs",
		"BuffsPanelCastableBuffs",
		"BuffsPanelConsolidateBuffs",
		"BuffsPanelShowAllEnemyDebuffs",
		--Battle net
		"BattlenetPanelOnlineFriends",
		"BattlenetPanelOfflineFriends",
		"BattlenetPanelBroadcasts",
		"BattlenetPanelFriendRequests",
		"BattlenetPanelConversations",
		"BattlenetPanelShowToastWindow",
		-- Camera
		"CameraPanelFollowTerrain",
		"CameraPanelHeadBob",
		"CameraPanelWaterCollision",
		"CameraPanelSmartPivot",
		-- Mouse
		"MousePanelInvertMouse",
		"MousePanelClickToMove",
		"MousePanelWoWMouse",
		-- Help
		"HelpPanelShowTutorials",
		"HelpPanelLoadingScreenTips",
		"HelpPanelEnhancedTooltips",
		"HelpPanelBeginnerTooltips",
		"HelpPanelShowLuaErrors",
		"HelpPanelColorblindMode",
		"HelpPanelMovePad",

		"DisplayPanelShowAccountAchievments",
		}
		for i = 1, getn(interfacecheckbox) do
			local icheckbox = _G["InterfaceOptions" .. interfacecheckbox[i]]
			if (icheckbox) then
				icheckbox:SkinCheckButton()
			end
		end

		local interfacedropdown ={
		-- Controls
		"ControlsPanelAutoLootKeyDropDown",
		-- Combat
		"CombatPanelTOTDropDown",
		"CombatPanelFocusCastKeyDropDown",
		"CombatPanelSelfCastKeyDropDown",
		"CombatPanelLossOfControlFullDropDown",
		"CombatPanelLossOfControlSilenceDropDown",
		"CombatPanelLossOfControlInterruptDropDown",
		"CombatPanelLossOfControlDisarmDropDown",
		"CombatPanelLossOfControlRootDropDown",
		-- Display
		"DisplayPanelAggroWarningDisplay",
		"DisplayPanelWorldPVPObjectiveDisplay",
		-- Social
		"SocialPanelChatStyle",
		"SocialPanelWhisperMode",
		"SocialPanelTimestamps",
		"SocialPanelBnWhisperMode",
		"SocialPanelConversationMode",
		-- Action bars
		"ActionBarsPanelPickupActionKeyDropDown",
		-- Names
		"NamesPanelNPCNamesDropDown",
		"NamesPanelUnitNameplatesMotionDropDown",
		-- Combat Text
		"CombatTextPanelFCTDropDown",
		-- Camera
		"CameraPanelStyleDropDown",
		-- Mouse
		"MousePanelClickMoveStyleDropDown",
		"LanguagesPanelLocaleDropDown",
		}
		for i = 1, getn(interfacedropdown) do
			local idropdown = _G["InterfaceOptions" .. interfacedropdown[i]]
			if (idropdown) then
				idropdown:SkinDropDownBox()
				DropDownList1:Template("TRANSPARENT")
			end
		end
		InterfaceOptionsHelpPanelResetTutorials:SkinButton()

		local optioncheckbox = {
		-- Advanced
		"Advanced_MaxFPSCheckBox",
		"Advanced_MaxFPSBKCheckBox",
		"Advanced_DesktopGamma",
		-- Audio
		"AudioOptionsSoundPanelEnableSound",
		"AudioOptionsSoundPanelSoundEffects",
		"AudioOptionsSoundPanelErrorSpeech",
		"AudioOptionsSoundPanelEmoteSounds",
		"AudioOptionsSoundPanelPetSounds",
		"AudioOptionsSoundPanelMusic",
		"AudioOptionsSoundPanelLoopMusic",
		"AudioOptionsSoundPanelPetBattleMusic",
		"AudioOptionsSoundPanelAmbientSounds",
		"AudioOptionsSoundPanelSoundInBG",
		"AudioOptionsSoundPanelReverb",
		"AudioOptionsSoundPanelHRTF",
		"AudioOptionsSoundPanelEnableDSPs",
		"AudioOptionsSoundPanelUseHardware",
		"AudioOptionsVoicePanelEnableVoice",
		"AudioOptionsVoicePanelEnableMicrophone",
		"AudioOptionsVoicePanelPushToTalkSound",
		-- Network
		"NetworkOptionsPanelOptimizeSpeed",
		"NetworkOptionsPanelUseIPv6",
		}
		for i = 1, getn(optioncheckbox) do
			local ocheckbox = _G[optioncheckbox[i]]
			if (ocheckbox) then
				ocheckbox:SkinCheckButton()
			end
		end

		local optiondropdown = {
		-- Graphics
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
		-- Advanced
		"Advanced_BufferingDropDown",
		"Advanced_LagDropDown",
		"Advanced_HardwareCursorDropDown",
		"Advanced_GraphicsAPIDropDown",
		-- Audio
		"AudioOptionsSoundPanelHardwareDropDown",
		"AudioOptionsSoundPanelSoundChannelsDropDown",
		"AudioOptionsVoicePanelInputDeviceDropDown",
		"AudioOptionsVoicePanelChatModeDropDown",
		"AudioOptionsVoicePanelOutputDeviceDropDown",
		}
		for i = 1, getn(optiondropdown) do
			local odropdown = _G[optiondropdown[i]]
			if (odropdown) then
				odropdown:SkinDropDownBox(165)
				DropDownList1:Template("TRANSPARENT")
			end
		end

		local buttons = {
		 "RecordLoopbackSoundButton",
		 "PlayLoopbackSoundButton",
		 "AudioOptionsVoicePanelChatMode1KeyBindingButton",
		}

		for _, button in pairs(buttons) do
			_G[button]:SkinButton()
		end
		InterfaceOptionsFrameAddOnsListScrollBar:SkinScrollBar()
		AudioOptionsVoicePanelChatMode1KeyBindingButton:ClearAllPoints()
		AudioOptionsVoicePanelChatMode1KeyBindingButton:Point("CENTER", AudioOptionsVoicePanelBinding, "CENTER", 0, -10)

		-- sliders
		local slides = {
			"InterfaceOptionsCombatPanelSpellAlertOpacitySlider",
			"InterfaceOptionsCombatPanelMaxSpellStartRecoveryOffset",
			"InterfaceOptionsBattlenetPanelToastDurationSlider",
			"InterfaceOptionsCameraPanelMaxDistanceSlider",
			"InterfaceOptionsCameraPanelFollowSpeedSlider",
			"InterfaceOptionsMousePanelMouseSensitivitySlider",
			"InterfaceOptionsMousePanelMouseLookSpeedSlider",
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

		for i = 1, getn(slides) do
			if (_G[slides[i]]) then
				if (_G[slides[i]] ~= AudioOptionsSoundPanelSoundVolume) then
					_G[slides[i]]:SkinSlideBar(8, true)
				else
					_G[slides[i]]:SkinSlideBar(8)
				end
			end
		end

		Graphics_Quality:SetScript("OnUpdate", function(self)
			Graphics_Quality:SkinSlideBar(11)
		end )
		Graphics_RightQuality:SetAlpha(0)

		Graphics_QualityLow2:Point("BOTTOM", 0, -20)
		Graphics_QualityFair:Point("BOTTOM", 0, -20)
		Graphics_RightQualityLabel:Point("TOP", 0, 16)
		Graphics_QualityMed:Point("BOTTOM", 0, -20)
		Graphics_QualityHigh2:Point("BOTTOM", 0, -20)
		Graphics_QualityUltra:Point("BOTTOM", 0, -20)

		-- mac option
		MacOptionsFrame:Strip()
		MacOptionsFrame:Template()
		MacOptionsButtonCompress:SkinButton()
		MacOptionsButtonKeybindings:SkinButton()
		MacOptionsFrameDefaults:SkinButton()
		MacOptionsFrameOkay:SkinButton()
		MacOptionsFrameCancel:SkinButton()
		MacOptionsFrameMovieRecording:Strip()
		MacOptionsITunesRemote:Strip()
		MacOptionsFrameMisc:Strip()

		MacOptionsFrameResolutionDropDown:SkinDropDownBox()
		MacOptionsFrameFramerateDropDown:SkinDropDownBox()
		MacOptionsFrameCodecDropDown:SkinDropDownBox()
		MacOptionsFrameQualitySlider:SkinSlideBar(10)

		for i = 1, 11 do
			local b = _G["MacOptionsFrameCheckButton" .. i]
			b:SkinCheckButton()
		end

		MacOptionsButtonKeybindings:ClearAllPoints()
		MacOptionsButtonKeybindings:Point("LEFT", MacOptionsFrameDefaults, "RIGHT", 2, 0)
		MacOptionsFrameOkay:ClearAllPoints()
		MacOptionsFrameOkay:Point("LEFT", MacOptionsButtonKeybindings, "RIGHT", 2, 0)
		MacOptionsFrameCancel:ClearAllPoints()
		MacOptionsFrameCancel:Point("LEFT", MacOptionsFrameOkay, "RIGHT", 2, 0)
		MacOptionsFrameCancel:SetWidth(MacOptionsFrameCancel:GetWidth() - 6)
	end
end

--------------------------------------------------
--	Events
--------------------------------------------------
do
	local events = CreateFrame('Frame')
	events:RegisterEvent('PLAYER_ENTERING_WORLD')							-- e:RegisterEvent('ADDON_LOADED')
	events:SetScript('OnEvent', function(self, event, addon)
		LoadSkin()
	end)
end

--]==]









