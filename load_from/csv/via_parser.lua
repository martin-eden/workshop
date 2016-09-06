local syntax = request('^.^.parse.syntaxes.csv')
local parser = request('^.^.parse.parser')
local struc_to_lua = request('^.^.parse.csv.struc_to_lua')

local csv_to_lua =
  function(csv_str)
    local result
    local parse_result, finish_pos, data_struc = parser.parse(syntax, csv_str)
    if parse_result then
      result = struc_to_lua(data_struc)
    end
    return result
  end

return csv_to_lua
