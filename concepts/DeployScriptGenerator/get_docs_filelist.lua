-- Return list of documentation files for given list of ".lua" files

--[[
  Author: Martin Eden
  Last mod.: 2026-05-29
]]

--[[
  Input

    [t] FilesList -- Strings list. Each entry is pathname.

  Output

    [t] -- documentation files pathnames list

      Each entry is pathname to documentation file.
      We guarantee there will be no duplicate entries.
      Only files that really exists are included.
]]

-- Imports:
local path_is_dir = request('!.concepts.path_name.is_directory')
local parse_pathname = request('!.concepts.path_name.parse')
local FilesLister = request('!.concepts.FilesLister.Interface')
local add_to_list = request('!.concepts.list.add_item')

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

local is_documentation_name =
  function(filename)
    for _, regexp_str in ipairs(DocNameRegexps) do
      if string.find(filename, regexp_str) then
        return true
      end
    end

    return false
  end

local get_docs_filelist =
  function(FilesList)
    local Result = { }

    local ProcessedDirectories_Map = { }

    for _, module_pathname in ipairs(FilesList) do
      assert(not path_is_dir(module_pathname))

      local ParsedPathname = parse_pathname(module_pathname)

      local module_dirname = ParsedPathname.HostDir

      if ProcessedDirectories_Map[module_dirname] then goto next end

      FilesLister:SetBaseDirectory(module_dirname)

      local Files = FilesLister:GetFiles()

      for _, filename in ipairs(Files) do
        if is_documentation_name(filename) then
          local doc_pathname = module_dirname .. filename

          add_to_list(Result, doc_pathname)
        end
      end

      ProcessedDirectories_Map[module_dirname] = true

      ::next::
    end

    return Result
  end

-- Export:
return get_docs_filelist

--[[
  2018 #
  2024 # #
  2026-05-11
  2026-05-28
]]
