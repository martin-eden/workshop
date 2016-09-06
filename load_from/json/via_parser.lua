local syntax = request('^.^.parse.syntaxes.json')
local parser = request('^.^.parse.parser')
local struc_to_lua = request('^.^.parse.json.struc_to_lua')

local json_to_lua =
  function(json_str)
    local result
    local parse_result, finish_pos, data_struc = parser.parse(syntax, json_str)
    if parse_result then
      result = data_struc
      result = struc_to_lua(data_struc)
    end
    return result
  end

return json_to_lua
