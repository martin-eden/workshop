--[[
  Parse ZIP file given as file handle or as string with file contents.
  Return table with parse tree.
]]

local c_string_stream =
  request('!.mechs.streams.mergeable.string.interface')
local c_file_stream =
  request('!.mechs.streams.mergeable.file.interface')
local run = request('parser.run')

return
  function(data, options)
    local c_stream
    if is_string(data) then
      c_stream = c_string_stream
    elseif is_userdata(data) and (io.type(data) == 'file') then
      c_stream = c_file_stream
    end

    local stream = new(c_stream)
    stream:init(data)

    return run(stream, options)
  end
