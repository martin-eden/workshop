--[[
  Get value of checkbox addressed by id.
]]

return
  function(app, checkbox_id)
    local checkbox = app:getById(checkbox_id)
    assert_table(checkbox)
    return checkbox.Selected
  end
