local unquote_utf = request('unquote_string.unquote_utf')

return
  function(s)
    if
      (#s >= 2) and
      (s:sub(1, 1) == '"') and
      (s:sub(-1, -1) == '"')
    then
      s = s:sub(2, -2)
      -- \" \/ \b \n \f \r \t
      s =
        s:gsub(
          [[\.]],
          {
            [ [[\"]] ] = '"',
            [ [[\/]] ] = '/',
            [ [[\b]] ] = '\x08',
            [ [[\f]] ] = '\x0c',
            [ [[\n]] ] = '\x0a',
            [ [[\r]] ] = '\x0d',
            [ [[\t]] ] = '\x09',
          }
        )
      s = unquote_utf(s)
      s = s:gsub([[\\]], [[\]])
    end
    return s
  end
