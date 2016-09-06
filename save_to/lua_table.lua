-- Serialize lua table as lua table definition.

-- Not suitable for tables with cross-links in keys or values.

local override_params = request('^.handy_mechs.override_params')

local default_params =
  {
    initial_deep = 0,
    serializer = request('lua_table.interface'),
  }

local serialize_manager =
  function(value, a_params)
    local params = override_params(default_params, a_params)
    local serializer = params.serializer
    serializer:init()
    serializer:serialize(value, params.initial_deep)
    return serializer.string_adder:get_result()
  end

return serialize_manager
