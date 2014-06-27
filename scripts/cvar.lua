local A, C, G, L = select(2, ...):Unpack()

-- CVars URL
-- http://wowpedia.org/Console_variables


--------------------------------------------------
--	CVars & Value Settins
--------------------------------------------------
local CVars

do

	CVars = {

		-- actionbars
		alwaysShowActionBars 			= 1,				-- Whether to always show the action bar grid. Default: 0

		-- buffs
		buffDurations 					= 1,				-- Whether to show buff durations. Default: 1
		consolidateBuffs 				= 1,				-- This CVars sets whether Buffs and Debuffs should be consolidated in the buffs section of the UI. Default: 0

		-- camera
		cameraDistanceMax 				= 30,			-- Sets the maximum distance (0-50) which you can zoom out to. Default: 15
		cameraDistanceMaxFactor 			= 2,				-- Sets the factor (0-4) by which cameraDistanceMax is multiplied. Default: 1
		cameraWaterCollision 			= 1,				-- Enables water collision for the camera. Depending on the player being above or below the water level, the camera will follow.
		cameraSmoothStyle 				= 1,				-- Controls the automatic camera adjustment-the 'following style' (0-4). Default: 4 (Adjust camera only when moving.) -- 1 = Adjust camera only horizontal when moving.
		screenshotQuality 				= 10,

		-- chat
		chatStyle  					= 'classic',
		conversationMode  				= 'inline',
		bnWhisperMode  				= 'inline',
		whisperMode 					= 'inline',
		chatBubbles 					= 1,
		chatBubblesParty 				= 0,
		chatMouseScroll				= 1,				-- 1 = allow mouse scrolling in chat, 0 = NO MOUSEY
		colorChatNamesByClass 			= 1,
		profanityFilter 				= 0,
		removeChatDelay 				= 1,
		spamFilter 					= 0,

		-- combat										-- showVKeyCastbar = 1, -- UNKNOWN:  /run print('GetCVar(\'showVKeyCastbar\') = ' .. GetCVar('showVKeyCastbar'))
		spellActivationOverlayOpacity 	= 1,
		threatPlaySounds 				= 1,
		threatWarning					= 3,				-- 3 = enhanced threat (somehow) ?

		-- combattext
		enableCombatText 				= 0,
		PetMeleeDamage					= 0,
		CombatDamage					= 0,
		CombatHealing					= 0,
		CombatLogPeriodicSpells			= 0,

		-- guild
		guildMemberNotify  				= 0,
		guildRewardsCategory  			= 0,
		guildRewardsUsable  			= 0,
		guildRosterView 				= 'playerStatus',	-- The current guild roster display mode (playerStatus, guildStatus, weeklyxp, totalxp, achievement, tradeskill). Default: playerStatus
		guildShowOffline 				= 0,				-- Whether to show offline members in the guild UI. Default: 1

		-- maps
		miniWorldMap					= 1,				-- WorldMap: set smaller version to default

		-- mouse
		alwaysCompareItems 				= 1,				-- "1" to Always show item comparison tooltips. "0" to Always hide. (0 or 1) Default: 0
		lootUnderMouse  				= 0,
		UberTooltips  					= 1,
		deselectOnClick  				= 0,
		interactOnLeftClick  			= 1,

		-- names
		UnitNameOwn 					= 1,
		UnitNameNPC 					= 1,
		UnitNameNonCombatCreatureName 	= 0,
		UnitNameGuildTitle  			= 0,
		UnitNamePlayerGuild 			= 1,
		UnitNamePlayerPVPTitle 			= 0,
		UnitNameFriendlyPlayerName 		= 1,
		UnitNameFriendlyPetName 			= 0,
		UnitNameFriendlyGuardianName 		= 0,
		UnitNameFriendlyTotemName 		= 0,
		UnitNameEnemyPlayerName 			= 1,
		UnitNameEnemyPetName 			= 0,
		UnitNameEnemyGuardianName 		= 0,
		UnitNameEnemyTotemName 			= 1,


		-- nameplates
		nameplateShowFriends			= 0,
		nameplateShowFriendlyPets 		= 0,
		nameplateShowFriendlyGuardians 	= 0,
		nameplateShowFriendlyTotems 		= 0,
		nameplateShowEnemies			= 1,
		nameplateShowEnemyPets 			= 0,
		nameplateShowEnemyGuardians 		= 0,
		nameplateShowEnemyTotems 		= 1,
		ShowClassColorInNameplate 		= 1,

		-- party
		showPartyBackground				= 1,

		-- unitframes
		showArenaEnemyFrames 			= 0,

		-- toast
		showToastOnline 				= 0,
		showToastOffline 				= 0,
		showToastBroadcast 				= 0,
		showToastConversation 			= 0,
		showToastWindow 				= 0,

		-- quest
		autoQuestWatch 				= 1,
		autoQuestProgress 				= 1,
		mapQuestDifficulty 				= 1,

		-- sound
		Sound_EnableAllSound 			= 1,
		Sound_EnableMusic 				= 0,
		Sound_EnableAmbience 			= 0,
		Sound_EnableSoundWhenGameIsInBG 	= 1,

		-- other
		autoLootDefault 				= 1,
		autoDismountFlying 				= 0,
		movieSubtitle 					= 0,
		showTutorials 					= 0,

		-- time
		timeMgrUseLocalTime				= 1,	--[[ DOES THIS EAT SHIT LIKE useLocalTim ?! FIND OUT !! ]]

		-- shestak choices
		shadowMode					= 0,
		ffxDeath						= 0,
		ffxNetherWorld					= 0,

		-- floating combat text (fct)
		fctLowManaHealth				= 0,
		fctReactives					= 0,
	}


	local pairs = pairs
	local CreateFrame = CreateFrame
	local SetCVar = SetCVar
	local SetActionBarToggles = SetActionBarToggles
	local SetAllowLowLevelRaid = SetAllowLowLevelRaid
	local SetAutoDeclineGuildInvites = SetAutoDeclineGuildInvites
	local SetMultisampleFormat = SetMultisampleFormat
	local ShowAccountAchievements = ShowAccountAchievements


	local f = CreateFrame('Frame')
	f:RegisterEvent('PLAYER_ENTERING_WORLD')
	f:SetScript('OnEvent', function(self, event, addon)


		-- Development
		CVars.scriptErrors = 1
		CVars.taintLog = 2					-- Records taint msgs (file is written periodically & 1x @ logout) Default: 0 --> 0 = No taint data, 1 = Basic taint data, 2 = Full taint data --> /console taintLog 2
	  -- SetCVar(scriptErrors, 1)
	  -- SetCVar(taintLog, 2)				-- Records taint msgs (file is written periodically & 1x @ logout) Default: 0 --> 0 = No taint data, 1 = Basic taint data, 2 = Full taint data --> /console taintLog 2


	--[[ WINDOWED FULLSCREEN MODE
		Both CVars must be using a value of 1
	--]]	------------------------
		CVars.gxWindow = 1					-- 1 = windowed mode, 0 = not windowed
		CVars.gxMaximize = 0				-- 1 = fullscreen mode, 0 = not fullscreen
	--	SetCVar(gxWindow, 1)				-- 1 = windowed mode, 0 = not windowed
	--	SetCVar(gxMaximize, 0)				-- 1 = fullscreen mode, 0 = not fullscreen


		-- Pixel Perfect
		CVars.useUiScale = 1
		CVars.uiScale = G.UISCALE
		CVars.gxMultisample = 1
		SetMultisampleFormat(1)				-- PixelPerfection requires value to be (1)


		-- Apply CVars Settings
		for k, v in pairs(CVars) do
			SetCVar(k, v)
		end

		CVars = nil						-- Release


		-- Apply Non-CVars Settings
		SetAllowLowLevelRaid(1)
		ShowAccountAchievements(1)
		SetAutoDeclineGuildInvites(1)
		SetActionBarToggles(1, 1, 1, 1, 1)		-- SetActionBarToggles(bar1, bar2, bar3, bar4, alwaysShow)


		-- Debug
--		A.print("CVar Setup", "done")


		-- Kill It
		self:UnregisterEvent('PLAYER_ENTERING_WORLD')
	end)
end



--------------------------------------------------
--	[NOTE]:I MODIFIED THIS CODE FOR READABILITY
--	Graphics Display Mode
--	GrphicsQualityLevels.lua
--------------------------------------------------
--[[	Graphics_DisplayModeDropDown = {

	name = VIDEO_DISPLAY_MODE,
	desc = OPTION_TOOLTIP_DISPLAY_MODE,

	data = {

	  [1] = {	text = VIDEO_OPTIONS_WINDOWED,
			cvars =	{
				gxWindow = 1,
				gxMaximize = 0,
			},
			windowed = true
			fullscreen = false
	  },

	  [2] = {	text = VIDEO_OPTIONS_WINDOWED_FULLSCREEN,
			cvars =	{
				gxWindow = 1,
				gxMaximize = 1,
			},
			windowed = true
			fullscreen = true
	  },

	  [3] = {	text = VIDEO_OPTIONS_FULLSCREEN,
			cvars =	{
				gxWindow = 0,
				gxMaximize = 0,
			},
			windowed = false
			fullscreen = true
		},
	},
--]]
