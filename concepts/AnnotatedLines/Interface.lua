-- Annotated lines format adapter

--[[
  Design

    Load(string): table

      Parse contents of file to table indexed by key names.

    Save(table): string

      Compile table with string key/values.

    Tools:

      SerializeKeyVal(string, string): string

        Serialize key-value.

      ParseLine(string): (string, string)

        Parse annotated line.

  See [ReadMe] and specific files for more info.
]]

-- Last mod.: 2024-02-28

return
  {
    Load = request('Load'),
    Save = request('Save'),
    --
    SerializeKeyVal = request('Compiler.SerializeKeyVal'),
    ParseLine = request('Parser.ParseLine'),
  }
