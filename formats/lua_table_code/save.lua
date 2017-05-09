-- Serialize table to string with Lua code which recreates table

local table_serializer_class = request('save.interface')

return
  function(t, options)
    assert_table(t)
    local table_serializer = new(table_serializer_class, options)
    table_serializer:init()
    local ast = table_serializer:get_ast(t)
    local result = table_serializer:serialize_ast(ast)
    return result
  end
