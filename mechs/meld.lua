-- Combine Lua modules in one Lua file

--[[
  Author: Martin Eden
  Last mod.: 2026-11-16
]]

--[[
  Input

    1 [t] -- modules
      0+ [t] -- module record
        1 [s] -- module name
        2 [s] -- module path
    2 [t] -- output stream
]]

local file_to_str = request('!.convert.file_to_str')
local newline = request('!.concepts.ascii.chars').newline
local ends_with = request('!.string.ends_with')
local quote = request('!.concepts.lua.quote_string')

return
  function(modules, output)
    local emit =
      function(str)
        output:write(str)
        if not ends_with(str, newline) then
          output:write(newline)
        end
      end
    for _, module in ipairs(modules) do
      local name = module[1]
      local path = module[2]
      local quoted_name = quote(name)
      local contents = file_to_str(path)
      emit('-- ( module ' .. name)
      emit('package.preload[' .. quoted_name .. '] =')
      emit('function(...)')
      emit(contents)
      emit('end')
      emit('-- )')
      emit('')
    end
  end

--[[
  2026-11-16
]]
