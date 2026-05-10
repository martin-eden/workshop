-- Get numeric value of input box addressed by id

--[[
  Author: Martin Eden
  Last mod.: 2026-05-10
]]

--[[
  In case of non-numeric text returns zero
]]

-- Imports:
local get_input_text = request('get_input_text')

local get_input_number =
  function(app, input_box_id)
    return tonumber(get_input_text(app, input_box_id)) or 0
  end

-- Export:
return get_input_number

--[[
  2020
  2026-05-10
]]
