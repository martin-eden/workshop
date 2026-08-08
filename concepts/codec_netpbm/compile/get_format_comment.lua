-- Return comment string for given format label

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

local get_format_comment
do
  local FormatComments
  do
    local monochrome_label
    local grayscale_label
    local color_label
    do
      local Syntels = request('^.Syntels')
      monochrome_label = Syntels.monochrome_label
      grayscale_label = Syntels.grayscale_label
      color_label = Syntels.color_label
    end

    FormatComments =
      {
        [monochrome_label] = 'Monochrome image, text format',
        [grayscale_label] = 'Grayscale image, text format',
        [color_label] = 'Color image, text format',
      }
  end

  get_format_comment =
    function(format_label)
      local comment = FormatComments[format_label]
      assert(comment, 'Format label is not found.')
      return comment
    end
end

-- Export:
return get_format_comment

--[[
  2026-05 #
  2026-06-15
]]
