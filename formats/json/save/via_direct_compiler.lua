-- JSON serializer's manager

local prepare = request('prepare')
local verify = request('verify')

local default_params =
  {
    do_prepare = true,
    do_verify = true,
    serializer = request('direct_compiler.interface'),
  }

return
  function(t, params)
    params = new(default_params, params)

    if params.do_prepare then
      prepare(t)
    end
    if params.do_verify then
      verify(t)
    end

    local serializer = params.serializer
    serializer:init()
    serializer:serialize(t)
    return serializer:get_result()
  end
