-- Initialize instance

--[[
  Author: Martin Eden
  Last mod.: 2026-06-17
]]

-- Imports:
local create_base_node_handlers = request('create_node_handlers.base')
local make_readable_node_handlers = request('create_node_handlers.readable')

local create_node_handlers =
  function(TextBlock, style, use_compact_sequences)
    local NodeHandlers =
      create_base_node_handlers(TextBlock, use_compact_sequences)

    if (style == 'readable') then
      make_readable_node_handlers(
        NodeHandlers, TextBlock, use_compact_sequences
      )
    end

    return NodeHandlers
  end

-- Export:
return create_node_handlers

--[[
  2018-02-05
  2026-06-16
]]
