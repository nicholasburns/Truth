local A, C, G, L = select(2, ...):Unpack()

if (not C["Dev"]["Interceptor"]) then return end
local print = function(...) Addon.print('Dev.Interceptor', ...) end
-- local select, type, unpack = select, type, unpack
-- local ipairs, pairs = ipairs, pairs


-- Module
local module = {}
local moduleName = "interceptor"
Addon[moduleName] = module					-- Truth[moduleName] = module





























