-- Name grammar

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  "Name" is alphanumeric (plus underscore) sequence of characters
  which is not reserved keyword.

  This matching implemented as function because it is a hot code and
  you can't use Lua regexps to exclude list of words.

  You can implement same idea as grammar

    { is_not(cho(<keyword>, ...)), match_regexp(<name_pattern>) }

  but this is less effective in practical sense.
]]

local name_pattern = '^[_A-Za-z][_A-Za-z0-9]*'

local keywords_map
do
  local keywords = request('!.concepts.lua.keywords')
  local map_values = request('!.table.map_values')
  keywords_map = map_values(keywords)
end

return
  function(input)
    local init_pos = input:get_position()

    if input:match_regexp(name_pattern) then
      local capture =
        input:get_segment(
          init_pos,
          input:get_position() - init_pos
        )

      if not keywords_map[capture] then
        return true
      else
        input:set_position(init_pos)
        return false
      end
    end
  end

--[[
  2017 #
  2018 #
  2026 #
  2026-10-26
]]
