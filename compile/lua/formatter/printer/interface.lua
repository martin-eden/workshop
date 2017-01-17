local text_block = request('^.^.^.^.string.text_block.interface')

return
  {
    next_line_indent = 0,
    text = new(text_block),
    line_indents = {},
    indent_chunk = '  ',
    indents_obj = nil,

    init = request('init'),

    add_text = request('add_text'),
    close_line = request('close_line'),
    request_clean_line = request('request_clean_line'),
    request_empty_line = request('request_empty_line'),

    inc_indent = request('inc_indent'),
    dec_indent = request('dec_indent'),
    update_indent = request('update_indent'),

    get_width = request('get_width'),
    get_height = request('get_height'),
    get_line = request('get_line'),
    get_text = request('get_text'),

    concat_printer = request('concat_printer'),
  }
