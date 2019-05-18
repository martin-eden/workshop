local parse = request('^.parse')
local parsers = request('parsers')

return
  function(stream)
    return parse(stream, parsers)
  end
