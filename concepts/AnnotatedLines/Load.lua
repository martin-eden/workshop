-- Parse annotated lines

--[[
  Input

    string

      String with annotated lines.

  Output

    table - Data

      Parsed contents in table indexed by key names.

    table - Errors report

      Table sequence of strings. Each string describes problem
      with parsing specific line. Or warning that this key overwrites
      previous data.

      Empty table if there are no errors.

  Special cases

    If there is problem with parsing line

      Mention that line in report

    If there are duplicate keys in input

      Keep the last value
      Mention that key and values in report

  Example

    'a=1'..'\n'..'b=2'..'\n'..'a=3' -> { a = '3', b = '2' }, {}
]]

-- Last mod.: 2024-03-03

local IterateLines = request('!.string.lines')
local ParseLine = request('Parser.ParseLine')

return
  function(DataString)
    assert_string(DataString)

    local Result, ErrorsReport
    do
      Result = {}
      ErrorsReport = {}

      local LineNumber = 1

      for _, Line in IterateLines(DataString) do
        local Key, Value = ParseLine(Line)

        if is_nil(Key) then
          local ErrorMsgFormat = 'Problem parsing line %d: "%s"'
          local ErrorMsg = string.format(ErrorMsgFormat, LineNumber, Line)
          table.insert(ErrorsReport, ErrorMsg)
          goto Continue
        end

        if Result[Key] then
          local ErrorMsgFormat =
            'Line %d. Overwriting value [%s] from "%s" to "%s".'
          local ErrorMsg =
            string.format(
              ErrorMsgFormat,
              LineNumber,
              Key,
              Result[Key],
              Value
            )
          table.insert(ErrorsReport, ErrorMsg)
        end

        Result[Key] = Value

        ::Continue::
        LineNumber = LineNumber + 1
      end
    end
    assert_table(Result)
    assert_table(ErrorsReport)

    return Result, ErrorsReport
  end

--[[
  2024-02-15
  2024-02-28
  2024-03-03
]]
