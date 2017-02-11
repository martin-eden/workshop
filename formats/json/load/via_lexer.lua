local loader = request('via_lexer.interface')

return
  function(json_str)
    loader:init()
    return loader:load(json_str)
  end
