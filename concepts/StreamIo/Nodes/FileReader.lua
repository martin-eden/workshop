-- Reads strings from file. Implements [Reader]

--[[
  Stream reader from file

  OpenFile(FileName): bool
    sets File
  Read(NumBytes): string, bool
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

    -- No End-of-File state in [Reader]
    if IsEof then
      Data = ''
    end

    IsComplete = (#Data == NumBytes)

    return Data, IsComplete
  end

-- Additions: Open file for reading
local OpenFile =
  function(self, FileName)
    local FileHandle = OpenForReading(FileName)

    if is_nil(FileHandle) then
      return false
    end

    self.File = FileHandle

    return true
  end

-- Additions: close file
local CloseFile =
  function(self)
    return (CloseFileFunc(self.File) == true)
  end

-- Exports:
local Interface =
  {
    -- Interface
    Read = Read,

    -- Intensities
    File = {},

    -- Intensities management
    OpenFile = OpenFile,
    CloseFile = CloseFile,
  }

setmetatable(Interface, { __gc = function(self) self:CloseFile() end } )

return Interface

--[[
  2024-07-19
  2024-07-24
  2024-08-05
  2024-08-09
]]
