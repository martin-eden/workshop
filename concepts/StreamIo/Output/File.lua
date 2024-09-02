-- Writes strings to file. Implements [Output]

--[[
  Contract

    Write(string): int, bool

  Intestines

    OpenFile(FileName)

    CloseFile(): bool
]]

local OpenForWriting = request('!.file_system.file.OpenForWriting')
local CloseFileFunc = request('!.file_system.file.Close')

-- Contract: Write string to file
local Write =
  function(self, Data)
    assert_string(Data)

    local IsOk = self.File:write(Data)

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

    self.File = FileHandle

    return true
  end

-- Intestines: close file
local CloseFile =
  function(self)
    return (CloseFileFunc(self.File) == true)
  end

-- Exports:
local Interface =
  {
    -- Interface
    Write = Write,

    -- Intestines
    File = {},

    -- Intestines management
    OpenFile = OpenFile,
    CloseFile = CloseFile,
  }

-- Close file at garbage collection
setmetatable(Interface, { __gc = function(self) self:CloseFile() end } )

return Interface

--[[
  2024-07-19
  2024-07-24
  2024-08-05
  2024-08-09
]]
