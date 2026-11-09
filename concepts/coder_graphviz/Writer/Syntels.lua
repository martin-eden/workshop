-- Named syntax elements of .dot format that we're using

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

local ascii_chars = request('!.concepts.ascii.chars')

return
  {
    kw_digraph = 'digraph',
    kw_label = 'label',

    arrow = '->',

    quote = ascii_chars.double_quote,
    assign = ascii_chars.equals,
    end_statement = ascii_chars.semicolon,

    start_graph = ascii_chars.opening_brace,
    end_graph = ascii_chars.closing_brace,

    start_attr = ascii_chars.opening_bracket,
    end_attr = ascii_chars.closing_bracket,
  }

--[[
  2026 #
]]
