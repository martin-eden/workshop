local tsv_parser_class = request('^.parse.tsv.specific')

return
  function(tsv_str, options)
    local tsv_parser = new(tsv_parser_class, options)
    tsv_parser:init(tsv_str)
    return tsv_parser:parse()
  end
