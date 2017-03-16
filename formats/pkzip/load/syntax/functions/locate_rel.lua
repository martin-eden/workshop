return
  function(name)
    return
      function(in_stream, out_stream)
        in_stream:set_relative_position(out_stream.int_data[name])
        return true
      end
  end
