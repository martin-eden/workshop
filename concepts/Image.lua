-- Image

--[[
  Author: Martin Eden
  Last mod.: 2026-09-26
]]

--[[
  "Image" is 3-d array of numbers: width.height.num_channels

  "Color" is 1-d array of <num_channels>.

  We're providing accessors for Color and getters for dimensions.
]]

--[[
  Storage format

    1 [t] index instance
    2 [t] data

  Metamethods

    GetColor
    SetColor
    GetWidth
    GetHeight
    GetNumChannels
]]

local get_color =
  function(Me, x, y)
    local Index = Me[1]
    local Data = Me[2]

    local num_channels = Index:GetDim(3)

    local Color = { }
    for channel = 1, num_channels do
      local i = Index:GetIndex({ x, y, channel })
      Color[channel] = Data[i]
    end

    return Color
  end

local set_color =
  function(Me, Color, x, y)
    local Index = Me[1]
    local Data = Me[2]

    local num_channels = Index:GetDim(3)

    for channel = 1, num_channels do
      local i = Index:GetIndex({ x, y, channel })
      Data[i] = Color[channel]
    end
  end

local Interface
local create
do
  local IndexClass = request('!.concepts.Index')
  local attach_methods = request('!.table.attach_methods')
  create =
    function(width, height, num_channels)
      local Index = IndexClass.create({ width, height, num_channels })

      local Data = { }
      for x = 1, width do
        for y = 1, height do
          for channel = 1, num_channels do
            local i = Index:GetIndex({ x, y, channel })
            Data[i] = 0
          end
        end
      end

      local Me = { Index, Data }
      attach_methods(Me, Interface)

      return Me
    end
end

Interface =
  {
    create = create,
    GetColor = get_color,
    SetColor = set_color,
    GetWidth = function(Me) return Me[1]:GetDim(1) end,
    GetHeight = function(Me) return Me[1]:GetDim(2) end,
    GetNumChannels = function(Me) return Me[1]:GetDim(3) end,
  }

return Interface

--[[
  2026-09-25
]]
