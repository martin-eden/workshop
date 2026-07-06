-- Graph serializer

--[[
  Author: Martin Eden
  Last mod.: 2026-07-06
]]

-- Imports:
local serialize_terminal_value = request('!.concepts.lua.serialize_terminal_value')
local is_identifier = request('!.concepts.lua.is_identifier')

local SerializeValue =
  function(Me, Node, Output)
    local node_type = Node[1]
    local node_value = Node[2]

    if (node_type == 'name') then
      Output:Write(node_value)
    elseif (node_type == 'table') then
      Me:SerializeTree(Node, Output)
    else
      local val_str = serialize_terminal_value(node_value)
      if is_nil(val_str) then
        val_str = serialize_terminal_value(_G.tostring(node_value))
      end
      Output:Write(val_str)
    end
  end

local SerializeTree =
  function(Me, TableAst, Output)
    local empty_table_str = Me.Config.empty_table_str
    local opening_table_str = Me.Config.opening_table_str
    local closing_table_str = Me.Config.closing_table_str
    local equal_str = Me.Config.equal_str
    local delimiter_str = Me.Config.delimiter_str

    local use_compact_sequences = Me.Config.use_compact_sequences
    local use_compact_indices = Me.Config.use_compact_indices
    local omit_tail_delimiter = Me.Config.omit_tail_delimiter

    local notify = Me.Config.notify

    local KeyVals = TableAst[2]

    if (#KeyVals == 0) then
      Output:Write(empty_table_str)

      return
    end

    notify('start_table', Output)
    Output:Write(opening_table_str)

    local last_integer_key = 0

    for index, KeyVal_Rec in ipairs(KeyVals) do
      local is_first_rec = (index == 1)
      if not is_first_rec then
        notify('items_delimiter', Output)
        Output:Write(delimiter_str)
      end

      notify('processing_item', Output)

      local Key = KeyVal_Rec[1]
      local Value = KeyVal_Rec[2]

      local key_type = Key[1]
      local key_value = Key[2]

      local brackets_not_required

      local skip_key_serialization =
        use_compact_sequences and
        (
          (key_type == 'number') and
          (key_value == last_integer_key + 1)
        )

      if skip_key_serialization then
        last_integer_key = key_value

        goto serialize_value
      end

      brackets_not_required =
        use_compact_indices and
        (
          (key_type == 'string') and
          is_identifier(key_value)
        )

      if brackets_not_required then
        Output:Write(key_value)
      else
        Output:Write('[')
        Me:SerializeValue(Key, Output)
        Output:Write(']')
      end

      Output:Write(equal_str)

      ::serialize_value::

      Me:SerializeValue(Value, Output)
    end

    if not omit_tail_delimiter then
      notify('items_delimiter', Output)
      Output:Write(delimiter_str)
    end

    notify('end_table', Output)
    Output:Write(closing_table_str)
  end

local SerializeGraph =
  function(Me, GraphAst, Output)
    local Output = Me.Config.Output

    local use_compact_indices = Me.Config.use_compact_indices
    local equal_str = Me.Config.equal_str

    for index, Rec in ipairs(GraphAst) do
      local rec_type = Rec[1]

      if (rec_type == 'local_definition') then
        local name = Rec[2]
        local Value = Rec[3]

        Output:Write('local')
        Output:Write(' ')
        Output:Write(name)
        Output:Write(equal_str)
        Me:SerializeValue(Value, Output)
        Output:Write('\n')
      elseif (rec_type == 'assignment') then
        local dest_name = Rec[2]
        local Key = Rec[3]
        local src_name = Rec[4]

        local key_type = Key[1]
        local key_value = Key[2]

        local brackets_not_required =
          use_compact_indices and
          (
            (key_type == 'string') and
            is_identifier(key_value)
          )

        Output:Write(dest_name)
        if brackets_not_required then
          Output:Write('.')
          Output:Write(key_value)
        else
          Output:Write('[')
          Me:SerializeValue(Key, Output)
          Output:Write(']')
        end
        Output:Write(equal_str)
        Output:Write(src_name)
        Output:Write('\n')
      elseif (rec_type == 'return_statement') then
        local Value = Rec[2]

        Output:Write('return')
        Output:Write(' ')
        Me:SerializeValue(Value, Output)
        Output:Write('\n')
      end
    end
  end

local Interface =
  {
    -- Main:
    SerializeGraph = SerializeGraph,

    -- Optional config:
    Config =
    {
      use_compact_indices = true,
      use_compact_sequences = true,
      omit_tail_delimiter = true,

      empty_table_str = '{}',
      opening_table_str = '{',
      closing_table_str = '}',
      delimiter_str = ',',
      equal_str = '=',

      notify = function(event_name, Output) end,
    },

    -- Internals:
    SerializeValue = SerializeValue,
    SerializeTree = SerializeTree,
  }

-- Export:
return Interface

--[[
  2026-06 # #
  2026-07-06
]]
