--[[
  Get AST for string with Lua code.

  str -> table

  Handles possible "#!" at start of shell files.
]]

local parse = request('!.mechs.generic_loader')
local syntax = request('!.formats.lua.syntax')
local parse_sh = request('!.formats.sh.load')

return
  function(s)
    assert_string(s)
    local sh = parse_sh(s)
    return parse(sh.data, syntax)
  end
