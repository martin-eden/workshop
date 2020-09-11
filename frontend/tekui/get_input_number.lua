--[[
  Get numeric value of input box addressed by id.

  In case of non-numeric text returns nil.
]]

local get_input_text = request('get_input_text')

return
  function(app, input_box_id)
    return tonumber(get_input_text(app, input_box_id))
  end
