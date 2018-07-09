--[[
  Parse InfoZip timestamp extra data. Return table.

  Well, here is one more obscure case.

  <flag> is bitmap for three values: time modified, created and
  accessed. It relates to data in local file header. But also present
  in central file header too.

  If it is present in central file header then it should has
  "modified" bit on. And extra data contains only four bytes for
  modification time, no matter that other flag bits may be on.

  When this routine called we don't know whether it is parsing data
  for local or for central file header. But in practice central file
  header time data have length of 5 bytes, so we load <flag>,
  <modified> and then boil out as there is no more data to parse.
]]

local to_bit_field = request('!.formats.bit_field.decode')
local ts_to_iso = request('!.formats.unix_time.decode')

local unpack_time =
  function(data, start_pos)
    result, start_pos = ('< I4'):unpack(data, start_pos)
    result = ts_to_iso(result)
    return result, start_pos
  end

return
  function(data)
    local result = {}

    local flag_str, start_pos = ('c1'):unpack(data)
    local flag_int = ('B'):unpack(flag_str)

    flag_str = to_bit_field(flag_str)

    result.flag = flag_str

    if (flag_int & (1 << 0) ~= 0) then
      result.modified, start_pos = unpack_time(data, start_pos)
    end
    if (flag_int & (1 << 1) ~= 0) and (start_pos + 3 <= #data) then
      result.accessed, start_pos = unpack_time(data, start_pos)
    end
    if (flag_int & (1 << 2) ~= 0) and (start_pos + 3 <= #data) then
      result.created, start_pos = unpack_time(data, start_pos)
    end

    return result
  end
