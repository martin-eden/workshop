local saver_class = request('^.compile.tsv')

return
  function(t)
    local saver = new(saver_class)
    saver:init(t)
    return saver:serialize()
  end
