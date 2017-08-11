--[[
  Return list of directory names in given directory.

  Input: [<start_dir>]
  Output: <list of strings>
]]

local file_lister = request('!.mechs.file_lister.interface')

return
  function(start_dir)
    file_lister.start_dir = start_dir
    file_lister:init()
    return file_lister:get_directories_list()
  end
