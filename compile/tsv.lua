-- .tsv serialization manager

return
  {
    data = nil,
    field_separator = '\t',
    record_separator = '\n',
    do_fix = true,
    do_check = true,
    init = request('tsv.init'),
    fix = request('tsv.fix'),
    check = request('tsv.check'),
    serialize = request('tsv.serialize'),
  }
