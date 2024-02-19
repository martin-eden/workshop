-- Remove files tree

--[[
  Input

    table of
    ~~~~~~~~
      Self

      [Name] = Contents
      ~~~~~~   ~~~~~~~~
      string   "" or Self

  Output

    nil
]]

--[[
  Remove empty directory:

    { ['/tmp/test/'] = '' }

  Do not remove empty directory:

    { ['/tmp/test/'] = {} }
]]

--[[
  Version: 2
  Last mod.: 2024-02-19
]]

local OrderedPass = request('!.table.ordered_pass')
local IsEmptyString = request('!.string.is_empty')

local ParsePathName = request('!.file_system.parse_pathname')
local IsFile = request('!.file_system.is_file')
local IsDirectory = request('!.file_system.is_directory')
local RemoveFile = request('!.file_system.file.remove')
local RemoveDirectory = request('!.file_system.directory.remove')

local RemoveTree

RemoveTree =
  function(DirPrefix, DirTree)
    assert_string(DirPrefix)
    assert_table(DirTree)

    for PathName, Contents in pairs(DirTree) do
      assert_string(PathName)

      assert(is_string(Contents) or is_table(Contents))
      if is_string(Contents) then
        assert(IsEmptyString(Contents))
      end
    end

    for PathName, Contents in OrderedPass(DirTree) do
      local FullPathname = DirPrefix .. PathName
      local Path, Name = ParsePathName(FullPathname)
      if is_string(Contents) then
        if (Name == '') then
          RemoveDirectory(Path)
        elseif (Name ~= '') then
          RemoveFile(FullPathname)
        end
      elseif is_table(Contents) then
        RemoveTree(Path, Contents)
      end
    end

  end

local RemoveTree_Outer =
  function(DirTree)
    RemoveTree('', DirTree)
  end

return RemoveTree_Outer
