-- Personal framework bootloader

--[[
  Author: Martin Eden
  Last mod.: 2026-02-09
]]

--[[
  This module installs global function "request" which is based on
  "require" and makes possible relative module names.

  Also this function tracks module dependencies. This allows to
  get dependencies list for any module. Which is used to create
  deploys without unused code.

  Price for tracking dependencies is global table "dependencies"
  and function "get_require_name".

  Lastly, global functions are added for convenience. Such functions
  are "new" and families of "is_<type>" and "assert_<type>".
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
          ([[Link "%s" is outside caller's prefix "%s".]]):format(
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

local names = {}
local depth = 1

local get_caller_prefix =
  function()
    local result = ''
    if names[depth] then
      result = names[depth].prefix
    end
    return result
  end

local get_caller_name =
  function()
    local result = 'anonymous'
    if names[depth] then
      result = names[depth].prefix .. names[depth].name
    end
    return result
  end

local push =
  function(prefix, name)
    depth = depth + 1
    names[depth] = {prefix = prefix, name = name}
  end

local pop =
  function()
    depth = depth - 1
  end

local dependencies = {}
local add_dependency =
  function(src_name, dest_name)
    dependencies[src_name] = dependencies[src_name] or {}
    dependencies[src_name][dest_name] = true
  end

local base_prefix = split_name((...))

local get_require_name =
  function(qualified_name)
    local is_absolute_name = (qualified_name:sub(1, 2) == '!.')
    if is_absolute_name then
      qualified_name = qualified_name:sub(3)
    end
    local prefix, name = split_name(qualified_name)
    local caller_prefix =
      is_absolute_name and base_prefix or get_caller_prefix()
    prefix = unite_prefixes(caller_prefix, prefix)
    return prefix .. name, prefix, name
  end

local table_pack =
  function(...)
    return {n = select('#', ...), ...}
  end

local math_type =
  function(n)
    if (type(n) == 'number') then
      local int, frac = math.modf(n)
      if (frac == 0) then
        return 'integer'
      else
        return 'float'
      end
    end
  end

local request =
  function(qualified_name)
    local src_name = get_caller_name()

    local require_name, prefix, name = get_require_name(qualified_name)

    push(prefix, name)
    local dest_name = get_caller_name()
    add_dependency(src_name, dest_name)
    local results = table_pack(require(require_name))
    pop()

    return table.unpack(results)
  end

local IsFirstRun = (_G.request == nil)

if IsFirstRun then
  _G.request = request
  _G.dependencies = dependencies
  _G.get_require_name = get_require_name
  _G.table.pack = table_pack
  _G.table.unpack = _G.unpack
  _G.math.type = math_type

  --[[
    At this point we installed "request()", so it's usable from
    outer code.

    Also we made global "dependencies{}" and "get_require_name()".
    "dependenices" is optional and not mission-critical. But stores
    inter-module call edges which are tricky to obtain other ways.
    "get_require_name()" is part of "request()" internal machinery.
    Both has niche uses in my code tree tools. And they can't be
    moved to module because it's request() that provides modules.
  ]]
  --[[
    Below we call optional modules which install additional
    global functions.

    Functions made global because they are widely used in my code.

    They are inside other files. We use freshly added "request()"
    to load them and add them to dependencies of this module.

    We need add record to call stack with our name because these
    calls of "request()" are inside "if", so the call will not be
    done until actual execution.
  ]]

  -- First element is invocation module name, second - module file path
  local our_require_name = (...)

  push('', our_require_name)

  request('!.system.install_is_functions')()
  request('!.system.install_assert_functions')()
  _G.new = request('!.table.new')

  pop()
end

--[[
  2016-06
  2017-09
  2018-02
  2018-05
  2024-03
]]
