require('#base')

local chunk_name = 'graph.dfs_pass.handlers.nice_print'

local options =
  {
    indent_chunk = '|   ',
  }

local options_getter =
  function()
    return options
  end

local num_table_entries = request('table.get_num_entries')

local verify_options =
  function(new_options)
    local result =
      is_table(new_options) and
      (num_table_entries(new_options) == 1) and
      is_string(new_options.indent_chunk)
    return result
  end

local options_setter =
  function(new_options)
    if verify_options(new_options) then
      options = new_options
    else
      error('Bad options passed.')
    end
  end

local nice_print =
  function(visit_type, node, external_name, node_status, depth)
    if (visit_type == 'entered') then
      local result = ''
      result =
        ('%s[%s] %s %s'):format(
          string.rep(options.indent_chunk, depth),
          tostring(external_name),
          tostring(node),
          node_status or ''
        )
      print(result)
    end
  end

tribute(
  chunk_name,
  {
    handler = nice_print,
    get_options = options_getter,
    set_options = options_setter,
  }
)
