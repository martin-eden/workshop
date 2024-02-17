--[[
  Get documentation files for deploy script. Internal function.

  Files added:

    <directory> wtf.txt
    <directory> <name>.txt
]]

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
