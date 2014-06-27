local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Enable"] or not C["Chat"]["Sounds"]["Enable"]) then
	return
end




do
	local pairs = pairs


	local EventSounds = {
		['CHAT_MSG_GUILD'] 			= A.media.sound.acquire,
		['CHAT_MSG_OFFICER'] 		= A.media.sound.acquire,
		['CHAT_MSG_INSTANCE']		= A.media.sound.yoshi,
		['CHAT_MSG_INSTANCE_LEADER']	= A.media.sound.yoshi,
		['CHAT_MSG_PARTY'] 			= A.media.sound.electronic,
		['CHAT_MSG_PARTY_LEADER'] 	= A.media.sound.electronic,
		['CHAT_MSG_RAID'] 			= A.media.sound.whisper,
		['CHAT_MSG_RAID_LEADER'] 	= A.media.sound.whisper,
		['CHAT_MSG_WHISPER'] 		= A.media.sound.whisper,
		['CHAT_MSG_BN_WHISPER'] 		= A.media.sound.whisper,
		['CHAT_MSG_REALID']			= A.media.sound.zelda,
	  -- ['CHAT_MSG_CHANNEL']		= A.media.sound.whisper, -- SPAM!
	}


	local f = CreateFrame('Frame')

	for event in pairs(EventSounds) do
		f:RegisterEvent(event)
	end

	f:SetScript("OnEvent", function(self, event)
		_G.PlaySoundFile(EventSounds[event], "Master")
	end)
end


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Whispers

	local w = CreateFrame('Frame')
	w:RegisterEvent('CHAT_MSG_WHISPER')
	w:RegisterEvent('CHAT_MSG_BN_WHISPER')
	w:SetScript("OnEvent", function(self, event)
		PlaySoundFile(A.media.sound.whisper, "Master")
	end)
--]]

--------------------------------------------------
--	Sound Choices (media.lua)
--------------------------------------------------
--[[ A.media.sound = {
		['acquire']	= SOUNDS .. "acquire",		-- A.media.sound.acquire
		['electronic']	= SOUNDS .. "estring",		-- A.media.sound.electronic
		['error']		= SOUNDS .. "error",		-- A.media.sound.error
		['msn']		= SOUNDS .. "msn",			-- A.media.sound.msn
		['warn']		= SOUNDS .. "warn",			-- A.media.sound.warn
		['femalewarn']	= SOUNDS .. "femalewarn",	-- A.media.sound.femalewarn
		['whisper']	= SOUNDS .. "whisper",		-- A.media.sound.whisper
		['yoshi']		= SOUNDS .. "yoshi",		-- A.media.sound.yoshi
		['zelda']		= SOUNDS .. "zelda",		-- A.media.sound.zelda
		['affliction']	= SOUNDS .. "affliction",	-- A.media.sound.affliction
		['failure']	= SOUNDS .. "failure",		-- A.media.sound.failure
		['necrotic']	= SOUNDS .. "necrotic",		-- A.media.sound.necrotic		-- credit: Decursive
	}
--]]

--------------------------------------------------
--	PlaySoundFile (Notes)
--------------------------------------------------
--[[ PlaySoundFile('sndFile', ['sndChannel'])
	---------------------------------------------
	● sndFile 	A path to the sound file to be played (string)
	● sndChannel 	Which of the following volume sliders the sound should use:
			 --> SFX, Music, Ambience, Master (string)
--]]

--------------------------------------------------
--	Whisper Notifications - REVERT (WORKING)
--------------------------------------------------
--[[ local w = CreateFrame('Frame')
	w:RegisterEvent('CHAT_MSG_WHISPER')
	w:RegisterEvent('CHAT_MSG_BN_WHISPER')
	w:SetScript('OnEvent', function(self, event)
		if (event == 'CHAT_MSG_WHISPER' or event == 'CHAT_MSG_BN_WHISPER') then
			PlaySoundFile(A.media.sound.whisper, 'Master')
		end
	end)
--]]

--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ local name = UnitName('player')

	local soundpath = "Interface\\AddOns\\" .. AddOn .. "\\media\\sound\\"

	local sound = {
		['acquire']	= SOUND_PATH .. 'acquire.mp3',
		['electronic']	= SOUND_PATH .. 'estring.mp3',
		['error']		= SOUND_PATH .. 'error.mp3',
		['msn']		= SOUND_PATH .. 'msn.mp3',
		['warn']		= SOUND_PATH .. 'warn.ogg',
		['fwarn']		= SOUND_PATH .. 'fwarn.mp3',
		['whisper']	= SOUND_PATH .. 'whisper.mp3',	-- A.media.sound.whisper
		['yoshi']		= SOUND_PATH .. 'yoshi.mp3',
		['zelda']		= SOUND_PATH .. 'zelda.mp3',
	},

	local EventSounds = {
		['CHAT_MSG_GUILD'] 			= 'acquire',
		['CHAT_MSG_OFFICER'] 		= 'acquire',
		['CHAT_MSG_INSTANCE']		= 'switchy',
		['CHAT_MSG_INSTANCE_LEADER']	= 'doublehit',
		['CHAT_MSG_PARTY'] 			= 'electronic',
		['CHAT_MSG_PARTY_LEADER'] 	= 'electronic',
		['CHAT_MSG_RAID'] 			= 'whisper',
		['CHAT_MSG_RAID_LEADER'] 	= 'whisper',
		['CHAT_MSG_WHISPER'] 		= 'msn',
		['CHAT_MSG_BN_WHISPER'] 		= 'msn',
		['CHAT_MSG_REALID']			= 'zelda',
		['CHAT_MSG_CHANNEL']		=  true, 								-- dummy
	}

	--------------------------------------------------
	--	Events
	--------------------------------------------------
	local s = CreateFrame('Frame')
	s:RegisterEvent('CHAT_MSG_CHANNEL')
	s:SetScript('OnEvent', function(self, event, ...)
		local msg, author, lang, channel = ...								-- if (author == name) then return end

		if (event ~= 'CHAT_MSG_CHANNEL') then
			local sound = soundpath .. EventSounds[event] .. '.mp3'

			PlaySoundFile(sound, 'Master')								-- print('<sounds> PlaySoundFile: ' .. sound)
		end

	end)

	for event, sound in pairs(EventSounds) do
		s:RegisterEvent(event)
	end
--]]
