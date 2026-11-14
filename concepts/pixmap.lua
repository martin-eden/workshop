-- Pixmap image

--[[
  Author: Martin Eden
  Last mod.: 2026-11-14
]]

--[[
  Data format

    1 [t] -- indexer instance
    2 [t] -- image data, list of color channel values
]]

local index_class = request('index')

local set_pixel =
  function(me, x, y, color)
    for channel = 1, me[1][3] do
      local index = me[1]:get_index({ x, y, channel })
      me[2][index] = color[channel]
    end
  end

local get_pixel
do
  local add_to_list = request('!.concepts.list.add_item')
  get_pixel =
    function(me, x, y)
      local result = { }
      for channel = 1, me[1][3] do
        local index = me[1]:get_index({ x, y, channel })
        add_to_list(result, me[2][index])
      end
      return result
    end
end

local interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function(width, height, num_channels)
      local image = { }
      for index = 1, width * height * num_channels do
        image[index] = 0
      end
      local me =
        {
          [1] = index_class.create({ width, height, num_channels }),
          [2] = image,
        }
      attach_methods(me, interface)
      return me
    end
end

interface =
  {
    create = create,
    set_pixel = set_pixel,
    get_pixel = get_pixel,
  }

-- Export:
return interface

--[[
  2026 #
  2026-11-14
]]
