--[[
  Select element from group of two.

  Decision is based on boolean value.
]]

local set_radiomark = request('set_radiomark')

return
  function(app, false_id, true_id, is_true)
    local elem_id
    assert_boolean(is_true)
    if is_true then
      elem_id = true_id
    else
      elem_id = false_id
    end
    set_radiomark(app, elem_id)
  end
