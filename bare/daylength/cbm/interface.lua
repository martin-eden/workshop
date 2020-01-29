return
  new(
    request('^.interface'),
    {
      name = 'CBM model',
      run = request('run'),
    }
  )
