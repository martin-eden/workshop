-- Shell command concept

--[[
  Author: Martin Eden
  Last mod.: 2026-08-12
]]

--[[
  Data format

    1 [s] command
    2 [t] list of arguments
      1+ [s] argument
]]

--[[
  F.e. ( ls -l ~ ) is represented as ( ls ( -l ~ ) ) (Itness format)
]]

--[[
  This module quotes command and arguments if needed,
  so it's safe to use special characters in them.

  Note that it won't suit you for cases when you really
  want fancy stuff like "sh -c ls 2>/dev/null".
]]

--[[
  Examples

    Serializing to "ls -l ~"

      * Short way

        s = ShellCommand.create({ 'ls', { '-l', '~' } }):ToString()

      * Longer way

        local Command = { 'ls', { '-l', '~' } }
        Command = ShellCommand.create(Command)
        s = Command:ToString()

    Executing "ls -l ~"

      *
        local Command = { 'ls', { '-l', '~' } }
        Command = ShellCommand.create(Command)
        Command:Execute()
]]

local Interface
do
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

  -- See [shell.execute] for output format
  local Execute
  do
    local execute_shell_command = request('!.concepts.shell.execute')

    Execute =
      function(Me)
        check_core(Me)

        return execute_shell_command(Me:ToString())
      end
  end

  Interface =
    {
      create = create,
      ToString = ToString,
      Execute = Execute,
    }
end

-- Export:
return Interface

--[[
  2026-08-09
  2026-08-12
]]
