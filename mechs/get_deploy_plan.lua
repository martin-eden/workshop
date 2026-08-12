-- Create deploy filelist

--[[
  Author: Martin Eden
  Last mod.: 2026-08-12
]]

--[[
  Given root modules list and deploy config, resolve full module
  dependencies and (optionally) documentation files sitting next
  to them.

  Return flat list of "where file is now" / "where it should end up"
  pairs.

  Input
    [t] Modules -- list of Lua root module names
    [t] Config -- deploy configuration
      [?s] deploy_dir -- deploy directory
        Default: "deploy/"
      [?b] include_docs -- also locate and copy documentation files
        Default: true

  Output
    [t] -- list of tables (pairs)
      1 [s] source pathname
      2 [s] destination pathname
]]

-- Imports:
local get_modules_filelist = request('get_deploy_plan.get_modules_filelist')
local get_docs_filelist = request('get_deploy_plan.get_docs_filelist')

local add_separator = request('!.concepts.path_name.add_separator')
local add_to_list = request('!.concepts.list.add_item')
local rebase_to = request('!.concepts.path_name.rebase_to')

local get_module_lua_pathname, get_module_bin_pathname
do
  local get_module_base_pathname
  do
    local quote_regexp = request('!.lua.regexp.quote')

    local names_sep = quote_regexp('.')

    local dirs_sep
    do
      local get_package_config = request('!.system.get_package_config')

      dirs_sep = quote_regexp(get_package_config().dirs_sep)
    end

    get_module_base_pathname =
      function(module_name)
        return string.gsub(module_name, names_sep, dirs_sep)
      end
  end

  get_module_lua_pathname =
    function(module_name)
      return get_module_base_pathname(module_name) .. '.lua'
    end

  get_module_bin_pathname =
    function(module_name)
      return get_module_base_pathname(module_name) .. '.so'
    end
end

local DefaultConfig =
  {
    deploy_dir = 'deploy/',
    include_docs = true,
  }

local get_deploy_plan =
  function(Modules, ArgConfig)
    local Config = new(DefaultConfig, ArgConfig)

    local deploy_dir = Config.deploy_dir
    local include_docs = Config.include_docs

    assert_string(deploy_dir)

    deploy_dir = add_separator(deploy_dir)

    local CodeFiles = get_modules_filelist(Modules)

    local DocFiles = { }

    if include_docs then
      local CodeFilesList = { }
      for _, Rec in ipairs(CodeFiles) do
        add_to_list(CodeFilesList, Rec.file)
      end
      DocFiles = get_docs_filelist(CodeFilesList)
    end

    local Result = { }

    for _, Rec in ipairs(CodeFiles) do
      local module_name = Rec.module
      local src_pathname = Rec.file
      local dest_pathname = deploy_dir

      if Rec.is_binary then
        dest_pathname =
          dest_pathname .. get_module_bin_pathname(module_name)
      else
        dest_pathname =
          dest_pathname .. get_module_lua_pathname(module_name)
      end

      add_to_list(Result, { src_pathname, dest_pathname })
    end

    for _, src_pathname in ipairs(DocFiles) do
      local dest_pathname = rebase_to(deploy_dir, src_pathname)

      add_to_list(Result, { src_pathname, dest_pathname })
    end

    return Result
  end

-- Export:
return get_deploy_plan

--[[
  2016
  2017 # #
  2018 # # # #
  2026 # # # #
  2026-08-12
]]
