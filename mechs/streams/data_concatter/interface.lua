return
  {
    init = request('init'),
    --
    add = request('add'),
    get_stream = request('get_stream'),
    --
    stream = new(request('!.mechs.streams.mergeable.string.interface')),
  }
