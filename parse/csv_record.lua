-- Comma-separated string parser driver

local _parse_record = request('csv.parse_record')
local fix_bad_line = request('csv.fix_bad_line')

local trim_linefeed = request('^.string.trim_linefeed')

return
  function(s, dirty_data_allowed)
    assert_string(s)
    s = trim_linefeed(s)
    local record, last_pos, has_problems = _parse_record(s)
    local is_unclosed_quote = not dirty_data_allowed and has_problems and (last_pos > #s)
    if has_problems and dirty_data_allowed then
      local fix_succeded, fixed_s = fix_bad_line(s)
      if fix_succeded then
        record, last_pos, has_problems = _parse_record(fixed_s)
      end
    end
    return record, has_problems, is_unclosed_quote
  end
