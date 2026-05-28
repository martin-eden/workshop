-- Prepare list of files to copy

--[[
  Author: Martin Eden
  Last mod.: 2026-05-28
]]

--[[
  Input

    [t] Me
    [t] Modules -- strings list with Lua root module names
    [?s] deploy_dir -- directory name where to copy files
      Default: "deploy"
]]

-- Imports:
local get_docs = request('get_docs')
local add_dir_postfix = request('!.string.file_name.add_dir_postfix')
local get_modules_dependencies = request('!.system.get_modules_dependencies')
local get_module_location = request('!.system.get_module_location')
local strip_updirs = request('!.string.file_name.strip_updirs')
local add_to_list = request('!.concepts.list.add_item')

local Populate =
  function(Me, Modules, deploy_dir)
    deploy_dir = deploy_dir or 'deploy'
    assert_string(deploy_dir)

    deploy_dir = add_dir_postfix(deploy_dir)

    Me.BashScriptWriter:DeleteDir(deploy_dir)

    local ModulesRequired = get_modules_dependencies(Modules)

    local FilesRequired = { }

    for _, module in ipairs(ModulesRequired) do
      local module_pathname = get_module_location(module)

      local dest_pathname = deploy_dir .. strip_updirs(module_pathname)

      Me.BashScriptWriter:CopyFile(module_pathname, dest_pathname)

      add_to_list(FilesRequired, module_pathname)
    end

    if Me.DeployDocs then
      local Docs = get_docs(FilesRequired)

      for _, doc_pathname in ipairs(Docs) do
        local dest_pathname = deploy_dir .. strip_updirs(doc_pathname)

        Me.BashScriptWriter:CopyFile(doc_pathname, dest_pathname)
      end
    end
  end

-- Export:
return Populate

--[[
  2018
  2026-05-28
]]
