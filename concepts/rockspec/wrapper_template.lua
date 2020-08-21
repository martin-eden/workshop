return
[[
require('$package.workshop.base')
local f = request('$package.$lua_main')
f(_G.arg)
]]
