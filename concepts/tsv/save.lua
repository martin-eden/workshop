local saver_class = request('compile.specific')

return
  function(t)
    local saver = new(saver_class)
    saver:init(t)
    return saver:serialize()
  end
