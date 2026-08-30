-- Generate string name for given function, thread, table or userdata

--[[
  Author: Martin Eden
  Last mod.: 2026-08-30
]]

local Templates =
  {
    ['function'] = 'f_%d',
    ['table'] = 'T_%d',
    ['thread'] = 'th_%d',
    ['userdata'] = 'u_%d',
  }

local str_format = string.format

-- Export:
return
  {
    Names = { },
    Counters =
      {
        ['function'] = 0,
        ['table'] = 0,
        ['thread'] = 0,
        ['userdata'] = 0,
      },
    give_name =
      function(Me, obj)
        if not Me.Names[obj] then
          local obj_type = type(obj)
          local counter = Me.Counters[obj_type]
          assert_integer(counter)
          counter = counter + 1
          Me.Names[obj] = str_format(Templates[obj_type], counter)
          Me.Counters[obj_type] = counter
        end
        return Me.Names[obj]
      end,
  }

--[[
  2016 #
  2026 # #
]]
