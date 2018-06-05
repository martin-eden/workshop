--[[
  Add file copy operation to queue.

  - tbl ----- str ------ str ---- -> nil
   (self) (src_name) (dest_name)
]]

return
  function(self, src_name, dest_name)
    assert_string(src_name)
    assert_string(dest_name)
    table.insert(
      self.files_to_copy,
      {
        src_name = src_name,
        dest_name = dest_name,
      }
    )
  end
