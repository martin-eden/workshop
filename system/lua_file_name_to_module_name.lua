--[[
  Convert pathname to lua file to module name.
  Return module name.

  Does not checks whether file exists or may it be loaded.
]]

return
  function(file_name)
    assert_string(file_name)
    local result = file_name
    result = result:gsub('^%./', '')
    result = result:gsub('%.lua$', '')
    result = result:gsub('/', '.')
    return result
  end
