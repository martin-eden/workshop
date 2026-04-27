-- Parse chunk with I2C Reply from Firmata

--[[
  Author: Martin Eden
  Last mod.: 2026-04-27
]]

--[[
  Parse I2C reply chunk

  Result structure

    {
      device_id [i]
      offset [i]
      data [t] -- list of bytes
    }
]]
local parse_i2c_reply_chunk =
  function(self, chunk)
    local device_id = self:to_word(chunk:byte(1, 2))
    local offset = self:to_word(chunk:byte(3, 4))
    local data = self:to_bytes(chunk:sub(5))

    return
      {
        device_id = device_id,
        offset = offset,
        data = data,
      }
  end

-- Export:
return parse_i2c_reply_chunk

--[[
  2019-05
]]
