-- [Insecure] Execute string with Lua code that expected to return table

--[[
  Author: Martin Eden
  Last mod.: 2026-08-11
]]

--[[
  Input string can contain Lua expression or Lua statements

    * String with Lua statements is produced by [compile_graph].
      F.e. "return { }".

    * String with Lua expression is produced by [compile_tree].
      F.e. "{ }"

  Instead of asking caller to specify which kind he is giving us,
  we're trying first to load string as chunk and if it fails,
  retrying to load it as expression.

  This moves cost of distinguishing them from caller to us.
]]

local parse =
  function(str)
    local f = load(str)

    if not f then
      f = load('return ' .. str)
    end

    if not f then return end

    return (f())
  end

-- Export:
return parse

--[[
  2016
  2026-06-17
  2026-08-11
]]
