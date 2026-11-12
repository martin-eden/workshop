-- Customizable BFS algorithm

--[[
  Author: Martin Eden
  Last mod.: 2026-11-12
]]

local empty_func = function() end

return
  {
    also_visit_keys = false,
    nodes_status = { },
    table_iterator = pairs,
    inform_add = empty_func,
    inform_extract = empty_func,
    run = request('bfs'),
  }

--[[
  2016
]]
