--[[
  Return list of directory names in <.start_dir>.
]]

local get_program_output_lines = request('!.system.get_program_output_lines')

return
  function(self)
    local cmd_get_dirs = ('find %s -maxdepth 1 -type d'):format(self.start_dir)
    local result = get_program_output_lines(cmd_get_dirs)
    self:simplify_file_names(result)
    self:remove_start_dir(result)
    return result
  end
