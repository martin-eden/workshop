--[[
  Dumps table to lua code which recreates table.
]]
local chunk_name = 'table_to_lua_code'

local assembly_order = request('^.graph.assembly_order')

local default_table_iterator = request('^.table.ordered_pass')

local create_name_giver =
  function()
    local table_names = {}
    local last_table_number = 0

    local gen_new_name =
      function()
        last_table_number = last_table_number + 1
        local result = 't_' .. last_table_number
        return result
      end

    local get_table_name =
      function(t)
        table_names[t] = table_names[t] or gen_new_name()
        return table_names[t]
      end

    return
      {
        get_table_name = get_table_name,
      }
  end

local create_line_adder =
  function()
    local lines = {}

    local add_line =
      function(s)
        lines[#lines + 1] = tostring(s)
      end

    local get_result =
      function()
        local result
        result = table.concat(lines, '\n')
        return result
      end

    return
      {
        add_line = add_line,
        get_result = get_result,
      }
  end


local looks_like_name = request('^.^.^.verify.lua_identifier')
assert_function(looks_like_name)

local quote = request('^.^.^.string.quote')
assert_function(quote)

local typed_printers =
  {
    ['string'] =
      function(node)
        return quote(node)
      end,
    ['function'] =
      function(node)
        return quote('<' .. tostring(node) .. '>')
      end,
    ['userdata'] =
      function(node)
        return quote('<' .. tostring(node) .. '>')
      end,
    ['thread'] =
      function(node)
        return quote('<' .. tostring(node) .. '>')
      end,
  }

local get_str =
  function(node, node_recs)
    local result
    if node_recs[node] then
      result = node_recs[node].name
    else
      local printer = typed_printers[type(node)]
      if printer then
        result = printer(node)
      else
        result = tostring(node)
      end
    end
    return result
  end

local get_key_str =
  function(node, node_recs)
    local result
    if looks_like_name(node) then
      result = tostring(node)
    else
      result = '[' .. get_str(node, node_recs) .. ']'
    end
    return result
  end

local get_qualified_key =
  function(node, node_recs)
    local result
    if looks_like_name(node) then
      result = '.' .. tostring(node)
    else
      result = '[' .. get_str(node, node_recs) .. ']'
    end
    return result
  end

local print_lua_code =
  function(node, node_recs, table_iterator, line_adder)
    local node_rec = node_recs[node]

    line_adder.add_line('local ' .. node_rec.name .. ' = {')
    for key, value in table_iterator(node) do
      if
        (not node_recs[key] or node_recs[key].is_defined) and
        (not node_recs[value] or node_recs[value].is_defined)
      then
        line_adder.add_line(('  %s = %s,'):format(get_key_str(key, node_recs), get_str(value, node_recs)))
      end
    end
    line_adder.add_line('}')
    node_recs[node].is_defined = true

    if node_rec.refs then
      for parent, parent_keys in pairs(node_rec.refs) do
        if node_recs[parent].is_defined then
          for parent_key in pairs(parent_keys) do
            line_adder.add_line(
              ('%s%s = %s'):format(
                get_str(parent, node_recs),
                get_qualified_key(parent_key, node_recs),
                node_rec.name
              )
            )
          end
        end
      end
    end
  end

local table_to_lua_code =
  function(t, table_iterator)
    table_iterator = table_iterator or default_table_iterator
    local dfs_options =
      {
        also_visit_keys = true,
        table_iterator = table_iterator,
      }
    local node_recs, assembly_order = assembly_order(t, dfs_options)

    local name_giver = create_name_giver()
    for i = 1, #assembly_order do
      local node = assembly_order[i]
      local node_rec = node_recs[node]
      node_rec.name = name_giver.get_table_name(node)
    end
    node_recs[t].name = 'result'

    local line_adder = create_line_adder()
    for i = 1, #assembly_order do
      print_lua_code(assembly_order[i], node_recs, table_iterator, line_adder)
    end
    line_adder.add_line('return result')

    local result = line_adder.get_result()
    return result
  end

tribute(chunk_name, table_to_lua_code)
