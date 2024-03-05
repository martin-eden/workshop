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

    Given pathname "d/e.lua" we check for existence following names:

      "d/wtf.txt"
      "d/e.txt"
]]

-- Last mod.: 2024-03-05

local parse_pathname = request('!.concepts.path_name.parse')
local exists = request('!.file_system.file.exists')
local get_keys = request('!.table.get_keys')

return
  function(self, files)
    local docs = {}
    local was_checked = {}
    for i = 1, #files do
      local possible_docs =
        {
          files[i]:gsub('%.lua$', '.txt'),
          parse_pathname(files[i]).directory .. 'wtf.txt',
        }
      for _, file_name in ipairs(possible_docs) do
        if not was_checked[file_name] then
          if exists(file_name) then
            docs[file_name] = true
          end
          was_checked[file_name] = true
        end
      end
    end
    docs = get_keys(docs)
    return docs
  end

--[[
  2018-06-05
  2024-03-05
]]
