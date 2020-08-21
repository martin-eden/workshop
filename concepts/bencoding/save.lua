local compile = request('!.mechs.generic_saver')
local c_structor = request('save.generic_compiler.interface')

local lua_to_struc =
  function(data)
    local structor = new(c_structor)
    structor:init()
    return structor:get_struc(data)
  end

local prepare = request('save.prepare')

return
  function(data)
    prepare(data)
    return compile(data, lua_to_struc)
  end
