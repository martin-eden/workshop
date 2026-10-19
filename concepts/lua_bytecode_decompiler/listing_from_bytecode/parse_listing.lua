-- Parse text with decompiled bytecode

--[[
  Author: Martin Eden
  Last mod.: 2026-10-19
]]

--[[
  Sample input (lines stream)

    >
    > main <?:0,0> (5 instructions at 0x56396dd57d00)
    > 0+ params, 2 slots, 1 upvalue, 0 locals, 0 constants, 1 function
    >   1 [-] VARARGPREP  0
    >   2 [-] LOADI     0 17
    >   3 [-] CLOSURE   1 0 ; 0x56396dd57df0
    >   4 [-] RETURN    1 2 1k  ; 1 out
    >   5 [-] RETURN    2 1 1k  ; 0 out
    >
    [...]
    > function <?:8,10> (3 instructions at 0x56396dd57fe0)
    > 0 params, 2 slots, 1 upvalue, 0 locals, 0 constants, 0 functions
    >   1 [-] GETUPVAL  0 0 ; -
    >   2 [-] RETURN1   0
    >   3 [-] RETURN0

  Sample output (using Itness format to represent strings tree)

    (
      (
        ( VARARGPREP 0 )
        ( LOADI 0 17 )
        ( CLOSURE 1 0 )
        ( RETURN 1 2 1k )
        ( RETURN 2 1 1k )
      )
      [...]
      (
        ( GETUPVAL 0 0 )
        ( RETURN1 0 )
        ( RETURN0 )
      )
    )
]]

--[[
  So it's all about text processing of ad-hoc format

  Note that we're parsing each line to tokens.
  So access dimensions are ( closure instruction operand ).
]]

local parse_line
do
  local space
  local tab
  local comment_char
  do
    local AsciiChars = request('!.concepts.Ascii.Chars')
    space = AsciiChars.space
    tab = AsciiChars.tab
    comment_char = AsciiChars.semicolon
  end

  local cleanup_spaces
  do
    local str_gsub = string.gsub
    local str_trim = request('!.string.trim')
    cleanup_spaces =
      function(str)
        str = str_gsub(str, tab, space)
        str = str_gsub(str, space .. space .. '+', space)
        return str_trim(str)
      end
  end

  local str_find = string.find
  local str_sub = string.sub
  local str_split = request('!.string.split')
  local tbl_remove = table.remove

  parse_line =
    function(str)
      local comment_pos = str_find(str, comment_char)
      if comment_pos then
        str = str_sub(str, 1, comment_pos - 1)
      end
      local Instruction = str_split(cleanup_spaces(str), space)
      tbl_remove(Instruction, 1)
      tbl_remove(Instruction, 1)
      return Instruction
    end
end

local add_to_list = request('!.concepts.list.add_item')

local parse_closure =
  function(InputLines)
    InputLines:Read()
    InputLines:Read()

    local is_ok, opcode_line = InputLines:Read()
    if not is_ok then return false end

    local Instructions = { }
    while true do
      if (opcode_line == '') then break end

      add_to_list(Instructions, parse_line(opcode_line))

      is_ok, opcode_line = InputLines:Read()
      if not is_ok then break end
    end

    return true, Instructions
  end

-- Export:
return
  function(InputLines)
    local Closures = { }
    InputLines:Read()
    while true do
      local is_ok, Closure = parse_closure(InputLines)
      if not is_ok then break end
      add_to_list(Closures, Closure)
    end
    return Closures
  end

--[[
  2026-07-13
  2026-10-19
]]
