-- Lua statements grammar

--[[
  Author: Martin Eden
  Last mod.: 2026-10-25
]]

--[[
  <statements>

    ─┬─────────────────────────────┬─┬────────────────────┬─
     │ ┌─────────────────────────┐ │ └─ return_statement ─┘
     │ ▼                         │ │
     └───┬─────────────────────┬─┴─┘
         ├─ assign_or_call ────┤
         ├─ named_function ────┤
         ├─ empty_statement ───┤
         ├─ label_statement ───┤
         ├─ goto_statement ────┤
         ├─ local_statement ───┤
         ├─ break_statement ───┤
         ├─ do_block ──────────┤
         ├─ if_block ──────────┤
         ├─ while_block ───────┤
         ├─ repeat_block ──────┤
         ├─ generic_for_block ─┤
         └─ numeric_for_block ─┘
]]

local handy = request('!.mechs.processor.handy')
local opt = handy.opt
local opt_rep = handy.opt_rep
local cho = handy.cho

local AssignOrCall
do
  local RefOrCall = request('qualifiers.var_or_call')
  local expr_list = request('wrappers.expr_list')

  AssignOrCall =
    {
      name = 'assign_or_call',
      RefOrCall,
      opt(
        opt_rep(',', RefOrCall),
        '=',
        expr_list
      ),
    }
end

local NamedFunction = request('statements.named_function')

local name = request('words.name')

local EmptyStatement = { name = 'empty_statement', ';' }
local LabelStatement = { name = 'label_statement', '::', name, '::' }
local GotoStatement = { name = 'goto_statement', 'goto', name }

local name_list = request('wrappers.name_list')
local expr_list = request('wrappers.expr_list')

local LocalStatement =
  {
    name = 'local_statement',
    'local',
    cho(
      { name = 'local_assignment', name_list, opt('=', expr_list) },
      NamedFunction
    ),
  }

local BreakStatement = { name = 'break_statement', 'break' }

local DoBlock = { name = 'do_block', 'do', '>statements', 'end' }

local IfBlock =
  {
    name = 'if_block',
    { name = 'if_part', 'if', '>expression', 'then', '>statements' },
    opt_rep(
      {
        name = 'elseif_part',
        'elseif', '>expression', 'then', '>statements'
      }
    ),
    opt({ name = 'else_part', 'else', '>statements' }),
    'end',
  }

local WhileBlock =
  {
    name = 'while_block',
    'while', '>expression', 'do', '>statements', 'end'
  }

local RepeatBlock =
  {
    name = 'repeat_block',
    'repeat', '>statements', 'until', '>expression'
  }

local GenericForBlock =
  {
    name = 'generic_for_block',
    'for', name_list, 'in', expr_list, 'do', '>statements', 'end'
  }

local NumericForBlock =
  {
    name = 'numeric_for_block',
    'for',
    name,
    '=',
    '>expression',
    ',',
    '>expression',
    opt(',', '>expression'),
    'do',
    '>statements',
    'end',
  }

local ReturnStatement =
  {
    name = 'return_statement',
    'return', opt(expr_list), opt(EmptyStatement)
  }

return
  {
    name = 'statements',
    inner_name = 'statements',
    opt_rep(
      cho(
        AssignOrCall,
        NamedFunction,

        EmptyStatement,
        LabelStatement,
        GotoStatement,
        LocalStatement,
        BreakStatement,

        DoBlock,
        IfBlock,
        WhileBlock,
        RepeatBlock,
        GenericForBlock,
        NumericForBlock
      )
    ),
    opt(ReturnStatement),
  }

--[[
  2013 # # # # #
  2016 # # # # # #
  2017 #
  2018 # # #
  2026 #
  2026-10-25
]]
