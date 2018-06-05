--[[
  Workflow:

    * Clone.

    *  ----------------
       V              /
      --- copy_file -+--+- get_script --+-
                        +- save_script -+
]]

return
  {
    copy_file = request('copy_file'),
    get_script = request('get_script'),
    save_script = request('save_script'),
    --
    files_to_copy = {},
  }
