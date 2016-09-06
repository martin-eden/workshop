local empty_func = function() end

return
  {
    also_visit_keys = false,
    nodes_status = {},
    table_iterator = pairs,
    inform_add = empty_func,
    inform_extract = empty_func,
    run = request('bfs'),
  }
