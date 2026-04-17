-- Return bash script that copies files with directories creation

--[[
  Author: Martin Eden
  Last mod.: 2026-04-17
]]

-- Imports:
local <const> Lines = request('!.concepts.Lines.Interface')
local <const> ParsePathname = request('!.concepts.path_name.parse')
local <const> GetCmd_RmDir = request('!.mechs.cmdline.get_cmd_rmdir')
local <const> GetCmd_MkDir = request('!.mechs.cmdline.get_cmd_mkdir')
local <const> GetCmd_CopyFile = request('!.mechs.cmdline.get_cmd_copy')

--[[
  Compare file pathnames preferring files in deeper directories
]]
local <const> ComparePathnames =
  function(Rec_A, Rec_B)
    local <const> A_Name, B_Name = Rec_A.src_name, Rec_B.src_name
    local <const> A_Depth = #ParsePathname(A_Name).path
    local <const> B_Depth = #ParsePathname(B_Name).path

    if (A_Depth < B_Depth) then return false end
    if (A_Depth > B_Depth) then return true end

    if (A_Name < B_Name) then return true end
    if (A_Name > B_Name) then return false end

    return false
  end

--[[
  For "a/b/c/" mark as created "a/", "a/b/" and "a/b/c".
]]
local <const> MarkDirectoriesCreated =
  function(DirPathName, DirectoriesCreated)
    local ParentDirPath = ''
    for DirName in DirPathName:gmatch('(.-)/') do
      ParentDirPath = ParentDirPath .. DirName
      ParentDirPath = ParentDirPath .. '/'
      DirectoriesCreated[ParentDirPath] = true
    end
    DirectoriesCreated[DirPathName] = true
  end

--[[
  Generate Bash script that copies all planned files with directories
  creation.

  Serializes object state to string.

  * Deepest directories are created first. This is to reduce number of
    "mkdir" commands: "mkdir -p a/b/" is better than "mkdir -p a/;
    mkdir -p a/b/". To reach this goal we sort files list.
]]
local <const> GetScript =
  function(Self)
    local <const> Lines = new(Lines)

    local <const> AddLine =
      function(Line)
        Lines:AddLastLine(Line)
      end

    AddLine('#! /bin/bash')

    if (#Self.dirs_to_delete > 0) then
      AddLine('')
    end

    table.sort(Self.dirs_to_delete)
    for i, DirPathName in ipairs(Self.dirs_to_delete) do
      AddLine(GetCmd_RmDir(DirPathName))
    end

    local <const> DirectoriesCreated = {}

    table.sort(Self.files_to_copy, ComparePathnames)

    local PrevDestDir = ''
    for _, CopyRec in ipairs(Self.files_to_copy) do
      local <const> SrcFullName = CopyRec.src_name
      local <const> DestFullName = CopyRec.dest_name
      local <const> DestDir = ParsePathname(DestFullName).directory
      if (DestDir ~= PrevDestDir) then
        AddLine('')
        PrevDestDir = DestDir
      end
      if not DirectoriesCreated[DestDir] then
        AddLine(GetCmd_MkDir(DestDir))

        MarkDirectoriesCreated(DestDir, DirectoriesCreated)
      end
      AddLine(GetCmd_CopyFile(SrcFullName, DestFullName))
    end

    return Lines:ToString()
  end

-- Export:
return GetScript

--[[
  2018-06-06
  2019-05-13
  2026-04-17
]]
