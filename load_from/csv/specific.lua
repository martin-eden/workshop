local csv_parser_class = request('^.^.parse.csv.specific')

return
  function(csv_str, options)
    local csv_parser = new(csv_parser_class, options)
    return csv_parser:parse_lines(csv_str)
  end
