local type_name = 'set_pin_value'

local record = 'B B B'
local rec_size = record:packsize()

local signature =
  request('!.formats.formata.protocol.signatures').pin_value

return
  function(stream)
    local chunk = stream:block_read(rec_size)

    if not chunk then
      return
    end

    local
      header,
      pin_number,
      pin_mode =
      record:unpack(chunk)

    local is_valid =
      (header == signature) and
      (pin_number <= 0x7F) and
      (pin_mode <= 0x7F)

    if not is_valid then
      return
    end

    local result =
      {
        type = type_name,
        pin_number = pin_number,
        pin_mode = pin_mode,
      }

    return result
  end
