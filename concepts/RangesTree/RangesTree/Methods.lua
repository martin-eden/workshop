-- Ranges Tree methods

--[[
  Author: Martin Eden
  Last mod.: 2026-05-03
]]

--[[
  Data structure

    Tree map of Range objects by name part
]]

-- Imports:
local split_string = request('!.string.split')
local create_range = request('^.Range.create')
local get_real_ranges = request('Freetown.get_real_ranges')

local names_delimiter = '.'

--[[
  Result structure

    List of names
    List of nodes
]]
local parse_name =
  function(Me, name)
    local NamePath = split_string(name, names_delimiter)

    local NodesPath = { }

    local Node = Me

    for idx, part_name in ipairs(NamePath) do
      Node = Node[part_name] or Node
      table.insert(NodesPath, Node)
    end

    return NamePath, NodesPath
  end

-- Export:
return
  {
    AddName =
      function(Me, name)
        local Names, Nodes = parse_name(Me, name)

        local LeafNode = Nodes[#Nodes]
        local leaf_name = Names[#Names]

        assert_nil(LeafNode[leaf_name])

        LeafNode[leaf_name] = { }
      end,
    AddRange =
      function(Me, name, Range)
        local Names, Nodes = parse_name(Me, name)

        local LeafNode = Nodes[#Nodes]

        table.insert(LeafNode, Range)
      end,
    GetRanges =
      function(Me, name)
        local Names, Nodes = parse_name(Me, name)

        local LeafNode = Nodes[#Nodes]

        --[[
          Requested ranges to read are same as node.
          Squeeze them to one read request.
        --]]
        local RangesToRead
        local total_length = 0
        for idx, Rec in ipairs(LeafNode) do
          total_length = total_length + Rec:GetLength()
        end
        RangesToRead = { create_range(1, total_length) }

        return get_real_ranges(RangesToRead, Nodes)
      end,
    --
    AddNameAndRange =
      function(Me, name, Range)
        Me:AddName(name)
        Me:AddRange(name, Range)
      end,
    AddRanges =
      function(Me, name, Ranges)
        for i = 1, #Ranges do
          Me:AddRange(name, Ranges[i])
        end
      end,
    AddNameAndRanges =
      function(Me, name, Ranges)
        Me:AddName(name)
        Me:AddRanges(name, Ranges)
      end,
  }

--[[
  2026-04-30
  2026-05-01
  2026-05-02
  2026-05-03
]]
