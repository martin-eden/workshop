-- Pixmap image

--[[
  Author: Martin Eden
  Last mod.: 2026-09-19
]]

--[[
  Data format

    1 [t] -- indexer instance
    2 [t] -- image data, list of color channel values
]]

local IndexClass = request('Index')

local Interface

local create
do
  local attach_methods = request('!.table.attach_methods')

  create =
    function(width, height, num_channels)
      local Index = IndexClass.create({ width, height, num_channels })

      local Core =
        {
          [1] = Index,
          [2] = { },
        }

      local num_slots = width * height * num_channels

      for data_i = 1, num_slots do
        Core[2][data_i] = 0
      end

      attach_methods(Core, Interface)

      return Core
    end
end

local get_pixel
local set_pixel
do
  set_pixel =
    function(Core, x, y, Color)
      local Indexer = Core[1]
      local Image = Core[2]
      local num_channels = Indexer[3]

      for channel_i = 1, num_channels do
        local image_i = Indexer:GetIndex({ x, y, channel_i })
        Image[image_i] = Color[channel_i]
      end
    end

  local add_to_list = request('!.concepts.list.add_item')

  get_pixel =
    function(Core, x, y)
      local Indexer = Core[1]
      local Image = Core[2]
      local num_channels = Indexer[3]
      local Result = { }

      for channel_i = 1, num_channels do
        local index = Indexer:GetIndex({ x, y, channel_i })
        add_to_list(Result, Image[index])
      end

      return Result
    end
end

Interface =
  {
    create = create,
    SetPixel = set_pixel,
    GetPixel = get_pixel,
  }

-- Export:
return Interface

--[[
  2026-09-19
]]
