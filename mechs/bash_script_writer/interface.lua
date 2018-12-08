--[[
  Workflow:

    * Clone.

    *  ----------------.
       V               |
      --+- copy_file --+---+- get_script --+-
        +- delete_dir -+   +- save_script -+
]]

return
  {
    copy_file = request('copy_file'),
    delete_dir = request('delete_dir'),
    get_script = request('get_script'),
    save_script = request('save_script'),
    --
    files_to_copy = {},
    dirs_to_delete = {},
  }
