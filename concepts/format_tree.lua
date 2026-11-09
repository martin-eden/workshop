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
  function(render_fn, item, Printer)
    local Trial = Printer:Seed()
    render_fn(item, Trial)
    if (Trial:GetWidth() > margin) then return end
    Printer:Graft(Trial)
    return true
  end

local render_string =
  function(str, Printer)
    if not Printer:OnCleanLine() then
      Printer:AddToCurline(separator)
    end
    Printer:AddToCurline(str)
  end

local render_shell_oneline
do
  local render_ghost_oneline =
    function(List, Printer)
      for _, item in ipairs(List) do
        if is_string(item) then
          render_string(item, Printer)
        elseif is_table(item) then
          render_shell_oneline(item, Printer)
        end
      end
    end
  render_shell_oneline =
    function(List, Printer)
      render_string(prefix, Printer)
      render_ghost_oneline(List, Printer)
      render_string(postfix, Printer)
    end
end

local render_ghost_variative
do
  local render_shell_multiliine =
    function(List, Printer)
      render_string(prefix, Printer)
      Printer:IncIndent()
      Printer:RequestCleanLine()
      render_ghost_variative(List, Printer)
      Printer:DecIndent()
      Printer:RequestCleanLine()
      render_string(postfix, Printer)
    end
  render_ghost_variative =
    function(List, Printer)
      for _, item in ipairs(List) do
        if is_string(item) then
          if not try(render_string, item, Printer) then
            Printer:RequestCleanLine()
            render_string(item, Printer)
          end
        elseif is_table(item) then
          if not try(render_shell_oneline, item, Printer) then
            Printer:RequestCleanLine()
            if not try(render_shell_oneline, item, Printer) then
              render_shell_multiliine(item, Printer)
            end
          end
        end
      end
    end
end

local default_margin = 64
local TextBlock = request('!.mechs.TextBlock')

return
  function(Tree, Options)
    Options = Options or { }
    margin = Options.margin or default_margin
    local Printer = TextBlock.create('  ')

    render_ghost_variative(Tree, Printer)

    Printer:RequestCleanLine()

    return Printer:GetText()
  end

--[[
  2026-11-06
  2026-11-09
]]
