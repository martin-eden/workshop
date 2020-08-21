return
  {
    hash = nil,
    starting_hash = request('^.md5.starting_hash'),
    msg_map = request('msg_map'),
    salt = request('salt'),
    shifts = request('shifts'),
    funcs = request('funcs'),
    hash_operation = request('hash_operation'),
    process_block = request('process_block'),

    process_stream = request('^.md5.process_stream'),
    get_hash_seq = request('^.md5.get_hash_seq'),

    init = request('^.md5.init'),
    get_hash = request('^.md5.get_hash'),
    get_hash_str = request('^.md5.get_hash_str'),
  }
