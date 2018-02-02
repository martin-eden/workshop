--[[
  Variable reference grammar.

  Structure similar to [function_call] but must not end at <call_args>.

  <qualifiers>:

     -----------------------------
     V                           |
    ---+- <name_continuation> -+---
       +- <call_args> ---------+

  <var_ref>:

    ---+- <name> -+----------------+-+--- <not_ends_in_call_args()> ---
       |          +- <qualifiers> -+ |
       |                             |
       +- <par_expr> <qualifiers> ---+
]]

local handy = request('!.mechs.processor.handy')
local cho = handy.cho
local opt = handy.opt
local rep = handy.rep
local opt_rep = handy.opt_rep
local is_not = handy.is_not

local name = request('^.words.name')
local par_expr = request('^.wrappers.par_expr')
local call_args = request('^.qualifiers.call_args')
local name_continuation = request('^.qualifiers.name_continuation')

local t2s = request('!.table.as_string')

local not_ends_in_call_args =
  function(input_stream, output_stream)
    local result =
      (output_stream.seq[output_stream.position - 1].type ~= 'func_args')
    -- print(t2s(output_stream), output_stream.seq[output_stream.position - 1].type, result)
    return result
  end

local qualifiers =
  rep(cho(name_continuation, call_args))

return
  {
    name = 'var_ref',
    cho(
      {name, opt(qualifiers)},
      {par_expr, qualifiers}
    ),
    not_ends_in_call_args,
  }
