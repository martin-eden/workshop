local parser = request('^.parse.parser')

return
  function(str, syntax, ...)
    local result
    local parse_result, finish_pos, data_struc = parser.parse(syntax, str)
    if parse_result then
      result = data_struc
      for i = 1, select('#', ...) do
        local struc_transformer = select(i, ...)
        if struc_transformer then
          result = struc_transformer(result)
        end
      end
    end
    return result
  end
