-- Input stream on file

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

--[[
  Storage format

    1 [s] pathname
    2 [u] file instance
]]

local open
do
  local open_read = request('!.file_system.file.open_for_reading')
  open =
    function(me)
      me[2] = open_read(me[1])
    end
end

local close
do
  local close_file = request('!.file_system.file.close')
  close =
    function(me)
      close_file(me[2])
    end
end

local read
do
  local is_natural = request('!.number.is_natural')
  read =
    function(me, num_bytes)
      assert_integer(num_bytes)
      assert(num_bytes >= 0)

      if (num_bytes == 0) then return '' end

      local data_str = me[2]:read(num_bytes)

      -- No end-of-file concept in input stream
      if is_nil(data_str) then data_str = '' end

      return data_str
    end
end

local interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function(pathname)
      assert_string(pathname)
      local me = { pathname, 0 }
      attach_methods(me, interface)
      return me
    end
end

interface =
  {
    -- Core:
    create = create,
    read = read,
    -- Extensions:
    open = open,
    close = close,
  }

-- Export:
return interface

--[[
  2024 # # # # #
  2026 #
  2026-09-28
]]
