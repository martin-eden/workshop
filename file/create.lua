-- Create empty file at given pathname

--[[
  Status: passed maiden flight
  Last mod.: 2024-02-13
]]

return
  function(PathName)
    assert_string(PathName)

    local FileMode = 'wb'
    local File, ErrorMsg = io.open(PathName, FileMode)
    if not File then
      error(ErrorMsg)
    end

    File:close()
  end
