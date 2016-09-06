--[[
  Bulk load of given .csv file. If you need to iterate by
  records or bad records detection, use [parse.csv_record]
  with given line.
]]
local parse_csv_line = request('^.^.parse.csv_record')

local load_full_file =
  function(csv_str, allow_dirty_fixes)
    local result = {}
    local line_pattern = '(.-\n)'
    local broken_line
    for line in csv_str:gmatch(line_pattern) do
      if broken_line then
        line = broken_line .. line
        broken_line = nil
      end
      local record, has_problems, is_unclosed_quote = parse_csv_line(line, allow_dirty_fixes)
      if is_unclosed_quote then
        broken_line = line
      elseif not has_problems then
        result[#result + 1] = record
      end
    end
    return result
  end

return load_full_file
