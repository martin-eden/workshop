-- Annotated lines format adapter

--[[
  Design

    Load(string): table, table

      Parse string with "annotated lines" to table indexed by key names.
      Second result is string list of problems. Ideally empty.

    Save(table [, table]): string

      Serialize table with string key/values. Second optional argument
      is a list with keys to serialize them in that order.

  See [ReadMe] and specific files for more info.
]]

-- Last mod.: 2024-03-03

return
  {
    Load = request('Load'),
    Save = request('Save'),
  }
