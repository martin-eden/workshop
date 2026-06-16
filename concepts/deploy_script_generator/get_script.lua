-- Generate string with deploy script

--[[
  Author: Martin Eden
  Last mod.: 2026-06-16
]]

--[[
  Return string with shell script to copy given modules with
  their dependencies.

  Input
    [t] Modules -- list of Lua module names
    [t] Config -- deploy configuration
      [?s] deploy_dir -- deploy directory.
        Default: "deploy/"
      [?b] include_docs -- also locate and copy documentation files.
        Default: true
]]

-- ( Imports
local get_modules_filelist = request('Internals.get_modules_filelist')
local get_docs_filelist = request('Internals.get_docs_filelist')

local BashScriptWriter = request('!.concepts.BashScriptWriter.Interface')

local add_dir_postfix = request('!.concepts.path_name.add_dir_postfix')
local add_to_list = request('!.concepts.list.add_item')
local strip_updirs = request('!.string.file_name.strip_updirs')
local quote_regexp = request('!.lua.regexp.quote')
-- )

local names_sep = quote_regexp('.')

local dirs_sep
do
  -- Imports:
  local get_package_config = request('!.system.get_package_config')

  local PackageConfig = get_package_config()

  dirs_sep = quote_regexp(PackageConfig.dirs_sep)
end

local get_module_base_pathname =
  function(module_name)
    return string.gsub(module_name, names_sep, dirs_sep)
  end

local get_module_lua_pathname =
  function(module_name)
    return get_module_base_pathname(module_name) .. '.lua'
  end

local get_module_bin_pathname =
  function(module_name)
    return get_module_base_pathname(module_name) .. '.so'
  end

local DefaultConfig =
  {
    deploy_dir = 'deploy/',
    include_docs = true,
  }

local get_script =
  function(Modules, ArgConfig)
    local Config = new(DefaultConfig, ArgConfig)

    local deploy_dir = Config.deploy_dir
    local include_docs = Config.include_docs

    assert_string(deploy_dir)

    deploy_dir = add_dir_postfix(deploy_dir)

    local CodeFiles = get_modules_filelist(Modules)

    local DocFiles = { }

    if include_docs then
      local CodeFilesList = { }
      for _, rec in ipairs(CodeFiles) do
        add_to_list(CodeFilesList, rec.file)
      end
      DocFiles = get_docs_filelist(CodeFilesList)
    end

    local ScriptWriter = new(BashScriptWriter)

    ScriptWriter:DeleteDir(deploy_dir)

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

      ScriptWriter:CopyFile(src_pathname, dest_pathname)
    end

    for _, src_pathname in ipairs(DocFiles) do
      local dest_pathname = deploy_dir .. strip_updirs(src_pathname)

      ScriptWriter:CopyFile(src_pathname, dest_pathname)
    end

    return ScriptWriter:GetScript()
  end

-- Export:
return get_script

--[[
  2016
  2017 # #
  2018 # # # #
  2026-05 # #
  2026-06-05
  2026-06-12
]]
