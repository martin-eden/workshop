--[[
  Quote all special regexp symbols in regexp-string.
  Returns regexp-string.

  Useful when you wish to pass to gsub() string with special
  characters with their literal meaning.

  Usually you don't want to apply it more than once.

  Example:

    /*
      Regexp meaning:
        '.' - any char
        '%.' - "."
        '%%%.' - "%."
    */
    quote('.') -> '%.'
    quote('%.') -> '%%%.'
]]

-- Last mod.: 2024-10-20

local magic_char_pattern = request('magic_char_pattern')

return
  function(s)
    return s:gsub(magic_char_pattern, '%%%0')
  end

--[[
  2018-02-05
  2024-10-20
]]
