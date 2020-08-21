local minimal_interface = request('^.minimal.interface')
local merge = request('!.table.merge')

local result =
  new(
    minimal_interface,
    {
      init = request('init'),
      handlers = request('handlers.interface'),
    }
  )

merge(
  result,
  {
    indent_chunk = '  ',
    indents_obj = request('!.mechs.indents_table'),
    indent = 0,
    dec_indent = request('dec_indent'),
    inc_indent = request('inc_indent'),
    get_indent_str = request('get_indent_str'),
  }
)

return result
