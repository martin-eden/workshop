-- "global <const> *" serialization

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

--[[
  "global <a> *" is parsed to

    {
      type = 'global_statement',
      {
        type = 'global_all',
        {
          type = 'attribute',
          {
            type = 'name',
            'a'
          },
        },
      },
    }

  "global *" is parsed to

    {
      type = 'global_statement',
      {
        type = 'global_all',
        value = '*',
      },
    }
]]

return
  function(me, node)
    if not node[1] then
      me[2]:add_to_curline('*')
      return true
    end
    if not me:process_node(node[1]) then return end
    me[2]:add_to_curline(' *')
    return true
  end

--[[
  2026-10-28
]]
