--[[
  Function call grammar.

  Almost same structure as [var_ref] but must end in <call_args>.

  <function_call>:

                        -----------------------------
                        V                           |
    ---+- <name> -----+---+- <call_args> ---------+---- <do_ends_in_call_args()> ---
       +- <par_expr> -+   +- <name_continuation> -+
]]

local handy = request('!.mechs.processor.handy')
local cho = handy.cho
local rep = handy.rep
local opt_rep = handy.opt_rep
local is_not = handy.is_not

local name = request('^.words.name')
local par_expr = request('^.wrappers.par_expr')
local name_continuation = request('^.qualifiers.name_continuation')
local call_args = request('^.qualifiers.call_args')

local t2s = request('!.table.as_string')

local do_ends_in_call_args =
  function(input_stream, output_stream)
    local result =
      (output_stream.seq[output_stream.position - 1].type == 'func_args')
    -- print(t2s(output_stream), output_stream.seq[output_stream.position - 1].type, result)
    return result
  end

return
  {
    name = 'function_call',
    cho(name, par_expr),
    rep(cho(call_args, name_continuation)),
    do_ends_in_call_args,
  }
