-- CSV parser driver

local iterate_data =
  function(self, next_line_func)
    local result = {}
    local broken_line
    for line in next_line_func do
      if broken_line then
        line = broken_line .. line
        broken_line = nil
      end
      local record, has_problems, is_unclosed_quote = self:parse_line(line)
      if is_unclosed_quote then
        broken_line = line
      elseif not has_problems then
        result[#result + 1] = record
      end
    end
    return result
  end

local parse_record = request('specific.parse_record')
local fix_bad_line = request('specific.fix_bad_line')
local trim_linefeed = request('^.^.string.trim_linefeed')
local line_pattern = '.-\n'

return
  {
    quote_char = '"',
    field_sep_char = ',',
    record_sep_char = '\n',
    dirty_data_allowed = false,
    parse_line =
      function(self, s)
        assert_string(s)
        s = trim_linefeed(s)
        local record, last_pos, has_problems = parse_record(self, s)
        if has_problems and self.dirty_data_allowed then
          local fix_succeded, fixed_s = fix_bad_line(s)
          if fix_succeded then
            record, last_pos, has_problems = parse_record(fixed_s)
          end
        end
        local is_unclosed_quote = has_problems and (last_pos > #s)
        return record, has_problems, is_unclosed_quote
      end,
    parse_lines =
      function(self, csv_str)
        return iterate_data(self, csv_str:gmatch(line_pattern))
      end,
    parse_file =
      function(self, f)
        return iterate_data(self, f:lines('L'))
      end,
  }
