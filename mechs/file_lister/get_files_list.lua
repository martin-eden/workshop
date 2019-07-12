--[[
  Return list of file names in <.start_dir>.
]]

local get_cmd_listfiles = request('!.bare.file_system.get_cmd_listfiles')
local get_program_output_lines = request('!.system.get_program_output_lines')

return
  function(self)
    local cmd_get_files = get_cmd_listfiles(self.start_dir)
    local result = get_program_output_lines(cmd_get_files)
    self:simplify_file_names(result)
    return result
  end
