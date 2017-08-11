--[[
  Simplifies given list of file names by removing <.start_dir> prefix.
]]

return
  function(self, file_names)
    for i = 1, #file_names do
      file_names[i] = self:remove_dir_prefix(file_names[i])
    end
  end
