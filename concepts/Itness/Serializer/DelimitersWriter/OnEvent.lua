-- Serialization event handler

-- Last mod.: 2024-10-21

-- ( Delimiting functions

local EmptyFunc =
  function(self)
  end

local NewlineFunc =
  function(self)
    self:EmitNewline()
  end

local NewlineIndentFunc =
  function(self)
    self:EmitNewlineIndent()
  end

local SpaceFunc =
  function(self)
    self:Emit(self.Syntax.Delimiters.Space)
  end

-- ) Delimiting functions

--[[
  Decision matrix

  Return delimiting function given previous and current item types.
]]
local DecisionMatrix =
  {
    Nothing =
      {
        StartList = EmptyFunc,
        WriteString = EmptyFunc,
        EndList = EmptyFunc,
        Nothing = EmptyFunc,
      },
    StartList =
      {
        StartList = NewlineIndentFunc,
        WriteString = NewlineIndentFunc,
        EndList = EmptyFunc,
        Nothing = EmptyFunc,
      },
    WriteString =
      {
        StartList = NewlineIndentFunc,
        WriteString = SpaceFunc,
        EndList = NewlineIndentFunc,
        Nothing = EmptyFunc,
      },
    EndList =
      {
        StartList = NewlineIndentFunc,
        WriteString = NewlineIndentFunc,
        EndList = NewlineIndentFunc,
        Nothing = NewlineIndentFunc,
      },
  }

--[[
  Add delimiters between items

  Called before writing non-delimiting element.

  Delimiter depends of previous and current item types.

  Input

    self
    What: str (= Nothing, StartList, WriteString, EndList)

  Output

    Emits strings to <self.Output>
]]
local EventHandler =
  function(self, What)
    -- We're not on empty line if we wrote something
    if (self.PrevItem ~= 'Nothing') then
      self.IsOnEmptyLine = false
    end

    -- Adjust indent if we're leaving group
    if (What == 'EndList') then
      self.Indent:Decrease()
    end

    local IndentFunc = DecisionMatrix[self.PrevItem][What]
    IndentFunc(self)

    -- Adjust indent if we're entering group
    if (What == 'StartList') then
      self.Indent:Increase()
    end

    -- Store this item
    self.PrevItem = What
  end

-- Exports:
return EventHandler

--[[
  2024-09 4
  2024-10-21
]]
