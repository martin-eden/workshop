-- Serialize lua table as lua table definition.

-- Not suitable for tables with cross-links in keys or values.

local table_serializer_class =
  request('^.^.^.compile.lua.serialize_table.lua_table.interface')

return
  function(t, options)
    assert_table(t)
    local serializer = new(table_serializer_class, options)
    serializer:init()
    serializer:serialize(t)
    return serializer:get_result()
  end
