local compile_locator = request('compile.locator')

return
  function(ast, stream)
    for _, rec in ipairs(ast.locators) do
      compile_locator(rec, stream)
    end
  end
