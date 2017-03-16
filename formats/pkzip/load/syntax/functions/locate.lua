return
  function(name)
    return
      function(in_stream, out_stream)
        in_stream:set_position(out_stream.int_data[name] + 1)
        return true
      end
  end
