-- Tree path to integer id of tree node. Graph export

--[[
  Author: Martin Eden
  Last mod.: 2026-11-14
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

--[=[
  Selling point of this module is exporting tree data to graph format.

  Example

    local enum = path_enumerator.create('.')
    enum:add_path('home.docs.notes')
    enum:add_path('home.photos')
    local id = enum:path_to_id('home.docs.notes'))
    -- 3
    local id_to_label, links = enum:get_graph()
    --[[
      { [1] = 'home', [2] = 'docs', [3] = 'notes', [4] = 'photos' },
      { [1] = { 2, 4 }, [2] = { 3 } }
    ]]
]=]

local str_split = request('!.string.split')

local add_path =
  function(me, path_str)
    local path = str_split(path_str, me[3])
    local parent = me[2]

    for node_idx, node_name in ipairs(path) do
      local node = parent[node_name]
      if not node then
        node = { me[1], { } }
        me[1] = me[1] + 1
        parent[node_name] = node
      end
      parent = node[2]
    end
  end

local path_to_id =
  function(me, path_str)
    local path = str_split(path_str, me[3])
    local parent = me[2]
    local node

    for node_idx, node_name in ipairs(path) do
      node = parent[node_name]
      if not node then return end
      parent = node[2]
    end

    return node[1]
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
  local add_to_list = request('!.concepts.list.add_item')
  local ordered_pass = request('!.table.ordered_pass')
  get_graph =
    function(me)
      local id_to_label = { }
      do
        local populate_labels
        populate_labels =
          function(node_name, node)
            if not node then return end
            id_to_label[node[1]] = node_name
            for subnode_name, subnode in pairs(node[2]) do
              populate_labels(subnode_name, subnode)
            end
          end
        for node_name, node in pairs(me[2]) do
          populate_labels(node_name, node)
        end
      end

      local links = { }
      do
        local populate_links
        populate_links =
          function(parent_id, node)
            if not node then return end
            if not links[parent_id] then
              links[parent_id] = { }
            end
            local node_id = node[1]
            add_to_list(links[parent_id], node_id)
            for _, subnode in ordered_pass(node[2]) do
              populate_links(node_id, subnode)
            end
          end
        for _, branch in ordered_pass(me[2]) do
          local branch_root_id = branch[1]
          for _, node in ordered_pass(branch[2]) do
            populate_links(branch_root_id, node)
          end
        end
      end

      return { id_to_label, links }
    end
end

local interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function(name_delimiter)
      assert_string(name_delimiter)
      assert(name_delimiter ~= '')
      local me = { 1, { }, name_delimiter }
      attach_methods(me, interface)
      return me
    end
end

interface =
  {
    create = create,
    add_path = add_path,
    path_to_id = path_to_id,
    get_graph = get_graph,
  }

-- Export:
return interface

--[[
  2026 #
  2026-11-14
]]
