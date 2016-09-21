local troublesome_characters_pattern = '[\r\n%"%,]'
local space_chars =
  {
    [' '] = true,
    ['\t'] = true,
  }
local quote = request('quote_field')

return
  function(s)
    assert_string(s)
    if
      space_chars[s:sub(1, 1)] or
      space_chars[s:sub(-1, -1)] or
      s:find(troublesome_characters_pattern)
    then
      s = quote(s)
    end
    return s
  end
