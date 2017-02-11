local prepare = request('prepare')
local verify = request('verify')

local compile = request('!.mechs.generic_saver')
local c_structor = request('generic_compiler.readable.interface')

local lua_to_struc =
  function(data)
    prepare(data)
    verify(data)
    local structor = new(c_structor)
    structor:init()
    return structor:get_struc(data)
  end

return
  function(data)
    return compile(data, lua_to_struc)
  end
