-- Write optional data and comment strings as line to output

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

--[[
  Input

    [t] Output -- output stream
    [?s] data -- data string
    [?s] comment -- comment string
]]
local write_line =
  function(Output, data, comment)
    data = data or ''
    comment = comment or ''

    assert_string(data)
    assert_string(comment)

    local has_data = (data ~= '')
    local has_comment = (comment ~= '')

    local line = data

    if has_comment then
      if has_data then
        line = line .. '  '
      end

      line = line .. '# ' .. comment
    end

    line = line .. '\n'

    Output:Write(line)
  end

-- Export:
return write_line

--[[
  2024
  2025
  2026-05-31
]]
