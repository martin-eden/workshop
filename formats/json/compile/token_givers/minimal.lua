return
  {
    init =
      function(self)
      end,
    open_array =
      function(self)
        return '['
      end,
    close_array =
      function(self)
        return ']'
      end,
    open_object =
      function(self)
        return '{'
      end,
    close_object =
      function(self)
        return '}'
      end,
    array_delimiter =
      function(self)
        return ','
      end,
    indent_value =
      function(self)
        return ''
      end,
    key_val_delimiter =
      function(self)
        return ':'
      end,
    object_delimiter =
      function(self)
        return ','
      end,
  }
