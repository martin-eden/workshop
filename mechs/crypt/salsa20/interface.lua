return
  {
    input = nil,
    key = nil,
    salt = nil,
    output = nil,
    inner_key = nil,
    inner_salt = nil,
    gen_block = request('gen_block'),
    print_block = request('print_block'),

    init = request('init'),
    run = request('run'),
  }
