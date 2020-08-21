-- Checks that specific values are BCD integers.

local bcd_paths = request('^.parsers.bcd_paths')
local path_get_value = request('!.table.path_get_value')
local is_bcd = request('!.number.is_bcd')

return
  function(data)
    local result, err_msg, err_report = true, nil, {}

    for _, path in ipairs(bcd_paths) do
      local value = path_get_value(data, path)
      local sub_result, sub_err_msg = is_bcd(value)
      if not sub_result then
        result = false
        err_msg = 'Wrong BCD value.'
        table.insert(
          err_report,
          {
            msg =
              ('Element %s: %s'):
              format(table.concat(path, '.'), sub_err_msg),
            path = path,
          }
        )
      end
    end

    return result, err_msg, err_report
  end
