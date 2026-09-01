-- Run module as standalone program

--[[
  Author: Martin Eden
  Last mod.: 2026-09-01
]]

--[[
  Contract

    * We create [ShellCommand] instance with shell code to execute
      given module with arguments as command-line program

    * Module arguments MUST be strings
]]

--[[
  Example:

  Suppose we want to call module "!.programs.get_bytecode_listing"
  with argument "tests/test.lua".

  And our "package.path" is "../../../?.lua".

  In Lua code it's

    package.path = '../../../?.lua'
    require('workshop.base')
    request('!.programs.get_bytecode_listing')('tests/test.lua')

  We'll build command-line for "lua" interpreter with Lua code like

    lua -e 'package.path = '\''../../../?.lua'\''
    require('\'workshop.base\'')
    request('\''!.programs.get_bytecode_listing'\'')('\'tests/test.lua\'')
    '

  and create [ShellCommand] instance which has methods
  :ToString() and :Execute().
]]

local get_lua_code
do
  local base_module = 'workshop.base'
  local lua_quote = request('!.concepts.lua.quote_string')
  local newline = request('!.concepts.Ascii.Chars').newline
  local add_to_list = request('!.concepts.list.add_item')
  local list_to_str = request('!.concepts.list.to_string')

  get_lua_code =
    function(module_name, Args)
      local lua_code

      lua_code =
        'package.path = ' .. lua_quote(package.path) .. newline ..
        'require(' .. lua_quote(base_module) .. ')' .. newline ..
        'request(' .. lua_quote(module_name) .. ')'

      local ArgStrs = { }
      for _, arg in ipairs(Args) do
        add_to_list(ArgStrs, lua_quote(arg))
      end

      lua_code =
        lua_code ..
        '(' .. list_to_str(ArgStrs, ', ') .. ')' .. newline

      return lua_code
    end
end

local get_shell_command
do
  local ShellCommand = request('!.concepts.ShellCommand')

  get_shell_command =
    function(lua_code)
      return ShellCommand.create({ 'lua', { '-e', lua_code } })
    end
end

-- Export:
return
  function(module_name, Args)
    assert_string(module_name)
    for _, arg in ipairs(Args) do
      assert_string(arg)
    end

    return get_shell_command(get_lua_code(module_name, Args))
  end

--[[
  2026-09-01
]]
