local type_name = 'system_reset'

local record = 'B'
local rec_size = record:packsize()

local signature = request('^.protocol.signatures').system_reset

return
  function(stream)
    local chunk = stream:block_read(rec_size)

    if not chunk then
      return
    end

    local header = record:unpack(chunk)

    local is_valid = (header == signature)

    if not is_valid then
      return
    end

    local result =
      {
        type = type_name,
      }

    return result
  end
