--[[
  Choose element of one-of group.
]]

return
  function(app, elem_id)
    local element = app:getById(elem_id)
    element:setValue('Selected', true)
  end
