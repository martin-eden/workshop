-- Write optional data and comment strings as line to output stream

--[[
  Author: Martin Eden
  Last mod.: 2026-06-04
]]

--[[
  Input

    [s] data -- data string
    [s] comment -- comment string
    [t] Output -- output stream
]]
local write_line =
  function(data, comment, Output)
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
  2026-05 #
  2026-06-04
]]
