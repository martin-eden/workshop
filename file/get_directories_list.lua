--[[
  Return list of directory names in given directory.

  Syntax:

    [<start_dir>] -> <list of strings>
       string            sequence
]]

local file_lister = request('!.mechs.file_lister.interface')

return
  function(start_dir)
    file_lister.start_dir = start_dir
    file_lister:init()
    return file_lister:get_directories_list()
  end
