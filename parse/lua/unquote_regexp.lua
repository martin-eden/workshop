local magic_chars = request('^.^.compile.lua.magic_chars')
local magic_chars_pattern
magic_chars_pattern = '%%(['
for i = 1, #magic_chars do
  magic_chars_pattern = magic_chars_pattern .. '%' .. magic_chars[i]
end
magic_chars_pattern = magic_chars_pattern .. '])'

return
  function(s)
    return s:gsub(magic_chars_pattern, '%1')
  end
