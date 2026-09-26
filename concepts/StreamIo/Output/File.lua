-- Output stream on file

--[[
  Author: Martin Eden
  Last mod.: 2026-08-30
]]

--[[
  Storage format

    1 [s] pathname
    2 [u] file instance
]]

local open
do
  local open_for_writing = request('!.file_system.file.open_for_writing')
  open =
    function(Me)
      Me[2] = open_for_writing(Me[1])
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

local write =
  function(Me, data_str)
    assert_string(data_str)

    Me[2]:write(data_str)
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
    Write = write,
  }

-- Export:
return Interface

--[[
  2024 # # # # #
  2026 # #
  2026-09-26
]]
