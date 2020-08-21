return
  {
    init = request('init'),
    load = request('load'),

    lexer = request('^.lexer.interface'),
    eat_spaces = request('eat_spaces'),
    process_null = request('process_null'),
    process_boolean = request('process_boolean'),
    process_number = request('process_number'),
    process_string = request('process_string'),
    load_array = request('load_array'),
    load_object = request('load_object'),
    load_value = request('load_value'),
  }
