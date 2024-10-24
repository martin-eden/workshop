-- Data separation/indentation

--[[
  We don't care about items encoding. It's [DataWriter]'s job.

  We do care about types of adjacent items.
]]

-- Last mod.: 2024-10-21

-- Imports:
local Output = request('!.concepts.StreamIo.Output')
local Syntax = request('^.^.Syntax')
local Indenter = request('!.concepts.Indent.Interface')

-- We're setting indent chunk on module load
Indenter:Init(0, string.rep(Syntax.Delimiters.Space, 2))

-- Exports:
return
  {
    -- [Config] Output implementer. Set to concrete for practical use
    Output = Output,

    -- [Main] Add indentation before or after writing something
    OnEvent = request('OnEvent'),

    -- [Internal] Categorized syntax elements
    Syntax = Syntax,

    -- [Internal] Indentation tracker
    Indent = Indenter,

    -- [Internal] Previous item type. Used by OnEvent()
    PrevItem = 'Nothing',

    --[[
      Side functionality: not-empty-liner

      I don't want empty lines in generated text. So no '\n\n'.
      But newline logic is scattered among event handlers.
    ]]
    -- [Internal] Empty line flag
    IsOnEmptyLine = true,

    -- [Internal] Write string
    Emit = request('Emit'),

    -- [Internal] Makes sure that next string will be written on new line
    EmitNewline = request('EmitNewline'),

    -- [Internal] Emit indent string
    EmitIndent = request('EmitIndent'),

    -- [Internal] Emit newline and indent
    EmitNewlineIndent = request('EmitNewlineIndent'),
  }

--[[
  2024-09-03
  2024-10-21
]]
