local loader = request('loader.interface')

return
  function(data)
    local c_stream
    if is_string(data) then
      c_stream = request('!.mechs.streams.mergeable.string.interface')
    elseif is_userdata(data) and (io.type(data) == 'file') then
      c_stream = request('!.mechs.streams.mergeable.file.interface')
    end

    local in_stream = new(c_stream)
    in_stream:init(data)

    loader.in_stream = in_stream
    loader:init()

    return loader:run()
  end
