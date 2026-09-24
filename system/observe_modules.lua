local ModulePaths = { }
local Dependencies = { }

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
        local CallChain = { '' }
        local pos = 1

        set =
          function(dest)
            CallChain[pos] = dest
          end

        get =
          function()
            return CallChain[pos]
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
            Dependencies[from] = Dependencies[from] or { }
            Dependencies[from][to] = true
          end

        before =
          function(Args)
            local src = get()
            local dest = Args[1]

            dive()
            set(dest)

            add_dependency(src, dest)
          end
      end

      do
        local set_module_path =
          function(name, path)
            ModulePaths[#ModulePaths + 1] = { name, path }
          end

        after =
          function(Args)
            local module_path = Args[2]
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
            local Results = tbl_pack(main(...))
            after(Results)
            return tbl_unpack(Results)
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
  function(Modules)
    observe_require()

    for _, module_name in ipairs(Modules) do
      require(module_name)
    end

    unobserve_require()

    for _, ModuleLoc in ipairs(ModulePaths) do
      local module_name = ModuleLoc[1]
      package.loaded[module_name] = nil
    end

    return ModulePaths, Dependencies
  end
