--[[
  Move table value to different path.

  tbl_from:
    source table
  tbl_to:
    dest table
  path_from:
    {path to source}
  path_to:
    {path to dest}
]]

local path_get_value = request('path_get_value')
local path_set_value = request('path_set_value')

return
  function(tbl_from, tbl_to, path_from, path_to)
    path_set_value(
      tbl_to,
      path_to,
      path_get_value(tbl_from, path_from)
    )
    path_set_value(tbl_from, path_from, nil)
  end
