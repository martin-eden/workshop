--[[
  Lua base libraries extensions which is used in almost any
  piece of my code. This file extends base facilities, so no
  modularity assumed. I'll try to keep this code short.

  The essential requirement is that code must work under
  Lua 5.1, Lua 5.2 and World of Warcraft Lua (which has
  no require() and no other way to load arbitrary file).
--]]
local chunk_name = '#base'

--[[ export "is_<type>" and "assert_<type>" functions: ]]--
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
  for k, type_name in ipairs(data_types) do
    _G['is_' .. type_name] = function(a) return (type(a) == type_name) end
    _G['assert_' .. type_name] =
      function(a, responsibility_level)
        local responsibility_level = (responsibility_level or 1)
        if (type(a) ~= type_name) then
          error(
            ('Argument must have a type "%s", not "%s".'):format(type_name, type(a)),
            responsibility_level + 1
          )
        end
      end
  end
end

--[[ make sure we have table.pack and table.unpack: ]]--
do
  _G.table.pack = _G.table.pack or _G.pack
  _G.table.unpack = _G.table.unpack or _G.unpack
end

--[[ export tribute/request functions: ]]--
if not truibute then
  local tributes = {}
  -- local requested_tributes = {}
  local system_have_require = is_function(require)
  local depth = 0
  local indent = '  '
  local caller_prefix = ''

  tribute =
    function(path_name, value)
      assert_string(path_name)
      path_name = caller_prefix .. path_name
      tributes[path_name] = value
      -- requested_tributes[path_name] = 0
      -- print(('%sTributed "%s" (%s)'):format(indent:rep(depth), path_name, type(value)))
    end

  local debug_print_tributes =
    function()
      for k, v in pairs(tributes) do
        print('tribute', k)
      end
    end

  local extract_keys =
    function(t)
      local result = {}
      for k in pairs(t) do
        result[#result + 1] = k
      end
      return result
    end

  local escape_punctuation =
    function(s)
      local result = s
      result = result:gsub('(%p)', '%%%1')
      return result
    end

  local substitute_upper_dir =
    function(s)
      local result
      while true do
        result = s:gsub('[^%.]-%.%^%.', '', 1)
        -- print(s, '->', result)
        if (result == s) then
          break
        end
        s = result
      end
      return result
    end

  request =
    function(path_name)
      local require_tried = false
      depth = depth + 1
      if (caller_prefix ~= '') then
        -- print(('%sCaller prefix is "%s".'):format(indent:rep(depth), caller_prefix))
      end
      local name_with_prefix = caller_prefix .. path_name
      name_with_prefix = substitute_upper_dir(name_with_prefix)
      -- print(('%sRequested "%s"'):format(indent:rep(depth), name_with_prefix))
      -- debug_print_tributes()

      local result = tributes[name_with_prefix]
      -- ::restart::
      repeat --< lack of GOTO in Lua 5.1 workaround
        local need_restart = false
        -- print('name_with_prefix', name_with_prefix)
        -- print('result', result)

        if not result then
          local path_name_pattern = escape_punctuation(name_with_prefix) .. '$'
          local known_names = extract_keys(tributes)
          local num_found = 0

          --[[ possibly passed module name is less qualified than we have: ]]
          for i = 1, #known_names do
            if known_names[i]:find(path_name_pattern) then
              num_found = num_found + 1
              result = tributes[known_names[i]]
            end
          end
          if (num_found > 1) then
            -- debug_print_tributes()
            error(('Found more than one match for short path name "%s".'):format(name_with_prefix))
          end

          if (num_found == 0) then
            --[[ possibly, passed module name is more qualified than we have: ]]
            for i = 1, #known_names do
              local known_name_pattern = escape_punctuation(known_names[i]) .. '$'
              if name_with_prefix:find(known_name_pattern) then
                num_found = num_found + 1
                result = tributes[known_names[i]]
              end
            end
            if (num_found > 1) then
              -- debug_print_tributes()
              error(('Found more than one match for long path name "%s".'):format(name_with_prefix))
            end
          end

          if system_have_require and not require_tried then
            local old_prefix = caller_prefix
            caller_prefix = name_with_prefix:match('(.+%.)') or ''
            name_with_prefix = name_with_prefix:gsub('%^%.', '') -- '^' not supported in require()
            if (caller_prefix ~= '') then
              -- print(('%sPrefix is set to "%s".'):format(indent:rep(depth), caller_prefix))
            end
            -- print(('%sRequiring "%s".'):format(indent:rep(depth), name_with_prefix))
            require(name_with_prefix)
            caller_prefix = old_prefix
            require_tried = true
            -- goto restart
            need_restart = true
          end
        end
      until not need_restart
      if not result then
        error(('No matches found for path name "%s".'):format(name_with_prefix))
      end
      -- requested_tributes[name_with_prefix] = requested_tributes[name_with_prefix] + 1
      -- print(('%sReturned "%s"'):format((' '):rep(2 * depth), name_with_prefix))
      depth = depth - 1
      return result
    end

  if not system_have_require then
    require = request
    -- print("System don't have require().")
  else
    -- print('System have require().')
  end

  --[[
  debug_print_requested_tributes =
    function()
      print('Requested trbutes:')
      for k, v in pairs(requested_tributes) do
        print(('  %s: %d'):format(k, v))
      end
    end
  ]]
end

tribute(chunk_name, '')
