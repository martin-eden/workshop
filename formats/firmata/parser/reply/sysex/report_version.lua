return
  function(self, chunk)
    return
      {
        major = chunk:byte(1),
        minor = chunk:byte(2),
        file_name = self:to_8bit_string(chunk:sub(3)),
      }
  end
