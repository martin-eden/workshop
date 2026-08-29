-- Return string with host directory for pathname list

--[[
  Author: Martin Eden
  Last mod.: 2026-08-29
]]

local is_directory = request('is_directory')
local tbl_concat = table.concat
local is_absolute = request('is_absolute')

local sep
local self_dir
do
  local Syntels = request('Syntels')
  sep = Syntels.separator
  self_dir = Syntels.self_dir
end

-- Export:
return
  function(Pathname)
    local host_dir_name
    do
      local host_dir_end_idx
      if is_directory(Pathname) then
        host_dir_end_idx = #Pathname - 2
      else
        host_dir_end_idx = #Pathname - 1
      end
      host_dir_name = tbl_concat(Pathname, sep, 1, host_dir_end_idx)
      if (host_dir_name == '') then
        --[[
          Cases when we can come here: ".", "..", "/", "abc".
          We need to provide host dir for them.
          Zen question: what is the name of "parent dir" for ".."?
          That's why we're using name "host", not "parent".
        ]]
        if not is_absolute(Pathname) then
          host_dir_name = self_dir
        end
      end
      host_dir_name = host_dir_name .. sep
    end

    return host_dir_name
  end

--[[
  2026 #
]]
