return
  {
    points = {},
    init = request('init'),
    process_measurement = request('process_measurement'),
    --
    max_num_points = 100,
    get_num_points = request('get_num_points'),
    squeeze = request('squeeze'),
    get_deletion_idx = request('get_deletion_idx'),
  }
