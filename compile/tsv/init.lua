return
  function(self, data)
    self.data = data
    assert_table(self.data)
    assert_string(self.field_separator)
    assert_string(self.record_separator)
  end
