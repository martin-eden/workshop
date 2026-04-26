-- Parses TSV line

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

-- Imports:
local trim_tail_nls = request('!.string.trim_tail_nls')

local get_next_rec =
  function(self)
    local result
    local line = self.lines_iterator:get_next_line()
    if line then
      line = trim_tail_nls(line)
      local pattern = '(.-)' .. '%' .. self.field_sep_char
      line = line .. self.field_sep_char
      result = {}
      for term in line:gmatch(pattern) do
        result[#result + 1] = term
      end
    end
    return result
  end

-- Export:
return get_next_rec

--[[
  2017-09
]]
