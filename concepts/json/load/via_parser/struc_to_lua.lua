-- Convert data tree from parser to Lua structure

--[[
  Author: Martin Eden
  Last mod.: 2026-08-09
]]

--[=[
  Job of this code is convert input data from parser (tree)
  to Lua structure.

  JSON is similar to Lua, so JSON objects and arrays become
  Lua tables and other types are native to Lua too.

  Implementation caveat is input data tree.

  For JSON [[{ "list": ]] tree will start like

    {
      [1] = '{ ',
      [2] = {
        [1] = '"list"',
        type = 'string',
      },
      [3] = ': ',
    }

  So some data nodes are annotated in syntax (and we need them),
  some nodes are plain strings (we don't need them, they will
  be recreated by formatter).
]=]

local struc_to_lua
do
  local unquote_string = request('^.unquote_string')
  local to_array = request('!.mechs.array.from_table')

  -- Get next names node and return it and next unchecked index
  local get_next_node =
    function(data_struc, pos)
      while true do
        if is_nil(data_struc[pos]) then
          return
        end

        if is_string(data_struc[pos].type) then
          return data_struc[pos], pos + 1
        end

        pos = pos + 1
      end
    end

  struc_to_lua =
    function(data_struc)
      assert_table(data_struc)

      local struc_to_lua
      struc_to_lua =
        function(Node)
          assert_table(Node)

          local Result

          if (Node.type == 'object') then
            Result = { }

            local KeyNode
            local ValueNode
            local pos = 1

            while true do
              KeyNode, pos = get_next_node(Node, pos)
              ValueNode, pos = get_next_node(Node, pos)

              if not ValueNode then break end

              local key = struc_to_lua(KeyNode)
              local value = struc_to_lua(ValueNode)

              Result[key] = value
            end
          elseif (Node.type == 'array') then
            Result = { }

            local ValueNode
            local pos = 1
            local num_items = 0

            while true do
              ValueNode, pos = get_next_node(Node, pos)

              if not ValueNode then break end

              local value = struc_to_lua(ValueNode)

              num_items = num_items + 1
              Result[num_items] = value
            end
            to_array(Result, num_items)
          elseif (Node.type == 'string') then
            Result = unquote_string(Node[1])
          elseif (Node.type == 'number') then
            Result = tonumber(Node[1])
          elseif (Node.type == 'boolean') then
            local value = Node[1]
            if (value == 'true') then
              Result = true
            elseif (value == 'false') then
              Result = false
            end
          elseif (Node.type == 'null') then
            Result = nil
          else
            error()
          end

          return Result
        end

      return struc_to_lua(data_struc)
    end
end

-- Export:
return struc_to_lua

--[[
  2016
  2017
  2018
  2026-08-09
]]
