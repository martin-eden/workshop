-- List of lines interface

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

--[[
  This class is about storing list of lines

  Lines are stored as strings (without newlines).

  Also we're providing convenience methods for indentation.
]]

-- Export:
return
  {
    -- Import/export:
    FromString = request('FromString'),
    ToString = request('ToString'),

    -- Access:

    GetNumLines = request('GetNumLines'),

    IsOneLine = request('IsOneLine'),

    GetLineAt = request('GetLineAt'),
    SetLineAt = request('SetLineAt'),

    GetFirstLine = request('GetFirstLine'),
    GetLastLine = request('GetLastLine'),

    InsertLineBefore = request('InsertLineBefore'),
    InsertLineAfter = request('InsertLineAfter'),

    AddFirstLine = request('AddFirstLine'),
    AddLastLine = request('AddLastLine'),

    RemoveLineAt = request('RemoveLineAt'),

    RemoveFirstLine = request('RemoveFirstLine'),
    RemoveLastLine = request('RemoveLastLine'),

    -- Indentation:
    Indent = request('Indent'),
    Unindent = request('Unindent'),

    -- Internals:

    Lines = {},
    IndentChunk = '  ',
    AssertValidIndex = request('AssertValidIndex'),
    AssertValidValue = request('AssertValidValue'),
  }

--[[
  2024-10-31
  2026-04-17
  2026-04-26
]]
