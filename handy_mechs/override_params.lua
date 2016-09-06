local clone = request('^.table.clone')
local patch = request('^.table.patch')

local override_params =
  function(default_params, a_params)
    assert_table(default_params)
    local result = clone(default_params)
    if is_table(a_params) then
      patch(result, a_params)
    end
    return result
  end

return override_params
