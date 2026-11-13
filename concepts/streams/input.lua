-- Input stream interface

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

--[[
  Interface

    create [f] -- create instance

      Arguments are implementation-specific.

    read [f] -- read given amount of bytes to string
]]

local read =
  function(me, num_bytes)
    assert_integer(num_bytes)
    assert(num_bytes >= 0)
    return ''
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
    read = read,
  }

return interface

--[[
  2024 # #
  2026 #
  2026-11-13
]]
