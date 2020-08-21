--[[
  Get AST for string with Lua code.

  str -> table

  Handles possible "#!" at start of shell files.
]]

local parse = request('!.mechs.generic_loader')
local syntax = request('!.concepts.lua.syntax')
local parse_sh = request('!.concepts.sh.load')

return
  function(s)
    assert_string(s)

    local sh = parse_sh(s)
    local shebang_str
    if sh.tool then
      shebang_str = '#! ' .. sh.tool
    end

    local result, unparsed_tail = parse(sh.data, syntax)

    result = result or {}
    result.shebang_str = shebang_str
    result.unparsed_tail = unparsed_tail

    return result
  end
