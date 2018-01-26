return
  {
    keep_comments = true,
    keep_unparsed_tail = true,

    data_struc = nil,
    run = request('run'),

    move_comments = request('move_comments'),
    remove_whitespaces = request('remove_whitespaces'),
    handlers = request('handlers.interface'),
    process_list = request('process_list'),
    process_node = request('process_node'),
  }
