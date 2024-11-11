-- Reads strings from file. Implements [Input]

-- Last mod.: 2024-11-11

local OpenForReading = request('!.file_system.file.OpenForReading')
local CloseFileFunc = request('!.file_system.file.Close')

-- Contract: Read string from file
local Read =
  function(self, NumBytes)
    assert_integer(NumBytes)
    assert(NumBytes >= 0)

    local Data = ''
    local IsComplete = false

    Data = self.FileHandle:read(NumBytes)

    local IsEof = is_nil(Data)

    -- No End-of-File state in [Input]
    if IsEof then
      Data = ''
    end

    IsComplete = (#Data == NumBytes)

    return Data, IsComplete
  end

-- Intestines: Open file for reading
local OpenFile =
  function(self, FileName)
    local FileHandle = OpenForReading(FileName)

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
    -- [New]

    -- Open file by name
    Open = OpenFile,

    -- Close file
    Close = CloseFile,

    -- [Main]: Read bytes
    Read = Read,

    -- Intestines
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
