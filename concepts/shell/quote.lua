-- Encode string to shell

--[[
  Author: Martin Eden
  Last mod.: 2026-05-04
]]

--[[
  Pack data for Bash

  Input
    [s] -- Data to encode
  Output
    [s] -- Encoded data
]]
local quote =
  function(str)
    --[[
      We're using single-quotes

      Happy case when data string does not contain '. Then we just
      enclose string in '.

      If it does contain ' we split string around it, quoting clean
      parts, and gluing escaped ':

        a'b -> 'a'\''b'

      After some thought we decided to always use quoting even if it
      can be omitted. Because it's hard to detect exact cases where
      it can be omitted:

        a -> 'a'
    ]]

    --[[
      ' is treated as delimiter and terminator

      Implementation adds ' to source string and then processes it
      by chunks separated by '.
    ]]

    assert_string(str)

    str = str .. "'"

    local data_end_idx = string.len(str)

    -- Capture characters before '
    local clean_part_capture = "(.-)'"

    local capture_start_idx, capture_end_idx, capture
    local result

    capture_start_idx = 1
    result = ''
    while true do
      capture_start_idx, capture_end_idx, capture =
        string.find(str, clean_part_capture, capture_start_idx)

      result = result .. "'" .. capture .. "'"

      if (capture_end_idx == data_end_idx) then
        break
      end

      result = result .. [[\']]

      capture_start_idx = capture_end_idx + 1
    end

    return result
  end

return quote

-- 2026-01-12
