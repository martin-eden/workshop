--[[
  Given list of found directories, exclude entry with <.start_dir>.
]]

return
  function(self, dir_list)
    for i = 1, #dir_list do
      -- if (start_dir == '/') then after remove_dir_prefix() (dir_list[i] == '')
      if (dir_list[i] == self.start_dir) or (dir_list[i] == '') then
        table.remove(dir_list, i)
        return
      end
    end
  end
