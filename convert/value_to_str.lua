-- Serialize any Lua value to string with Lua code for that value

--[[
  Author: Martin Eden
  Last mod.: 2026-06-20
]]

--[[
  Only following types can be load back:

    nil, boolean, number, string, table

  Following types can't be load back:

    function, userdata, thread

    We still return tostring() of them to use in data discovery
    scenarios.
]]

--[[
  Implementation can be reused to serialize to other data languages
]]

--[[
  Input
    [∀] Value -- any Lua value
    [?t] Encoders -- map of type_name-function
      Function will receive value of given type and
      must return string in case of success.
]]

-- Imports:
local serialize_terminal_value = request('!.concepts.lua.serialize_terminal_value')
local table_to_str = request('table_to_str')

local represent_unserializable =
  function(val)
    return serialize_terminal_value(_G.tostring(val))
  end

local DefaultEncoders =
  {
    ['nil'] = serialize_terminal_value,
    ['boolean'] = serialize_terminal_value,
    ['number'] = serialize_terminal_value,
    ['string'] = serialize_terminal_value,
    ['table'] = table_to_str,
    ['function'] = represent_unserializable,
    ['userdata'] = represent_unserializable,
    ['thread'] = represent_unserializable,
  }

local value_to_str =
  function(Value, ArgEncoders)
    local Encoders = new(DefaultEncoders, ArgEncoders)

    local encoder = Encoders[type(Value)]

    if not encoder then
      error('No encoder for given type of value.')
    end

    return encoder(Value)
  end

-- Export:
return value_to_str

--[[
  2026-06-17
  2026-06-18
  2026-06-20
]]
