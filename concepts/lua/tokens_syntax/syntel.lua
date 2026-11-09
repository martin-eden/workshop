-- Syntax element grammar

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  Syntax elements are that punctuation chars (and tuples) and keywords
]]

local name_pattern = '^[_A-Za-z][_A-Za-z0-9]*'

local keywords_map
do
  local keywords = request('!.concepts.lua.keywords')
  local map_values = request('!.table.map_values')
  keywords_map = map_values(keywords)
end

local is_keyword =
  function(input)
    local init_pos = input:get_position()

    if input:match_regexp(name_pattern) then
      local capture =
        input:get_segment(
          init_pos,
          input:get_position() - init_pos
        )

      if keywords_map[capture] then
        return true
      else
        input:set_position(init_pos)
        return false
      end
    end
  end

local match_regexp = request('!.mechs.parser.handy').match_regexp
local cho = request('!.mechs.processor.handy').cho

return
  {
    cho(
      is_keyword,
      '==',
      '~=',
      '<=',
      '<<',
      '>=',
      '>>',
      '...',
      '..',
      '//',
      '::',
      match_regexp('[%=%~%<%>%.%:%,%;%/%(%)%[%]%{%}%-%+%#%*%%%^%&%|]')
    )
  }

--[[
  2026-10-26
  2026-10-28
]]
