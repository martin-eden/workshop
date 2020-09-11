--[[
  Get text of input box addressed by id.
]]

return
  function(app, input_box_id)
    local input_box = app:getById(input_box_id)
    assert_table(input_box)
    return input_box:getText()
  end
