local A, C, G, L = select(2, ...):Unpack()

if (not C["Announce"]["Enable"] or not C["Announce"]["LowHealth"]["Enable"]) then
	return
end

local M = C["Announce"]["LowHealth"]


local F = CreateFrame("ScrollingMessageFrame", "TruthLowHPFrame", UIParent)
F.threshold = M["Threshold"]
F.warned = false


local Update, OnEvent
local heathpercent

do
	local unpack = unpack
	local floor = math.floor
	local PlaySoundFile = PlaySoundFile
	local UnitHealth = UnitHealth
	local UnitHealthMax = UnitHealthMax


	Update = function()
		heathpercent = floor((UnitHealth("player") / UnitHealthMax("player")) * 100)

		if ((heathpercent <= F.threshold) and (F.warned == false)) then
			PlaySoundFile(M["Sound"], "Master")
			F:AddMessage(M["Message"], 1, 0, 0, nil, 3)

			F.warned = true

			return
		end

		if (floor((UnitHealth("player") / UnitHealthMax("player")) * 100) > F.threshold) then
			F.warned = false

			return
		end
	end


	OnEvent = function(event, a1, ...)
		if (event == 'PLAYER_LOGIN') then
			F:SetSize(450, 200)
			F:SetPoint("CENTER") -- UIParent, 0, 0)
			F:SetFrameStrata("BACKGROUND")
			F:SetFrameLevel(0)
			F:SetFont(unpack(M["Font"]))
			F:SetShadowOffset(M["Font"] or 1, -M["Font"] or -1)
			F:SetShadowColor(unpack(M["Font"][5]))
			F:SetJustifyH('CENTER')
			F:SetMaxLines(2)
			F:SetTimeVisible(1)
			F:SetFadeDuration(1)

			Update()

			F:UnregisterEvent('PLAYER_LOGIN')
		end
		if (event == 'UNIT_HEALTH' and a1 == 'player') then
			A:Update()
			return
		end
	end


	F:RegisterEvent("PLAYER_LOGIN")
	F:RegisterEvent("UNIT_HEALTH")
	F:SetScript('OnEvent', OnEvent)
end


--------------------------------------------------
--	Backup
--------------------------------------------------
--[[ Constants
	local LOWHEALTH_FONT			= C.lowhealth_font or [=[Interface\AddOns\Truth\media\font\grunge.ttf]=]
	local LOWHEALTH_FONTSIZE			= C.lowhealth_fontsize or 30
	local LOWHEALTH_FONTFLAG			= C.lowhealth_fontflag or 'THICKOUTLINE'
	local LOWHEALTH_MESSAGE			= C.lowhealth_message or '- LOW HEALTH -'
	local LOWHEALTH_THRESHOLD 		= C.lowhealth_threshold or 50
	local LOWHEALTH_SOUND			= C.lowhealth_sound or [=[Interface\AddOns\Truth\media\sound\warn.ogg]=]
--]]
--[[ A Revert

	local AddOn, A = ...
	local F = CreateFrame('ScrollingMessageFrame', 'TruthLowHeathFrame', UIParent)
	F.Threshold = LOWHEALTH_THRESHOLD
	F.Warned = false

	function A:Initialize()
		F:SetWidth(450)
		F:SetHeight(200)
		F:SetPoint('CENTER', UIParent, 0, 0)

		F:SetFont(LOWHEALTH_FONT, LOWHEALTH_FONTSIZE, LOWHEALTH_FONTFLAG)
		F:SetShadowColor(0, 0, 0, .75)
		F:SetShadowOffset(3, -3)
		F:SetJustifyH('CENTER')
		F:SetMaxLines(2)
		F:SetTimeVisible(1)
		F:SetFadeDuration(1)

		A:Update()
	end

	function A:Update()
		if (floor((UnitHealth('player') / UnitHealthMax('player')) * 100) <= F.Threshold and F.Warned == false) then

			PlaySoundFile(LOWHEALTH_SOUND, 'Master')

			F:AddMessage(LOWHEALTH_MESSAGE, 1, 0, 0, nil, 3)
			F.Warned = true

			return
		end

		if (floor((UnitHealth('player') / UnitHealthMax('player')) * 100) > F.Threshold) then
			F.Warned = false

			return
		end
	end

	function A:OnEvent(event, a1, ...)
		if (event == 'PLAYER_LOGIN') then
			A:Initialize()
			return
		end

		if (event == 'UNIT_HEALTH' and a1 == 'player') then
			A:Update()
			return
		end
	end
	F:SetScript('OnEvent', A.OnEvent)
	F:RegisterEvent('PLAYER_LOGIN')
	F:RegisterEvent('UNIT_HEALTH')
--]]
