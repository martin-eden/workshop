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

node_handlers.table =
  function(node)
    if (#node == 0) then
      add('{}')
      return
    end
    add('{')
    inc_indent()
    for i = 1, #node do
      local pair = node[i]
      request_clean_line()
      if
        pair.key.type and
        (pair.key.type == 'string') and
        is_identifier(pair.key.value)
      then
        add(pair.key.value)
      else
        add('[')
        compile(pair.key)
        add(']')
      end
      add(' = ')
      compile(pair.value)
      add(',')
      add(' ')
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
  function(a_node_handlers, a_text_block)
    text_block = a_text_block
    merge(a_node_handlers, node_handlers)
    node_handlers = a_node_handlers
  end
