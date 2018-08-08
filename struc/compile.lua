local compile_core = request('compile_core')
local unfold = request('!.table.unfold')

return
  function(t, node_handlers)
    if is_string(t) then
      return t
    else
      assert_table(t)
    end

    node_handlers = node_handlers or {}
    assert_table(node_handlers)

    local result = {}

    compile_core(t, node_handlers, result)
    result = unfold(result)
    result = table.concat(result)

    return result
  end
