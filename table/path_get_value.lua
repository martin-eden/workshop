--[[
  Receive start node (table) and array with path to node.
  May also have optional integer parameter <max_depth>. Negative
    values means counting from last element of array (as in Lua
    strings): -1 == #path. Useful for simulating truncation of
    <path> array.
  Return value of the node.
]]

return
  function(node, path, max_depth)
    assert_table(node)
    assert_table(path)

    max_depth = max_depth or #path
    if (max_depth < 0) then
      max_depth = #path + 1 + max_depth
    end
    assert_integer(max_depth)

    for i = 1, #path do
      if (i > max_depth) then
        break
      end
      node = node[path[i]]
    end

    return node
  end
