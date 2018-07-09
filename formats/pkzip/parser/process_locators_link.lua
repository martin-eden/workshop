--[[
  Find link to file locators and parse it.

  Populates <result>. Changes stream position.

  Algorithm to retrieve file locators offset:

    locate_and_parse('PK\x05\x06')
    if result.offset == 0xFFFFFFFF
      locate_and_parse('PK\x06\x07')
      locate(result.offset)
      parse('PK\x06\x06')
]]

local locate_signature = request('locate_signature')

local parse_locators_link = request('parse.locators_link')
local parse_locators_link_64_link = request('parse.locators_link_64_link')
local parse_locators_link_64 = request('parse.locators_link_64')

local FFx4 = 0xFFFFFFFF
local locators_link_sign = 'PK\x05\x06'
local locators_link_64_link_sign = 'PK\x06\x07'

return
  function(stream, result)
    local signature_found =
      locate_signature(stream, locators_link_sign)

    if not signature_found then
      error('ZIP: Failed to locate link to files list.')
    end

    result.locators_link = parse_locators_link(stream)

    -- Need to search for 64-bit file locators list link?
    if (result.locators_link.offset == FFx4) then
      if not locate_signature(stream, locators_link_64_link_sign) then
        error('ZIP: Failed to locate int64-link to files list.')
      end
      result.locators_link_64_link = parse_locators_link_64_link(stream)
      stream:set_position(
        result.locators_link_64_link.offset + 1
      )
      result.locators_link_64 = parse_locators_link_64(stream)
    end
  end
