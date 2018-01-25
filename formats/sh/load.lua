--[[
  Shebang script files splitter.

  Input:
    string with file data

  Output:
    {tool = <str> or <nil>, data = <str>}
]]

local get_next_line = request('!.string.lines.get_next_line')

return
  function(s)
    local new_pos, line = get_next_line(s)
    local result =
      {
        tool = nil,
        data = '',
      }
    if (line:sub(1, 2) == '#!') then
      result.tool = line:match('#!%s*(.*)')
      result.data = s:sub(new_pos)
    else
      result.data = s
    end
    return result
  end
