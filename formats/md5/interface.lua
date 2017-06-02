return
  {
    hash = nil,
    starting_hash = request('starting_hash'),
    msg_map = request('msg_map'),
    salt = request('salt'),
    shifts = request('shifts'),
    funcs = request('funcs'),
    process_block = request('process_block'),

    process_stream = request('process_stream'),
    get_hash_seq = request('get_hash_seq'),

    init = request('init'),
    get_hash = request('get_hash'),
    get_hash_str = request('get_hash_str'),
  }
