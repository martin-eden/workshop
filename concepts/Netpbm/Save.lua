-- Save image to stream

-- Last mod.: 2025-03-29

-- Imports:
local Compiler_LuaToIs = request('Compiler_LuaToIs.Interface')
local Compiler_IsToNif = request('Compiler_IsToNif.Interface')

-- Exports:
return
  function(self, Image)
    local ImageIs

    do
      Compiler_LuaToIs.Settings = self.Settings

      ImageIs = Compiler_LuaToIs:Run(Image)

      if not ImageIs then
        return false
      end
    end

    do
      Compiler_IsToNif.Settings = self.Settings
      Compiler_IsToNif.Output = self.Output

      local IsOkay = Compiler_IsToNif:Run(ImageIs)

      if not IsOkay then
        return false
      end
    end

    return true
  end

--[[
  2024-11-04
  2025-03-29
]]
