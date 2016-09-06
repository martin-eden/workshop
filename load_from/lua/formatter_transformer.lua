local struc_printers

local indent = 0

local get_indent =
  function()
    return ('  '):rep(indent)
  end

local has_debt = false

local string_adder = request('^.^.handy_mechs.string_adders').array

local emit =
  function(s)
    if has_debt then
      string_adder:add_term(get_indent())
      has_debt = false
    end
    string_adder:add_term(s)
  end

local is_word =
  function(s)
    return s:match('^[%a_][%w_]*$')
  end

local process_node =
  function(node)
    -- assert_table(node)
    if is_table(node) then
      local handler = struc_printers[node.name]
      if handler then
        handler(node)
      else
        emit('<' .. node.name .. '>')
      end
    end
  end

local inc_indent =
  function()
    indent = indent + 1
  end

local dec_indent =
  function()
    indent = indent - 1
  end

local emit_nl =
  function()
    emit('\n')
    has_debt = true
  end

local process_list =
  function(node, delimiter)
    for i = 1, (#node - 1) do
      process_node(node[i])
      if delimiter then
        emit(delimiter)
      end
    end
    if node[#node] then
      process_node(node[#node])
    end
  end

struc_printers =
  {
    execute_assign =
      function(node)
        local destination = node[1]
        local source = node[2]
        process_node(destination)
        if source then
          emit(' = ')
          process_list(source)
        end
      end,
    local_statement =
      function(node)
        emit('local ')
        local sub_statement = node[1]
        process_node(sub_statement)
      end,
    local_assignment =
      function(node)
        local destination = node[1]
        local source = node[2]
        process_node(destination)
        if source then
          emit(' = ')
          process_node(source)
        end
      end,
    name_list =
      function(node)
        process_list(node, ', ')
      end,
    dot_name =
      function(node)
        emit('.')
        process_list(node)
      end,
    colon_name =
      function(node)
        emit(':')
        process_list(node)
      end,
    name =
      function(node)
        emit(node.value)
      end,
    var_list =
      function(node)
        process_list(node, ', ')
      end,
    var_link =
      function(node)
        process_list(node)
      end,
    func_args =
      function(node)
        emit('(')
        process_list(node, ', ')
        emit(')')
      end,
    bracket_expr =
      function(node)
        emit('[')
        process_list(node)
        emit(']')
      end,
    expr_list =
      function(node)
        process_list(node, ', ')
      end,
    expression =
      function(node)
        process_list(node)
      end,
    par_expr =
      function(node)
        emit('(')
        process_list(node)
        emit(')')
      end,
    statements =
      function(node)
        for i = 1, (#node - 1) do
          process_node(node[i])
          emit_nl()
        end
        process_node(node[#node])
      end,
    return_statement =
      function(node)
        emit('return ')
        process_list(node)
      end,
    break_statement =
      function(node)
        emit('break')
      end,
    label_statement =
      function(node)
        emit('::')
        process_node(node[1])
        emit('::')
      end,
    goto_statement =
      function(node)
        emit('goto ')
        process_node(node[1])
      end,
    do_block =
      function(node)
        emit('do')
        local statements = node[1]
        if statements then
          inc_indent()
          emit_nl()
          process_node(statements)
          dec_indent()
        end
        emit_nl()
        emit('end')
      end,
    if_block =
      function(node)
        process_list(node)
        emit_nl()
        emit('end')
      end,
    if_part =
      function(node)
        emit('if ')
        local expression = node[1]
        process_node(expression)
        emit(' then')
        local statements = node[2]
        if statements then
          inc_indent()
          emit_nl()
          process_node(statements)
          dec_indent()
        end
      end,
    elseif_part =
      function(node)
        emit_nl()
        emit('elseif ')
        local expression = node[1]
        process_node(expression)
        emit(' then')
        local statements = node[2]
        if statements then
          inc_indent()
          emit_nl()
          process_node(statements)
          dec_indent()
        end
      end,
    else_part =
      function(node)
        emit_nl()
        emit('else')
        local statements = node[1]
        if statements then
          inc_indent()
          emit_nl()
          process_node(statements)
          dec_indent()
        end
      end,
    numeric_for_block =
      function(node)
        emit('for ')
        local name = node[1]
        process_node(name)
        emit(' = ')
        local start_idx = node[2]
        process_node(start_idx)
        emit(', ')
        local finish_idx = node[3]
        process_node(finish_idx)
        local statements
        if (node[4].name == 'expression') then
          local increment = node[4]
          emit(', ')
          process_node(increment)
          statements = node[5]
        else
          statements = node[4]
        end
        emit(' do')
        if statements then
          inc_indent()
          emit_nl()
          process_node(statements)
          dec_indent()
        end
        emit_nl()
        emit('end')
      end,
    generic_for_block =
      function(node)
        emit('for ')
        local names = node[1]
        process_node(names)
        emit(' in ')
        local exprs = node[2]
        process_node(exprs)
        emit(' do')
        local statements = node[3]
        if statements then
          inc_indent()
          emit_nl()
          process_node(statements)
          dec_indent()
        end
        emit_nl()
        emit('end')
      end,
    while_block =
      function(node)
        emit('while ')
        local expression = node[1]
        process_node(expression)
        emit(' do')
        local statements = node[2]
        if statements then
          inc_indent()
          emit_nl()
          process_node(statements)
          dec_indent()
        end
        emit_nl()
        emit('end')
      end,
    repeat_block =
      function(node)
        emit('repeat')
        local statements = node[1]
        if statements then
          inc_indent()
          emit_nl()
          process_node(statements)
          dec_indent()
        end
        emit_nl()
        emit('until ')
        local expression = node[2]
        process_node(expression)
      end,
    named_function =
      function(node)
        emit('function ')
        local dot_list = node[1]
        local colon_name
        if node[2] and (node[2].name == 'colon_name') then
          colon_name = node[2]
        end
        local params
        if colon_name then
          params = node[3]
        else
          params = node[2]
        end
        local body = node[#node]

        process_list(dot_list, '.')
        if colon_name then
          emit(':')
          process_node(colon_name)
        end
        process_node(params)
        process_node(body)
      end,
    type_function =
      function(node)
        emit('function')
        process_list(node)
      end,
    function_params =
      function(node)
        local params_list = node[1]
        emit('(')
        process_node(params_list)
        emit(')')
        emit_nl()
      end,
    function_body =
      function(node)
        inc_indent()
        process_list(node)
        dec_indent()
        emit_nl()
        emit('end')
      end,
    vararg =
      function(node)
        emit('...')
      end,
    un_op =
      function(node)
        if is_word(node.value) then
          emit(node.value .. ' ')
        else
          emit(node.value)
          --beware that two "-" "-" forms "--" if printed consequently
        end
      end,
    bin_op =
      function(node)
        emit(' ' .. node.value .. ' ')
      end,
    ['nil'] =
      function(node)
        emit('nil')
      end,
    boolean =
      function(node)
        emit(node.value)
      end,
    number =
      function(node)
        emit(node.value)
      end,
    string =
      function(node)
        emit(node.value)
      end,
    table =
      function(node)
        emit('{')
        if (#node > 0) then
          inc_indent()
          emit_nl()
          for i = 1, #node do
            process_node(node[i])
            emit(',')
            emit_nl()
          end
          dec_indent()
        end
        emit('}')
      end,
    key_val =
      function(node)
        local key = node[1]
        local value = node[2]
        process_node(key)
        if value then
          emit(' = ')
          process_node(value)
        end
      end,
    table_key =
      function(node)
        process_node(node[1])
      end,
    table_value =
      function(node)
        process_node(node[1])
      end,
  }

local struc_to_lua =
  function(data_struc)
    assert_table(data_struc)
    string_adder:init()
    for i = 1, #data_struc do
      process_node(data_struc[i])
    end
    return string_adder:get_result()
  end

return struc_to_lua
