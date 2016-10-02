-- CSV parser driver

return
  {
    field_sep_char = ',',
    dirty_data_allowed = false,
    lines_iterator = nil,
    init = request('specific.init'),
    get_next_rec = request('specific.get_next_rec'),
    parse_data = request('specific.parse_data'),
  }
