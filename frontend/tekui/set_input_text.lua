--[[
  Change text of input box addressed by id.
]]

return
  function(app, input_box_id, text)
    text = tostring(text)
    local input_box = app:getById(input_box_id)
    assert_table(input_box)
    input_box:onEnter()
    input_box:setValue('Text', text)
  end
