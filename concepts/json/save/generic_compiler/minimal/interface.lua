-- Minimal JSON serializer via callbacks

--[[
  Author: Martin Eden
  Last mod.: 2026-11-08
]]

local init = function() end

local get_struc =
  function(Me, Data)
    return Me.handlers[type(Data)](Me, Data)
  end

local create_stateless_handler =
  function(Me)
    return
      function(Data)
        return Me:get_struc(Data)
      end
  end

return
  {
    init = init,
    get_struc = get_struc,
    create_stateless_handler = create_stateless_handler,
    --
    handlers = request('handlers.interface'),
    table_iterator = request('!.table.ordered_pass'),
  }

--[[
  2017 #
  2026-11-08
]]
