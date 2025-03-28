-- Anonymize color to list

-- Last mod.: 2025-03-28

-- Imports:
local DenormalizeColor = request('!.concepts.Image.Color.Denormalize')

-- Exports:
return
  function(self, Color)
    local ByteColor = new(Color)

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
  2024-11-03
  2024-11-25
  2024-12-12
  2025-03-28
]]
