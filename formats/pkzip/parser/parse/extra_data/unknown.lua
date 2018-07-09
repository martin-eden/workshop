--[[
  Handler for extra data of unknown type.

  Data signature is filled in caller, [parse.extra_data].
]]

return
  function(data)
    return {data = data}
  end
