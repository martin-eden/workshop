-- List of lines interface

-- Last mod.: 2024-10-31

-- "Line" is a string with newline. "String" is a line without newline.

--[[
  This class is about storing list of lines.

  Lines are stored as strings (without newlines).

  Text output facilities work with lines, not with multiline
  strings. Among other things they want indentation. We're
  providing indentation. They want add header or footer. We're
  providing that.
]]

-- Exports:
return
  {
    -- Import/export:

    -- Import: Explode string to list of lines
    FromString = request('FromString'),

    -- Export: Implode list of lines to string
    ToString = request('ToString'),

    -- Access:

    -- Meta: get number lines
    GetNumLines = request('GetNumLines'),

    -- MetaMeta: is one line?
    IsOneLine = request('IsOneLine'),

    -- Access: get string at given line
    GetLineAt = request('GetLineAt'),

    -- Access: set string at given line
    SetLineAt = request('SetLineAt'),

    -- Meta: get first line string
    GetFirstLine = request('GetFirstLine'),

    -- Meta: get last line string
    GetLastLine = request('GetLastLine'),

    -- Modification:

    -- Add string to start of list
    AddFirstLine = request('AddFirstLine'),

    -- Add string to end of list
    AddLastLine = request('AddLastLine'),

    -- Insert string before line at given index
    InsertLineBefore = request('InsertLineBefore'),

    -- Insert string after line at given index
    InsertLineAfter = request('InsertLineAfter'),

    -- Remove line
    RemoveLineAt = request('RemoveLineAt'),

    -- Indentation:

    -- Indent
    Indent = request('Indent'),

    -- Unindent
    Unindent = request('Unindent'),

    -- Internals:

    -- Internal: list of lines
    Lines = {},

    -- Config: indent chunk
    IndentChunk = '  ',

    -- Internal: assert that value is valid index
    AssertValidIndex = request('AssertValidIndex'),

    -- Internal: assert that value is string without newlines
    AssertValidValue = request('AssertValidValue'),
  }

--[[
  2024-10-31
]]
