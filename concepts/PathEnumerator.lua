-- Tree path to integer id of tree node. Graph export

--[[
  Author: Martin Eden
  Last mod.: 2026-10-18
]]

--[[
  Selling point of this module is export tree data to graph format.
]]

--[[
  Storage format

    1 [i] next free id
    2 [t] tree map with node names and ids
      <s> [t] node rec
        1 [i] id
        2 [t] list of children recs
    3 [s] name delimiter
]]

local str_split = request('!.string.split')
local add_to_list = request('!.concepts.list.add_item')

local add_path
do
  add_path =
    function(Me, path)
      local Path = str_split(path, Me[3])

      local Parent = Me[2]

      for node_idx, node_name in ipairs(Path) do
        local Node = Parent[node_name]

        if not Node then
          Node = { [1] = Me[1], [2] = { } }
          Me[1] = Me[1] + 1
          Parent[node_name] = Node
        end

        Parent = Node[2]
      end
    end
end

local path_to_id
do
  path_to_id =
    function(Me, path)
      local Path = str_split(path, Me[3])

      local Parent = Me[2]
      local Node
      for node_idx, node_name in ipairs(Path) do
        Node = Parent[node_name]
        if not Node then return end
        Parent = Node[2]
      end

      return Node[1]
    end
end

local get_graph
do
  --[[
    Output graph format

      1 [t] labels
        i [s] id to label
      2 [t] links
        i [t] node neighbors
          0+ [i] neighbor id
  ]]
  local ordered_pass = request('!.table.ordered_pass')
  get_graph =
    function(Me)
      local IdToLabel_Map = { }
      do
        local populate_labels
        populate_labels =
          function(node_name, Node)
            if not Node then return end
            IdToLabel_Map[Node[1]] = node_name

            for node_name, NodeRec in pairs(Node[2]) do
              populate_labels(node_name, NodeRec)
            end
          end

        for node_name, NodeRec in pairs(Me[2]) do
          populate_labels(node_name, NodeRec)
        end
      end

      local Links = { }
      do
        local populate_links
        populate_links =
          function(parent_id, Node)
            if not Node then return end
            if not Links[parent_id] then
              Links[parent_id] = { }
            end
            add_to_list(Links[parent_id], Node[1])

            for _, NodeRec in ordered_pass(Node[2]) do
              populate_links(Node[1], NodeRec)
            end
          end

        for _, BranchRec in ordered_pass(Me[2]) do
          local branch_root_id = BranchRec[1]
          for _, NodeRec in ordered_pass(BranchRec[2]) do
            populate_links(branch_root_id, NodeRec)
          end
        end
      end

      return { [1] = IdToLabel_Map, [2] = Links }
    end
end

local Interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function(name_delimiter)
      assert_string(name_delimiter)
      assert(name_delimiter ~= '')

      local Me = { [1] = 1, [2] = { }, [3] = name_delimiter }
      attach_methods(Me, Interface)

      return Me
    end
end

Interface =
  {
    create = create,
    AddPath = add_path,
    PathToId = path_to_id,
    GetGraph = get_graph,
  }

-- Export:
return Interface

--[[
  2026-10-18
]]
