-- Create deploy filelist

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

--[[
  For list of pathnames and deploy directory, return list of records
  "from-to" with pathnames.

  Optionally can add to this list documentation files from
  related directories.

  Input

    1 [t] -- list of file names
    2 [s] -- deploy directory
    3 [b] -- also locate and copy documentation files

  Output

    [t] -- list of pairs
      1 [s] source pathname
      2 [s] destination pathname
]]

local get_docs_filelist = request('get_docs_filelist')
local add_separator = request('!.concepts.path_name.add_separator')
local add_to_list = request('!.concepts.list.add_item')
local rebase_to = request('!.concepts.path_name.rebase_to')

return
  function(pathnames, deploy_dir, include_docs)
    deploy_dir = add_separator(deploy_dir)

    local result = { }

    if include_docs then
      for _, src_pathname in ipairs(get_docs_filelist(pathnames)) do
        add_to_list(
          result,
          { src_pathname, rebase_to(deploy_dir, src_pathname) }
        )
      end
    end

    for _, src_pathname in ipairs(pathnames) do
      add_to_list(
        result,
        { src_pathname, rebase_to(deploy_dir, src_pathname) }
      )
    end

    return result
  end

--[[
  2016 #
  2017 # #
  2018 # # # #
  2026 # # # # # # #
]]
