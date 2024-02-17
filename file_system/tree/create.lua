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
  Version: 2
  Last mod.: 2024-02-17
]]

local OrderedPass = request('!.table.ordered_pass')

local ParsePathName = request('!.file_system.parse_pathname')
local CreateDirectory = request('!.file_system.directory.create')
local CreateFile = request('!.file_system.file.create')

local CreateTree

CreateTree =
  function(DirTree, Problems)
    assert_table(DirTree)
    assert_table(Problems)

    for PathName, Contents in pairs(DirTree) do
      assert_string(PathName)
      assert(is_string(Contents) or is_table(Contents))
    end

    for PathName, Contents in OrderedPass(DirTree) do
      if is_string(Contents) then
        -- Parse pathname to path and name
        local Path, Name = ParsePathName(PathName)
        if (Path ~= '') then
          -- Create directory at path (existing directory is okay).
          if not CreateDirectory(Path) then
            -- We can't create directory.
            local ProblemMsgFmt = 'Problem creating directory "%s".'
            local ProblemMsg = string.format(ProblemMsgFmt, Path)
            table.insert(Problems, ProblemMsg)
            goto Continue
          end
        end
        CreateFile(PathName, Contents)
      elseif is_table(Contents) then
        CreateTree(Contents, Problems)
      end
      ::Continue::
    end
  end

local CreateTree_Outer =
  function(DirTree)
    local Problems = {}
    CreateTree(DirTree, Problems)
    return Problems
  end

return CreateTree_Outer
