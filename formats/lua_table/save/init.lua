local c_text_block = request('!.mechs.text_block.interface')
local add_node_handlers = request('add_node_handlers')

return
  function(self)
    self.text_block = new(c_text_block)
    self.text_block:init()
    add_node_handlers(self.node_handlers, self.text_block)
  end
