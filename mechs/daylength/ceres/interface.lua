return
  new(
    request('^.interface'),
    {
      name = 'CERES-Wheat model',
      run = request('run'),
    }
  )
