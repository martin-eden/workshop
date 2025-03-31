-- Anonymize color to list

-- Last mod.: 2025-03-29

-- Imports:
local SpawnColor = request('!.concepts.Image.Color.SpawnColor')
local DenormalizeColor = request('!.concepts.Image.Color.Denormalize')
local PatchTable = request('!.table.patch')

-- Exports:
return
  function(self, Color)
    local ByteColor = SpawnColor(self.Settings.ColorFormat)
    PatchTable(ByteColor, Color)

    DenormalizeColor(ByteColor)

    local Result = {}

    for _, Component in ipairs(ByteColor) do
      local SerializedComponent = self:CompileColorComponent(Component)

      if not SerializedComponent then
        return
      end

      table.insert(Result, SerializedComponent)
    end

    return Result
  end

--[[
  2024-11 # #
  2024-12-12
  2025-03-28
]]
