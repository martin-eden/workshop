--[[
  The most annouying problem is that we do not know what sort of
  handler we call: will it use variate() or not. Also normal handlers
  do not return result values. So handlers that use variate()
  return result in <printer.has_failed_to_represent>. We nullify this
  field before calling handler and check it's value after. If it is
  not nil, handler used variate() and we handle this accordingly.

  Another problem is that we should return result even it is not
  valid in terms of <multiline_allowed> and representation_is_allowed().
  This is for case when we have no other choice.
  --
  Current architecture easily becomes a performance black hole.
  Consider we are formatting a statement "a = {z = {}}". It parsed
  to something like

    <assignment>("a", <table>( ("z", <table>() ) ) )

  Both <assignment> and <table> have one-line and multiline versions.
  So we iterate from multiline to oneline as

    <assignment-m> <table-m> <table-m>
                             <table-1>
                   <table-1> <table-1>
    <assignment-1> <table-1> <table-1>

  The problem is that internal nodes called many times for same
  values, differed only by parent function who called it and usually
  by indentation in "printer" device abstraction.

  Also for a table with many values we anyway call one-line version
  which will fail in representation_is_allowed() function.
]]

local states = {}

local add =
  function(state)
    states[#states + 1] = state
  end

local get =
  function()
    return states[#states]
  end

local is_empty =
  function()
    return (#states == 0)
  end

local remove =
  function()
    states[#states] = nil
  end

local is_multiline_allowed =
  function()
    if is_empty() then
      return true
    else
      return get()
    end
  end

local get_handler =
  function(handler_rec)
    local handler, handler_is_multiline
    if is_table(handler_rec) then
      handler = handler_rec[1]
      handler_is_multiline = handler_rec.is_multiline
    elseif is_function(handler_rec) then
      handler = handler_rec
    end
    if is_nil(handler_is_multiline) then
      handler_is_multiline = false
    end
    assert_function(handler)
    assert_boolean(handler_is_multiline)
    return handler, handler_is_multiline
  end

local get_most_suitable_handler =
  function(representers, is_multiline_allowed)
    local result, is_multiline

    if not result then
      for i = 1, #representers do
        local handler, handler_is_multiline = get_handler(representers[i])
        if (handler_is_multiline and is_multiline_allowed) then
          result, is_multiline = handler, handler_is_multiline
          break
        end
      end
    end
    if not result then
      for i = 1, #representers do
        local handler, handler_is_multiline = get_handler(representers[i])
        if (not handler_is_multiline and not is_multiline_allowed) then
          result, is_multiline = handler, handler_is_multiline
          break
        end
      end
    end
    if not result then
      for i = 1, #representers do
        local handler, handler_is_multiline = get_handler(representers[i])
        if (not handler_is_multiline and is_multiline_allowed) then
          result, is_multiline = handler, handler_is_multiline
          break
        end
      end
    end
    if not result then
      for i = 1, #representers do
        local handler, handler_is_multiline = get_handler(representers[i])
        if (handler_is_multiline and not is_multiline_allowed) then
          result, is_multiline = handler, handler_is_multiline
          break
        end
      end
    end

    assert(result)
    return result, is_multiline
  end

local printer_class = request('printer.interface')

local represent =
  function(self, handler, handler_is_multiline, node)
    local original_presentation = self.printer

    local trial_presentation = new(printer_class)
    trial_presentation:init()
    local num_lines = #original_presentation.text.lines
    trial_presentation.text.lines[1] = original_presentation.text.lines[num_lines]
    trial_presentation.line_indents[1] = original_presentation.line_indents[num_lines]
    trial_presentation.next_line_indent = original_presentation.next_line_indent

    self.printer = trial_presentation
    add(handler_is_multiline)

    handler(self, node)

    remove()
    local has_failed
    if is_nil(trial_presentation.has_failed_to_represent) then
      has_failed = false
    else
      has_failed = trial_presentation.has_failed_to_represent
    end
    if not handler_is_multiline and (#trial_presentation.text.lines > 1) then
      has_failed = true
    end

    -- print(('[%s](%s)'):format(self.printer:get_text(), has_failed))
    self.printer = original_presentation

    return trial_presentation, has_failed
  end

return
  function(self, representers, node)
    self.printer.has_failed_to_represent = false

    local representation

    for i = 1, #representers do
      local handler, handler_is_multiline = get_handler(representers[i])
      if
        is_multiline_allowed() or
        (not is_multiline_allowed() and not handler_is_multiline)
      then
        local trial_presentation, has_failed =
          represent(self, handler, handler_is_multiline, node)
        if
          not has_failed and
          self:representation_is_allowed(trial_presentation)
        then
          representation = trial_presentation
        else
          if not representation then
            self.printer.has_failed_to_represent = true
            representation = trial_presentation
          end
          break
        end
      end
    end

    if not representation then
      local handler, handler_is_multiline =
        get_most_suitable_handler(representers, is_multiline_allowed())
      representation =
        represent(self, handler, handler_is_multiline, node)
      self.printer.has_failed_to_represent = true
    end

    self.printer.text.lines[#self.printer.text.lines] = ''
    self.printer:concat_printer(representation, true)
  end
