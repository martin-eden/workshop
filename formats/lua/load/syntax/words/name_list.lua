local handy = request('!.mechs.processor.handy')

local name = request('name')
local syntel = request('syntel')

return
  {
    name = 'name_list',
    handy.list(name, syntel(','))
  }
