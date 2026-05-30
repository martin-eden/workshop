-- Write optinal data and comment strings as line to output

--[[
  Author: Martin Eden
  Last mod.: 2026-05-30
]]

--[[
  Input

    [?s] data -- data string
    [?s] comment -- comment string
]]

local WriteLine =
  function(Me, data, comment)
    data = data or ''
    comment = comment or ''

    assert_string(data)
    assert_string(comment)

    local has_data = (data ~= '')
    local has_comment = (comment ~= '')

    local line = ''

    line = line .. data

    if has_comment then
      if has_data then
        line = line .. '  '
      end

      line = line .. Me.Settings.LineCommentChar .. ' ' .. comment
    end

    line = line .. '\n'

    Me.Output:Write(line)
  end

-- Exports:
return WriteLine

--[[
  2024
  2025
  2026-05-30
]]
