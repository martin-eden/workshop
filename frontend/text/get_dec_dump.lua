-- Serialize string to ASCII dec

--[[
  Author: Martin Eden
  Last mod.: 2026-04-24
]]

-- Imports:
local trim_tail = request('!.string.trim_tail')

-- Serialize string data as ASCII decimals line
local get_dec_dump =
  function(raw_bytes)
    assert_string(raw_bytes)

    local result

    result =
      string.gsub(
        raw_bytes,
        '.',
        function(char)
          return ('%03d '):format(char:byte())
        end
      )

    result = trim_tail(result)

    return result
  end

-- Export:
return get_dec_dump

--[[
  2026-04-24
]]
