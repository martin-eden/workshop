--[[
  Generic-for iterator for lines in string.

  Interface:
    input:
      base, start_index
    output:
      func, base, start_index

  Common use case is

    local lines = request(<...>)
    for next_pos, line in lines(s) do
      <...>
    end
]]

local get_next_line = request('get_next_line')

return
  function(s, start_pos)
    return get_next_line, s, start_pos
  end
