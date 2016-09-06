local chunk_name = 'handlers'

tribute(
  chunk_name,
  {
    debug_with_indent =
      function(event_name, node, node_name, depth, order_number)
        local indent = '|   '
        if (event_name == 'node_added') then
          local result
          result = ('%s[%s] %s'):format(indent:rep(depth), node_name, tostring(node))
          print(result)
        end
      end,
  }
)
