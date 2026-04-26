-- Parses CSV line

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

-- Imports:
local parse_record = request('parse_record')
local fix_bad_line = request('^.^.fix_bad_line')
local trim_tail_nls = request('!.string.trim_tail_nls')

local parse_line =
  function(parent, s)
    assert_string(s)
    s = trim_tail_nls(s)
    local record, last_pos, has_problems = parse_record(parent, s)
    local is_unclosed_quote = has_problems and (last_pos > #s)
    if
      has_problems and
      not is_unclosed_quote and
      parent.fix_bad_data
    then
      local fix_succeded, fixed_s = fix_bad_line(s)
      if fix_succeded then
        record, last_pos, has_problems = parse_record(fixed_s)
      end
    end
    return record, has_problems, is_unclosed_quote
  end

-- Export:
return parse_line

--[[
  2017-09
]]
