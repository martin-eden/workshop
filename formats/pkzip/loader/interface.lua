return
  {
    init = request('init'),
    in_stream = nil,
    run = request('run'),

    signatures = request('signatures'),
    locate_signature = request('locate_signature'),
    parse_files_list_link = request('parse.files_list_link'),
    parse_files_list_link_link = request('parse.files_list_link_link'),
    parse_files_list_link_64 = request('parse.files_list_link_64'),
    parse_file_header = request('parse.file_header'),
    parse_additional_data = request('parse.additional_data'),
    fill_zip64 = request('fill_zip64'),
    parse_ntfs_add_data = request('parse.ntfs_add_data'),
    parse_ntfs_mtimes = request('parse.ntfs_mtimes'),
    parse_zip64_add_data = request('parse.zip64_add_data'),
    parse_local_file_header = request('parse.local_file_header'),
    parse_post_file_rec = request('parse.post_file_rec'),
  }
