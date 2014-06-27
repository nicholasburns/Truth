local A, C, G, L = select(2, ...):Unpack()



----------------------------------------------------------------------------------------------------
--	Graphics
----------------------------------------------------------------------------------------------------
do
	local max = math.max
	local match = string.match
	local tonumber = tonumber

--	Resolution		= "2560x1440"
--	ScreenWidth 		=  2560
--	ScreenHeight 		=  1440
--	UIScale 			=  0.64

	G.SCREEN_SIZE		= GetCVar("gxResolution")
	G.SCREEN_WIDTH		= tonumber(match(G.SCREEN_SIZE, "(%d+)x+%d"))
	G.SCREEN_HEIGHT	= tonumber(match(G.SCREEN_SIZE, "%d+x(%d+)"))
	G.UISCALE			= max(0.64, 768 / G.SCREEN_HEIGHT)
end

----------------------------------------------------------------------------------------------------
--	Pixel Perfect
----------------------------------------------------------------------------------------------------
do
	local X = 768 / G.SCREEN_HEIGHT / G.UISCALE

	A["PixelSize"] = X

	A["PixelSizes"] = {
		[1]  = 1*X,						-- 0.83
		[2]  = 2*X,						-- 1.66
		[3]  = 3*X,						-- 2.50
		[4]  = 4*X,						-- 3.33
		[5]  = 5*X,						-- 4.16
		[6]  = 6*X,						-- 5.00
		[7]  = 7*X,						-- 5.83
		[8]  = 8*X,						-- 6.66	(tiny)
		[9]  = 9*X,						-- 7.5
		[10] = 10*X,						-- 8.33	(small)
		[11] = 11*X,						-- 9.16
		[12] = 12*X,						-- 10	(medium) / (normal)
		[13] = 13*X,						-- 10.83
		[14] = 14*X,						-- 11.66
		[15] = 15*X,						-- 12.45
		[16] = 16*X,						-- 13.33	(large)
		[18] = 18*X,						-- 15
		[20] = 20*X,						-- 16.66	(huge) / (huge1)
		[22] = 22*X,						-- 18.33
		[24] = 24*X,						-- 20	(superhuge)
		[30] = 30*X,						-- 25
		[32] = 32*X,						-- 26.66	(gigantic)
		[48] = 48*X,						-- 40
		----------------------
		["Pixel"]		= 1*X,
		["Pad"]		= 2*X,
		----------------------
		["Tiny"]		= 10*X,				-- 8.33

		["Small"]		= 12*X,				-- 10
		["Normal"]	= 14*X,				-- 11.66
		["Large"]		= 16*X,				-- 13.33

		["Huge"] 		= 20*X,				-- 16.66
		["Superhuge"]	= 24*X,				-- 20	(superhuge)
		["Gigantic"]	= 32*X,				-- 26.66	(gigantic)

		["Biggest"]	= 48*X,				-- 40
	}

end

--------------------------------------------------
--	Debug Commands
--------------------------------------------------
--[[	ChatFontNormal

/d ChatFontNormal:GetFont()

--]]



