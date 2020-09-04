--[[
  Grammar for name.

  "Name" is alphanumeric (plus underscore) sequence of characters
  which is not reserved keyword.

  This matching implemented as function because it is a hot code and
  you can't use Lua regexps to exclude list of words.

  You can implement same idea as grammar

    { is_not(cho(<keyword>, ...)), match_regexp(<name_pattern>) }

  but this is less effective in practic sense.
]]

local match_regexp = request('!.mechs.parser.handy').match_regexp
local opt_spc = request('opt_spc')

local name_pattern = '^[_A-Za-z][_A-Za-z0-9]*'
local keywords = request('!.concepts.lua.keywords')

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
