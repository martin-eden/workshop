-- Given string with pathname return strings with path and name.

--[[
  If there is not path or name, empty string is returned, not nil:

    ('/tmp/') -> '/tmp/', ''
    ('Results.lua') -> '', 'Results.lua'

  We don't check if the directory exists.

  And we think that file name is the rest of the string after last
  directory separator:

    ('/tmp') -> '/', 'tmp'
]]

-- Last mod.: 2024-02-17

return
  function(PathName)
    assert_string(PathName)

    --[[
      Path-name pattern. This does not allow path part to be empty.

      That is why we need "if" and another pattern for this case.
    ]]
    local PathName_Pattern = '^(.*/)(.*)$'

    local Name_Pattern = '^(.*)$'

    local Path, Name

    Path, Name = string.match(PathName, PathName_Pattern)
    if is_nil(Path) then
      Name = string.match(PathName, Name_Pattern)
    end

    Path = Path or ''
    Name = Name or ''

    return Path, Name
  end
