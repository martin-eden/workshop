-- Print node to our virtual printer

--[[
  Author: Martin Eden
  Last mod.: 2026-10-31
]]

--[[
  We're creating new virtual printer with current settings
  but without previous text (except "last line with text").

  Then we're calling serializer with that printer.

  We're returning printer's instance. If it's result is accepted
  it can me merged to higher-level result.
]]

return
  function(me, represent, node)
    local original_printer = me[2]
    local trial_printer = original_printer:seed()

    me[2] = trial_printer
    local has_failed = not represent(me, node)
    me[2] = original_printer

    return trial_printer, has_failed
  end

--[[
  2017 # #
  2026 #
  2026-10-31
]]
