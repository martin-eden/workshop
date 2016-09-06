--[[
  Straightforward implementation of printing lua table
  as lua table definition.

  Not suitable for tables with cross-links in keys or values.

  Trying to find the balance between simplicity and nice
  looking result.

  2016-04-22
--]]
local chunk_name = 'print_anytype_simple'

local quote_string = request('^.string.quote')
-- local quote_string = request('^.string.quote_noesc')

local is_identifier = request('^.verify.lua_identifier')

local printer =
  {
    ['nil'] =
      function(node)
        return 'nil'
      end,
    ['boolean'] =
      function(node)
        if (node == false) then
          return 'false'
        else
          return 'true'
        end
      end,
    ['number'] =
      function(node)
        return tostring(node)
      end,
    ['string'] =
      function(node)
        return quote_string(node)
      end,
    ['function'] =
      function(node)
        return quote_string(tostring(node))
      end,
    ['userdata'] =
      function(node)
        return quote_string(tostring(node))
      end,
    ['thread'] =
      function(node)
        return quote_string(tostring(node))
      end,
  }

local indent_chunk = '  '
printer.table =
  function(a_table, table_iterator, deep)
    local result = {}
    deep = deep or 1
    local indent = (indent_chunk):rep(deep)
    table.insert(result, '{')
    local table_iterator = table_iterator or pairs
    for k, v in table_iterator(a_table) do
      local line
      if is_identifier(k) then
        line =
          ('%s%s = %s,'):format(
            indent,
            k,
            printer[type(v)](v, table_iterator, deep + 1)
          )
      else
        line =
          ('%s[%s] = %s,'):format(
            indent,
            printer[type(k)](k, table_iterator, deep + 1),
            printer[type(v)](v, table_iterator, deep + 1)
          )
      end
      table.insert(result, line)
    end
    indent = (indent_chunk):rep(deep - 1)
    table.insert(result, ('%s}'):format(indent))
    result = table.concat(result, '\n')
    return result
  end

local simple_print =
  function(value, table_iterator)
    return printer[type(value)](value, table_iterator)
  end

tribute(chunk_name, simple_print)
