-- Load image from stream

-- Last mod.: 2025-03-29

-- Imports:
local Parser_PpmToIs = request('Parser_NifToIs.Interface')
local Parser_IsToLua = request('Parser_IsToLua.Interface')

-- Exports:
return
  function(self)
    Parser_PpmToIs.Input = self.Input

    local ImageIs = Parser_PpmToIs:Run()

    if not ImageIs then
      return
    end

    local Image = Parser_IsToLua:Run(ImageIs)

    if not Image then
      return
    end

    return Image
  end

--[[
  2024-11-04
]]
