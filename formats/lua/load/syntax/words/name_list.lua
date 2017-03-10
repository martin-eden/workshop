local handy = request('!.mechs.processor.handy')

local name = request('name')
local opt_spc = request('opt_spc')

return
  {
    name = 'name_list',
    handy.list({opt_spc, name}, {opt_spc, ','})
  }
