-- Get a list of paths to each value in tree

--[[
  Author: Martin Eden
  Last mod.: 2025-03-31
]]

-- Imports:
local IsTree = request('!.table.is_tree')

--[[
  Get a list of paths to each value in tree

  Example:

    Suppose you have matrix

      ( ( A B ) ( C A ) )

    You can represent it as

      { { 'A', 'B' }, { 'C', 'A' } }

    Now you want know what paths reach value "A":

      () ->
        {
          A = { { 1, 1 }, { 2, 2 } },
          B = { { 1, 2 } },
          C = { { 2, 1 } },
        }
]]

--[[
  Core function. Receives current node, path to that node and
  list of paths which is result.
]]
local ProcessNode
ProcessNode =
  function(Node, Path, Paths)
    if not is_table(Node) then
      if not Paths[Node] then
        Paths[Node] = {}
      end
      table.insert(Paths[Node], new(Path))

      return
    end

    for Key, Value in pairs(Node) do
      table.insert(Path, Key)
      ProcessNode(Value, Path, Paths)
      table.remove(Path)
    end
  end

--[[
  Root function. Checks that structure has no cycles and calls
  core function.
]]
local GetPaths =
  function(Tree)
    if not IsTree(Tree) then
      return
    end

    local Result = {}

    ProcessNode(Tree, {}, Result)

    return Result
  end

-- Exports:
return GetPaths

--[[
  2025-03-30
]]
