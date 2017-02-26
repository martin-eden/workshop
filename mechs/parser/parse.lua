local c_marker = request('marker.interface')
local c_folder = request('folder.interface')

return
  function(stream, struc)
    assert_table(stream)
    assert(is_table(struc) or is_string(struc) or is_function(struc))

    local result, data_struc
    local marker = new(c_marker)
    marker:init(stream)
    result = marker:match(struc)
    data_struc = marker:get_marks()

    local folder = new(c_folder)
    folder:init(data_struc)
    folder:fold()
    data_struc = folder:get_struc()

    return result, data_struc
  end
