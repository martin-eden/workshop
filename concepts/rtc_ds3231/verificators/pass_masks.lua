--[[
  Verify we have zeros in specifics bytes.

  Receives array of bytes from previous stage.
  Verifies it has zero bits in specific places.
]]

local byte_masks =
  {
    [0x00] = 0x7F,
    [0x01] = 0x7F,
    [0x02] = 0x7F,
    [0x03] = 0x07,
    [0x04] = 0x3F,
    [0x05] = 0x9F,
    [0x06] = 0xFF,
    [0x07] = 0xFF,
    [0x08] = 0xFF,
    [0x09] = 0xFF,
    [0x0A] = 0xFF,
    [0x0B] = 0xFF,
    [0x0C] = 0xFF,
    [0x0D] = 0xFF,
    [0x0E] = 0xFF,
    [0x0F] = 0x8F,
    [0x10] = 0xFF,
    [0x11] = 0xFF,
    [0x12] = 0xC0,
  }

return
  function(data)
    local result, err_msg, err_report = true, nil, {}

    for offset, mask in pairs(byte_masks) do
      if (data[offset] & mask ~= data[offset]) then
        result = false
        err_msg = 'Impossible data values.'
        table.insert(
          err_report,
          {
            msg =
              ("Element [%d]: value 0x%02X doesn't match mask 0x%02X."):
              format(offset, data[offset], mask),
            idx = offset,
            mask = mask,
          }
        )
      end
    end

    return result, err_msg, err_report
  end
