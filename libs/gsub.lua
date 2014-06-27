



string.gsub(s, pattern, repl, [n])



	---------------------------------------------
	-- Examples
	---------------------------------------------
	print(gsub("hello world", "(%w+)", "%1 %1"))
	> hello hello world world, 2

	print(gsub("hello world", "%w+", "%0 %0", 1))
	> hello hello world, 1

	print(gsub("hello Lua", "(%w+)%s*(%w+)", "%2 %1"))
	> Lua hello, 1

	---------------------------------------------
	lookupTable = {
		["hello"] = "hola",
		["world"] = "mundo",
	}

	function lookupFunc(pattern)
		return lookupTable[pattern]
	end


	print(gsub("hello world", "(%w+)", lookupTable))
	> hola mundo, 2

	print(gsub("hello world", "(%w+)", lookupFunc))
	> hola mundo, 2

	---------------------------------------------





















