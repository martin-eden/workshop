-- Get program name from string with Bash script

--[[
  Input

    string - file data

  Output

    table
      tool: string or nil
      data: string

  Example

    Input:
      ```
      #! /bin/bash
      echo "Line 1"
      echo "Line 2"
      ```

    Output:
      {
        tool = '/bin/bash',
        data =
          'echo "Line 1"' .. '\n' ..
          'echo "Line 2"' .. '\n',
      }
]]

-- Last mod.: 2024-02-28

local get_next_line = request('!.string.get_next_line')

return
  function(s)
    local result =
      {
        tool = nil,
        data = '',
      }

    local new_pos, line = get_next_line(s)
    if line and (line:sub(1, 2) == '#!') then
      result.tool = line:match('#!%s*(.*)')
      result.data = s:sub(new_pos)
    else
      result.data = s
    end

    return result
  end

--[[
  2018-02-05
]]
