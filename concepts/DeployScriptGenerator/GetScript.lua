-- Generate string with deploy script

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

--[[
  Input

    [t] Me
    [t] Modules -- strings list with Lua root module names
]]

-- ( Imports
local add_dir_postfix = request('!.string.file_name.add_dir_postfix')
local get_modules_filelist = request('get_modules_filelist')
local get_docs_filelist = request('get_docs_filelist')
local add_to_list = request('!.concepts.list.add_item')
local BashScriptWriter = request('!.concepts.BashScriptWriter.Interface')

local get_package_config = request('!.system.get_package_config')
local quote_regexp = request('!.lua.regexp.quote')
-- )

local name_sep = quote_regexp('.')
local dirs_sep
do
  local PackageConfig = get_package_config()

  dirs_sep = PackageConfig.dirs_sep
end
dirs_sep = quote_regexp(dirs_sep)

local get_module_base_pathname =
  function(module_name)
    return string.gsub(module_name, name_sep, dirs_sep)
  end

local get_module_lua_pathname =
  function(module_name)
    return get_module_base_pathname(module_name) .. '.lua'
  end

local get_module_bin_pathname =
  function(module_name)
    return get_module_base_pathname(module_name) .. '.so'
  end

local GetScript =
  function(Me, Modules)
    local deploy_dir = Me.deploy_dir
    assert_string(deploy_dir)

    deploy_dir = add_dir_postfix(deploy_dir)

    local CodeFiles = get_modules_filelist(Modules)

    local DocFiles = { }

    if Me.include_docs then
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
return GetScript

--[[
  2018
  2026-05 # #
  2026-06-05
]]
