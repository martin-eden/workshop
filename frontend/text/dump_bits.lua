-- Receives table with list of bytes. Returns string with text dump

--[[
  Author: Martin Eden
  Last mod.: 2026-04-29
]]

--[=[
  Example

  { 66, 9, 22 } ->
     Pos | Dec | BCD | Hex | Bin
    -----------------------------------------
      01 | 066 |  42 |  42 | . X . . . . X .
      02 | 009 |  09 |  09 | . . . . X . . X
      03 | 022 |  16 |  16 | . . . X . X X .
    -----------------------------------------
]=]

-- Imports:
local assert_byte = request('!.number.assert_byte')
local from_bcd = request('!.number.from_bcd')
local glue_words = request('!.concepts.words.to_string')
local Lines = new(request('!.concepts.Lines.Interface'))

local to_hex_str =
  function(byte)
    return string.format('%02X', byte)
  end

local to_bcd_str =
  function(byte_bcd)
    local result_str

    local is_ok, byte = pcall(from_bcd, byte_bcd)

    if is_ok then
      result_str = string.format('%02d', byte)
    else
      result_str = '??'
    end

    return result_str
  end

local to_bit_str =
  function(byte)
    local BitChar_Map = { [0] = '.', [1] = 'X' }
    local num_bits = 8
    local Bits = {}

    for i = 1, num_bits do
      Bits[num_bits - i + 1] = BitChar_Map[(byte >> (i - 1)) & 1]
    end

    local result_str = glue_words(Bits)
    -- result_str = result_str:reverse()

    return result_str
  end

local to_dec_str =
  function(byte)
    return string.format('%03d', byte)
  end

local get_dump =
  function(Data)
    assert_table(Data)

    local format_str = '%4s | %3s | %3s | %3s | %-15s'

    local header_str =
      string.format(format_str, 'Pos', 'Dec', 'BCD', 'Hex', 'Bin')

    Lines:AddLastLine(header_str)

    local last_line_len = #Lines:GetLastLine()
    local delimiter_str = string.rep('-', last_line_len + 1)

    Lines:AddLastLine(delimiter_str)

    for pos = 1, #Data do
      local byte = Data[pos]

      assert_byte(byte)

      local data_str =
        string.format(
          format_str,
          string.format('%02d', pos),
          to_dec_str(byte),
          to_bcd_str(byte),
          to_hex_str(byte),
          to_bit_str(byte)
        )

      Lines:AddLastLine(data_str)
    end

    Lines:AddLastLine(delimiter_str)

    Lines:AddLastLine('')

    local result_str = Lines:ToString()

    return result_str
  end

-- Export:
return get_dump

--[[
  2019
  2022
  2026-04-29
]]
