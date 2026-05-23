-- Convert table to flat list of values

--[[
  Author: Martin Eden
  Last mod.: 2026-05-23
]]

--[[
  Table may have folded tables.

    YES: t = { 'a', b = 'b', { c = 'a' } }
      => { 'a', 'b', 'a' }

  Table should not have cycles.

    NO: t = {} t.t = t

  Only values are processed. Not their keys.

    NO: t = { [{ 'a' }] = {} }
]]

-- Imports:
local ordered_pass = request('ordered_pass')
local add_to_list = request('!.concepts.list.add_item')

local fold_root =
  function(Node)
    local Result = { }

    local fold
    fold =
      function(Node)
        assert_table(Node)

        for _, SubNode in ordered_pass(Node) do
          if is_table(SubNode) then
            fold(SubNode)
          else
            add_to_list(Result, SubNode)
          end
        end
      end

    fold(Node, Result)

    return Result
  end

-- Exports:
return fold_root

--[[
  2024-10-20
  2026-05-23
]]
