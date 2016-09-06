local get_num_refs =
  function(node_rec)
    local result = 0
    if node_rec.refs then
      for parent, parent_keys in pairs(node_rec.refs) do
        for field in pairs(parent_keys) do
          result = result + 1
        end
      end
    end
    return result
  end

local may_print_inline =
  function(node_rec)
    return
      not node_rec or
      (
        node_rec and
        (get_num_refs(node_rec) <= 1) and
        not node_rec.part_of_cycle
      )
  end

return may_print_inline
