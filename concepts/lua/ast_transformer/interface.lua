-- AST transformer

--[[
  Author: Martin Eden
  Last mod.: 2026-10-21
]]

return
  {
    keep_unparsed_tail = true,

    data_struc = nil,
    run = request('run'),

    handlers = request('handlers.interface'),
    align_nodes = request('align_nodes'),
    restruc_nodes = request('restruc_nodes'),
  }

--[[
  2018 # # #
  2026-10-21
]]
