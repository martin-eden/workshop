-- JSON serializer manager

local default_params =
  {
    do_prepare = true,
    do_verify = true,
    serializer = request('save.interface'),
  }

return
  function(t, params)
    params = new(default_params, params)
    local serializer = params.serializer

    serializer:init()
    if params.do_prepare then
      t = serializer:prepare(t)
    end
    if params.do_verify then
      serializer:verify(t)
    end
    serializer:serialize(t)
    local result = serializer.string_adder:get_result()

    return result
  end
