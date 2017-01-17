--[[
  Process indent block witn one-line style.

  oneline samples:
    if <> then
    (<>)
    return <>

  Note the presence of " " after prefix if it ends on character
  and possibly " " before postfix.
]]

return
  function(self, prefix, postfix, node)
    local printer = self.printer

    prefix = prefix or ''
    local prefix_need_space = not prefix:match('[%p]$')
    postfix = postfix or ''
    local postfix_need_space = not postfix:match('^[%p]')

    printer:add_text(prefix)

    if prefix_need_space then
      printer:add_text(' ')
    end
    printer:inc_indent()
    self:process_node(node)
    printer:dec_indent()
    if postfix_need_space then
      printer:add_text(' ')
    end

    printer:add_text(postfix)
  end
