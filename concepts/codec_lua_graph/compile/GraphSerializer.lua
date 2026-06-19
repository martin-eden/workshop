-- Graph serializer

--[[
  Author: Martin Eden
  Last mod.: 2026-06-20
]]

-- Imports:
local serialize_terminal_value = request('!.concepts.lua.serialize_terminal_value')
local is_identifier = request('!.concepts.lua.is_identifier')

local SerializeValue =
  function(Me, Node, Output)
    if (Node.type ~= 'table') then
      if (Node.type == 'name') then
        Output:Write(Node.value)
      else
        local val_str = serialize_terminal_value(Node.value)
        if is_nil(val_str) then
          val_str = serialize_terminal_value(_G.tostring(Node.value))
        end
        Output:Write(val_str)
      end
    else
      Me:SerializeTree(Node, Output)
    end
  end

local SerializeTree =
  function(Me, TreeAst, Output)
    local empty_table_str = Me.Config.empty_table_str
    local opening_table_str = Me.Config.opening_table_str
    local closing_table_str = Me.Config.closing_table_str
    local equal_str = Me.Config.equal_str
    local delimiter_str = Me.Config.delimiter_str

    local use_compact_sequences = Me.Config.use_compact_sequences
    local use_compact_indices = Me.Config.use_compact_indices
    local omit_tail_delimiter = Me.Config.omit_tail_delimiter

    local notify = Me.Config.notify

    if (#TreeAst == 0) then
      Output:Write(empty_table_str)

      return
    end

    notify('start_table', Output)
    Output:Write(opening_table_str)

    local last_integer_key = 0

    for index, Rec in ipairs(TreeAst) do
      local is_first_rec = (index == 1)
      if not is_first_rec then
        notify('items_delimiter', Output)
        Output:Write(delimiter_str)
      end

      notify('processing_item', Output)

      local Key = Rec.Key
      local Value = Rec.Value
      local brackets_are_required

      local skip_key_serialization =
        (Key.type == 'number') and (Key.value == last_integer_key + 1) and
        use_compact_sequences

      if skip_key_serialization then
        last_integer_key = Key.value

        goto serialize_value
      end

      brackets_are_required =
        not ((Key.type == 'string') and is_identifier(Key.value)) or
        not use_compact_indices

      if brackets_are_required then
        Output:Write('[')
      end

      if brackets_are_required then
        Me:SerializeValue(Key, Output)
      else
        Output:Write(Key.value)
      end

      if brackets_are_required then
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
      local rec_type = Rec.type
      if (rec_type == 'local_definition') then
        local name = Rec.name
        local Value = Rec.Value

        Output:Write('local')
        Output:Write(' ')
        Output:Write(name)
        Output:Write(equal_str)
        Me:SerializeValue(Value, Output)
        Output:Write('\n')
      elseif (rec_type == 'assignment') then
        local dest_name = Rec.dest_name
        local Index = Rec.IndexValue
        local src_name = Rec.src_name

        Output:Write(dest_name)

        local brackets_not_required =
          use_compact_indices and
          (Index.type == 'string') and
          is_identifier(Index.value)

        if brackets_not_required then
          Output:Write('.')
          Output:Write(Index.value)
        else
          Output:Write('[')
          Me:SerializeValue(Index, Output)
          Output:Write(']')
        end

        Output:Write(equal_str)
        Output:Write(src_name)
        Output:Write('\n')
      elseif (rec_type == 'return_statement') then
        local Value = Rec.Value

        Output:Write('return')
        Output:Write(' ')
        Me:SerializeValue(Value, Output)
        Output:Write('\n')
      else
        error('Unknown record type ( ' .. rec_type .. ' )')
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
  2026-06-19
  2026-06-20
]]
