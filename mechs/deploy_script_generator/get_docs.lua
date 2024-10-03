-- Return table list of documentation files for given list of ".lua" files

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

  Details

    We are working directory-wise and considering that file is
    documentation just by it's extension.

    Previous implementation picked documentation by module-dependent
    name and extension. Plus hardcoded names. Hardcoded list was never
    enough. Module-dependent name was not used widely enough.
]]

-- Last mod.: 2024-10-03

local ParsePathname = request('!.concepts.path_name.parse')
local FileLister = request('!.mechs.file_lister.interface')

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
    '.+%.[mM]ark[dD]own',
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

      assert(not ParsedPathname.is_directory)

      local Dirname = ParsePathname(Pathname).directory

      if ProcessedDirectories[Dirname] then
        goto Continue
      end

      FileLister.start_dir = Dirname
      FileLister:init()
      local Files = FileLister:get_files_list()

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
  2018-06-05
  2024-03-05
  2024-10-03
]]
