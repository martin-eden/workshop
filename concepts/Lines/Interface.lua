-- List of lines interface. Frontend

--[[
  Author: Martin Eden
  Last mod.: 2026-04-26
]]

--[[
  This class is about storing list of lines

  Lines are stored as strings (without newlines).

  Also we're providing convenience methods for indentation.
]]

local Core = request('Core.Interface')
local Indenter = request('Indent-Methods')

-- ( Core wrappers

-- String to lines list
local FromString =
  function(Me, str)
    local Core = Me.Core

    Core:FromString(str)
  end

-- Lines to string
local ToString =
  function(Me)
    local Core = Me.Core

    return Core:ToString()
  end

-- Return number of lines
local GetNumLines =
  function(Me)
    local Core = Me.Core

    return Core:GetNumItems()
  end

-- Return line's contents by index
local GetLineAt =
  function(Me, index)
    local Core = Me.Core

    Core:AssertValidIndex(index)

    return Core:GetItem(index)
  end

-- Set line at given index
local SetLineAt =
  function(Me, str, index)
    local Core = Me.Core

    Core:AssertValidValue(str)
    Core:AssertValidIndex(index)

    Core:SetItem(Core:ToItem(str), index)
  end

-- Insert line before given index
local InsertLineBefore =
  function(Me, str, index)
    local Core = Me.Core

    Core:AssertValidValue(str)
    Core:AssertValidIndex(index)

    Core:InsertItemBefore(Core:ToItem(str), index)
  end

-- Insert line after given index
local InsertLineAfter =
  function(Me, str, index)
    local Core = Me.Core

    Core:AssertValidValue(str)
    Core:AssertValidIndex(index)

    Core:InsertItemBefore(Core:ToItem(str), index + 1)
  end

-- Remove line at given index
local RemoveLineAt =
  function(Me, index)
    local Core = Me.Core

    Core:AssertValidIndex(index)

    Core:RemoveItemAt(index)
  end

-- ) Core wrappers

-- ( Extensions

-- Return true when we have just one line
local IsOneLine =
  function(Me)
    return (Me:GetNumLines() == 1)
  end

-- Return first line
local GetFirstLine =
  function(Me)
    return Me:GetLineAt(1)
  end

-- Return last line
local GetLastLine =
  function(Me)
    return Me:GetLineAt(Me:GetNumLines())
  end

-- Add line to start of list
local AddFirstLine =
  function(Me, str)
    Me:InsertLineBefore(Me.Core:ToItem(str), 1)
  end

-- Add string to end of list
local AddLastLine =
  function(Me, str)
    Me:InsertLineAfter(Me.Core:ToItem(str), Me:GetNumLines())
  end

-- Remove first line
local RemoveFirstLine =
  function(Me)
    Me:RemoveLineAt(1)
  end

-- Remove last line
local RemoveLastLine =
  function(Me)
    Me:RemoveLineAt(Me:GetNumLines())
  end

-- ) Extensions

-- Export:
return
  {
    -- Import/export:
    FromString = FromString,
    ToString = ToString,

    -- Access:

    GetNumLines = GetNumLines,

    IsOneLine = IsOneLine,

    GetLineAt = GetLineAt,

    GetFirstLine = GetFirstLine,
    GetLastLine = GetLastLine,

    SetLineAt = SetLineAt,

    InsertLineBefore = InsertLineBefore,
    InsertLineAfter = InsertLineAfter,

    AddFirstLine = AddFirstLine,
    AddLastLine = AddLastLine,

    RemoveLineAt = RemoveLineAt,

    RemoveFirstLine = RemoveFirstLine,
    RemoveLastLine = RemoveLastLine,

    -- Indentation:
    Indent = Indenter.Indent,
    Unindent = Indenter.Unindent,

    -- Internals:
    Core = Core,
  }

--[[
  2024 #
  2026-04-17
  2026-04-24
  2026-04-26
]]
