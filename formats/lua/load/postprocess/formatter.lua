--[[
  This is parsed lua text transformer. It reformulates structure
  produced by parser to something simpler for human to manage.

  And because parser by design cannot return back and say:
    Aha!

    I just parsed <call_assign> structure,
    it has just one term and no assign part.

    So I'll name it <function_call_statement>.

  Such work is done by this code.
]]

local transformer = request('formatter.interface')

return
  function(data_struc)
    assert_table(data_struc)
    return transformer:process_node(data_struc)
  end
