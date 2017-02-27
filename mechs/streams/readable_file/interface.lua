local merge = request('!.table.merge')
local result = new(request('^.readable.interface'))
local original_init = result.init
return
  merge(
    result,
    {
      init = request('init'),
      raw_get_position = request('raw_get_position'),
      raw_set_position = request('raw_set_position'),
      raw_read = request('raw_read'),

      f = nil,
      original_init = original_init,
    }
  )
