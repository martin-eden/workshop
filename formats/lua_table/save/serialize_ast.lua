local compile = request('!.mechs.compile')

return
  function(self, ast)
    local text_block = self.text_block
    text_block:add_curline(compile(ast, self.node_handlers))
    local result = text_block:get_text()
    return result
  end
