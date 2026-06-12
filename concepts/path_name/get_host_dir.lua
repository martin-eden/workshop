-- Return string with host directory for pathname list

--[[
  Author: Martin Eden
  Last mod.: 2026-06-12
]]

-- Imports:
local is_directory = request('is_directory')
local is_absolute = request('is_absolute')

local sep = '/'
local empty = ''
local self_dir = '.'

local get_host_dir =
  function(Pathname)
    local host_dir_name
    do
      local host_dir_end_idx
      if is_directory(Pathname) then
        host_dir_end_idx = #Pathname - 2
      else
        host_dir_end_idx = #Pathname - 1
      end
      host_dir_name = table.concat(Pathname, sep, 1, host_dir_end_idx)
      if (host_dir_name == empty) then
        --[[
          Cases when we can come here: ".", "..", "/", "abc".
          We need to provide host dir for them.
          Zen question: what is the name of "parent dir" for ".."?
          That's why we're using name "host", not "parent".
        ]]
        if is_absolute(Pathname) then
          host_dir_name = empty
        else
          host_dir_name = self_dir
        end
      end
      host_dir_name = host_dir_name .. sep
    end

    return host_dir_name
  end

-- Export:
return get_host_dir

--[[
  2026-06-12
]]
