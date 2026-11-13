-- Output stream on file

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
  local create_file = request('!.file_system.file.create')
  local open_for_writing = request('!.file_system.file.open_for_writing')
  open =
    function(me)
      create_file(me[1], '')
      me[2] = open_for_writing(me[1])
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

local write =
  function(me, data_str)
    assert_string(data_str)
    me[2]:write(data_str)
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
    write = write,
    -- Extensions:
    open = open,
    close = close,
  }

-- Export:
return interface

--[[
  2024 # # # # #
  2026 # # #
  2026-10-02
]]
