--[[
  Quote all special regexp symbols in regexp-string.
  Returns regexp-string.

  Useful when you wish to pass to gsub() string with special
  characters with their literal meaning.

  Note that it will quote already quoted symbols:
    "%." -- match "."
    will become
    "%%%." -- match "%."
]]

local magic_char_pattern = request('magic_char_pattern')

return
  function(s)
    return s:gsub(magic_char_pattern, '%%%0')
  end
