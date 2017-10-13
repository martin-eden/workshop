return
  {
    -- core
    allowed_params =
      {
        {name = 'f_in_name', type = 'string'},
        {name = 'f_out_name', type = 'string'},
      },
    run = request('run'),
    -- may
    description = 'Do some file processing.',
    usage = '<f_in> <f_out>',
    -- implementation
    print_usage = request('print_usage'),
    parse_args = request('parse_args'),
    classify_item = request('classify_item'),
    get_key_name = request('get_key_name'),
    assert_type_is_correct = request('assert_type_is_correct'),
  }
