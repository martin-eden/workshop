-- Personal framework bootloader

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

--[[
  Point of code organization with small files and directories
  is relative "require()" and ability to deploy only used files.
]]

--[[
  Installed globals

  * Global "request()"

    Relative "require()" which allows loading modules by name
    related to caller's module directory.

    Uses extended name syntax: "^." -- upper directory,
    "!." -- directory of this "base.lua" module.

  * Global "get_dependencies()"

    Table with names map. Implementation of "request()" tracks run-time
    dependencies.

  * Global "get_base_prefix()"

    Implementation of "request()" knows it's own module name prefix
    for "require()". It's critical information for niche tools.

  * Global "get_require_name()"

    Not essential -- can be recreated with already provided information.
    Used by [require_file]. Shared because we don't like duplicate code.

  * Convenience globals

    These functions are actually modules but made global because
    they are using often:

    * is_..() family

      is_boolean(), is_number, is_integer(), is_float(), is_table() ...

    * assert_..() family

      assert_boolean(), assert_number(), assert_integer(), ...

    * new() -- clones table and applies optional field overrides
]]

local split_name =
  function(qualified_name)
    local prefix_name_pattern = '^(.+%.)([^%.]+)$'  -- a.b.c --> (a.b.) (c)
    local prefix, name = qualified_name:match(prefix_name_pattern)
    if not prefix then
      prefix = ''
      name = qualified_name
      if not name:find('^([^%.]+)$') then
        name = ''
      end
    end
    return prefix, name
  end

local unite_prefixes =
  function(base_prefix, rel_prefix)
    local init_base_prefix, init_rel_prefix = base_prefix, rel_prefix
    local list_without_tail_pattern = '(.+%.)[^%.]-%.$' -- a.b.c. --> (a.b.)
    local list_without_head_pattern = '[^%.]+%.(.+)$' -- a.b.c. --> (b.c.)
    while rel_prefix:find('^%^%.') do
      if (base_prefix == '') then
        error(
          ([[Link "%s" is outside of caller's prefix "%s".]]):format(
            init_rel_prefix,
            init_base_prefix
          )
        )
      end
      base_prefix = base_prefix:match(list_without_tail_pattern) or ''
      rel_prefix = rel_prefix:match(list_without_head_pattern) or ''
    end
    return base_prefix .. rel_prefix
  end

local Names = { }
local depth = 1

local get_caller_prefix =
  function()
    local result = ''
    if Names[depth] then
      result = Names[depth].prefix
    end
    return result
  end

local get_caller_name =
  function()
    local result = 'anonymous'

    if Names[depth] then
      result = Names[depth].prefix .. Names[depth].name
    end

    return result
  end

local push =
  function(prefix, name)
    depth = depth + 1
    Names[depth] = { prefix = prefix, name = name }
  end

local pop =
  function()
    depth = depth - 1
  end

local Dependencies_Map = { }

local add_dependency =
  function(src_name, dest_name)
    Dependencies_Map[src_name] = Dependencies_Map[src_name] or { }

    Dependencies_Map[src_name][dest_name] = true
  end

local base_prefix = split_name((...))

local get_require_name =
  function(qualified_name)
    local caller_prefix

    local is_absolute_name = (qualified_name:sub(1, 2) == '!.')

    if is_absolute_name then
      qualified_name = qualified_name:sub(3)
      caller_prefix = base_prefix
    else
      caller_prefix = get_caller_prefix()
    end

    local prefix, name = split_name(qualified_name)

    prefix = unite_prefixes(caller_prefix, prefix)

    return prefix .. name, prefix, name
  end

local request =
  function(qualified_name)
    local src_name = get_caller_name()

    local require_name, prefix, name = get_require_name(qualified_name)

    push(prefix, name)

    local dest_name = get_caller_name()

    add_dependency(src_name, dest_name)

    local Results = table.pack(require(require_name))

    pop()

    return table.unpack(Results)
  end

local is_first_run = (_G.request == nil)

-- Export globals:
if is_first_run then
  _G.request = request
  _G.get_dependencies = function() return Dependencies_Map end
  _G.get_base_prefix = function() return base_prefix end
  _G.get_require_name = get_require_name

  -- We can now use request() but need to add our name to call stack

  -- First element is invocation module name
  local our_require_name = (...)

  push('', our_require_name)

  request('!.system.install_is_functions')()
  request('!.system.install_assert_functions')()
  _G.new = request('!.table.new')

  pop()
end

--[[
  2016 #
  2017 #
  2018 # #
  2024 #
  2026-05-08
  2026-05-28
]]
