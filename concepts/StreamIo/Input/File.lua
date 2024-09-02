-- Reads strings from file. Implements [Input]

--[[
  Contract

    Read(NumBytes): string, bool

  Intestines

    OpenFile(FileName): bool

    CloseFile(): bool
]]

local OpenForReading = request('!.file_system.file.OpenForReading')
local CloseFileFunc = request('!.file_system.file.Close')

-- Contract: Read string from file
local Read =
  function(self, NumBytes)
    assert_integer(NumBytes)
    assert(NumBytes >= 0)

    local Data = ''
    local IsComplete = false

    Data = self.File:read(NumBytes)

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
    Read = Read,

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
