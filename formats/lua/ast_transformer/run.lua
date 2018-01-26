return
  function(self)
    assert_table(self.data_struc)

    local result

    if self.keep_comments then
      self:move_comments()
    end
    self:remove_whitespaces()

    local result = self:process_node(self.data_struc)

    result.shebang_str = self.data_struc.shebang_str
    if self.keep_unparsed_tail then
      result.unparsed_tail = self.data_struc.unparsed_tail
    end

    return result
  end
