-- Serialize any Lua value to string with Lua code for that value

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
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
      must return ( true <str> ) in case of success.
]]

-- Imports:
local is_nan = request('!.number.is_nan')
local is_pos_inf = request('!.number.is_pos_inf')
local is_neg_inf = request('!.number.is_neg_inf')
local stock_value_to_str = _G.tostring
local lua_quote_str = request('!.concepts.lua.quote_string')
local table_to_str = request('table_to_str')

local encode_nil =
  function()
    return true, 'nil'
  end

local encode_bool =
  function(val)
    if (val == false) then return true, 'false' end
    if (val == true) then return true, 'true' end
  end

local encode_number =
  function(val)
    if is_nan(val) then return true, '0/0' end
    if is_pos_inf(val) then return true, '1/0' end
    if is_neg_inf(val) then return true, '-1/0' end

    return true, stock_value_to_str(val)
  end

local encode_string =
  function(val)
    return true, lua_quote_str(val)
  end

local encode_table =
  function(val)
    return true, table_to_str(val)
  end

local encode_function =
  function(val)
    return true, lua_quote_str(stock_value_to_str(val))
  end

local encode_userdata =
  function(val)
    return true, lua_quote_str(stock_value_to_str(val))
  end

local encode_thread =
  function(val)
    return true, lua_quote_str(stock_value_to_str(val))
  end

local DefaultEncoders =
  {
    ['nil'] = encode_nil,
    ['boolean'] = encode_bool,
    ['number'] = encode_number,
    ['string'] = encode_string,
    ['table'] = encode_table,
    ['function'] = encode_function,
    ['userdata'] = encode_userdata,
    ['thread'] = encode_thread,
  }

local value_to_str =
  function(Value, ArgEncoders)
    local Encoders = DefaultEncoders
    if is_table(ArgEncoders) then
      Encoders = new(Encoders, ArgEncoders)
    end

    local encoder = Encoders[type(Value)]

    -- No codec?
    if not encoder then return end

    local is_ok, as_str = encoder(Value)

    -- Encoder failed?
    if not is_ok then return end

    return as_str
  end

-- Export:
return value_to_str

--[[
  2026-06-17
  2026-06-18
]]
