--[[
  Return string with possible ANSI-terminal output commands.

  Sample arguments:

    'default',
    {fg = 'green'}, ' green ',
    {fg = 'default', bg = 'blue'}, ' blue bg ',
    {fg = 'yellow', bg = 'default'}, ' yellow ',
    {mode = 'underline'}, ' underline ',
    {mode = {'underline_off', 'invert'}}, ' invert ',
    {mode = {'invert_off', 'bold'}}, ' bold ',
    {mode = {'invert', 'bold'}}, ' invert, bold ',
    {mode = {'invert_off', 'bold_off', 'hide'}}, ' hide ',
    {mode = 'hide_off'}, ' unhide ',
    {mode = 'default'}, ' default '

  Written for fun.

  2017-09-02
]]

local handle = request('get_ansi_str.handle')

return
  function(...)
    local args = {...}
    local result = {}
    for i = 1, #args do
      result[#result + 1] = handle(args[i])
    end
    return table.concat(result)
  end
