-- CSV codec

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

local init = request('specific.init')
local parse = request('specific.parse')
local get_next_rec = request('specific.get_next_rec')

local csv_parser_class =
  {
    init = init,
    parse = parse,
    get_next_rec = get_next_rec,
    field_sep_char = ',',
    lines_iterator = nil,
  }

return
  function(csv_str, options)
    local csv_parser = new(csv_parser_class, options)
    csv_parser:init(csv_str)
    return csv_parser:parse()
  end

--[[
  2017
]]
