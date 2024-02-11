-- Returns true if directory exists. Else returns false.

--[[
  Status: works
  Version: 1
  Last mod.: 2024-02-11
]]

return
  function(DirectoryName)
    assert_string(DirectoryName)

    local File = io.open(DirectoryName, 'r');

    if is_nil(File) then
      return false
    end

    local ReadResult, ErrMsg, ErrNo = File:read(1)
    File:close()

    return
      (ErrMsg == 'Is a directory') and
      (ErrNo == 21)
  end
