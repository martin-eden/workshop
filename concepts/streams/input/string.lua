-- Input stream on string

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

--[[
  Storage format

    1 [s] -- data string
    2 [i] -- read position
]]

local read
do
  local min = math.min
  local str_sub = string.sub
  read =
    function(me, num_bytes)
      assert_integer(num_bytes)
      assert(num_bytes >= 0)

      if (num_bytes == 0) then return '' end

      local str = me[1]
      local start_pos = me[2]

      local end_pos = min(start_pos + num_bytes - 1, #str)

      me[2] = end_pos + 1

      return str_sub(str, start_pos, end_pos)
    end
end

local interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function(str)
      assert_string(str)
      local me = { str, 1 }
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
  2025 #
  2026 #
  2026-11-13
]]
