-- Serialize tree AST

--[[
  Author: Martin Eden
  Last mod.: 2026-08-22
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

    serialize_index =
      function(Settings, Index)
        local Output = Settings.Output
        local start_index = Settings.Syntels.start_index
        local end_index = Settings.Syntels.end_index
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

  local event_start_table
  local event_end_table
  local event_start_item
  local event_end_item
  do
    local NotificationEvents = request('NotificationEvents')
    event_start_table = NotificationEvents.start_table
    event_end_table = NotificationEvents.end_table
    event_start_item = NotificationEvents.start_item
    event_end_item = NotificationEvents.end_item
  end

  serialize_tree =
    function(Settings, TableAst)
      local Output = Settings.Output

      local empty_table
      local start_table
      local end_table
      local item_separator
      local assign
      do
        local Syntels = Settings.Syntels
        empty_table = Syntels.empty_table
        start_table = Syntels.start_table
        end_table = Syntels.end_table
        item_separator = Syntels.item_separator
        assign = Syntels.assign
      end

      local notify = Settings.notify
      local use_compact_sequences = Settings.use_compact_sequences
      local omit_tail_delimiter = Settings.omit_tail_delimiter
      local KeyVals = TableAst[2]

      if (#KeyVals == 0) then
        Output:Write(empty_table)

        return
      end

      notify(event_start_table, Output)
      Output:Write(start_table)

      local next_integer_key = 1

      for index, KeyVal_Rec in ipairs(KeyVals) do
        if (index ~= 1) then
          notify(event_end_item, Output)
          Output:Write(item_separator)
        end

        notify(event_start_item, Output)

        local Key = KeyVal_Rec[1]
        local Value = KeyVal_Rec[2]
        local key_type = Key[1]
        local key_value = Key[2]

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
      end

      if not omit_tail_delimiter then
        notify(event_end_item, Output)
        Output:Write(item_separator)
      end

      notify(event_end_table, Output)
      Output:Write(end_table)
    end
end

-- Export:
return serialize_value

--[[
  2026 # # # # # #
  2026-08-22
]]
