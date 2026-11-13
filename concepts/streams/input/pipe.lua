-- Input stream on standard input

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local read =
  function(me, num_bytes)
    assert_integer(num_bytes)
    assert(num_bytes >= 0)

    if (num_bytes == 0) then return '' end

    local data_str = io.stdin:read(num_bytes)

    -- No end-of-file concept in input stream
    if is_nil(data_str) then data_str = '' end

    return data_str
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

-- Export:
return interface

--[[
  2024 # #
  2026 #
  2026-11-13
]]
