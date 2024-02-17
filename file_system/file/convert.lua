--[[
  Action-call of [file_converter].
]]

local c_converter = request('!.mechs.file_converter.interface')

return
  function(params)
    local coverter = new(c_converter, params)
    coverter:run()
  end
