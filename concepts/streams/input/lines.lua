-- Lines input stream

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

--[[
  Storage format

    1 [t] -- base input stream
]]

--[[
  Actually it's wrapper over provided base stream.
]]

--[[
  Unlike Read() from base streams we have different interface:

  Base read():

    * Uses one argument (number of bytes to read)
    * If stream is over
      * Returns empty string
    * Returns string with given bytes

  This read():

    * Uses no arguments (reads one line per call)
    * If stream is over
      * Returns "false"
    * Returns "true" and string with line
]]

local read
do
  local newline = request('!.concepts.ascii.chars').newline
  read =
    function(me)
      -- Naive implementation for first time

      local input = me[1]

      local char = input:read(1)
      if (char == '') then return false end

      local line = ''
      while true do
        if (char == newline) then break end
        line = line .. char
        char = input:read(1)
        if (char == '') then break end
      end

      return true, line
    end
end

local interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function(base_stream)
      assert_table(base_stream)
      local me = { base_stream }
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
  2026 #
  2026-11-13
]]
