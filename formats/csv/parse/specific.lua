local csv_parser_class =
  new(
    request('^.^.tsv.parse.specific'),
    {
      field_sep_char = ',',
      get_next_rec = request('specific.get_next_rec'),
    }
  )

return
  function(csv_str, options)
    local csv_parser = new(csv_parser_class, options)
    csv_parser:init(csv_str)
    return csv_parser:parse()
  end
