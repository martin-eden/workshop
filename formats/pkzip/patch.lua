local run = request('compiler.run')

local c_stream = request('!.mechs.streams.mergeable.file.interface')
local open = request('!.file.safe_open')

return
  function(file_name, ast)
    assert_string(file_name)
    assert_table(ast)

    local f = open(file_name, 'wb')

    local stream = new(c_stream)
    stream:init(f)

    run(ast, stream)

    f:close()
  end
