--[[
  Verify we have zeroes in specifics bytes.

  Receives verified array of bytes with fixed length.
  Verifies it has zero bits in specific places.
]]

local byte_masks = request('byte_masks')

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
              ("Element [%d] value 0x%02X doesn't match mask 0x%02X."):
              format(offset, data[offset], mask),
            idx = offset,
            mask = mask,
          }
        )
      end
    end

    return result, err_msg, err_report
  end
