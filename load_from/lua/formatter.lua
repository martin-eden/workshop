--[[
  This is lua code formatter.

  It receives adjusted parsed code and produces some text result
  of it.
]]

local formatter = request('formatter.interface')

local struc_to_lua =
  function(data_struc)
    assert_table(data_struc)
    formatter:init()
    formatter:process_node(data_struc)
    local result = formatter.printer.string_adder:get_result()
    return result
  end

return struc_to_lua
