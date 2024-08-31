-- Indented line interface

return
  {
    -- Contract:

    -- Set indent, empty text
    init = request('init'),

    -- Text is empty?
    is_empty = request('is_empty'),

    -- Get length of text
    get_text_length = request('get_text_length'),

    -- Get length of indented text
    get_line_length = request('get_line_length'),

    -- Get indented text
    get_line = request('get_line'),

    -- Add string to text
    add = request('add'),

    -- Intestines:

    -- Indent string
    indent = '',
    -- Text string
    text = '',
  }

--[[
  2017-09
  2024-09
]]
