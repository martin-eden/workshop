-- Represent string in bash

--[[
  Author: Martin Eden
  Last mod.: 2026-01-12
]]

-- Represent data in Bash
local QuoteBashString =
  function(s)
    --[[
      We're using single-quotes

      Happy case when data string does not contain '. Then we just
      enclose string in '.

      If it does contain ' we split string around it, quoting clean
      parts, and gluing escaped ':

        a'b -> 'a'\''b'

      After some thought we decided always use quoting even if it
      is may be omitted. It's hard to detect exact cases where
      it cab be omitted:

        a -> 'a'
    ]]

    local StartIdx = 1
    -- Capture characters before '
    local CleanPartCaptureStr = "(.-)'"
    local Result = ''

    s = s .. "'"

    local LastIdx = string.len(s)
    local EndIdx, Capture

    while true do
      StartIdx, EndIdx, Capture =
        string.find(s, CleanPartCaptureStr, StartIdx)

      Result = Result .. "'" .. Capture .. "'"

      if (EndIdx == LastIdx) then
        break
      end

      Result = Result .. [[\']]

      StartIdx = EndIdx + 1
    end

    return Result
  end

return QuoteBashString

-- 2026-01-12
