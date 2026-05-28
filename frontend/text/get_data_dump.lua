-- Receives string with data. Returns string with text dump

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
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
local bytes_from_str = request('!.convert.bytes_from_str')
local byte_to_bits = request('!.convert.byte_to_bits')
local trim_tail = request('!.string.trim_tail')
local add_to_list = request('!.concepts.list.add_item')
local lines_to_str = request('!.convert.lines_to_str')

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

    result = byte_to_bits(byte)
    result = string.reverse(result)
    result = string.gsub(result, '.', function(c) return c .. ' ' end)

    return result
  end

local get_dump =
  function(str)
    local Bytes = bytes_from_str(str)

    local table_width = 35

    local Lines = { }

    local add_line =
      function(line_str)
        add_to_list(Lines, trim_tail(line_str))
      end

    local format_str = '%4s | %3s | %3s | %-15s'

    local header_str =
      string.format(format_str, 'Offs', 'Dec', 'Hex', 'Bin')

    add_line(header_str)

    local table_separator = string.rep('-', table_width)

    add_line(table_separator)

    for pos, byte in ipairs(Bytes) do
      local data_str =
        string.format(
          format_str,
          to_dec_str(pos - 1),
          to_dec_str(byte),
          to_hex_str(byte),
          to_bit_str(byte)
        )

      add_line(data_str)
    end

    add_line(table_separator)

    return lines_to_str(Lines)
  end

-- Export:
return get_dump

--[[
  2019
  2022
  2026-04-29
  2026-05-04
  2026-05-05
  2026-05-07
  2026-05-28
]]
