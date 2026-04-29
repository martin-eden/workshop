-- Return list of documentation files for given list of ".lua" files

--[[
  Author: Martin Eden
  Last mod.: 2026-05-11
]]

--[[
  Input

    table - self

    table - files list

      String list. Each entry is pathname.

  Output

    table - docs list

      String list. Each entry is pathname to documentation file.
      We guarantee there will be no duplicate entries.
      Only files that really exists are included.
]]

-- Imports:
local ParsePathname = request('!.concepts.path_name.parse')
local PathIsDir = request('!.concepts.path_name.is_directory')
local FilesLister = request('!.concepts.FilesLister.Interface')

-- Regexps for documentation file names
local DocNameRegexps =
  {
    --[[
      ".+" - filler
      "%." - dot
      "txt$" - ends with "txt"
      "[mM]" - "m" or "M"
    ]]
    '.+%.txt$',
    '.+%.md$',
    '.+%.[mM]ark[dD]own$',
    '.+%.[iI]s'
  }

local IsDocumentationName =
  function(FileName)
    for Index, Regexp in ipairs(DocNameRegexps) do
      if string.find(FileName, Regexp) then
        return true
      end
    end

    return false
  end

return
  function(self, FileList)
    local Result = {}

    local ProcessedDirectories = {}
    for Index, Pathname in ipairs(FileList) do
      local ParsedPathname = ParsePathname(Pathname)

      assert(not PathIsDir(Pathname))

      local Dirname = ParsedPathname.HostDir

      if ProcessedDirectories[Dirname] then
        goto Continue
      end

      FilesLister:SetBaseDirectory(Dirname)
      local Files = FilesLister:GetFiles()

      for Index, FileName in ipairs(Files) do
        if IsDocumentationName(FileName) then
          local FullFileName = Dirname .. FileName
          table.insert(Result, FullFileName)
        end
      end

      ProcessedDirectories[Dirname] = true

      ::Continue::
    end

    return Result
  end

--[[
  2018 #
  2024 # #
  2026-05-11
]]
