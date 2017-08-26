--[[
  Returns nicely formatted string with AST representation.
]]

local text_block
do
  local c_text_block = request('!.mechs.text_block.interface')
  text_block = new(c_text_block)
  text_block.indent_chunk = '|   '
  text_block:init()
end

local quote = request('!.string.quote')

local process
process =
  function(node)
    if is_string(node) then
      text_block:request_clean_line()
      text_block:add_curline(quote(node))
    elseif is_table(node) then
      text_block:request_clean_line()
      local line = ('(%s)'):format(node.type)
      text_block:add_curline(line)

      text_block:inc_indent()
      for i = 1, #node do
        process(node[i])
      end
      text_block:dec_indent()
    end
  end


return
  function(ast)
    assert_table(ast)
    process(ast)
    local result
    result = text_block:get_text()
    return result
  end
