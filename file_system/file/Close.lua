-- Close file object

--[[
  Stock Lua explodes with exception on double close.
  I want idempotence.
]]

--[[
  Close file object

  Input
    file

  Output
    nil(if not applicable) or bool(file is closed)

  Notes
    Lua's "io" do not closes stdins etc. We reflect this in boolean
    result. For most practical cases is can be ignored.
]]
return
  function(File)
    local IsFile = is_string(io.type(File))

    if not IsFile then
      return
    end

    local IsClosed = (io.type(File) == 'closed file')
    if IsClosed then
      return true
    end

    local IsOk = io.close(File)

    return IsOk
  end

--[[
  2024-08-09
]]
