local c_text_block = request('!.mechs.text_block.interface')

return
  function(self)
    self.text_block = new(c_text_block)
    self.text_block:init()
    self.install_node_handlers(self.node_handlers, self.text_block)
  end
