-- Writes strings to file. Implements [Output]

-- Last mod.: 2024-11-11

local OpenForWriting = request('!.file_system.file.OpenForWriting')
local CloseFileFunc = request('!.file_system.file.Close')

-- Contract: Write string to file
local Write =
  function(self, Data)
    assert_string(Data)

    local IsOk = self.FileHandle:write(Data)

    if is_nil(IsOk) then
      return 0, false
    end

    return #Data, true
  end

-- Intestines: Open file for writing
local OpenFile =
  function(self, FileName)
    local FileHandle = OpenForWriting(FileName)

    if is_nil(FileHandle) then
      return false
    end

    self.FileHandle = FileHandle

    return true
  end

-- Intestines: close file
local CloseFile =
  function(self)
    return (CloseFileFunc(self.FileHandle) == true)
  end

local Interface =
  {
    -- [Added]

    -- Open file by name
    Open = OpenFile,

    -- Close file
    Close = CloseFile,

    -- [Main]: Write string
    Write = Write,

    -- [Internals]
    FileHandle = 0,
  }

-- Close file at garbage collection
setmetatable(Interface, { __gc = function(self) self:Close() end } )

-- Exports:
return Interface

--[[
  2024-07-19
  2024-07-24
  2024-08-05
  2024-08-09
  2024-11-11
]]
