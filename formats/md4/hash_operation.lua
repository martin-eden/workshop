-- This function is also used in MD4-extended, so it is made standalone

local rol = request('!.mechs.bin_ops.rol')

return
  function(slots, funcs, msg_map, data, salt, shifts)
    local h1, h2, h3, h4 = slots[1], slots[2], slots[3], slots[4]

    for round = 1, 3 do
      local mix = funcs[round]
      local map = msg_map[round]
      local round_salt = salt[round]
      local shifts = shifts[round]
      for i = 1, 16 do
        local slot_val =
          rol(
            h1 + mix(h2, h3, h4) + data[map[i]] + round_salt,
            shifts[(i - 1) % 4 + 1]
          )
        h1, h2, h3, h4 = h4, slot_val, h2, h3
      end
    end

    slots[1] = (slots[1] + h1) & 0xFFFFFFFF
    slots[2] = (slots[2] + h2) & 0xFFFFFFFF
    slots[3] = (slots[3] + h3) & 0xFFFFFFFF
    slots[4] = (slots[4] + h4) & 0xFFFFFFFF
  end
