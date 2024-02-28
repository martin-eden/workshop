-- Get line from given string and start position

--[[
  Input

    <s>: string
      Given string.

    | <start_pos>: int = 1
      Position where to start extraction of next line.

  Output

    Return argument for next iteration and result or nil:

    If <start_pos> is beyond <s>, return

      <nil>

    Else return

      <int>
        Position where next line starts. Expected to become <start_pos>
        value for next call.

      <str>
        Extracted line (without newline character).

  Special cases

    1. No tail newline:

      If there is no tail newline

        Handle that part as if newline was present

    2. Empty string

      If <s> is empty

        Return ('', 1)
]]

-- Last mod.: 2024-02-28

return
  function(s, start_pos)
    -- If <start_pos> is nil we consider it as a first iteration.
    if (is_nil(start_pos)) then
      -- For empty line return empty line. Make sure it's the last iteration.
      if (s == '') then
        return 1, ''
      else
        start_pos = 1
      end
    end

    assert_string(s)

    assert_integer(start_pos)

    -- Throw error for negative indexes:
    if (start_pos <= 0) then
      error('get_next_line(): start index must be natural number')
    end

    -- Termination condition:
    if (start_pos > #s) then
      return nil
    end

    -- Here <start_pos> is index inside string <s>.

    local pattern = '(.-)\n'
    local entry_start, entry_finish, capture = string.find(s, pattern, start_pos)

    if is_nil(capture) then
      --[[
        String doesn't ends with newline.

        Treat remained string suffix as line.
      ]]
      entry_start = start_pos
      entry_finish = #s
      capture = string.sub(s, entry_start, entry_finish)
    end

    return entry_finish + 1, capture
  end

--[[
  2018-02-06
  2024-02-28
]]
