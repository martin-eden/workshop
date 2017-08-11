return
  {
    start_dir = '.',
    init = request('init'),
    get_files_list = request('get_files_list'),
    get_directories_list = request('get_directories_list'),

    remove_dir_prefix = request('remove_dir_prefix'),
    simplify_file_names = request('simplify_file_names'),
    align_start_dir = request('align_start_dir'),
    remove_start_dir = request('remove_start_dir'),
  }
