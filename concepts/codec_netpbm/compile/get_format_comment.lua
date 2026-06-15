-- Return comment string for given format label

--[[
  Author: Martin Eden
  Last mod.: 2026-06-15
]]

local FormatComments =
  {
    ['P1'] = 'Monochrome image, text format',
    ['P2'] = 'Grayscale image, text format',
    ['P3'] = 'Color image, text format',
  }

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
