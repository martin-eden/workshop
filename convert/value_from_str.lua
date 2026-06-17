-- Try to convert string to Lua value

--[[
  Author: Martin Eden
  Last mod.: 2026-06-18
]]

--[[
  Input
    [s] str -- string
    [?t] Decoders -- list of decoder functions
      Function will receive string and
      must return ( true <val> ) in case of success.

      First success terminates trying of decoders.
]]

-- Imports:
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
    local Table = table_from_str(str)
    if not Table then return end

    return true, Table
  end

local DefaultDecoders =
  {
    decode_nil,
    decode_bool,
    decode_number,
    decode_string,
    decode_table,
  }

local value_from_str =
  function(str, ArgDecoders)
    if not is_string(str) then return end

    local Decoders = new(DefaultDecoders)
    if is_table(ArgDecoders) then
      patch(Decoders, ArgDecoders)
    end

    for _, decoder in ipairs(Decoders) do
      local is_ok, as_val = decoder(str)
      if is_ok then return as_val end
    end
  end

-- Export:
return value_from_str

--[[
  2026-06-17
  2026-06-18
]]
