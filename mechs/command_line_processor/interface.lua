-- Command-line argument parser

--[[
  Author: Martin Eden
  Last mod.: 2026-11-15
]]

--[[
  Process sequence with command-line arguments.
  Return map of parameter values.

  Input

    [t] -- list of records
      type [s] -- one of ( key_int key_str flag string )
      name [s] -- parameter name for map
]]

--[[
  Parse string (command-line argument)

  Returns
    1 [s] -- type
    2 [s] -- key
    3 [b/i/s] -- value

  For "key_int" types converts value to integer.
  If parsing failed returns ( "string" nil item ).
]]
local parse_item
do
  -- --~keep-comments
  local flag_pattern = '^%-%-(~?)([%w%-]+)$'
  -- --right-margin=40
  local key_int_pattern = '^%-%-([%w%-]+)=(%d+)$'
  -- --indent-chunk=..
  local key_str_pattern = '^%-%-([%w%-]+)=(.*)$'
  local str_match = string.match
  parse_item =
    function(item)
      do
        local flag_negate, flag_name = str_match(item, flag_pattern)
        if flag_name then
          return 'flag', flag_name, (flag_negate == '')
        end
      end
      do
        local int_name, int_value = str_match(item, key_int_pattern)
        if int_name then
          return 'key_int', int_name, tonumber(int_value)
        end
      end
      do
        local str_name, str_value = str_match(item, key_str_pattern)
        if str_name then
          return 'key_str', str_name, str_value
        end
      end
      return 'string', nil, item
    end
end

local parse_items
do
  local str_format = string.format
  local get_key_name =
    function(me, idx)
      local num_found = 0
      for _, param_rec in ipairs(me.allowed_params) do
        if (param_rec.type == 'string') then
          num_found = num_found + 1
          if (num_found == idx) then
            return param_rec.name
          end
        end
      end
      error(str_format('No description for string parameter #%d.', idx))
    end
  local assert_type_is_correct =
    function(me, name, item_type)
      for _, param_rec in ipairs(me.allowed_params) do
        if (param_rec.name == name) then
          if (param_rec.type ~= item_type) then
            error(
              str_format(
                'Actual type for parameter "%s" is "%s", not "%s".',
                name, item_type, param_rec.type
              )
            )
          end
          return
        end
      end
      error(str_format('No record for parameter "%s".', name))
    end
  parse_items =
    function(me, params)
      local result = { }
      local num_strings = 0
      for _, item in ipairs(params) do
        local type, key, value = parse_item(item)
        if not key then
          num_strings = num_strings + 1
          key = get_key_name(me, num_strings)
        end
        assert_type_is_correct(me, key, type)
        result[key] = { type = type, value = value }
      end
      return result
    end
end

local run =
  function(me, params)
    assert_table(params)
    local typed_params = parse_items(me, params)
    local result = { }
    for key, rec in pairs(typed_params) do
      result[key] = rec.value
    end
    return result
  end

return
  {
    allowed_params =
      {
        { name = 'f_in_name', type = 'string' },
        { name = 'f_out_name', type = 'string' },
      },
    run = run,
  }

--[[
  2018 # #
  2026-11-15
]]
