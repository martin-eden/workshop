-- require() given modules and return module locations and dependencies

--[[
  Author: Martin Eden
  Last mod.: 2026-11-13
]]

--[[
  Input
    [t] list of module names

  Output
    1 [t] list of module locations
      1 [s] module name
      2 [s] module path
    2 [t] map of module dependencies
      * [t] dependency record
        <key> [s] source module name
        <value> [t] destination modules map
          <key> [s] destination module name
          <value> [b] true
]]

--[[
  It requires Lua 5.4

  Since Lua 5.4 require() returns module pathname in 2nd result.
]]

--[[
  This is root-level module with zero dependencies

  It's similar by design with [base]. Internally we're using similar
  sequence for calls tracking.

  But [base] uses it mainly for request() -- relative require().
  We are using it to store dependencies and modules locations.

  List of used modules is crucial for deploy scripts.

  Locations are very neat addition. Processing package.path "manually"
  is not fun.

  dependencies can be used to build nice graphs.
  (Yes, it's not crucial, currently not used, and occupies most of
  code. Still, we consider this as important.)
]]

local module_paths
local dependencies

local observe_require
local unobserve_require
do
  local original_require
  local create_observer
  do
    local before
    local after
    do
      local set
      local get
      local dive
      local raise
      do
        local call_chain = { '' }
        local pos = 1

        set =
          function(dest)
            call_chain[pos] = dest
          end

        get =
          function()
            return call_chain[pos]
          end

        dive =
          function()
            pos = pos + 1
          end

        raise =
          function()
            pos = pos - 1
          end
      end

      do
        local add_dependency =
          function(from, to)
            dependencies[from] = dependencies[from] or { }
            dependencies[from][to] = true
          end

        before =
          function(args)
            local src = get()
            local dest = args[1]

            dive()
            set(dest)

            add_dependency(src, dest)
          end
      end

      do
        local set_module_path =
          function(name, path)
            module_paths[#module_paths + 1] = { name, path }
          end

        after =
          function(args)
            local module_path = args[2]
            if module_path then
              local module_name = get()
              set_module_path(module_name, module_path)
            end

            raise()
          end
      end
    end

    local tbl_pack = table.pack
    local tbl_unpack = table.unpack

    create_observer =
      function(main)
        return
          function(...)
            before(tbl_pack(...))
            local results = tbl_pack(main(...))
            after(results)
            return tbl_unpack(results)
          end
      end
  end

  observe_require =
    function()
      original_require = require
      require = create_observer(require)
    end

  unobserve_require =
    function()
      require = original_require
    end
end

-- Export:
return
  function(modules)
    module_paths = { }
    dependencies = { }

    observe_require()

    for _, module_name in ipairs(modules) do
      require(module_name)
    end

    unobserve_require()

    for _, module_loc in ipairs(module_paths) do
      package.loaded[module_loc[1]] = nil
    end

    return module_paths, dependencies
  end

--[[
  2026-09-24
]]
