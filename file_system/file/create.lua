-- Create file with given pathname and contents

--[[
  Design version: 2
  Last mod.: 2024-02-17
]]

return
  function(PathName, Contents)
    assert_string(PathName)
    assert_string(Contents)

    local FileMode = 'wb'
    local File, ErrorMsg = io.open(PathName, FileMode)
    if not File then
      error(ErrorMsg)
    end
    File:write(Contents)

    File:close()
  end
