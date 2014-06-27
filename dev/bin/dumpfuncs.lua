local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["DumpFuncs"]) then return end

local GetMouseFocus = GetMouseFocus




--------------------------------------------------
--	print_r
--
--	A function in Lua similar to PHP's print_r
--	[src] https://gist.github.com/nrk/31175
--	[credit] http://luanet.net/lua/function/print_r
--------------------------------------------------
local print_r
do
   --[[ Usage
	----------------------------------------
	/d print_r()
	/d print_r(PriceDropDown)
	/d print_r(GetMouseFocus():GetName()
	/d print_r(AuctionFrameBrowse)
	----------------------------------------
   --]]

	local print = print
	local len = string.len
	local rep = string.rep
	local pairs = pairs
	local type = type
	local tostring = tostring


	print_r = function(T)
		T = T and T or GetMouseFocus():GetName()

		local Cache = {}

		local Printer = function(T, indent)
			if (Cache[ tostring(T) ]) then
				print(indent .. "*" .. tostring(T))
			else
				Cache[ tostring(T) ] = true
			  if (type(T) == "table") then
				 for pos, val in pairs(T) do
					if (type(val) == "table") then
						print(indent .."[" .. pos .. "] => ".. tostring(T) .. " {")
						Printer(val, indent .. rep(" ", len(pos) + 8))
						print(indent .. rep(" ", len(pos) + 6) .. "}")
					else
						print(indent .. "[" .. pos .. "] => " .. tostring(val))
					end
				 end
			  else
				 print(indent .. tostring(T))
			  end
		   end
		end
		print("\n")  Printer(T, "  ")  print("\n")
	end
end


--------------------------------------------------
--	GetDumpAsString   [src] pastebin.com/A7JScXWk
--
--	Usage:	print(GetDumpAsString(T))
--	Returns:	str instead of printing by default
--------------------------------------------------
local GetDumpAsString
do
   --[[ Usage
	----------------------------------------
	/d print(GetDumpAsString())
	/d print(GetDumpAsString(PriceDropDown))
	/d print(GetDumpAsString(GetMouseFocus():GetName())
	/d print(GetDumpAsString(ACTIVE_CHAT_EDIT_BOX))
	----------------------------------------
   --]]

	local rep = string.rep
	local pairs = pairs
	local type = type
	local tostring = tostring
	local GetMouseFocus = GetMouseFocus


	GetDumpAsString = function(T)
		T = T and T or GetMouseFocus():GetName()

		local Cache = {}
		local buffer = ""
		local padder = "	"


		local CreateDumpString = function(D, depth)

			local typ = type(D)
			local str = tostring(D)

			if (typ == "table") then
				if (Cache[str]) then
					buffer = buffer .. "<" .. str .. ">\n"
				else
					Cache[str] = (Cache[str] or 0) + 1
					buffer = buffer .. "(" .. str .. ") {\n"
					for k, v in pairs(D) do
						buffer = buffer .. rep(padder, depth + 1) .. "[" .. k .. "] => "
						CreateDumpString(v, depth + 1)
					end
					buffer = buffer .. rep(padder, depth) .. "}\n"
				end
			elseif (typ == "number") then
				buffer = buffer .. "(" .. typ .. ") " .. str .. "\n"
			else
				buffer = buffer .. "(" .. typ .. ") \"" .. str .. "\"\n"
			end
		end

		CreateDumpString(T, 0)

		return buffer
	end
end


--------------------------------------------------
--	Format String
--------------------------------------------------
local SPACE_CHAR		= "_"
local SPACE_COLOR		= "|cff8888ee"
local NUMBER_COLOR		= "|cffeeeeee"
local BOOLEAN_COLOR		= "|cffeeeeee"
local FRAME_COLOR		= "|cff88ffff"
local TABLE_COLOR		= "|cff88ff88"
local OTHERTYPE_COLOR	= "|cff88ff88"
local FUNCTION_COLOR	= "|cffff66aa"
local NIL_COLOR		= "|cffff0000"

do
	local len = string.len
	local rep = string.rep
	local gsub = string.gsub
	local type = type
	local sub = string.sub
	local tostring = tostring
	local rawget = rawget


	local function Space(str)
		local n = len(str)
		return SPACE_COLOR .. rep(SPACE_CHAR, n) .. "|r"
	end


	local function Escape(str)
		local dnext = gsub(str,	"\"", "\\\"")
		dnext = gsub(dnext, "|", "||")
		dnext = gsub(dnext, "\n", "\\n")
		dnext = gsub(dnext, "	+", Space)
		dnext = gsub(dnext, "^ ", Space)
		return "\"" .. gsub(dnext, " $", Space) .. "\""
	end


	A.FormatString = function(data, functionLookup)
		local dt = type(data)

		if (dt == "string") then
			local dl = len(data)

			if (dl > 80) then
				return Escape(sub(data, 1, 80)) .. "...", true
			else
				return Escape(data)
			end

		elseif (dt == "number") then
			return NUMBER_COLOR .. tostring(data) .. "|r"

		elseif (dt == "boolean") then
			return BOOLEAN_COLOR .. tostring(data) .. "|r"

		elseif (dt == "function") then
			local s = (functionLookup and functionLookup[data]) or tostring(data)
			return FUNCTION_COLOR .. s .. "|r"

		elseif (dt == "table") then
			local ud = rawget(data, 0)

			if (type(ud) == "userdata") then
				local got = data.GetObjectType
				local obj = got and got(data)

				if (obj) then
					local gn = data.GetName

					if (gn) then
						gn = gn(data)
					end

					if (type(gn) == "string") then
						if (_G[gn] ~= data) then
							gn = tostring(data) .. "(" .. Escape(gn) .. ")"
						else
							gn = Escape(gn)
						end
					else
						gn = tostring(data)
					end

					return FRAME_COLOR .. obj .. "|r:" .. gn, true
				end
			end

			return TABLE_COLOR .. "<" .. dt .. ":" .. tostring(data) .. ">|r", true

		elseif (dt ~= "nil") then
			return OTHERTYPE_COLOR .. "<" .. dt .. ":" .. tostring(data) .. ">|r"

		else
			return NIL_COLOR .. "nil|r"
		end
	end
end

--------------------------------------------------
--	Credit
--------------------------------------------------
--[[ _Dev
	Author: Iriel
	File: DevToolsFormat.lua
	Functions:
		Space(spcs)
		Escape(str)
		UTIL.StringSummary(data, functionLookup)
--]]
--------------------------------------------------


