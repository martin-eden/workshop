local compile = request('!.mechs.compile')

return
  function(self, ast)
    compile(ast, self.node_handlers)
    return self.text_block:get_text()
  end
