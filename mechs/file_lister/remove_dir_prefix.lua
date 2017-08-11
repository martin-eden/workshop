--[[
  Returns <file_name> without <.start_dir> part.

  Input: <self> <file_name>
]]

local quote_regexp = request('!.funcs.lua.regexp.quote')

return
  function(self, file_name)
    local prefix = self.start_dir
    if (prefix:sub(-1) ~= '/') then
      prefix = prefix .. '/'
    end
    local pattern = '^' .. quote_regexp(prefix)
    return file_name:gsub(pattern, '')
  end
