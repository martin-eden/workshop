-- Save Netpbm data

--[[
  Author: Martin Eden
  Last mod.: 2026-06-01
]]

-- Imports:
local convert_image_to_nif = request('Convert_ImageToNif.convert')
local compile_nif_to_raw = request('Compiler_NifToRaw.compile')

local compile =
  function(Image, Output)
    local ImageSettings, ImageNif = convert_image_to_nif(Image)

    ImageSettings.is_text_storage = true

    compile_nif_to_raw(Output, ImageSettings, ImageNif)
  end

-- Export:
return compile

--[[
  2024
  2025
  2026-01-20
  2026-05-31
]]
