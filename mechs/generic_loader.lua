local parse = request('parser.parse')
local c_string_stream = request('!.mechs.streams.mergeable.string.interface')

-- local profiler = request('!.system.profiler')
-- local to_str = request('!.formats.lua_table_code.save')

return
  function(str, syntax, ...)
    -- profiler.start()
    -- print(to_str(syntax))

    local input_stream = new(c_string_stream)
    input_stream:init(str)
    local result

    local is_processed, data_struc = parser.parse(input_stream, syntax)
    if is_processed then
      result = data_struc
      for i = 1, select('#', ...) do
        local struc_transformer = select(i, ...)
        result = struc_transformer(input_stream, result)
      end
    end

    -- profiler.stop()

    return result
  end
