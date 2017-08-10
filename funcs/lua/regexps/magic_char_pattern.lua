local magic_chars = request('magic_chars')
local magic_char_patttern = '[' .. magic_chars:gsub('.', '%%%0') .. ']'
return magic_char_patttern
