local parser = request('^.^.mechs.parser')
local syntax = request('syntax')
local struc_to_lua = request('transform')

return
  function(dirtree_str)
    local result
    local parse_result, finish_pos, data_struc =
      parser.parse(syntax, dirtree_str)
    if parse_result then
      result = struc_to_lua(data_struc)
    end
    return result
  end
