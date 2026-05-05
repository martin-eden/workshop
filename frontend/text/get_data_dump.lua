-- Receives string with data. Returns string with text dump

--[[
  Author: Martin Eden
  Last mod.: 2026-05-05
]]

--[[
  Example

  string.char(66, 233, 22)
    ->
    Offs | Dec | Hex | Bin
    -----------------------------------
     000 | 066 |  42 | . X . . . . X .
     001 | 233 |  E9 | X X X . X . . X
     002 | 022 |  16 | . . . X . X X .
    -----------------------------------
]]

-- Imports:
local assert_byte = request('!.number.assert_byte')
local bits_from_str = request('!.convert.bits_from_str')
local Lines = request('!.concepts.Lines.Interface')

local to_dec_str =
  function(byte)
    return string.format('%03d', byte)
  end

local to_hex_str =
  function(byte)
    return string.format('%02X', byte)
  end

local to_bit_str =
  function(byte)
    local result

    result = bits_from_str(string.char(byte))
    result = string.reverse(result)
    result = string.gsub(result, '.', function(c) return c .. ' ' end)

    return result
  end

local get_dump =
  function(str)
    assert_string(str)

    local table_width = 35

    local Lines = new(Lines)

    local format_str = '%4s | %3s | %3s | %-15s'

    local header_str =
      string.format(format_str, 'Offs', 'Dec', 'Hex', 'Bin')

    Lines:AddLastLine(header_str)

    local table_separator = string.rep('-', table_width)

    Lines:AddLastLine(table_separator)

    for pos = 1, string.len(str) do
      local byte = string.byte(string.sub(str, pos, pos))

      assert_byte(byte)

      local data_str =
        string.format(
          format_str,
          to_dec_str(pos - 1),
          to_dec_str(byte),
          to_hex_str(byte),
          to_bit_str(byte)
        )

      Lines:AddLastLine(data_str)
    end

    Lines:AddLastLine(table_separator)

    local result_str = Lines:ToString()

    return result_str
  end

-- Export:
return get_dump

--[[
  2019
  2022
  2026-04-29
  2026-05-04
  2026-05-05
]]
