-- Makes sure we got sequence of bytes.

local is_byte = request('!.number.is_byte')

return
  function(data)
    local result, err_msg, err_report = true, nil, {}
    local idx_min, idx_max = 0, 18
    for i = idx_min, idx_max do
      local sub_result, sub_err_msg = is_byte(data[i])
      if not sub_result then
        result = false
        err_msg = 'Wrong data structure.'
        table.insert(
          err_report,
          {
            msg = ('Table element [%d]: (%s).'):format(i, sub_err_msg),
            idx = i,
          }
        )
      end
    end
    return result, err_msg, err_report
  end
