local text_block

local add =
  function(s)
    text_block:add_curline(s)
  end

local request_clean_line =
  function()
    text_block:request_clean_line()
  end

local inc_indent =
  function()
    text_block:inc_indent()
  end

local dec_indent =
  function()
    text_block:dec_indent()
  end

local node_handlers = {}

local raw_compile = request('!.mechs.compile')

local compile =
  function(t)
    add(raw_compile(t, node_handlers))
  end

local is_identifier = request('!.formats.lua.load.is_identifier')
local compact_sequences = true

node_handlers.table =
  function(node)
    if (#node == 0) then
      add('{}')
      return
    end
    local last_integer_key = 0
    add('{')
    inc_indent()
    for i = 1, #node do
      local key, value = node[i].key, node[i].value
      request_clean_line()
      -- skip key part?
      if
        compact_sequences and
        (key.type == 'number') and
        is_integer(key.value) and
        (key.value == last_integer_key + 1)
      then
        last_integer_key = key.value
      else
        -- may mention key without brackets?
        if
          (key.type == 'string') and
          is_identifier(key.value)
        then
          add(key.value)
        else
          add('[')
          compile(key)
          add(']')
        end
        add(' = ')
      end
      compile(value)
      add(',')
    end
    dec_indent()
    request_clean_line()
    add('}')
  end

local quote_string = request('!.formats.lua.save.quote_string')

node_handlers.string =
  function(node)
    add(quote_string(node.value))
  end

local serialize_tostring =
  function(node)
    add(tostring(node.value))
  end

local tostring_datatypes =
  {'number', 'boolean', 'nil', 'function', 'thread', 'userdata'}

for i = 1, #tostring_datatypes do
  node_handlers[tostring_datatypes[i]] = serialize_tostring
end

node_handlers.name =
  function(node)
    compile(node.value)
  end

local merge = request('!.table.merge')

return
  function(a_node_handlers, a_text_block, options)
    node_handlers = merge(a_node_handlers, node_handlers)
    text_block = a_text_block
    if options and is_boolean(options.compact_sequences) then
      compact_sequences = options.compact_sequences
    end
  end
