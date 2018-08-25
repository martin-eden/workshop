local compile_locators_link =
  request('compile.locators_link')
local compile_locators_link_64 =
  request('compile.locators_link_64')
local compile_locators_link_64_link =
  request('compile.locators_link_64_link')

return
  function(ast, stream)
    compile_locators_link(ast.locators_link, stream)
    if ast.locators_link_64 then
      compile_locators_link_64(ast.locators_link_64, stream)
    end
    if ast.locators_link_64_link then
      compile_locators_link_64_link(ast.locators_link_64_link, stream)
    end
  end
