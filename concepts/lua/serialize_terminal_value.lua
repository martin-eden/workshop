-- Convert serializable non-table value to string

--[[
  Author: Martin Eden
  Last mod.: 2026-06-20
]]

-- Imports:
local is_nan = request('!.number.is_nan')
local is_pos_inf = request('!.number.is_pos_inf')
local is_neg_inf = request('!.number.is_neg_inf')
local lua_quote_str = request('!.concepts.lua.quote_string')

local encode_bool =
  function(val)
    if (val == false) then return 'false' end
    if (val == true) then return 'true' end
  end

local encode_number =
  function(val)
    if is_nan(val) then return '0/0' end
    if is_pos_inf(val) then return '1/0' end
    if is_neg_inf(val) then return '-1/0' end

    return _G.tostring(val)
  end

local encode_string =
  function(val)
    return lua_quote_str(val)
  end

local serialize_terminal_value =
  function(val)
    if is_nil(val) then
      return 'nil'
    elseif is_boolean(val) then
      return encode_bool(val)
    elseif is_number(val) then
      return encode_number(val)
    elseif is_string(val) then
      return encode_string(val)
    end
  end

-- Export:
return serialize_terminal_value

--[[
  2026-06-20
]]
