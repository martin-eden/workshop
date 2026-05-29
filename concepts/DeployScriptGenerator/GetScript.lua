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

-- Imports:
local add_dir_postfix = request('!.string.file_name.add_dir_postfix')
local get_modules_filelist = request('get_modules_filelist')
local get_docs_filelist = request('get_docs_filelist')
local add_list = request('!.concepts.list.add_list')
local BashScriptWriter = request('!.concepts.BashScriptWriter.Interface')
local strip_updirs = request('!.string.file_name.strip_updirs')

local GetScript =
  function(Me, Modules)
    local deploy_dir = Me.deploy_dir
    assert_string(deploy_dir)

    deploy_dir = add_dir_postfix(deploy_dir)

    local CodeFiles = get_modules_filelist(Modules)

    local DocFiles = { }

    if Me.include_docs then
      DocFiles = get_docs_filelist(CodeFiles)
    end

    local FilesToCopy = { }
    add_list(FilesToCopy, CodeFiles)
    add_list(FilesToCopy, DocFiles)

    local ScriptWriter = new(BashScriptWriter)

    ScriptWriter:DeleteDir(deploy_dir)

    for _, pathname in ipairs(FilesToCopy) do
      local dest_pathname = deploy_dir .. strip_updirs(pathname)

      ScriptWriter:CopyFile(pathname, dest_pathname)
    end

    return ScriptWriter:GetScript()
  end

-- Export:
return GetScript

--[[
  2018
  2026-05-28
  2026-05-29
]]
