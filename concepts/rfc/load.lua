local c_line_iterator = request('!.mechs.string.lines_iterator')
local table_to_str = request('!.concepts.lua_table.save')

local get_block = request('get_block')

local process_title_block = request('process_title_block')
local process_header_block = request('process_header_block')
local print_block = request('print_block')

return
  function(s)
    local line_iterator = new(c_line_iterator)
    line_iterator:init(s)

    local header = get_block(line_iterator)
    -- print_block(header, 'Header')
    local title = get_block(line_iterator)
    -- print_block(title, 'Title')

    local result = {}

    process_header_block(header, result)
    process_title_block(title, result)

    print(table_to_str(result))

    return result
  end

--[[
  Sample data:



  Internet Engineering Task Force (IETF)                  M. Pritikin, Ed.
  Request for Comments: 7030                           Cisco Systems, Inc.
  Category: Standards Track                                    P. Yee, Ed.
  ISSN: 2070-1721                                             AKAYLA, Inc.
                                                           D. Harkins, Ed.
                                                            Aruba Networks
                                                              October 2013


                      Enrollment over Secure Transport

]]
