local csv_parser_class = request('^.^.parse.csv.specific')

return
  function(csv_str, options)
    local csv_parser = new(csv_parser_class, options)
    csv_parser:init(csv_str)
    return csv_parser:parse()
  end
