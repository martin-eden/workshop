-- Save image to stream

-- Last mod.: 2024-12-12

-- Imports:
local Compiler_LuaToIs = request('Compiler_LuaToIs.Interface')
local Compiler_IsToPpm = request('Compiler_IsToPpm.Interface')

-- Exports:
return
  function(self, Image)
    local ImageIs = Compiler_LuaToIs:Run(Image)

    if not ImageIs then
      return false
    end

    Compiler_IsToPpm.Output = self.Output

    local IsOkay = Compiler_IsToPpm:Run(ImageIs)

    if not IsOkay then
      return false
    end

    return true
  end

--[[
  2024-11-04
]]
