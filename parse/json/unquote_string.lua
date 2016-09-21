local hex_digit_pattern = '[0-9a-fA-F]'
local basic_plane_pattern = [[(\u)]] .. '(' .. hex_digit_pattern:rep(4) .. ')'
local utf16_surrogate_pair_pattern = basic_plane_pattern:rep(2)

return
  function(s)
    if
      (#s >= 2) and
      (s:sub(1, 1) == '"') and
      (s:sub(-1, -1) == '"')
    then
      s = s:sub(2, -2)
      -- '"', [[\]], '/', 'b', 'f', 'n', 'r', 't', utf_code_point)
      s = s:gsub([[\"]], '"')
      s = s:gsub([[\/]], '/')
      s = s:gsub([[\b]], '\x08')
      s = s:gsub([[\f]], '\x0c')
      s = s:gsub([[\n]], '\x0a')
      s = s:gsub([[\r]], '\x0d')
      s = s:gsub([[\t]], '\x09')
      -- UTF code points sequencies ("\u" and 4 hex digits)
      s =
        s:gsub(
          basic_plane_pattern,
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
          utf16_surrogate_pair_pattern,
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
      s = s:gsub([[\\]], '\\')
    end
    return s
  end
