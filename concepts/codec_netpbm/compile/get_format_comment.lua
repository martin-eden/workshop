-- Return comment string for given format label

--[[
  Author: Martin Eden
  Last mod.: 2026-08-08
]]

local FormatComments
do
  local Syntels = request('^.Syntels')

  FormatComments =
    {
      [Syntels.monochrome_label] = 'Monochrome image, text format',
      [Syntels.grayscale_label] = 'Grayscale image, text format',
      [Syntels.color_label] = 'Color image, text format',
    }
end

local get_format_comment =
  function(format_label)
    local comment = FormatComments[format_label]
    assert(comment, 'Format label is not found.')
    return comment
  end

-- Export:
return get_format_comment

--[[
  2026-05 #
  2026-06-15
]]
