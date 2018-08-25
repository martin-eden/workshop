local process_files = request('process_files')
local process_locators = request('process_locators')
local process_locators_link = request('process_locators_link')

return
  function(ast, stream)
    assert_table(ast)
    assert_table(stream)

    process_files(ast, stream)
    process_locators(ast, stream)
    process_locators_link(ast, stream)
  end
