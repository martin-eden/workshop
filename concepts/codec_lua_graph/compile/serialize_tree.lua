-- Tree serializer

--[[
  Author: Martin Eden
  Last mod.: 2026-08-20
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
    function(Settings, Ast)
      local Output = Settings.Output
      local type = Ast[1]
      local value = Ast[2]

      if (type == type_name) then
        Output:Write(value)
      elseif (type == type_table) then
        serialize_tree(Settings, Ast)
      else
        local val_str = serialize_terminal_value(value)
        if is_nil(val_str) then
          val_str = serialize_terminal_value(tostring(value))
        end
        Output:Write(val_str)
      end
    end
end

do
  local is_identifier = request('!.concepts.lua.is_identifier')

  serialize_tree =
    function(Settings, TableAst)
      local Output = Settings.Output
      local Write = Settings.Writer

      local use_compact_sequences = Settings.use_compact_sequences
      local use_compact_indices = Settings.use_compact_indices
      local omit_tail_delimiter = Settings.omit_tail_delimiter

      local notify = Settings.notify

      local KeyVals = TableAst[2]

      if (#KeyVals == 0) then
        Write:EmptyTable()

        return
      end

      notify('start_table', Output)
      Write:StartTable()

      local last_integer_key = 0

      for index, KeyVal_Rec in ipairs(KeyVals) do
        local is_first_rec = (index == 1)
        if not is_first_rec then
          notify('items_delimiter', Output)
          Write:SeparateItem()
        end

        notify('processing_item', Output)

        local Key = KeyVal_Rec[1]
        local Value = KeyVal_Rec[2]

        local key_type = Key[1]
        local key_value = Key[2]

        local brackets_not_required

        local skip_key_serialization =
          use_compact_sequences and
          ((key_type == type_number) and (key_value == last_integer_key + 1))

        if skip_key_serialization then
          last_integer_key = key_value

          goto serialize_value
        end

        brackets_not_required =
          use_compact_indices and
          ((key_type == type_string) and is_identifier(key_value))

        if brackets_not_required then
          Output:Write(key_value)
        else
          Write:StartIndex()
          serialize_value(Settings, Key)
          Write:EndIndex()
        end

        Write:Assign()

        ::serialize_value::

        serialize_value(Settings, Value)
      end

      if not omit_tail_delimiter then
        notify('items_delimiter', Output)
        Write:SeparateItem()
      end

      notify('end_table', Output)
      Write:EndTable()
    end
end

-- Export:
return serialize_value

--[[
  2026 # # # # # #
]]
