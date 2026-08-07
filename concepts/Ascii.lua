-- ASCII characters table

--[[
  Author: Martin Eden
  Last mod.: 2026-08-07
]]

local Codes = request('Ascii.Codes')
local Chars = request('Ascii.Chars')
local is_control_code = request('Ascii.is_control_code')

local Ascii =
  {
    Chars = Chars,
    Codes = Codes,
    is_control_code = is_control_code,
  }

-- Export:
return Ascii

--[[
  2026-08-01
]]
