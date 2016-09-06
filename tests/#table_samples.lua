require('#base')

local chunk_name = '#table_samples'

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
    simple_folded_table = simple_folded_table,
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
