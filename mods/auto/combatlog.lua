local A, C, G, L = select(2, ...):Unpack()

if (not C["Auto"]["Enable"] or not C["Auto"]["Combatlog"]["Enable"]) then
	return
end

local print = function(...)
	A.print("Combatlog", ...)
end





