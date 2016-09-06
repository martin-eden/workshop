local chunk_name = 'nice'

local options =
  {
    indent_chunk = '.   ',
  }

local num_entries = request('^.^.^.table.get_num_entries')

local verify_options =
  function(new_options)
    local result =
      is_table(new_options) and
      (num_entries(new_options) == 1) and
      is_string(new_options.indent_chunk)
    return result
  end

local nice_print =
  function(visit_type, node, external_name, node_status, depth)
    if (visit_type == 'entered') then
      local node_str
      if is_table(node) then
        if (num_entries(node) == 0) then
          node_str = '{}'
        else
          node_str = ''
        end
      else
        node_str = tostring(node)
      end
      local result =
        ('%s%s | %s %s'):format(
          options.indent_chunk:rep(depth),
          tostring(external_name),
          node_str,
          node_status or ''
        )
      print(result)
    end
  end

tribute(
  chunk_name,
  {
    handler = nice_print,
    get_options = function() return options end,
    set_options =
      function(new_options)
        assert(verify_options(new_options), 'Bad options passed.')
        options = new_options
      end,
  }
)
