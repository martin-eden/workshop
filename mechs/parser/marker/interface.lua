local merge = request('!.table.merge')

local result = new(request('^.matcher.interface'))
local original_init = result.init
return
  merge(
    result,
    {
      on_match = request('on_match'),
      init = request('init'),
      get_marks = request('get_marks'),

      original_init = original_init,
      marks = nil,
    }
  )
