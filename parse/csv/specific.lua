local result = new(request('^.tsv.specific'))

result.fix_bad_data = false
result.field_sep_char = ','
result.get_next_rec = request('specific.get_next_rec')

return result
