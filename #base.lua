--[[
  Lua base libraries extensions which is used in almost any
  piece of my code. This extends base facilities. So no
  modularity assumed. I'll try to keep this code short.

  The essential requirement is that code must work under
  Lua 5.1, Lua 5.2 and World of Warcraft Lua (which has
  no require() and no other way to load arbitrary file).
--]]

local chunk_name = '#base'

-- export is_<type> functions:
do
  local data_types =
    {
      'boolean',
      'function',
      'nil',
      'number',
      'string',
      'table',
      'thread',
      'userdata',
    }
  for k, v in ipairs(data_types) do
    _G['is_' .. v] = function(a) return (type(a) == v) end
  end
end

-- make sure we have table.pack and table.unpack:
do
  _G.table.pack = _G.table.pack or _G.pack
  _G.table.unpack = _G.table.unpack or _G.unpack
end

-- exprort tribute/request functions:
if not truibute then
  local tributes = {}
  local requested_tributes = {}
  local depth = 0
  local system_have_require = is_function(require)

  request =
    function(path_name)
      -- depth = depth + 1
      -- print(('%sRequested "%s"'):format((' '):rep(2 * depth), path_name))
      local result = tributes[path_name]
      if not result and system_have_require then
        require(path_name)
        result = tributes[path_name]
      end
      if not result then
        error(('Path "%s" not exists.'):format(path_name), 2)
      end
      requested_tributes[path_name] = requested_tributes[path_name] + 1
      -- print(('%sReturned "%s"'):format((' '):rep(2 * depth), path_name))
      -- depth = depth - 1
      return result
    end

  tribute =
    function(path_name, value)
      tributes[path_name] = value
      requested_tributes[path_name] = 0
      -- print(('%sTributed "%s" (%s)'):format((' '):rep(2 * depth), path_name, type(value)))
    end

  if not system_have_require then
    require = request
  end

  debug_print_requested_tributes =
    function()
      for k, v in pairs(requested_tributes) do
        print(('%s: %d'):format(k, v))
      end
    end
end

tribute(chunk_name, '')
