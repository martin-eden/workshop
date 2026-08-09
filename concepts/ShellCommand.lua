-- Shell command concept

--[[
  Author: Martin Eden
  Last mod.: 2026-08-09
]]

--[[
  Shell command is just command (string) and arguments
  (list of strings):

    ls -l ~
    ->
    ( ls ( -l ~ ) )

  This module is added also to quote shell stings in one place.

  Note that it won't suit you for cases when you really
  want fancy stuff like "sh -c ls 2>/dev/null".
]]

--[[
  Examples for serializing to "ls -l ~":

    * Short way

      print(ShellCommand.create({ 'ls', { '-l', '~' } }):ToString())

    * Long way

      local Command = ShellCommand.create()
      Command[1] = 'ls'
      Command[2] = { '-l', '~' }
      print(Command:ToString())
]]

local Interface
do
  --[[
    Data storage format

      1 [s] program name
      2 [t] arguments (list of strings)
  ]]

  local check_core =
    function(Core)
      assert_table(Core)
      assert(#Core == 2)
      assert_string(Core[1])
      assert_table(Core[2])
      for _, arg in ipairs(Core[2]) do
        assert_string(arg)
      end
    end

  local create
  do
    local DefaultCore = { '', { } }
    local create_instance = request('!.table.create_instance')

    create =
      function(OptCore)
        local Core = OptCore or DefaultCore

        check_core(Core)

        return create_instance(Core, Interface)
      end
  end

  local ToString
  do
    local quote = request('!.concepts.shell.quote')
    local add_to_list = request('!.concepts.list.add_item')
    local glue_words = request('!.concepts.words.to_string')

    ToString =
      function(Me)
        check_core(Me)

        local Words = { }

        add_to_list(Words, quote(Me[1]))

        for _, arg in ipairs(Me[2]) do
          add_to_list(Words, quote(arg))
        end

        return glue_words(Words)
      end
  end

  Interface =
    {
      create = create,
      ToString = ToString,
    }
end

-- Export:
return Interface

--[[
  2026-08-09
]]
