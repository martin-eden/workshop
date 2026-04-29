-- Verify we have zeros in specifics bytes.

--[[
  Author: Martin Eden
  Last mod.: 2026-04-29
]]

local ByteMasks =
  {
    [01] = 0x7F,
    [02] = 0x7F,
    [03] = 0x7F,
    [04] = 0x07,
    [05] = 0x3F,
    [06] = 0x9F,
    [07] = 0xFF,
    [08] = 0xFF,
    [09] = 0xFF,
    [10] = 0xFF,
    [11] = 0xFF,
    [12] = 0xFF,
    [13] = 0xFF,
    [14] = 0xFF,
    [15] = 0xFF,
    [16] = 0x8F,
    [17] = 0xFF,
    [18] = 0xFF,
    [19] = 0xC0,
  }

--[[
local ByteMasksStr =
  {
    [01] = '0.......',
    [02] = '0.......',
    [03] = '0.......',
    [04] = '00000...',
    [05] = '00......',
    [06] = '.00.....',
    [07] = '........',
    [08] = '........',
    [09] = '........',
    [10] = '........',
    [11] = '........',
    [12] = '........',
    [13] = '........',
    [14] = '........',
    [15] = '........',
    [16] = '.000....',
    [17] = '........',
    [18] = '........',
    [19] = '..000000',
  }
]]

--[[
  Receives array of bytes from previous stage.
  Verifies it has zero bits in specific places.
]]
local check_masks =
  function(Data)
    for idx, mask in ipairs(ByteMasks) do
      if (Data[idx] & mask ~= Data[idx]) then
        local err_msg =
          string.format(
            "Element [%d]: value 0x%02X doesn't match mask 0x%02X.",
            idx,
            Data[idx],
            mask
          )
        coroutine.yield(idx, mask, err_msg)
      end
    end
  end

-- Export:
return check_masks

--[[
  2020
  2023
]]
