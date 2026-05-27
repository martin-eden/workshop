-- Close file object

--[[
  Author: Martin Eden
  Last mod.: 2026-05-27
]]

local close =
  function(File)
    local file_type = io.type(File)
    if not is_string(file_type) then return end
    if (file_type == 'closed file') then return end

    io.close(File)
  end

-- Export:
return close

--[[
  2024-08-09
  2026-05-27
]]
