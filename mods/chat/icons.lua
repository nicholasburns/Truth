local A, C, G, L = select(2, ...):Unpack()

if (not C["Chat"]["Enable"] or not C["Chat"]["Icons"]["Enable"]) then
	return
end




----------------------------------------------------------------------------------------------------
--	Display Icon:  Group Leaders Only
----------------------------------------------------------------------------------------------------
CHAT_RAID_LEADER_GET  = "|Hchannel:Raid|h[R|TInterface\GroupFrame\UI-Group-LeaderIcon:0|t]|h %s: "

CHAT_RAID_WARNING_GET = "|Hchannel:RaidWarning|h[RW|TInterface\GroupFrame\UI-GROUP-MAINASSISTICON:0|t]|h %s: "

CHAT_PARTY_LEADER_GET = "|Hchannel:Party|h[P|TInterface\GroupFrame\UI-Group-LeaderIcon:0|t]|h %s: "

CHAT_PARTY_GUIDE_GET  =  CHAT_PARTY_LEADER_GET

CHAT_INSTANCE_CHAT_LEADER_GET	= "|Hchannel:INSTANCE_CHAT|h[BG|TInterface\GroupFrame\UI-Group-LeaderIcon:0|t]|h %s: "


----------------------------------------------------------------------------------------------------
--	Credits
----------------------------------------------------------------------------------------------------
--	XanChat by Xruptor
--	http://www.GitHub.com/Xruptor/XanChat/blob/master/XanChat.lua
----------------------------------------------------------------------------------------------------

