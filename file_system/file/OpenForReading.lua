-- Open file for reading

return
  function(FileName)
    assert_string(FileName)

    local File = io.open(FileName, 'rb')

    if is_nil(File) then
      return
    end

    return File
  end

--[[
  2024-08-09
]]
