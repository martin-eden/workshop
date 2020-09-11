--[[
  Set/clear checkbox addressed by id.
]]

return
  function(app, checkbox_id, value)
    if is_nil(value) then
      value = true
    end
    assert_boolean(value)
    local checkbox = app:getById(checkbox_id)
    assert_table(checkbox)
    checkbox:setValue('Selected', value)
  end
