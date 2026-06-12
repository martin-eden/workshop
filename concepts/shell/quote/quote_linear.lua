-- Quote shell string using linear quotes (\')

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

-- Imports:
local InputStrStream = request('!.concepts.StreamIo.Input.String')
local OutputStrStream = request('!.concepts.StreamIo.Output.String')

local SpecialChars_Map
local SpaceChars_Map

do
  -- Imports:
  local map_table_values = request('!.table.map_values')
  local SpecialChars = request('SpecialChars')
  local SpaceChars = request('SpaceChars')

  SpecialChars_Map = map_table_values(SpecialChars)
  SpaceChars_Map = map_table_values(SpaceChars)
end

local quote =
  function(Input, Output)
    local comment = '#'
    local backslash = [[\]]
    local empty_str_quoted = [['']]

    local state = 'init'
    local needs_quoting

    while true do
      local c = Input:Read(1)

      if (c == '') then break end

      state = 'leading_space'

      needs_quoting = false

      if SpecialChars_Map[c] then
        needs_quoting = true
      end

      if (state == 'leading_space') then
        if (c == comment) then
          needs_quoting = true
        end

        if not SpaceChars_Map[c] then
          state = 'body'
        end
      end

      if needs_quoting then
        Output:Write(backslash)
      end
      Output:Write(c)
    end

    if (state == 'init') then
      Output:Write(empty_str_quoted)
    end
  end

local quote_root =
  function(str)
    local Input = new(InputStrStream)
    Input:Init(str)

    local Output = new(OutputStrStream)

    quote(Input, Output)

    return Output:GetString()
  end

-- Export:
return quote_root

--[[
  2026-06-12
]]
