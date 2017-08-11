--[[
  Unquote regexp-string.
  Returns unquoted string.
]]

local magic_char_pattern = request('magic_char_pattern')
local replace_pattern = '%%(' .. magic_char_pattern .. ')'

return
  function(s)
    return s:gsub(replace_pattern, '%1')
  end
