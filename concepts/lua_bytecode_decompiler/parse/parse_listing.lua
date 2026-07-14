-- Parse Lines with text of decompiled bytecode

--[[
  Author: Martin Eden
  Last mod.: 2026-07-14
]]

--[[
  Sample code (Lua code in string):

    local val = 17

    local func =
      function()
        local f_val =
          function()
            local get_f_val =
              function()
                return val
              end

            return get_f_val() + 1
          end

        return f_val()
      end

    return func
]]

--[[
  Sample input (list of strings from "luac", Lua 5.5):

  >
  > main <?:0,0> (5 instructions at 0x56396dd57d00)
  > 0+ params, 2 slots, 1 upvalue, 0 locals, 0 constants, 1 function
  >   1 [-] VARARGPREP  0
  >   2 [-] LOADI     0 17
  >   3 [-] CLOSURE   1 0 ; 0x56396dd57df0
  >   4 [-] RETURN    1 2 1k  ; 1 out
  >   5 [-] RETURN    2 1 1k  ; 0 out
  >
  > function <?:4,16> (5 instructions at 0x56396dd57df0)
  > 0 params, 2 slots, 1 upvalue, 0 locals, 0 constants, 1 function
  >   1 [-] CLOSURE   0 0 ; 0x56396dd57ee0
  >   2 [-] MOVE      1 0
  >   3 [-] TAILCALL  1 1 0 ; 0 in
  >   4 [-] RETURN    1 0 0 ; all out
  >   5 [-] RETURN0
  >
  > function <?:6,13> (7 instructions at 0x56396dd57ee0)
  > 0 params, 2 slots, 1 upvalue, 0 locals, 0 constants, 1 function
  >   1 [-] CLOSURE   0 0 ; 0x56396dd57fe0
  >   2 [-] MOVE      1 0
  >   3 [-] CALL      1 1 2 ; 0 in 1 out
  >   4 [-] ADDI      1 1 1
  >   5 [-] MMBINI    1 1 6 0 ; __add
  >   6 [-] RETURN1   1
  >   7 [-] RETURN0
  >
  > function <?:8,10> (3 instructions at 0x56396dd57fe0)
  > 0 params, 2 slots, 1 upvalue, 0 locals, 0 constants, 0 functions
  >   1 [-] GETUPVAL  0 0 ; -
  >   2 [-] RETURN1   0
  >   3 [-] RETURN0
]]

--[[
  Sample output (using Itness format to represent strings tree):

  (
    (
      ( VARARGPREP 0 )
      ( LOADI 0 17 )
      ( CLOSURE 1 0 )
      ( RETURN 1 2 1k )
      ( RETURN 2 1 1k )
    )
    (
      ( CLOSURE 0 0 )
      ( MOVE 1 0 )
      ( TAILCALL 1 1 0 )
      ( RETURN 1 0 0 )
      ( RETURN0 )
    )
    (
      ( CLOSURE 0 0 )
      ( MOVE 1 0 )
      ( CALL 1 1 2 )
      ( ADDI 1 1 1 )
      ( MMBINI 1 1 6 0 )
      ( RETURN1 1 )
      ( RETURN0 )
    )
    (
      ( GETUPVAL 0 0 )
      ( RETURN1 0 )
      ( RETURN0 )
    )
  )
]]

local cleanup_spaces
do
  local str_gsub = string.gsub
  local str_trim = request('!.string.trim')

  cleanup_spaces =
    function(str)
      str = str_gsub(str, '\t', ' ')
      str = str_gsub(str, '  +', ' ')
      str = str_trim(str)

      return str
    end
end

local str_split
do
  local base_str_split = request('!.string.split')

  str_split =
    function(str)
      return base_str_split(str, ' ')
    end
end

local parse_line =
  function(str)
    return str_split(cleanup_spaces(str))
  end

local add_to_list = request('!.concepts.list.add_item')

local parse_function =
  function(InputLinesStream)
    local remove_first_item =
      function(List)
        local remove_item = table.remove
        remove_item(List, 1)
      end

    InputLinesStream:Read()
    InputLinesStream:Read()
    local is_ok, opcode_line = InputLinesStream:Read()

    if not is_ok then return false end

    local Instructions = { }
    do
      local str_find = string.find
      local str_sub = string.sub

      while true do
        if not is_ok then break end

        if (opcode_line == '') then break end

        local Instruction
        do
          local comment_pos = str_find(opcode_line, ';')

          if comment_pos then
            opcode_line = str_sub(opcode_line, 1, comment_pos - 1)
          end

          Instruction = parse_line(opcode_line)

          remove_first_item(Instruction)
          remove_first_item(Instruction)
        end

        add_to_list(Instructions, Instruction)

        is_ok, opcode_line = InputLinesStream:Read()
      end
    end

    return true, Instructions
  end

local parse_listing =
  function(InputLinesStream)
    local Functions = { }

    InputLinesStream:Read()

    while true do
      local is_ok, Function = parse_function(InputLinesStream)

      if not is_ok then break end

      add_to_list(Functions, Function)
    end

    return Functions
  end

-- Export:
return parse_listing

--[[
  2026-07-13
]]
