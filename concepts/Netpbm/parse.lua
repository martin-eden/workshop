-- Load Netpbm data

--[[
  Author: Martin Eden
  Last mod.: 2026-05-31
]]

-- Imports:
local parse_raw_to_nif = request('Parser_RawToNif.parse')
local convert_nif_to_image = request('Convert_NifToImage.convert')

local parse =
  function(Input)
    return convert_nif_to_image(parse_raw_to_nif(Input))
  end

-- Export:
return parse

--[[
  2024
  2026-05-31
]]
