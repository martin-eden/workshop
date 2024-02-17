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

-- Last mod.: 2024-02-17

local OrderedPass = request('!.table.ordered_pass')
local IsEmptyString = request('!.string.is_empty')

local IsFile = request('!.file_system.is_file')
local IsDirectory = request('!.file_system.is_directory')
local RemoveFile = request('!.file_system.file.remove')
local RemoveDirectory = request('!.file_system.directory.remove')

local RemoveTree

RemoveTree =
  function(DirTree)
    assert_table(DirTree)

    for Name, Value in pairs(DirTree) do
      assert_string(Name)

      assert(is_string(Value) or is_table(Value))
      if is_string(Value) then
        assert(IsEmptyString(Value))
      end
    end

    for Name, Value in OrderedPass(DirTree) do
      if is_string(Value) then
        if IsFile(Name) then
          RemoveFile(Name)
        elseif IsDirectory(Name) then
          RemoveDirectory(Name)
        end
      elseif is_table(Value) then
        RemoveTree(Value)
      end
    end

  end

return RemoveTree
