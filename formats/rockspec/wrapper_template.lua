return
[[
require('$package.workshop.base')
local run = request('$package.$lua_main')
run(arg[1], arg[2])
]]
