local c_table_serializer = request('!.formats.lua_table.save.interface')
local add_node_handlers = request('add_node_handlers')

return
  function(self)
    self.table_serializer = new(c_table_serializer)
    self.table_serializer:init()
    add_node_handlers(
      self.table_serializer.node_handlers,
      self.table_serializer.text_block
    )
  end
