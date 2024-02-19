-- Create files tree

--[[
  Input

    table of
    ~~~~~~~~
      Self

      [string] = string or Self
      ~~~~~~~~   ~~~~~~~~~~~~~~
        Name        Contents

  Output

    Table with sequence of strings.

    Each string describes problem encountered.

    In case of no problems table is empty.
]]

--[[
  Example

    {
      ['/tmp/test/'] =
        {
          ['test'] = 'Test content.\n',
          ['empty_dir/'] = {},
          ['empty_file'] = '',
        }
    }
]]

--[[
  Version: 3
  Last mod.: 2024-02-19
]]

local OrderedPass = request('!.table.ordered_pass')

local ParsePathName = request('!.file_system.parse_pathname')
local CreateDir = request('!.file_system.directory.create')
local CreateFile = request('!.file_system.file.create')

--[[
  Handle DirTree structure: if key is a string and value is a table then
  create directory with key name and do a recursive call.

  It's not possible to change current directory in Lua in Linux:
  "os.execute('cd test/')" will spawn child process and change directory
  for it. So instead we are passing additional string <DirPrefix> in
  recursive call.
]]

local CreateTree

CreateTree =
  function(DirPrefix, DirTree, Problems)
    assert_string(DirPrefix)
    assert_table(DirTree)
    assert_table(Problems)

    for PathName, Contents in pairs(DirTree) do
      assert_string(PathName)
      assert(is_string(Contents) or is_table(Contents))
    end

    for PathName, Contents in OrderedPass(DirTree) do
      local FullPathname = DirPrefix .. PathName
      local Path, Name = ParsePathName(FullPathname)

      if (Path ~= '') then
        -- Create directory at path (existing directory is okay).
        if not CreateDir(Path) then
          -- We can't create directory.
          local ProblemMsgFmt = 'Problem creating directory "%s".'
          local ProblemMsg = string.format(ProblemMsgFmt, Path)
          table.insert(Problems, ProblemMsg)
          goto Continue
        end
      end

      if is_string(Contents) then
        -- Okay, create file and write <Contents> to it.
        CreateFile(FullPathname, Contents)
      elseif is_table(Contents) then
        -- Recursive call.
        CreateTree(Path, Contents, Problems)
      end

      ::Continue::
    end
  end

local CreateTree_Outer =
  function(DirTree)
    local Problems = {}
    CreateTree('', DirTree, Problems)
    return Problems
  end

return CreateTree_Outer
