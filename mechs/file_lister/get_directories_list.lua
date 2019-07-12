--[[
  Return list of directory names in <.start_dir>.
]]

local get_cmd_listdirs = request('!.bare.file_system.get_cmd_listdirs')
local get_program_output_lines = request('!.system.get_program_output_lines')

return
  function(self)
    local cmd_get_dirs = get_cmd_listdirs(self.start_dir)
    local result = get_program_output_lines(cmd_get_dirs)
    self:simplify_file_names(result)
    self:remove_start_dir(result)
    return result
  end
