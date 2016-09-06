local chunk_name = 'default_ordered_pass'

local ordered_pass = request('ordered_pass')
local comparator = request('comparators.general')

local inited_ordered_pass =
  function(t)
    return ordered_pass(t, comparator)
  end

tribute(chunk_name, inited_ordered_pass)
