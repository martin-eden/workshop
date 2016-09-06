-- JSON serializer manager

local override_params = request('^.handy_mechs.override_params')

local default_params =
  {
    do_prepare = true,
    do_verify = true,
    serializer = request('json.interface'),
  }

local serialize_outer =
  function(t, params)
    params = override_params(default_params, params)
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

return serialize_outer
