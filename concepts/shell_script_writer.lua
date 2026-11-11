-- Shell script writer

--[[
  Author: Martin Eden
  Last mod.: 2026-11-11
]]

--[[
  Storage format

    1 [t] -- list of directories to delete
      0+ [s] -- directory pathname
    2 [t] -- list of files to copy
      1 [s] -- source pathname
      2 [s] -- destination pathname
]]

local add_to_list = request('!.concepts.list.add_item')

local delete_dir =
  function(me, dir_name)
    add_to_list(me[1], dir_name)
  end

local copy_file
do
  local normalize = request('!.concepts.path_name.normalize')
  copy_file =
    function(me, src_name, dest_name)
      add_to_list(
        me[2],
        { normalize(src_name), normalize(dest_name) }
      )
    end
end

local get_script = request('shell_script_writer.get_script')

local interface
local create
do
  local attach_methods = request('!.table.attach_methods')
  create =
    function()
      local me = { { }, { } }
      attach_methods(me, interface)
      return me
    end
end

interface =
  {
    create = create,
    delete_dir = delete_dir,
    copy_file = copy_file,
    get_script = get_script,
  }

-- Export:
return interface

--[[
  2018
  2019
  2026-05-28
]]
