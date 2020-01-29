return
  new(
    request('^.interface'),
    {
      name = 'Forest-BGC model',
      run = request('run'),
    }
  )
