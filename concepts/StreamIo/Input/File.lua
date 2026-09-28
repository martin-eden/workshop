-- Input stream on file

--[[
  Author: Martin Eden
  Last mod.: 2026-09-28
]]

--[[
  Storage format

    1 [s] pathname
    2 [u] file instance
]]

local open
do
  local open_file_for_reading = request('!.file_system.file.open_for_reading')
  open =
    function(Me)
      Me[2] = open_file_for_reading(Me[1])
    end
end

local close
do
  local close_file = request('!.file_system.file.close')
  close =
    function(Me)
      close_file(Me[2])
    end
end

local read
do
  local is_natural = request('!.number.is_natural')
  read =
    function(Me, num_bytes)
      assert(is_natural(num_bytes))

      local data_str = Me[2]:read(num_bytes)

      -- No end-of-file concept in input stream
      if is_nil(data_str) then data_str = '' end

      return data_str
    end
end

local Interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function(pathname)
      assert_string(pathname)
      local Me = { pathname, 0 }
      attach_methods(Me, Interface)

      return Me
    end
end

Interface =
  {
    create = create,
    -- Extensions:
    Open = open,
    Close = close,
    -- Core:
    Read = read,
  }

-- Export:
return Interface

--[[
  2024 # # # # #
  2026 #
  2026-09-28
]]
