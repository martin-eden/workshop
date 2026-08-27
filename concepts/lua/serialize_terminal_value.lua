-- Convert serializable non-table value to string

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
]]

local encode_bool =
  function(val)
    if (val == false) then return 'false' else return 'true' end
  end

local encode_number
do
  local is_nan = request('!.number.is_nan')
  local is_pos_inf = request('!.number.is_pos_inf')
  local is_neg_inf = request('!.number.is_neg_inf')

  encode_number =
    function(val)
      if is_nan(val) then
        return '0/0'
      elseif is_pos_inf(val) then
        return '1/0'
      elseif is_neg_inf(val) then
        return '-1/0'
      end

      return _G.tostring(val)
    end
end

local encode_string
do
  local lua_quote_str = request('!.concepts.lua.quote_string')
  encode_string =
    function(val)
      return lua_quote_str(val)
    end
end

-- Export:
return
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

--[[
  2026-06-20
]]
