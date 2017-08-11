local compile = request('!.struc.compile')

return
  function(struc, ...)
    local result = struc

    for i = 1, select('#', ...) do
      local struc_transformer = select(i, ...)
      if struc_transformer then
        result = struc_transformer(result)
      end
    end

    result = compile(result)

    return result
  end
