local populate_outer =
  function(data_struc, in_stream)
    local populate
    populate =
      function(node)
        if not is_table(node) then
          return
        end
        if (#node == 0) then
          node.value = in_stream:get_segment(node.start, node.len)
        else
          for i = 1, #node do
            populate(node[i])
          end
        end
        node.start = nil
        node.len = nil
      end
    if next(data_struc) then
      populate(data_struc)
    end
  end

return populate_outer

--[[
  * We populate only leaf nodes.
  * For all records we remove data  offsets relating to input stream.

    This is because
      * we assume that input stream is no longer accessible in
        further flow
      * the intention of parsing is remove more low-level layer,
        not just annotate it
]]
