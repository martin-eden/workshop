-- Open file for writing

return
  function(FileName)
    assert_string(FileName)

    local File = io.open(FileName, 'w+b')

    if is_nil(File) then
      return
    end

    return File
  end

--[[
  2024-08-09
]]
