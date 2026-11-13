-- Write strings tree to output stream

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

local delimiters_writer = request('compile.delimiters_writer')
local data_writer = request('compile.data_writer')

return
  function(node, output)
    local delimiters_writer = delimiters_writer.create(output)
    local data_writer = data_writer.create(output)

    local compile
    compile =
      function(node)
        if is_string(node) then
          delimiters_writer:event('write_string')
          data_writer:write_leaf(node)
        elseif is_table(node) then
          delimiters_writer:event('start_list')
          data_writer:start_list()
          for _, node in ipairs(node) do
            compile(node)
          end
          delimiters_writer:event('end_list')
          data_writer:end_list()
        end
      end

    compile(node)

    delimiters_writer:event('nothing')
  end

--[[
  2024 # # #
  2026 # # #
  2026-11-13
]]
