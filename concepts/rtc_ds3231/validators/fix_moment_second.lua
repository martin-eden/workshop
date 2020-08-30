--[[
  Change second to some valid number.
]]

local generate_second = request('!.concepts.daytime.generate_second')

return
  function(data, report)
    data.moment.second = generate_second()
  end
