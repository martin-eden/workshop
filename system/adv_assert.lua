--[[
  assert() extended to following result format:

    <bool> result
    <str> error_message
    <table> error_details

  In standard Lua third paramater in case of error is integer or
  absent.
]]

local t2s = request('!.concepts.lua_table.save')

return
  function(...)
    local result = select(1, ...)
    local msg = select(2, ...)
    local report = select(3, ...)
    if not result then
      if is_string(msg) then
        local report_msg = msg
        if is_table(report) then
          report_msg = report_msg .. '\n' .. t2s(report)
        end
        error(report_msg)
      else
        error('')
      end
    end
  end
