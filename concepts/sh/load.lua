--[[
  Shebang script files splitter.

  Input:

    string - file data

  Output:

    table
      tool: string or nil
      data: string
]]

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
