local get_ast = request('get_ast')
local ast_as_code = request('ast_as_code')

return
  function(s)
    return ast_as_code(get_ast(s))
  end
