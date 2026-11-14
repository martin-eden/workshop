-- 2-d matrix image

--[[
  Author: Martin Eden
  Last mod.: 2026-11-14
]]

--[[
  Storage format

    1 [t] index instance
    2 [t] image data, list of color channel values
]]

--[[
  "Image" is 3-d array with dimensions: width, height, num_channels.
  "Color" is 1-d array with dimension: num_channels.
]]

local get_color =
  function(me, x, y)
    local color = { }
    for channel = 1, me[1]:get_dim(3) do
      local index = me[1]:get_index({ x, y, channel })
      color[channel] = me[2][index]
    end
    return color
  end

local set_color =
  function(me, color, x, y)
    for channel = 1, me[1]:get_dim(3) do
      local index = me[1]:get_index({ x, y, channel })
      me[2][index] = color[channel]
    end
  end

local get_width =
  function(me)
    return me[1]:get_dim(1)
  end

local get_height =
  function(me)
    return me[1]:get_dim(2)
  end

local get_num_channels =
  function(me)
    return me[1]:get_dim(3)
  end

local interface
local create
do
  local index_class = request('index')
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
    get_color = get_color,
    set_color = set_color,
    get_width = get_width,
    get_height = get_height,
    get_num_channels = get_num_channels,
  }

-- Export:
return interface

--[[
  2026 #
  2026-11-14
]]
