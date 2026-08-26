-- Serialize tree AST

--[[
  Author: Martin Eden
  Last mod.: 2026-08-28
]]

local type_name
local type_table
local type_number
local type_string
do
  local TypeNames = request('Ast.TypeNames')
  type_name = TypeNames.type_name
  type_table = TypeNames.type_table
  type_number = TypeNames.type_number
  type_string = TypeNames.type_string
end

local Syntels = request('Syntels')

local is_serializeable =
  function(val_type)
    return
      (val_type ~= 'function') and
      (val_type ~= 'thread') and
      (val_type ~= 'userdata')
  end

local serialize_value
local serialize_tree

do
  local serialize_terminal_value =
    request('!.concepts.lua.serialize_terminal_value')

  serialize_value =
    function(Settings, Node)
      local Output = Settings.Output
      local node_type = Node[1]
      local node_value = Node[2]

      if not is_serializeable(node_type) then return end

      if (node_type == type_name) then
        Output:Write(node_value)
      elseif (node_type == type_table) then
        serialize_tree(Settings, Node)
      else
        local val_str = serialize_terminal_value(node_value)
        if is_nil(val_str) then
          val_str = serialize_terminal_value(tostring(node_value))
        end
        Output:Write(val_str)
      end
    end
end

do
  local serialize_index
  do
    local is_identifier = request('!.concepts.lua.is_identifier')
    local start_index = Syntels.start_index
    local end_index = Syntels.end_index

    serialize_index =
      function(Settings, Index)
        local Output = Settings.Output
        local index_type = Index[1]
        local index_value = Index[2]
        local use_compact_indices = Settings.use_compact_indices

        local brackets_not_required =
          use_compact_indices and
          ((index_type == type_string) and is_identifier(index_value))

        if brackets_not_required then
          Output:Write(index_value)
        else
          Output:Write(start_index)
          serialize_value(Settings, Index)
          Output:Write(end_index)
        end
      end
  end

  local start_table = Syntels.start_table
  local end_table = Syntels.end_table
  local item_separator = Syntels.item_separator
  local assign = Syntels.assign

  serialize_tree =
    function(Settings, TableAst)
      local Output = Settings.Output

      local use_compact_sequences = Settings.use_compact_sequences
      local omit_tail_delimiter = Settings.omit_tail_delimiter
      local KeyVals = TableAst[2]

      Output:Write(start_table)

      local has_items = false

      do
        local wrote_something = false
        local next_integer_key = 1

        for index, KeyVal_Rec in ipairs(KeyVals) do
          local Key = KeyVal_Rec[1]
          local Value = KeyVal_Rec[2]
          local key_type = Key[1]
          local key_value = Key[2]
          local val_type = Value[1]

          if not
            (is_serializeable(key_type) and is_serializeable(val_type))
          then
            goto next
          end

          has_items = true

          if wrote_something then
            Output:Write(item_separator)
          end

          local skip_key_serialization =
            use_compact_sequences and
            ((key_type == type_number) and (key_value == next_integer_key))

          if skip_key_serialization then
            next_integer_key = key_value + 1
          else
            serialize_index(Settings, Key)
            Output:Write(assign)
          end

          serialize_value(Settings, Value)

          wrote_something = true

          :: next ::
        end
      end

      if has_items and not omit_tail_delimiter then
        Output:Write(item_separator)
      end

      Output:Write(end_table)
    end
end

-- Export:
return serialize_value

--[[
  2026 # # # # # #
  2026-08-22
  2026-08-28
]]
