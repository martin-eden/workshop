-- Ranges Tree methods

--[[
  Author: Martin Eden
  Last mod.: 2026-05-09
]]

--[[
  Data structure

    Ranges [t] - list of Range objects
    Children [t] - map of nodes by name
]]

-- Imports:
local attach_methods = request('!.table.attach_methods')
local split_string = request('!.string.split')
local add_to_list = request('!.concepts.list.add_item')
local get_real_ranges = request('Freetown.get_real_ranges')

local names_delimiter = '.'

-- Forward declaration
local create

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
      Node = Node.Children[part_name] or Node
      add_to_list(NodesPath, Node)
    end

    return NamePath, NodesPath
  end

local Interface
Interface =
  {
    AddName =
      function(Me, name)
        local Names, Nodes = parse_name(Me, name)

        local LeafNode = Nodes[#Nodes]
        local leaf_name = Names[#Names]

        assert_nil(LeafNode.Children[leaf_name])

        LeafNode.Children[leaf_name] = Interface.create()
      end,
    AddRange =
      function(Me, name, Range)
        local Names, Nodes = parse_name(Me, name)

        local LeafNode = Nodes[#Nodes]

        add_to_list(LeafNode.Ranges, Range)
      end,
    GetRanges =
      function(Me, name)
        local Names, Nodes = parse_name(Me, name)

        local LeafNode = Nodes[#Nodes]

        if (#LeafNode.Ranges == 0) then
          error('Node have no ranges')
        end

        --[[
          Requested ranges to read are same as node.
          Squeeze them to one read request.
        --]]
        local RangesToRead
        local total_length = 0
        for idx, Rec in ipairs(LeafNode.Ranges) do
          total_length = total_length + Rec:GetLength()
        end

        local LengthRange = LeafNode.Ranges[1].create(1, total_length)

        RangesToRead = { LengthRange }

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

    create =
      function()
        local Result = { Ranges = { }, Children = { } }

        attach_methods(Result, Interface)

        return Result
      end,
  }

-- Export:
return Interface

--[[
  2026-04-30
  2026-05-01
  2026-05-02
  2026-05-03
  2026-05-06
  2026-05-09
]]
