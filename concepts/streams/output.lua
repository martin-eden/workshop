-- Output stream interface

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

--[[
  Interface

    create [f] -- create instance

      Arguments are implementation-specific.

    write [f] -- write bytes from string
]]

local write =
  function(me, data_str)
    assert_string(data_str)
  end

local interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function()
      local me = { }
      attach_methods(me, interface)
      return me
    end
end

interface =
  {
    create = create,
    write = write,
  }

return interface

--[[
  2024 # #
  2026 #
  2026-11-13
]]
