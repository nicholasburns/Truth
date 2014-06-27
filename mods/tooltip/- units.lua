





Exists = UnitExists(unit)
--------------------------------------------------
Return:		1	 - 1 means the unit exists, nil otherwise

> [example]
> UnitExists(target) - 1 is returned only if you have a target selected
>				   Many of the other unit functions return nil if UnitExists is nil
>


Name, Realm = UnitName(unit)
--------------------------------------------------
Return:	Name		- Name of the specified unit (string)
		Realm	- When cross-realm (i.e. battlegrounds), returns the server name (string), otherwise is nil




Level = UnitLevel(unit)
--------------------------------------------------
Return:	Level	- Units level (number)
				  Also returns –1 if youre not supposed to know the level




Reaction = UnitReaction(unit, otherUnit)
--------------------------------------------------
Determines the reaction of unit to otherUnit

Return:	1-7
		 1 	 - is extremely HOSTILE (number)
		 7 	 - is as FRIENDLY as possible (number)
		nil	 - is returned if UNKNOWN







--[[
health = UnitHealth("unit") or UnitHealth("name")
	Return:	Health	- Current amount of health (hit points) for the unit (number)

Power = UnitPower("unitID" [, powerType])
	Return:	Power	- Current level of mana, rage, energy, runic power, or other power type for the unit (number)



HealthMax = UnitHealthMax(unit)				HealthMax - Maximum Health of the unit (number)

ManaMax = UnitManaMax(unit)
--]]



