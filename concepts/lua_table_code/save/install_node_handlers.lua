local text_block

local add =
  function(s)
    text_block:add_curline(s)
  end

local request_clean_line =
  function()
    text_block:request_clean_line()
  end

local node_handlers = {}
local raw_compile = request('!.struc.compile')

local compile =
  function(t)
    add(raw_compile(t, node_handlers))
  end

local handle_local_definition =
  function(node)
    request_clean_line()
    add('local ')
    compile(node.name)
    add(' = ')
    compile(node.value)
  end

local is_identifier = request('!.concepts.lua.is_identifier')

local handle_index =
  function(node)
    if
      (node.value.type == 'string') and
      is_identifier(node.value.value)
    then
      add('.')
      add(node.value.value)
    else
      add('[')
      compile(node.value)
      add(']')
    end
  end

local handle_assignment =
  function(node)
    request_clean_line()
    add(node.name)
    compile(node.index)
    add(' = ')
    compile(node.value)
  end

local handle_return_statement =
  function(node)
    request_clean_line()
    add('return ')
    compile(node.value)
  end

local merge = request('!.table.merge')

return
  function(a_node_handlers, a_text_block)
    node_handlers =
      merge(
        a_node_handlers,
        {
          local_definition = handle_local_definition,
          index = handle_index,
          assignment = handle_assignment,
          return_statement = handle_return_statement,
        }
      )
    text_block = a_text_block
  end
