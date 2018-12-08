--[[
  Add file copy operation to queue.

  Specification:

    self: tbl
    src_name: str
    dest_name: str
    ->
    nil
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
