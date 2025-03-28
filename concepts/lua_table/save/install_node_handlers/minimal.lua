-- Minificating table serializer methods

-- Last mod.: 2024-11-11

local text_block

local add =
  function(s)
    text_block:add_curline(s)
  end

local node_handlers = {}

local raw_compile = request('!.struc.compile')

local compile =
  function(t)
    add(raw_compile(t, node_handlers))
  end

local is_identifier = request('!.concepts.lua.is_identifier')
local compact_sequences = true

node_handlers.table =
  function(node)
    if (#node == 0) then
      add('{}')
      return
    end
    local last_integer_key = 0
    add('{')
    for i = 1, #node do
      if (i > 1) then
        add(',')
      end
      local key, value = node[i].key, node[i].value
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
        add('=')
      end
      compile(value)
    end
    add('}')
  end

do
  local serialize_tostring =
    function(node)
      add(tostring(node.value))
    end

  node_handlers.boolean = serialize_tostring
  node_handlers['nil'] = serialize_tostring
end

--[[
  tostring() of 1/0, 2/0, ... yields unloadable "inf".
  (-1/0, -2/0, ...) -> "-inf". (0/0, -0/0, -0/-0.0, ...) -> "-nan".
  We can compare "inf" values (1/0 == 2/0 -> true) but
  can't compare "nan" values (0/0 == 0/0 -> false).
  For "inf" cases we emit loadable "1/0" or "-1/0".
]]
node_handlers.number =
  function(node)
    if (node.value == 1/0) then
      add('1/0')
    elseif (node.value == -1/0) then
      add('-1/0')
    else
      add(tostring(node.value))
    end
  end

do
  local quote = request('!.lua.string.quote')

  local serialize_quoted =
    function(node)
      local quoted_string = quote(tostring(node.value))
      -- Quite ugly handling indexing [[[s]]] case: convert to [ [[s]]]
      if not text_block:on_clean_line() then
        local text_line = text_block.line_with_text:get_line()
        if
          (text_line:sub(-1) == '[') and
          (quoted_string:sub(1, 1) == '[')
        then
          add(' ')
        end
      end
      add(quoted_string)
    end

  local quoted_datatypes = {'string', 'function', 'thread', 'userdata'}

  for i = 1, #quoted_datatypes do
    node_handlers[quoted_datatypes[i]] = serialize_quoted
  end
end

node_handlers.name =
  function(node)
    compile(node.value)
  end

local force_merge = request('!.table.merge_and_patch')

return
  function(a_node_handlers, a_text_block, options)
    node_handlers = force_merge(a_node_handlers, node_handlers)
    text_block = a_text_block
    if options and is_boolean(options.compact_sequences) then
      compact_sequences = options.compact_sequences
    end
  end

--[[
  2017-05
  2019-06
]]
