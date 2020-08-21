--[[
  Grammar for name.

  "Name" is alphanumeric sequence of characters. With exclusion of
  reserved keywords.

  Checking implemented as function because it is a hot code and
  you can't exclude list of words via Lua patterns.

  You can implement this in existing elements as

    { is_not(cho(<keyword>, ...)), match_regexp(<pattern>) }

  but this is less effective algorithmically.
]]

local match_regexp = request('!.mechs.parser.handy').match_regexp
local opt_spc = request('opt_spc')

local name_pattern = '^[_A-Za-z][_A-Za-z0-9]*'
local keywords = request('!.formats.lua.keywords')

local is_name =
  function(in_stream, out_stream)
    local init_pos = in_stream:get_position()
    if in_stream:match_regexp(name_pattern) then
      local capture =
        in_stream:get_segment(
          init_pos,
          in_stream:get_position() - init_pos
        )
      if not keywords[capture] then
        return true
      else
        in_stream:set_position(init_pos)
        return false
      end
    end
  end

return
  {
    name = 'name',
    opt_spc, is_name,
  }
