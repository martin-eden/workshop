-- Virtual text printer interface

--[[
  Author: Martin Eden
  Last mod.: 2026-10-21
]]

--[[
  Architecture defect

  [line] indent is set at initialization time, not when we need text.

  So in bad scenario we're setting indent (low), then increasing it
  (it increases indent in this module, not in line instance),
  then adding text to line and getting line text back.

  Line text will be with initial (low) indent.

  I think we should just remove indent concept from line, track it here.
  And prepend final result with our current indent.

  Discovered in process of relinking Lua code formatter to
  this module.
]]

local Interface =
  {
    -- text:
    line_with_text = request('line.interface'),
    processed_text = {},
    num_line_feeds = 0,

    store_textline = request('text.store_textline'),
    add_textline = request('text.add_textline'),
    add_curline = request('text.add_curline'),

    new_line = request('text.new_line'),
    request_clean_line = request('text.request_clean_line'),
    request_empty_line = request('text.request_empty_line'),

    on_clean_line = request('text.on_clean_line'),

    include = request('text.include'),

    get_text = request('text.get_text'),

    -- indents:
    indent_chunk = '  ',
    next_line_indent = 0,
    inc_indent = request('inc_indent'),
    dec_indent = request('dec_indent'),

    -- text length:
    max_text_width = 0,
    max_block_width = 0,
    get_text_width = request('text.get_text_width'),
    get_block_width = request('text.get_block_width'),

    init = request('init'),

    -- Intestines
    Indent = { },
  }

-- Export:
return Interface

--[[
  2017 # # #
  2024 #
  2026-05-12
  2026-07-05
]]
