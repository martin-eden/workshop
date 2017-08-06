--[[
  Get line for given string and position. Return it with next position.

  Function interface uses standard next() function format:
    input:
      base, index
    output:
      new_index, result

  Special case:
    Last line may not have tail newline.
]]

return
  function(s, start_pos)
    start_pos = start_pos or 1
    local start, finish, result = s:find('(.-)\n', start_pos)
    local new_start
    if not start then
      if (start_pos <= #s) then
        result = s:sub(start_pos)
        new_start = #s + 1
      end
    else
      new_start = finish + 1
    end
    return new_start, result
  end
