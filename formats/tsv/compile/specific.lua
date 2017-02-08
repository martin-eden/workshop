-- .tsv serialization manager

return
  {
    data = nil,
    field_separator = '\t',
    record_separator = '\n',
    do_fix = true,
    do_check = true,
    init = request('specific.init'),
    fix = request('specific.fix'),
    check = request('specific.check'),
    serialize = request('specific.serialize'),
  }
