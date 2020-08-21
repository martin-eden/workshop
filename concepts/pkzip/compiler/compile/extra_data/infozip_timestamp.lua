local from_bit_field = request('!.concepts.bit_field.encode')
local iso_to_nixtime = request('!.concepts.unix_time.encode')

local pack_time =
  function(ts_str)
    return ('< I4'):pack(iso_to_nixtime(ts_str))
  end

return
  function(rec)
    local result = {}
    table.insert(result, from_bit_field(rec.flag))
    if rec.modified then
      table.insert(result, pack_time(rec.modified))
    end
    if rec.accessed then
      table.insert(result, pack_time(rec.accessed))
    end
    if rec.created then
      table.insert(result, pack_time(rec.created))
    end
    result = table.concat(result)
    return result
  end
