-- Tree serializer

--[[
  Author: Martin Eden
  Last mod.: 2026-08-15
]]

-- Imports:
local serialize_terminal_value = request('!.concepts.lua.serialize_terminal_value')
local is_identifier = request('!.concepts.lua.is_identifier')

local SerializeValue =
  function(Me, Node)
    local Output = Me.Output
    local node_type = Node[1]
    local node_value = Node[2]

    if (node_type == 'name') then
      Output:Write(node_value)
    elseif (node_type == 'table') then
      Me:SerializeTree(Node)
    else
      local val_str = serialize_terminal_value(node_value)
      if is_nil(val_str) then
        val_str = serialize_terminal_value(_G.tostring(node_value))
      end
      Output:Write(val_str)
    end
  end

local SerializeTree =
  function(Me, TableAst)
    local Output = Me.Output
    local Writer = Me.Writer

    local use_compact_sequences = Me.use_compact_sequences
    local use_compact_indices = Me.use_compact_indices
    local omit_tail_delimiter = Me.omit_tail_delimiter

    local notify = Me.notify

    local KeyVals = TableAst[2]

    if (#KeyVals == 0) then
      Writer:EmptyTable()

      return
    end

    notify('start_table', Output)
    Writer:StartTable()

    local last_integer_key = 0

    for index, KeyVal_Rec in ipairs(KeyVals) do
      local is_first_rec = (index == 1)
      if not is_first_rec then
        notify('items_delimiter', Output)
        Writer:SeparateItem()
      end

      notify('processing_item', Output)

      local Key = KeyVal_Rec[1]
      local Value = KeyVal_Rec[2]

      local key_type = Key[1]
      local key_value = Key[2]

      local brackets_not_required

      local skip_key_serialization =
        use_compact_sequences and
        ((key_type == 'number') and (key_value == last_integer_key + 1))

      if skip_key_serialization then
        last_integer_key = key_value

        goto serialize_value
      end

      brackets_not_required =
        use_compact_indices and
        ((key_type == 'string') and is_identifier(key_value))

      if brackets_not_required then
        Output:Write(key_value)
      else
        Writer:StartIndex()
        Me:SerializeValue(Key)
        Writer:EndIndex()
      end

      Writer:Assign()

      ::serialize_value::

      Me:SerializeValue(Value)
    end

    if not omit_tail_delimiter then
      notify('items_delimiter', Output)
      Writer:SeparateItem()
    end

    notify('end_table', Output)
    Writer:EndTable()
  end

local Interface =
  {
    -- Main:
    SerializeTree = SerializeTree,

    -- Internals:
    SerializeValue = SerializeValue,
  }

-- Export:
return Interface

--[[
  2026 # # #
  2026-08-11
  2026-08-15
]]
