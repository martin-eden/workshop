--[[
  Add a directory removal operation to queue.
]]

return
  function(self, dir_name)
    assert_string(dir_name)
    table.insert(self.dirs_to_delete, dir_name)
  end
