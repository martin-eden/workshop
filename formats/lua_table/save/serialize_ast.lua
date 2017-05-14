local compile = request('!.mechs.compile')

return
  function(self, ast)
    compile(ast, self.node_handlers)
    local result = self.text_block:get_text()
    return result
  end
