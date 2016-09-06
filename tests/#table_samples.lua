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

local subtable = {'subtable'}

local simple_linked_table =
  {
    subtable,
    subtable
  }

local simple_self_linked_table = {}
simple_self_linked_table._self = simple_self_linked_table

--need direct assignment
local lua_print_self_linked =
  {
  }
lua_print_self_linked.self = lua_print_self_linked

--need common table
local _lua_print_cross_linked_common = {}
local lua_print_cross_linked =
  {
    ref_1 = _lua_print_cross_linked_common,
    ref_2 = _lua_print_cross_linked_common,
  }

local _lua_print_test_1_common = {}
local lua_print_test_1 =
  {
    ref_1 = _lua_print_test_1_common,
    ref_2 = _lua_print_test_1_common,
  }
_lua_print_test_1_common.self = lua_print_test_1

local _lua_print_test_2_common = {}
local lua_print_test_2 =
  {
    ref_1 = {_lua_print_test_2_common},
    ref_2 = {_lua_print_test_2_common},
  }
_lua_print_test_2_common.self = lua_print_test_2

local _lua_print_test_3_common = {}
local lua_print_test_3 =
  {
    ref_1 = {_lua_print_test_3_common},
  }
lua_print_test_3.ref_2 = lua_print_test_3.ref_1
lua_print_test_3.ref_3 = lua_print_test_3.ref_2
_lua_print_test_3_common.self = lua_print_test_3

local lua_print_test_4_a = {}
local lua_print_test_4_b = {lua_print_test_4_a}
lua_print_test_4_a[1] = lua_print_test_4_b
local lua_print_test_4 = lua_print_test_4_a

local simple_folded_table =
  {
    a = 'abc',
    [2] = 2,
    ['nil'] = 0,
    t =
      {
        z = 'x',
        [1] = 1
      }
  }

local self_linked_table =
  {
    'Let\'s the party begin!',
    -- _self = self_linked_table,
    -- key_1 = {self_linked_table},
    -- key_2 = self_linked_table.key_1,
    -- [self_linked_table] = self_linked_table,
    -- [self_linked_table.key_2] = '!',
  }
self_linked_table._self = self_linked_table
self_linked_table.key_1 = {self_linked_table}
self_linked_table.key_2 = self_linked_table.key_1
self_linked_table[self_linked_table] = self_linked_table
self_linked_table[self_linked_table.key_1] = '!'
-- [[
--]]
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
    simple_linked_table = simple_linked_table,
    simple_self_linked_table = simple_self_linked_table,
    lua_print_self_linked = lua_print_self_linked,
    lua_print_cross_linked = lua_print_cross_linked,
    lua_print_test_1 = lua_print_test_1,
    lua_print_test_2 = lua_print_test_2,
    lua_print_test_3 = lua_print_test_3,
    lua_print_test_4 = lua_print_test_4,
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
