-- AST formatter

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  Internal storage format

    1 [t] -- printer
    2 [t] -- state keeper
]]

local interface
local create
do
  local default_right_margin = 72
  local default_indent_chunk = '  '
  local text_block = request('!.concepts.text_block')
  local state_keeper_class = request('state_keeper')
  local attach_methods = request('!.table.attach_methods')
  create =
    function(options)
      local options = options or { }

      local printer
      do
        local indent_chunk = options.indent_chunk or default_indent_chunk
        local right_margin = options.right_margin or default_right_margin
        printer = text_block.create(indent_chunk, right_margin)
      end

      local state_keeper = state_keeper_class.create()

      local me = { printer, state_keeper }
      attach_methods(me, interface)

      return me
    end
end

interface =
  {
    create = create,

    handlers = request('handlers.interface'),

    process_list = request('process_list'),
    process_node = request('process_node'),

    process_block_oneline = request('process_block_oneline'),
    process_block_multiline = request('process_block_multiline'),
    process_block = request('process_block'),

    represent = request('represent'),
    variate = request('variate'),
    process_list_variative = request('process_list_variative'),
  }

return interface

--[[
  2016 #
  2017 # # #
  2018 #
  2026 # #
  2026-10-31
]]
