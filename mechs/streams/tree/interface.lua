return
  {
    init = request('init'),
    get_position = request('get_position'),
    set_position = request('set_position'),
    read = request('read'),
    match_string = request('match_string'),

    c_sequence = request('^.sequence.interface'),
    levels = nil,
    cur_level = nil,
    move_down = request('move_down'),
    move_up = request('move_up'),
    move_down_str = '(',
    move_up_str = ')',
  }
