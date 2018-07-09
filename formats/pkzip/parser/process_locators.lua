--[[
  Process file locators.

  Populates <result>. Changes stream position.
]]

local parse_locator = request('parse.locator')
local name_zip64_fields_locator = request('name_zip64_fields_locator')

local FFx4 = 0xFFFFFFFF

return
  function(stream, result)
    -- Get offset to file locators:
    local offset, num_entries
    if result.locators_link_64 then
      offset = result.locators_link_64.offset
      num_entries = result.locators_link_64.num_entries_on_disk
    else
      offset = result.locators_link.offset
      num_entries = result.locators_link.num_entries_on_disk
    end

    stream:set_position(offset + 1)

    result.locators = {}
    for i = 1, num_entries do
      local rec = parse_locator(stream)
      if is_table(rec.extra_data) then
        name_zip64_fields_locator(rec)
      end
      result.locators[i] = rec
    end
  end
