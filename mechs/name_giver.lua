-- Generate string name for given function, thread, table or userdata

--[[
  Author: Martin Eden
  Last mod.: 2026-06-19
]]

local Interface =
  {
    names = {},
    counters =
      {
        ['function'] = 0,
        table = 0,
        thread = 0,
        userdata = 0,
      },
    templates =
      {
        ['function'] = 'f_%d',
        table = 'T_%d',
        thread = 'th_%d',
        userdata = 'u_%d',
      },
    give_name =
      function(self, obj)
        if not self.names[obj] then
          local obj_type = type(obj)
          if not self.counters[obj_type] then
            error(
              ('Argument type "%s" is not supported for counting.'):
              format(obj_type),
              2
            )
          end
          self.counters[obj_type] = self.counters[obj_type] + 1
          self.names[obj] =
            (self.templates[obj_type]):format(self.counters[obj_type])
        end
        return self.names[obj]
      end,
  }

-- Export:
return Interface

--[[
  2016
  2026-06-19
]]
