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

    Each string describes action done (file or directory created)
    of problem encountered while doing this.
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
  Version: 4
  Last mod.: 2024-02-29
]]

local OrderedPass = request('!.table.ordered_pass')

local ParsePathName = request('!.file_system.parse_pathname')
local DirectoryExists = request('!.file_system.directory.exists')
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
  function(DirPrefix, DirTree, Report)
    assert_string(DirPrefix)
    assert_table(DirTree)
    assert_table(Report)

    for PathName, Contents in pairs(DirTree) do
      assert_string(PathName)
      assert(is_string(Contents) or is_table(Contents))
    end

    for PathName, Contents in OrderedPass(DirTree) do
      local FullPathname = DirPrefix .. PathName
      local Path, Name = ParsePathName(FullPathname)

      if (Path ~= '') then
        if not DirectoryExists(Path) then
          -- Create directory at path.
          if not CreateDir(Path) then
            -- We can't create directory.
            local ProblemMsgFmt = 'Problem creating directory "%s".'
            local ProblemMsg = string.format(ProblemMsgFmt, Path)
            table.insert(Report, ProblemMsg)
            goto Continue
          end
          table.insert(
            Report,
            string.format('Created directory "%s".', Path)
          )
        end
      end

      if is_string(Contents) then
        -- Okay, create file and write <Contents> to it.
        CreateFile(FullPathname, Contents)
        table.insert(
          Report,
          string.format('Created file "%s".', FullPathname)
        )
      elseif is_table(Contents) then
        -- Recursive call.
        CreateTree(Path, Contents, Report)
      end

      ::Continue::
    end
  end

local CreateTree_Outer =
  function(DirTree)
    local Report = {}
    CreateTree('', DirTree, Report)
    return Report
  end

return CreateTree_Outer

--[[
  2024-02-19
  2024-02-29
]]
