-- Serialize string to ASCII hex

--[[
  Author: Martin Eden
  Last mod.: 2026-04-24
]]

-- Imports:
local trim_tail = request('!.string.trim_tail')

-- Serialize string data as ASCII hex line
local get_hex_dump =
  function(raw_bytes)
    assert_string(raw_bytes)

    local result

    result =
      string.gsub(
        raw_bytes,
        '.',
        function(char)
          return ('%02X '):format(char:byte())
        end
      )

    result = trim_tail(result)

    return result
  end

-- Export:
return get_hex_dump

--[[
  2018-02
  2020-01
  2026-04
]]
