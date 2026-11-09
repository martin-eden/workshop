-- Format strings tree to wrapped text

--[[
  Author: Martin Eden
  Last mod.: 2026-11-09
]]

--[[
  Contract

    Group is list. Item is string or group.

    String item tried to be rendered two ways:

      * current_line « » item
      *
        current_line
        item

    Group item tried to be rendered three ways:

      * current_line « » «(» « » render(item) « » «)»
      *
        current_line
        «(» « » render(item) « » «)»
      *
        current_line
        «(»
        « » « » render(item)
        «)»

    Fallback is the last way.
]]

--[[
  Input

    1 [t] -- strings tree
    2 [?t] -- options
      margin [?i] -- max line width
]]

local prefix = '('
local postfix = ')'
local separator = ' '

local margin

local try =
  function(render_fn, item, printer)
    local trial = printer:seed()
    render_fn(item, trial)
    if (trial:get_width() > margin) then return end
    printer:graft(trial)
    return true
  end

local render_string =
  function(str, printer)
    if not printer:on_clean_line() then
      printer:add_to_curline(separator)
    end
    printer:add_to_curline(str)
  end

local render_shell_oneline
do
  local render_ghost_oneline =
    function(list, printer)
      for _, item in ipairs(list) do
        if is_string(item) then
          render_string(item, printer)
        elseif is_table(item) then
          render_shell_oneline(item, printer)
        end
      end
    end
  render_shell_oneline =
    function(list, printer)
      render_string(prefix, printer)
      render_ghost_oneline(list, printer)
      render_string(postfix, printer)
    end
end

local render_ghost_variative
do
  local render_shell_multiliine =
    function(list, printer)
      render_string(prefix, printer)
      printer:inc_indent()
      printer:request_clean_line()
      render_ghost_variative(list, printer)
      printer:dec_indent()
      printer:request_clean_line()
      render_string(postfix, printer)
    end

  render_ghost_variative =
    function(list, printer)
      for _, item in ipairs(list) do
        if is_string(item) then
          if not try(render_string, item, printer) then
            printer:request_clean_line()
            render_string(item, printer)
          end
        elseif is_table(item) then
          if not try(render_shell_oneline, item, printer) then
            printer:request_clean_line()
            if not try(render_shell_oneline, item, printer) then
              render_shell_multiliine(item, printer)
            end
          end
        end
      end
    end
end

local default_margin = 64
local text_block = request('!.concepts.text_block')

return
  function(tree, options)
    options = options or { }
    margin = options.margin or default_margin
    local printer = text_block.create('  ')

    render_ghost_variative(tree, printer)

    printer:request_clean_line()

    return printer:get_text()
  end

--[[
  2026-11-06
  2026-11-09
]]
