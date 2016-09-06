--[[
  Dumps table values to lua code which may be executed to
  recreate table. Not all value types supported.

  Not suitable for dumping tables where
    key has type "table", "userdata", "function" or "thread" or
    value has type "userdata", "function", "thread".

  Cross-linked tables are supported.
]]
local chunk_name = 'lua'

local indent_chunk = '  '

local looks_like_name = request('^.^.^.verify.lua_identifier')
assert_function(looks_like_name)
local quote = request('^.^.^.string.quote')
assert_function(quote)

local lua_table_printer =
  function(visit_type, node_value, node_key, node_value_status, depth, result_data)
    local result
    local indent = indent_chunk:rep(depth)
    local next_indent = indent_chunk:rep(depth + 1)
    local key_str
    local value_str
    if (visit_type == 'finish') then
      result_data[1] = 'local ' .. result_data.table_name .. result_data[1]
      result_data[#result_data + 1] = 'return ' .. result_data.table_name
      result = table.concat(result_data, '\n')
      return result
    elseif (visit_type == 'start') then
      if looks_like_name(node_key) then
        result_data.table_name = node_key
      else
        result_data.table_name = 'result'
      end
    elseif (visit_type == 'entered') then
      -- Table header generated in "finish" handler, so we doesn't fill
      -- key name in root table
      if (depth == 0) then
        key_str = ''
      else
        if is_table(node_key) then
          --[[
            dfs-pass() ignores keys while passing, so we have no chance to
            implement dumper as a node visit handler. For sure I can implement
            key passing in DFS but see no natural sense in this. Logic
            will become obscure and code complex.

            Full-geared table dumper should be implemented standalone.
            It will be done when I feel real need for this.

            And now for key I just print a string like "table: 0x1f46d00"
            instead of table definition.
          ]]
          key_str = ('[%q]'):format(tostring(node_key))
        else
          if is_string(node_key) then
            if looks_like_name(node_key) then
              key_str = node_key
            else
              key_str = ('[%s]'):format(quote(node_key))
            end
          elseif is_number(node_key) then
            key_str = ('[%s]'):format(node_key)
          else
            key_str = ('[%s]'):format(node_key)
          end
        end
      end

      if is_table(node_value) then
        if (node_value_status == 'processed') then
          --crosslink
          value_str = 'nil, --crosslink, defined later'
          result_data.has_crosslinks = true
        elseif (node_value_status == 'processing') then
          --uplink
          value_str = 'nil, --uplink, defined later'
          result_data.has_crosslinks = true
        else
          -- value_str = '\n' .. next_indent .. '{'
          value_str = '{'
        end
      else
        if is_string(node_value) then
          value_str = ('%s,'):format(quote(node_value))
        elseif is_number(node_value) then
          value_str = ('%s,'):format(node_value)
        else
          value_str = tostring(node_value) .. ','
        end

      end
      result = indent .. key_str .. ' = ' .. value_str
    elseif (visit_type == 'left') then
      if is_table(node_value) then
        if is_nil(node_value_status) then
          value_str = next_indent .. '}'
          -- value_str = indent .. '}'
          if (depth > 0) then
            value_str = value_str .. ','
          end
        end
      end
      result = value_str
    end

    if result then
      result_data[#result_data + 1] = result
    end
  end

tribute(chunk_name, lua_table_printer)
