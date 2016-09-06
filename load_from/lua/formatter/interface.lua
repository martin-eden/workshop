return
  {
    handlers =
      {
        expression = request('handlers.expression'),

        function_call = request('handlers.expressions.function_call'),
        name = request('handlers.expressions.name'),
        var_link = request('handlers.expressions.var_link'),
        vararg = request('handlers.expressions.vararg'),

        boolean = request('handlers.expressions.data_types.boolean'),
        ['nil'] = request('handlers.expressions.data_types.nil'),
        number = request('handlers.expressions.data_types.number'),
        string = request('handlers.expressions.data_types.string'),
        table = request('handlers.expressions.data_types.table'),
        type_function = request('handlers.expressions.data_types.type_function'),

        statements = request('handlers.statements'),

        assignment = request('handlers.statements.assignment'),
        break_statement = request('handlers.statements.break_statement'),
        goto_statement = request('handlers.statements.goto_statement'),
        label_statement = request('handlers.statements.label_statement'),
        local_assignment = request('handlers.statements.local_assignment'),
        return_statement = request('handlers.statements.return_statement'),

        do_block = request('handlers.statements.blocks.do_block'),
        generic_for_block = request('handlers.statements.blocks.generic_for_block'),
        if_block = request('handlers.statements.blocks.if_block'),
        local_named_function = request('handlers.statements.blocks.local_named_function'),
        named_function = request('handlers.statements.blocks.named_function'),
        numeric_for_block = request('handlers.statements.blocks.numeric_for_block'),
        repeat_block = request('handlers.statements.blocks.repeat_block'),
        while_block = request('handlers.statements.blocks.while_block'),

        bracket_expr = request('handlers.wrappers.bracket_expr'),
        colon_name = request('handlers.wrappers.colon_name'),
        dot_name = request('handlers.wrappers.dot_name'),
        dot_list = request('handlers.wrappers.dot_list'),
        expr_list = request('handlers.wrappers.expr_list'),
        func_args = request('handlers.wrappers.func_args'),
        function_params = request('handlers.wrappers.function_params'),
        name_list = request('handlers.wrappers.name_list'),
        name_parts = request('handlers.wrappers.name_parts'),
        par_expr = request('handlers.wrappers.par_expr'),
        ref_list = request('handlers.wrappers.ref_list'),
      },
    printer =
      {
        indent = 0,
        had_debt = false,
        string_adder = request('^.^.^.handy_mechs.string_adders').array,

        emit = request('printer.emit'),
        emit_nl = request('printer.emit_nl'),
        inc_indent = request('printer.inc_indent'),
        dec_indent = request('printer.dec_indent'),
        get_indent = request('printer.get_indent'),
      },
    init = request('init'),
    process_list = request('process_list'),
    process_node = request('process_node'),
  }
