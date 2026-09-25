-- NetP?M image

--[[
  Author: Martin Eden
  Last mod.: 2026-09-25
]]

--[[
  Storage format

    1 [i] format
    2 [t] image instance

  Metamethods

    GetFormat
    GetImage
]]

local Interface
local create_from_image
local create
do
  local attach_methods = request('!.table.attach_methods')

  create_from_image =
    function(format, Image)
      local Me = { format, Image }
      attach_methods(Me, Interface)

      return Me
    end

  local ImageClass = request('!.concepts.Image')
  create =
    function(format, width, height)
      local num_channels
      if (format == 1) or (format == 2) then
        num_channels = 1
      elseif (format == 3) then
        num_channels = 3
      end

      local Image = ImageClass.create(width, height, num_channels)

      return create_from_image(format, Image)
    end
end

Interface =
  {
    create = create,
    create_from_image = create_from_image,
    GetFormat = function(Me) return Me[1] end,
    GetImage = function(Me) return Me[2] end,
  }

return Interface

--[[
  2026-09-25
  2026-09-26
]]
