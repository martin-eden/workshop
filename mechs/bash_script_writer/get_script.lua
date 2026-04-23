-- Return bash script that copies files with directories creation

--[[
  Author: Martin Eden
  Last mod.: 2026-04-23
]]

-- Imports:
local Lines = request('!.concepts.Lines.Interface')
local ParsePathname = request('!.concepts.path_name.parse')
local GetCmd_RmDir = request('!.mechs.cmdline.get_cmd_rmdir')
local GetCmd_MkDir = request('!.mechs.cmdline.get_cmd_mkdir')
local GetCmd_CopyFile = request('!.mechs.cmdline.get_cmd_copy')

--[[
  Compare file pathnames first by name then by depth
]]
local ComparePathnames =
  function(Rec_A, Rec_B)
    local A_Name, B_Name = Rec_A.src_name, Rec_B.src_name
    local A_Depth = #ParsePathname(A_Name).Path
    local B_Depth = #ParsePathname(B_Name).Path

    if (A_Name < B_Name) then return true end
    if (A_Name > B_Name) then return false end

    if (A_Depth < B_Depth) then return false end
    if (A_Depth > B_Depth) then return true end

    return false
  end

--[[
  For "a/b/c/" mark as created "a/", "a/b/" and "a/b/c".
]]
local MarkDirectoriesCreated =
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
local GetScript =
  function(Self)
    local Lines = new(Lines)

    local AddLine =
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

    local DirectoriesCreated = {}

    table.sort(Self.files_to_copy, ComparePathnames)

    local PrevDestDir = ''
    for _, CopyRec in ipairs(Self.files_to_copy) do
      local SrcFullName = CopyRec.src_name
      local DestFullName = CopyRec.dest_name
      local DestDir = ParsePathname(DestFullName).Directory
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
