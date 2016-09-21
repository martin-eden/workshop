local parser = request('^.parse.parser')
local syntax = request('^.parse.syntaxes.far_dir_list')
local struc_to_lua = request('^.parse.far_dir_list.struc_to_lua')

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
