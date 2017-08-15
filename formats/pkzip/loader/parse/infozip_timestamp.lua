--[[
  Parse InfoZip timestamp additional data. Return table.

  Well, here is one more obscure case.

  <flag> is bitmap for three values: time modified, created and
  accessed. It relates to data in local file header.
  But also present in file header too.

  If it is present then it should has "modified" bit on. And additional
  data contains only four bytes for modification time, no matter that
  other bits may be on.

  I have no inclination to indicate somehow that this routine
  called while parsing file header. So just check that unpack() will
  not fail when parsing further announced fields.
]]

return
  function(self, data)
    local result = {}

    local flag, start_pos = ('I1'):unpack(data)
    result.flag = flag

    if (flag & (1 << 0) ~= 0) then
      result.modified, start_pos = ('< I4'):unpack(data, start_pos)
    end
    if (flag & (1 << 1) ~= 0) and (start_pos + 3 <= #data) then
      result.accessed, start_pos = ('< I4'):unpack(data, start_pos)
    end
    if (flag & (1 << 2) ~= 0) and (start_pos + 3 <= #data)then
      result.created, start_pos = ('< I4'):unpack(data, start_pos)
    end

    return result
  end
