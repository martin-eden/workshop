-- Parse string with RFC

--[[
  Author: Martin Eden
  Last mod.: 2026-06-16
]]

-- Imports:
local lines_iterator = request('!.mechs.string.lines_iterator')
local table_to_str = request('!.convert.table_to_str')

local get_block = request('get_block')

local process_title_block = request('process_title_block')
local process_header_block = request('process_header_block')
local print_block = request('print_block')

local load =
  function(s)
    local lines_iterator = new(lines_iterator)
    lines_iterator:init(s)

    local header = get_block(lines_iterator)
    -- print_block(header, 'Header')
    local title = get_block(lines_iterator)
    -- print_block(title, 'Title')

    local result = {}

    process_header_block(header, result)
    process_title_block(title, result)

    print(table_to_str(result))

    return result
  end

-- Export:
return load

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

--[[
  2018
]]
