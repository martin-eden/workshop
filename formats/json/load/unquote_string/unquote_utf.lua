local hex_digit = '[0-9a-fA-F]'
local basic_plane = [[(\u)]] .. '(' .. hex_digit:rep(4) .. ')'
local utf16_surrogate_pair = basic_plane:rep(2)

return
  function(s)
    -- UTF code points sequencies ("\u" and 4 hex digits)
    s =
      s:gsub(
        basic_plane,
        function(prefix, utf_code_point)
          local code_point = tonumber(utf_code_point, 16)
          local utf_char
          if (code_point >= 0xD800) and (code_point < 0xE000) then
            --this is going to be surrogate pair, deal with it later
          else
            utf_char = utf8.char(code_point)
          end
          return utf_char
        end
      )
    s =
      s:gsub(
        utf16_surrogate_pair,
        function(high_prefix, high_code_point, low_prefix, low_code_point)
          high_code_point = tonumber(high_code_point, 16)
          low_code_point = tonumber(low_code_point, 16)
          local utf_char
          if
            (high_code_point >= 0xD800) and
            (high_code_point <= 0xDBFF) and
            (low_code_point >= 0xDC00) and
            (low_code_point <= 0xDFFF)
          then
            local code_point =
              0x10000 +
              ((high_code_point - 0xD800) << 10) +
              (low_code_point - 0xDC00)
            utf_char = utf8.char(code_point)
          end
          return utf_char
        end
      )
    return s
  end
