-- Output stream on standard output

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local write =
  function(me, data_str)
    assert_string(data_str)
    io.stdout:write(data_str)
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
  2026-05-27
  2026-08-30
]]
