require('#base')

local chunk_name = '#table_samples'

local create_table =
  function(keys_feed, values_feed)
    assert_table(keys_feed)
    assert_table(values_feed)
    local len = math.min(#keys_feed, #values_feed)
    local result = {}
    for i = 1, len do
      result[keys_feed[i]] = values_feed[i]
    end
  end

local string_values = {'a_string', ' ', '', '1', '"asd"', "'dsa'", [=["'%\[[]]]=], '\n\r'}
local numeric_values = {0, 1, -1, -0, 1e-10, 3.14e+20, math.huge, -math.huge}
local table_values =
  {
    {},
    {{}},
    {{{}}, {}, {{}, {}}}
  }

local simple_table =
  {
    key_1 = 'some key',
    key_2 = 12,
  }

local simple_folded_table =
  {
    a = 'abc',
    [2] = 2,
    t =
      {
        z = 'x',
        [1] = 1
      }
  }

local self_linked_table =
  {
    key_1 = 'value_1',
    key_2 = {},
  }
self_linked_table.key_3 = self_linked_table.key_2
self_linked_table.self = self_linked_table
self_linked_table[self_linked_table] = 'key is a selfref'

local multitype_table =
  {
    [0] = '[0]',
    ['0'] = [=[['0']]=],
    [0.0] = '[0.0]',
    [1] = '1',
    '',
    [3] = '3',
    [5] = '5',
    [{table_is_a_key = true}] = '[{table_is_a_key = true}]',
    [{{folded_table_is_a_key = true}}] = '[{{folded_table_is_a_key = true}}]',
    [function() end] = 'function() end',
    [function() end] = 'function() end',
  }

tribute(
  chunk_name,
  {
    simple_table = simple_table,
    simple_folded_table = simple_folded_table,
    self_linked_table = self_linked_table,
    string_values = string_values,
    numeric_values = numeric_values,
    multitype_table = multitype_table,
    make_table_self_linked =
      function(t)
        assert(is_table(t))
        t.self_link = t
      end,
    make_table_folded_self_linked =
      function(t)
        assert(is_table(t))
        t.fold = {self_link = t}
      end
  }
)
