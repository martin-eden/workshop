-- Try to convert string to Lua value

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

--[[
  Input

    [s] -- string
    [?t] -- list of decoder functions
      Function will receive string and
      must return ( true <val> ) in case of success.

      First success terminates trying of decoders.
]]

local patch = request('!.table.patch')
local stock_num_from_str = _G.tonumber
local lua_unquote_str = request('!.concepts.lua.unquote_string')
local table_from_str = request('table_from_str')

local decode_nil =
  function(str)
    if not (str == 'nil') then return end
    return true, nil
  end

local decode_bool =
  function(str)
    if (str == 'true') then return true, true end
    if (str == 'false') then return true, false end
  end

local decode_number =
  function(str)
    if (str == '-nan') then return true, 0/0 end
    if (str == 'inf') then return 1/0 end
    if (str == '-inf') then return -1/0 end
    local num = stock_num_from_str(str)
    if num then return true, num end
  end

local decode_string =
  function(str)
    local str = lua_unquote_str(str)
    if not str then return end
    return true, str
  end

local decode_table =
  function(str)
    local table = table_from_str(str)
    if not table then return end
    return true, table
  end

local default_decoders =
  {
    decode_nil,
    decode_bool,
    decode_number,
    decode_string,
    decode_table,
  }

-- Export:
return
  function(str, arg_decoders)
    if not is_string(str) then return end

    local decoders = new(default_decoders)
    if is_table(arg_decoders) then
      patch(decoders, arg_decoders)
    end

    for _, decoder in ipairs(decoders) do
      local is_ok, as_val = decoder(str)
      if is_ok then return as_val end
    end
  end

--[[
  2026 # #
]]
