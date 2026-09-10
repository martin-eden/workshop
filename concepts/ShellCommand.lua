-- Shell command concept

--[[
  Author: Martin Eden
  Last mod.: 2026-09-10
]]

--[[
  Data format

    1 [s] -- command
    2 [t] -- list of arguments
      0+ [s] argument
]]

--[[
  F.e. "ls -l ~" is represented as ( ls ( -l ~ ) ) (Itness format)
]]

--[[
  This module quotes command and arguments if needed,
  so it's safe to use special characters in them.

  It won't suit you for cases when you really
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

local ToString
do
  local quote = request('!.concepts.shell.quote')
  local add_to_list = request('!.concepts.list.add_item')
  local glue_words = request('!.concepts.words.to_string')
  ToString =
    function(Me)
      local command = Me[1]
      local Args = Me[2]

      local Words = { }
      add_to_list(Words, quote(command))
      for _, arg in ipairs(Args) do
        add_to_list(Words, quote(arg))
      end

      return glue_words(Words)
    end
end

local Execute
do
  local execute_shell_command = request('!.concepts.shell.execute')
  Execute =
    function(Me)
      return execute_shell_command(Me:ToString())
    end
end

local Interface
do
  local create
  do
    local create_instance = request('!.table.create_instance')
    create =
      function(Core)
        -- Check core
        do
          assert_table(Core)
          assert(#Core == 2)

          local command = Core[1]
          local Args = Core[2]

          assert_string(command)
          assert_table(Args)
          for _, arg in ipairs(Args) do
            assert_string(arg)
          end
        end

        return create_instance(Core, Interface)
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
  2026 # # #
]]
