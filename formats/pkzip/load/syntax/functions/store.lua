local read_uint = request('read_uint')

return
  function(name, length)
    return
      function(in_stream, out_stream)
        local int_data = out_stream.int_data
        local value = read_uint(in_stream, length)
        int_data[name] = value
        return true
      end
  end
